﻿/*** SoundSkin: simple API wrapper for ActionScript 3 sound control. * @author Greg MacWilliam* @version 1.2*//*** Licensed under the MIT License* * Copyright (c) 2009 Greg MacWilliam* * Permission is hereby granted, free of charge, to any person obtaining a copy of* this software and associated documentation files (the "Software"), to deal in* the Software without restriction, including without limitation the rights to* use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of* the Software, and to permit persons to whom the Software is furnished to do so,* subject to the following conditions:* * The above copyright notice and this permission notice shall be included in all* copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS* FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER* IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.* * http://code.google.com/p/sound-skin/* http://www.opensource.org/licenses/mit-license.php */package br.mayworm.sound{	import flash.media.Sound;	import flash.utils.Timer;	import flash.events.TimerEvent;		import br.mayworm.events.SoundSkinEvent;		/**	* Dispatched after a sound clip finishes a fade transition.	* @eventType com.gmac.sound.SoundSkinEvent.SOUND_FADE	*/	[Event(name="soundSkinFade", type="br.mayworm.events.SoundSkinEvent")]		/**	* SoundSkinFx is an extention of SoundSkin that adds volume fade in/out capabilities.	* Note that SoundSkinFx transitons do not account for load latency, so preloading sounds before playback is recommended.	*/	public class SoundSkinFx extends SoundSkin	{		/**		* Specifies the frames per second of sound fade tweens.		*/		public var fps:int = 20;				/** @private */		private var _transTimer:Timer;		private var _transMilliseconds:Number = 2;		private var _transRange:Number = 0;		private var _transTarget:Number = 0;		private var _transEnabled:Boolean = false;		private var _destroyAfterTrans:Boolean = false;				/**		* Creates a new SoundSkinFx object.		* A SoundSkinFx has all the features of a SoundSprite as well as volume transition controls.		* @param sound  A preloaded sound object to play. If no sound is provided, an external sound will need to be loaded.		* @param loop  Specifies the number of times the track will play sequentially. Use 0 to make the sound loop indefinitely.		* @param startTime  Specifies the time (in milliseconds) at which the sound should start playing.		*/		public function SoundSkinFx($sound:Sound=null, $loops:int=1, $startTime:Number=0):void		{			super($sound, $loops, $startTime);			_transTimer = new Timer(1000/fps);		}				/** @private */		override public function destroy():void		{			_enableTransition(false);			_transTimer.stop();			_transTimer = null;			super.destroy();		}				/**		* @private		* Sets the volume of the sound.		* overrides base class to prevent volume from being adjusted while a fade is in progress.		*/		override public function set volume($percent:Number):void {			if (!_transEnabled) super.volume = $percent;			else recalibrate($percent);		}				/** @private */		override public function play():void		{			super.play();						// restart framerate if playback was stopped mid tween.			if (playing && _transEnabled && !_transTimer.running) _transTimer.start();		}				/** @private */		override public function stop():void		{			super.stop();						// stop framerate of any existing fade.			if (_transTimer.running) _transTimer.stop();		}				/**		* Specifies if a transition is currently in progress.		*/		public function get transitioning():Boolean {			return _transEnabled;		}				/**		* Fades sound from its current volume to a new volume.		* Target sound must be playing at the time <code>fadeTo()</code> is called, otherwise the call is ignored.		* Note that SoundSpriteFader transitons do not account for load latency, so preloading sounds before playback is recommended.		* @param targetVolume  The target volume to fade to, expressed as a number between 0 and 1.		* @param seconds  Number of seconds (emphasis: seconds, not milliseconds) over which to transition the sound from its current volume.		* @param standardizeRate  Specifies if the fade duration should be adjusted to a standard rate based on a 100% shift in volume range.		* For example, if <code>$seconds</code> is 2 and volume shifts from 0.5 to 1, then the fade only spans 1 second since only half the volume range was covered.		* This methodology is employed to allow easy implementation of consistent transition rates, regardless of current and target volume differential.		*/		public function fadeTo($targetVolume:Number, $seconds:Number=2, $standardizeRate:Boolean=true):void		{			if (playing && $targetVolume != volume) {				_destroyAfterTrans = false;				_configureTransition($targetVolume, $seconds, $standardizeRate);			}		}				/**		* Starts sound playing with a gradual fade in.		* Target must <em>not</em> be playing at the time <code>fadeIn()</code> is called, otherwise the call is ignored.		* Note that SoundSpriteFader transitons do not account for load latency, so preloading sounds before playback is recommended.		* @param targetVolume  The target volume to fade in to, expressed as a number greater than 0 and less than or equal to 1.		* @param seconds  Number of seconds (emphasis: seconds, not milliseconds) over which to transition the sound from its current volume.		* @param standardizeRate  Specifies if the fade duration should be adjusted to a standard rate based on a 100% shift in volume range.		* For example, if <code>$seconds</code> is 2 and volume shifts from 0 to 0.5, then the fade only spans 1 second since only half the volume range was covered.		* This methodology is employed to allow easy implementation of consistent transition rates, regardless of current and target volume differential.		*/		public function fadeIn($targetVolume:Number=1, $seconds:Number=2, $standardizeRate:Boolean=true):void		{			stop();						if ($targetVolume > 0)			{				super.volume = 0;				_destroyAfterTrans = false;				_configureTransition($targetVolume, $seconds, $standardizeRate);				play();			}		}				/**		* Gradually fades out a playing sound.		* @param seconds  Number of seconds (emphasis: seconds, not milliseconds) over which to transition the sound from its current volume.		* @param standardizeRate  Specifies if the fade duration should be adjusted to a standard rate based on a 100% shift in volume range.		* For example, if <code>$seconds</code> is 2 and volume shifts from 0.5 to 0, then the fade only spans 1 second since only half the volume range was covered.		* This methodology is employed to allow easy implementation of consistent transition rates, regardless of current and target volume differential.		* @param destroy Flags the sound for destruction after fade-out is complete. This parameter allows the sound to be orphaned immediately after calling <code>fadeOut()</code>.		*/		public function fadeOut($seconds:Number=2, $standardizeRate:Boolean=true, $destroy:Boolean=false):void		{			if (playing && volume > 0) {				_destroyAfterTrans = $destroy;				_configureTransition(0, $seconds, $standardizeRate);			}			else if ($destroy) {				destroy();			}		}				/**		* Recalibrates any existing transition with new settings.		* Use this method to change the duration of the transition that is currently playing.		* A sound is automatically recalibrated if you change its volume during a transition.		* @param targetVolume  Target volume to transition to. If value is -1 (default), then the current target setting is used.		* @param seconds  Number of seconds (not millisconds) over which to play the transition. If value is -1 (default), then the current duration is used.		* @param standardizeRate  If a new duration of seconds is set, then this param will specify if the duration should be standardized.		* @see #transitioning		*/		public function recalibrate($targetVolume:Number=-1, $seconds:Number=-1, $standardizeRate:Boolean=true):void		{			// update target transition volume, if specified.			if ($targetVolume >= 0) _transTarget = $targetVolume;			// set transition time, if specified.			if ($seconds > 0) {				_transMilliseconds = ($standardizeRate ? _standardizeRate(volume, $targetVolume, $seconds) : $seconds) * 1000;			}						// flag whether timer should resume playback after calibration.			var $resume:Boolean = _transTimer.running;						// recalibrate the timer			_transTimer.stop();			_transTimer.delay = 1000/fps;			_transTimer.repeatCount = _transMilliseconds / _transTimer.delay;			_transTimer.reset();			_transRange = _transTarget - volume;			// if timer was running, resume playback.			if ($resume) _transTimer.start();		}			//-------------------------------------------------	// Fade methods	//-------------------------------------------------			/**		* @private		* Configures a fade transition.		* @param targetVolume  The target volume to fade to.		* @param seconds  The number of seconds (not millisconds) over which to transition.		* @param standardizeRate  Specifies if the seconds duration should be adjusted to the range of the fade.		*/		private function _configureTransition($targetVolume:Number, $seconds:Number, $standardizeRate:Boolean):void 		{			// disable any existing fade.			_enableTransition(false);						// recalibrates the transition			recalibrate($targetVolume, $seconds, $standardizeRate);			// enable new fade timer.			_enableTransition(true);			_transTimer.reset();			_transTimer.start();		}				/**		* @private		* Toggles the fade tween timer's configuration.		* @param enable  Specifies if the fade tween timer should be enabled or disabled.		*/		private function _enableTransition($enable:Boolean):void		{			if ($enable && !_transEnabled) {				_transTimer.addEventListener(TimerEvent.TIMER, this._onTimerFrame);				_transTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this._onTimerFrame);			}			else if (!$enable && _transEnabled) {				_transTimer.removeEventListener(TimerEvent.TIMER, this._onTimerFrame);				_transTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this._onTimerFrame);				_transTimer.stop();			}			_transEnabled = $enable;		}				/**		* @private		* Adjusts a transition's maximum duration relative to the starting and target values.		* @param $startValue: the property's starting percentage value (0 - 1)		* @param $targetValue: the target percentage value to transition the property to (0 - 1)		* @param $maxDuration: the full length of transition assuming the maximum possible range is covered.		*/		private function _standardizeRate($startValue:Number, $targetValue:Number, $maxDuration:Number):Number		{			var $startLimit:Number = ($startValue < $targetValue) ? $startValue : 1-$startValue;			var $targetLimit:Number = ($startValue > $targetValue) ? $targetValue : 1-$targetValue;			return $maxDuration * (1 - ($startLimit + $targetLimit));		}			//-------------------------------------------------	// Event handlers	//-------------------------------------------------				/**		* @private		* handler for the fade's framerate.		*/		private function _onTimerFrame($event:TimerEvent):void		{			// set volume on supercalss.			super.volume = _transTarget - (_transRange * (1 - _transTimer.currentCount / _transTimer.repeatCount));						// decrement the time remaining in the transition.			_transMilliseconds -= _transTimer.delay;						// If timer has completed,			if (!_transTimer.running)			{				// deactive transition.				_enableTransition(false);				dispatchEvent(new SoundSkinEvent(SoundSkinEvent.SOUND_FADE));				if (_destroyAfterTrans) destroy();			}		}	}}