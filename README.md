001_Kongregate-API
==================

An easy way to connect to- and use the Kongregate API for ActionScript 3.0!

==================

Using the Kongregate API has never been so easy! Simply connect the stage to Kongregate using 
a few lines and start to use many methods!

A short example is shown in src/Main.as which shows how to connect and use the class.

Full list of available methods:
 - Login (registers when the user logged in on Kongregate through the 'Welcome' dialog. This allows the user to login without having to refresh the page/game)
 - ShowRegistrationBox (prompts a registration lightbox to the user)
 - SaveSharedContent (save shared content to the Kongregate server)
 - BrowseSharedContent (Show a list of shared content in the user's browser to allow the user to view, rate or load shared content)
 - SubmitStatistic (submit a stat to the Kongregate server)
 - SubmitAvatar (submit an avatar of the user to the Kongregate server)
 - PurchaseItem (open the 'Purchase Items' lightbox
 - PurchaseKreds (open the 'Purchase Kreds' lightbox)
 - RequestInventory (request the inventory of the user)
 - ShowTab (show a specific tab in the chat)
 - PostShout (post a 'shout' to the user's profile)
 - SendPrivateMessage (send a private message to the user)
 - InviteFriend (invite someone on the user's friendlist to the game)
 - get User (returns the user object)
 - get Username (returns the username of the user)
 - get UserId (returns the userId of the user)
 - get Guest (returns true/false whether the user is a guest)
 - get GameAuthToken (returns the game authentication token)

All methods are called using Kongregate.API. Example: Kongregate.API.Login();

Get ready to create your social games on http://www.kongregate.com/ now!
