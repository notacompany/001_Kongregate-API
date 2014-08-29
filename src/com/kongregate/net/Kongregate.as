package com.kongregate.net 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	public class Kongregate extends EventDispatcher
	{
		private static var _Instance:Kongregate = null;
		
		public static function get API():Kongregate
		{
			if (_Instance == null)
				throw new Error("[Kongregate] A new instance of Kongregate has to be created first!");
			
			return _Instance;
		}
		
		private var _API:*;
		private var _APIPath:String;
		private var _Parameters:Object;
		
		
		/**
		 * Description: Constructor.
		 */
		public function Kongregate() 
		{
			_Instance = this;
			
			_API = null;
			_APIPath = null;
			_Parameters = null;
		}
		
		
		/**
		 * Description: Connect to the Kongregate server (will use a shadow .swf when running local).
		 * @param	stage The stage to connect with.
		 */
		public function Connect(stage:Stage):void
		{
			_Parameters = LoaderInfo(stage.loaderInfo).parameters;
			_APIPath = _Parameters.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
			
			Security.allowDomain(_APIPath);
			
			var request:URLRequest = new URLRequest(_APIPath);
			var loader:Loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadingComplete);
			loader.load(request);
			
			stage.addChild(loader);
		}
		
		
		/**
		 * Description: On successfully loaded callback.
		 */
		private function OnLoadingComplete(e:Event):void 
		{
			_API = e.target.content;
			
			_API.services.connect();
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		/**
		 * Description: Adds an event listener for when the user logs in through a 'Welcome' box. This will allow the user to 'login' without having to refresh the page/game.
		 * @param	callback The function to call when completed.
		 */
		public function Login(callback:Function):void
		{
			_API.services.addEventListener("login", callback);
		}
		
		
		/**
		 * Description: Prompt a registration lightbox to the user (WARNING: This method occasionally fails).
		 */
		public function ShowRegistrationBox():void
		{
			_API.services.showRegistrationBox();
		}
		
		
		/**
		 * Description: Save shared content to the Kongregate server.
		 * @param	type The type of the content to save (max. 12 characters).
		 * @param	content The value of content to be saved (strongly recommended to keep under 100K as this may freeze the project).
		 * @param	callback The function to call when completed.
		 * @param	thumbnail The thumbnail to send (optional).
		 * @param	label The label for sub-classing shared content (optional).
		 */
		public function SaveSharedContent(type:String, content:String, callback:Function, thumbnail:DisplayObject = null, label:String = null):void
		{
			if (type.length > 12)
				throw new Error("The property 'type' exceeded the maximum characters of 12.");
			
			_API.sharedContent.save(type, content, callback, thumbnail, label);
		}
		
		
		/**
		 * Description: Show a list of shared content in the user's browser to allow the user to view, rate or load shared content.
		 * @param	contentType The type of content to browse.
		 * @param	sortOrder The order to sort the list in (optional: BY_NEWEST, BY_RATING, BY_LOAD_COUNT, BY_FRIENDS, BY_OWN).
		 * @param	label The label to search content for (optional).
		 */
		public function BrowseSharedContent(contentType:String, sortOrder:String = null, label:String = null):void
		{
			var sortTypes:Array = new Array("BY_NEWEST", "BY_RATING", "BY_LOAD_COUNT", "BY_FRIENDS", "BY_OWN");
			
			if (sortOrder)
				if (sortTypes.indexOf(sortOrder) != -1)
					throw new Error("The property 'sortOrder' contains an invalid value (" + sortOrder + ").");
			
			_API.sharedContent.browse(contentType, sortOrder, label);
		}
		
		
		/**
		 * Description: Submit a stat to the Kongregate server.
		 * @param	statName The name of the statistic.
		 * @param	value The value to submit.
		 */
		public function SubmitStatistic(statName:String, value:int):void
		{
			_API.stats.submit(statName, value);
		}
		
		
		/**
		 * Description: Submit an avatar of the user to the Kongregate server.
		 * @param	avatar The avatar to send. If null, the stage will be snapshotted and be sent instead.
		 * @param	callback The function to call when completed (returns a Boolean).
		 */
		public function SubmitAvatar(avatar:DisplayObject, callback:Function):void
		{
			_API.images.submitAvatar(avatar, callback);
		}
		
		
		/**
		 * Description: Open the 'Purchase Items' dialog box.
		 * @param	items The array of item identfier strings or item/metadata objects.
		 * @param	callback The function to call when completed (returns a Boolean).
		 */
		public function PurchaseItem(items:Array, callback:Function):void
		{
			_API.mtx.purchaseItems(items, callback);
		}
		
		
		/**
		 * Description: Open the 'Purchase Kreds' dialog box (offers, mobile).
		 * @param	purchaseMethod The purchase method to display.
		 */
		public function PurchaseKreds(purchaseMethod:String = "offers"):void
		{
			var methodList:Array = new Array("offers", "mobile");
			
			if (methodList.indexOf(purchaseMethod) != -1)
				throw new Error("The property 'purchaseMethod' contains an invalid value (" + purchaseMethod + ").");
			
			_API.mtx.showKredPurchaseDialog(purchaseMethod);
		}
		
		
		/**
		 * Description: Request the inventory of the user.
		 * @param	username The username to request the inventory for.
		 * @param	callback The function to call when completed (returns an Object).
		 */
		public function RequestInventory(username:String, callback:Function):void
		{
			_API.mtx.requestUserItemList(username, callback);
		}
		
		
		/**
		 * Description: Show a specific tab in the chat (NOTE: this feature is not enabled by default. Contact Kongregate to have it enabled for your project).
		 * @param	name The name of the tab.
		 * @param	description The description of the tab.
		 * @param	options The options for the tab.
		 */
		public function ShowTab(name:String, description:String, options:Object):void
		{
			_API.chat.showTab(name, description, options);
		}
		
		
		/**
		 * Description: Post a 'shout' on the user's profile (NOTE: this feature is not enabled by default. Contact Kongregate to have it enabled for your project).
		 * @param	message The message to post.
		 */
		public function PostShout(message:String):void
		{
			_API.services.showShoutBox(message);
		}
		
		
		/**
		 * Description: Send a private message to the user (NOTE: this feature is not enabled by default. Contact Kongregate to have it enabled for your project).
		 * @param	message The message to send.
		 */
		public function SendPrivateMessage(message:String):void
		{
			_API.services.privateMessage( { content: message } );
		}
		
		
		/**
		 * Description: Invite someone on the user's friendlist to the game (NOTE: this feature is not enabled by default. Contact Kongregate to have it enabled for your project).
		 * @param	message The message included with the invitation. If left blank, a default invitation will be used.
		 * @param	filter Whether to show it to people who everyone or only who have not played yet.
		 */
		public function InviteFriend(message:String, filter:String = "not_played"):void
		{
			var filterTypes:Array = new Array("not_played", "played");
			
			if (!filterTypes.indexOf(filter))
				_API.services.showInvitationBox( { content: message, filter: filter } );
		}
		
		
		/**
		 * Description: Get the user info.
		 */
		public function get User():Object
		{
			return _API.user;
		}
		
		
		/**
		 * Description: Returns the username of the user.
		 */
		public function get Username():String
		{
			return _API.services.getUsername();
		}
		
		
		/**
		 * Description: Returns the user ID of the user.
		 */
		public function get UserId():int
		{
			return _API.services.getUserId();
		}
		
		
		/**
		 * Description: Returns whether the user is a guest or not (true/false).
		 */
		public function get Guest():Boolean
		{
			return _API.services.isGuest();
		}
		
		
		/**
		 * Description: Get the user's game authentication token.
		 */
		public function get GameAuthToken():String
		{
			return _API.services.getGameAuthToken();
		}
	}
}