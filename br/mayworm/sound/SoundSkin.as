/**
* SoundSkin: simple API wrapper for ActionScript 3 sound control. 
* @author Greg MacWilliam
* @version 1.3
*/

/**
* Licensed under the MIT License
* 
* Copyright (c) 2009 Greg MacWilliam
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy of
* this software and associated documentation files (the "Software"), to deal in
* the Software without restriction, including without limitation the rights to
* use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
* the Software, and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
* FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
* IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
* 
* http://code.google.com/p/sound-skin/
* http://www.opensource.org/licenses/mit-license.php 
*/

/*
* VERSION HISTORY:
*
* v1.3: 3/12/09 - added auto-play and left/right pan control.
*
* v1.2: 1/21/09 - added SoundSkinFx extension for animating volume transitions.
*
* v1.1: 1/8/09 - updated destroyer to close connections, and fixed a bug that prevented sound from playing while loading.
*
* v1.0: 1/7/09 - first release.

  @Using
  
    musicTocando = new SoundSkin();							
			
    musicTocando.addEventListener(SoundSkinEvent.SOUND_LOADED, carregou);
    musicTocando.sound.addEventListener(ProgressEvent.PROGRESS, loadingMusic);
			
    musicTocando.load("teste.mp3", true);
  
    function loadingMusic(e:Event):void {			
		trace(int(musicTocando.percentLoaded * 100) + "%");
	}		
		
	function carregou(e:SoundSkinEvent):void {
		trace("carregou");
	}
  

*/

package br.mayworm.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundLoaderContext;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import br.mayworm.events.SoundSkinEvent;

	/** 
	* Dispatched when the sound finishes loading.
	* @eventType com.gmac.sound.SoundSkinEvent.SOUND_LOADED
	*/
	[Event(name="soundSkinLoaded", type="br.mayworm.events.SoundSkinEvent")]
	
	/**
	* Dispatched when the sound finishes playing all loops.
	* @eventType com.gmac.sound.SoundSkinEvent.SOUND_COMPLETE
	*/
	[Event(name="soundSkinComplete", type="br.mayworm.events.SoundSkinEvent")]

	/**
	* Dispatched each time the sound finishes playing and starts playing a new loop.
	* @eventType com.gmac.sound.SoundSkinEvent.SOUND_LOOP
	*/
	[Event(name="soundSkinLoop", type="br.mayworm.events.SoundSkinEvent")]
	
	/**
	* SoundSkin is a wrapper for Sound objects that provides a simple interface for controlling sound playback.
	* SoundSkin can be constructed with a reference to a preloaded Sound object, or load an external audio file.
	*/
	public class SoundSkin extends EventDispatcher
	{
		/**
		* Specifies the number of times the sound will play through sequentially.
		* A value of 1 will play the track once, 2 will play the track twice, etc.
		* Specify 0 to loop the sound indefinitely. If a sound is set to indefinite looping (0),
		* you can gracefully break the loop at the end of the current play cycle by changing this value to 1.
		* Likewise, you can enter a non-looping sound into an indefinite loop by setting this value to 1.
		*/
		public var loops:int = 1;
		
		// private
		private var _sound:Sound;
		private var _channel:SoundChannel;
		private var _loopCount:int = 0;
		private var _playhead:Number = 0;
		private var _volume:Number = 1;
		private var _pan:Number = 0;
		private var _mute:Boolean = false;
		private var _loaded:Boolean = false;
		private var _autoPlay:Boolean = false;
		
		/**
		* Creates a new SoundSkin object.
		* A SoundSkin can be constructed with a preloaded sound to manage; otherwise, an external sound will need to be loaded.
		* @param sound  A preloaded sound object to play. If no sound is provided, an external sound will need to be loaded.
		* @param loop  Specifies the number of times the track will play sequentially. Use 0 to make the sound loop indefinitely.
		* @param startTime  Specifies the time (in milliseconds) at which the sound should start playing.
		* @see #load()
		*/
		public function SoundSkin($sound:Sound=null, $loops:int=1, $startTime:Number=0):void
		{
			super();
			_sound = ($sound is Sound) ? $sound : new Sound();
			_loaded = ($sound != null);
			_playhead = $startTime;
			loops = $loops;
		}
		
		/**
		* Cleans up the SoundSkin object to expedite garbage collection.
		* Sound playback is stopped, any loading connection is closed, and all object references are nullified.
		* This method should always be called after you are finishing with a SoundSkin.
		*/
		public function destroy():void
		{
			stop();
			
			// close sound if a connection was opened that has not yet completed.
			if (_sound.url != null && !_loaded) _sound.close();
			
			// nullify all object references.
			_sound = null;
			_channel = null;
		}
		
		/**
		* Loads an external sound file into the SoundSkin.
		* The <code>load()</code> method may only be called once on a SoundSkin object that was constructed <em>without</em> a preloaded Sound object.
		* Once a load has been initialized, subsequent calls to <code>load()</code> will be ignored.
		* If you'd like to load a new external sound file, destroy the existing SoundSkin and construct a new instance.
		* @param url  URL string of the relative or absolute path from which to load an external sound.
		* @param autoPlay  Specifies if the sound should automatically start playing once minimal data has been loaded.
		* @param bufferSeconds  Number of seconds (emphasis: seconds, not milliseconds) to buffer audio before allowing playback.
		* @see #destroy()
		*/
		public function load($url:String, $autoPlay:Boolean=false, $bufferSeconds:Number=1):void
		{
			if (_sound.url == null && percentLoaded == 0) {
				_autoPlay = $autoPlay;
				_sound.addEventListener(ProgressEvent.PROGRESS, this._onLoadProgress, false, 0, true);
				_sound.addEventListener(Event.COMPLETE, this._onLoadComplete, false, 0, true);
				_sound.load(new URLRequest($url), new SoundLoaderContext($bufferSeconds * 1000));
			}
		}
		
		/**
		* Provides a reference to the encapsulated Sound object.
		* Use this reference to assign load listeners to the sound (all normal Sound events can be observed).
		*/
		public function get sound():Sound {
			return _sound;
		}
		
		/**
		* Specifies whether or not the sound has completely loaded.
		* @see #load()
		*/
		public function get loaded():Boolean {
			return _loaded;
		}
		
		/**
		* Specifies whether or not the sound is currently playing.
		*/
		public function get playing():Boolean {
			return _channel != null;
		}

		/**
		* Returns the actual length (in milliseconds) of the sound data available.
		* @see #estimatedLength
		*/
		public function get length():Number {
			return _sound.length;
		}
		
		/**
		* Returns the estimated length (in milliseconds) of the sound relative to its current load progress.
		* <code>estimatedLength</code> will be identical to the <code>length</code> property after the sound has finished loading.
		* @see #length
		*/
		public function get estimatedLength():Number {
			var $length:Number = loaded ? _sound.length : (_sound.length / percentLoaded);
			return isNaN($length) ? 0 : $length;
		}
		
		/**
		* Gets the current pecrentage of sound data loaded, expressed as a number between 0 and 1.
		* @see #load()
		*/
		public function get percentLoaded():Number {
			var $percent:Number = _sound.bytesLoaded / _sound.bytesTotal;
			return isNaN($percent) ? 0 : $percent;
		}
		
		/**
		* Specifies the sound's current playback percentage relative to the full track length, expressed as a number between 0 and 1.
		* If the sound has not completely loaded, playback percentage will be based on the sound's estimated full length.
		* @see #position
		*/
		public function get percentPlayback():Number {
			var $percent:Number = (playing) ? (_channel.position / estimatedLength) : (_playhead / estimatedLength);
			return isNaN($percent) ? 0 : $percent;
		}
		public function set percentPlayback($percent:Number):void {
			position = estimatedLength * $percent;
		}
		
		/**
		* Specifies the playback time position (in milliseconds) of the sound.
		* Time position setting is limited to the current length of the loaded sound data.
		* @see #percentPlayed
		*/
		public function get position():Number {
			if (playing) return _channel.position;
			return _playhead;
		}
		public function set position($milliseconds:Number):void
		{
			// record if sound is playing, then stop sound.
			var $resume:Boolean = playing;
			stop();
			
			// set new playhead position, then resume play.
			_playhead = Math.max(0, Math.min($milliseconds, _sound.length));
			if ($resume) play();
		}
		
	//-------------------------------------------------
	// Volume / pan controls
	//-------------------------------------------------
		
		/**
		* Specifies the sound volume, expressed as a number between 0 and 1.
		* @see #mute
		* @see #toggleMute()
		*/
		public function get volume():Number {
			return _volume;
		}
		public function set volume($volume:Number):void {
			_volume = $volume;
			if (playing) _channel.soundTransform = _getTransform();
		}
		
		/**
		* Specifies if the sound's volume is muted. Muting the sound does not affect its source volume setting.
		* @param mute  Use <code>true</code> to silence the sound. Use <code>false</code> to make it audible.
		* @see #toggleMute()
		* @see #volume
		*/
		public function get mute():Boolean {
			return _mute;
		}
		public function set mute($mute:Boolean):void {
			_mute = $mute;
			if (playing) _channel.soundTransform = _getTransform();
		}
		
		/**
		* Toggles the sound's current mute setting.
		* @see #mute
		* @see #volume
		*/
		public function toggleMute():void {
			mute = !_mute;
		}
		
		/**
		* Specifies the sound's left to right pan, represented by a number between -1 (full left) and 1 (full right).
		* @param value The left-to-right value, ranging from -1 (full left) to 1 (full right). A value of 0 represents no panning (center).
		*/
		public function get pan():Number {
			return _pan;
		}
		public function set pan($value:Number):void {
			_pan = Math.max(-1, Math.min($value, 1));
			if (playing) _channel.soundTransform = _getTransform();
		}
		
		/** @private  creates a sound transform with current volume and pan setting applied. */
		private function _getTransform():SoundTransform {
			return new SoundTransform(_mute ? 0 : _volume, _pan);
		}
		
	//-------------------------------------------------
	// Playback controls
	//-------------------------------------------------
		
		/**
		* Rewinds the sound to the beginning of the current playback loop.
		* The sound will resume play if it was playing when <code>rewind()</code> was called.
		* @see #reset()
		*/
		public function rewind():void
		{
			if (playing) {
				stop();
				_playhead = 0;
				play();
			}
			else {
				_playhead = 0;
			}
		}
		
		/**
		* Rewinds the sound and resets playback to the first loop.
		* @see #rewind()
		*/
		public function reset():void
		{
			_loopCount = 0;
			rewind();
		}
		
		/**
		* Plays the sound from the current playhead position.
		* @see #stop()
		*/
		public function play():void
		{
			if (!playing && percentLoaded > 0) {
				_channel = _sound.play(_playhead, 0, _getTransform());
				
				
				if (_loaded) dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_PLAY));
				
				
				
				// if a channel was successfully created, listen for completion.
				// (starting sound at its end point will return no channel)
				if (_channel != null) {
					_channel.addEventListener(Event.SOUND_COMPLETE, this._onSoundComplete, false, 0, true);
				}				
				
			}
			
		}
		
		/**
		* Stops/pauses playback at the current sound position.
		* @see #play()
		*/
		public function stop():void
		{
			if (playing) {
				_playhead = 0;
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, this._onSoundComplete);
				_channel = null;				
				dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_STOP));
			}
		}
		
		public function pause():void
		{
			if (playing) {
				_playhead = _channel.position;
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, this._onSoundComplete);
				_channel = null;				
				dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_STOP));
			}
		}

		/**
		* Toggles the playback status of the sound.
		* A playing sound is stopped, or a stopped sound is played.
		* You can check the SoundSkin's <code>playing</code> property to obtain the outcome of the toggle action.
		* @see #playing
		* @see #play()
		* @see #stop()
		*/
		public function togglePlayback():void
		{
			if (playing) stop();
			else play();
		}
		
	//-------------------------------------------------
	// Event handlers
	//-------------------------------------------------
		
		/** @private called upon completion of the sound channel's playback. */
		private function _onSoundComplete($event:Event):void
		{
			// clear spent channel
			_channel.removeEventListener(Event.SOUND_COMPLETE, this._onSoundComplete);
			_channel = null;
			
			// increment loop
			_loopCount++;

			// if loop is infinite (0) or count is still less than limit
			if (loops <= 0 || _loopCount < loops) {
				// play new loop.
				rewind();
				play();
				dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_LOOP));
			}
			else {
				// signal sound completion.
				reset();
				dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_COMPLETE));
			}
		}
		
		/** @private called upon completion of the sound loading operation. */
		private function _onLoadComplete($event:Event):void {
			_sound.removeEventListener(Event.COMPLETE, this._onLoadComplete);
			_loaded = true;
			if(playing) dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_PLAY));
			dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_LOADED));
		}
		
		/** @private called upon load progress; starts the sound playing once there is data available */
		private function _onLoadProgress($event:ProgressEvent):void {
			if (_autoPlay && percentLoaded > 0) play();
			if (playing) _sound.removeEventListener(ProgressEvent.PROGRESS, this._onLoadProgress);
		}
	}
}