package 
{
	import com.kongregate.net.Kongregate;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite 
	{
		private var _Kongregate:Kongregate;
		
		
		/**
		 * Description: Constructor.
		 */
		public function Main():void 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}
		
		
		/**
		 * Description: OnAddedToStage callback.
		 */
		private function OnAddedToStage(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			
			_Kongregate = new Kongregate();
			_Kongregate.addEventListener(Event.COMPLETE, OnKongregateLoaded);
			_Kongregate.Connect(stage);
		}
		
		
		/**
		 * Description: OnKongregateLoaded callback.
		 */
		private function OnKongregateLoaded(e:Event):void 
		{
			// Kongregate is now fully loaded and ready to be used!
			// You can call any method in the class using Kongregate.API
			
			// Example: Check if the user playing your game is a guest or not.
			var isGuest:Boolean = Kongregate.API.Guest;
			
			// Example: If the user is not a guest get the account information.
			if (!isGuest)
			{
				var username:String = Kongregate.API.Username;
				var userId:int = Kongregate.API.UserId;
			}
		}
	}
}
