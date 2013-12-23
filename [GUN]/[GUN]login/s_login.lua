	
	LOGIN = {}
	
	function LOGIN_getAvatar(UID)
		--local bool, av = exports["[GUN]mySQL"]:IPB_getPlayerAvatar ( UID )
		local bool, av = call ( getResourceFromName ( "[GUN]mySQL" ), "IPB_getPlayerAvatar", UID )
		outputChatBox (tostring (av))
	--	if bool then
		--	triggerClientEvent ("LOGIN:receiveAvatar", root, avatar)
	--	end
	end
	
	function LOGIN_getPlayer(player)
		local player, UID = exports["[GUN]mySQL"]:IPB_isUser ( player )
		outputChatBox (UID)
		if player then
			LOGIN_getAvatar(UID)
		end
	end
	LOGIN_getPlayer(4)
	addEvent ("LOGIN:getPlayer", true)
	addEventHandler ("LOGIN:getPlayer", root,  LOGIN_getPlayer)
	
	function LOGIN_logPlayer()
	
	end