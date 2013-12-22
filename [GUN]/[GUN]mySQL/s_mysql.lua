
	IPB = {}
	
	function mySQL_connect()
			IPB["connection"] = dbConnect ( "mysql", "dbname=iroleplay.pl;host=185.25.148.85;port=3306" ,"mta", "patr0" )
			if mySQL then
				outputDebugString ("mySQL connected", 3)
				return true
			else return false end
		
	end
	mySQL_connect()
	
	function IPB:loginPlayer(login, pass)
		if IPB["connection"] and login then
			local user = dbQuery( IPB["connection"], "SELECT member_id FROM forum_members WHERE members_l_username = '"..login.."' AND members_pass_hash= MD5(CONCAT(MD5(members_pass_salt),'', MD5( '".. pass .. "' )))")	
			local result, num_affected_rows, last_insert_id = dbPoll( user, -1 )
			if #result > 0 then
				return true
			else
				return false
			end
		else
			outputDebugString ("mySQL connection or user data missing",1 )
			return false
		end
	end
	
	function IPB:isUser(user)
		if IPB["connection"] and user then
			local user = dbQuery( IPB["connection"], "SELECT member_id FROM forum_members WHERE members_l_username = '"..getPlayerName (user).."'")	
			local result, num_affected_rows, last_insert_id = dbPoll( user, -1 )
			if result then
				for k,table in pairs (result) do
					for k,v in pairs (table) do
						return true, v
					end
				end
			else
				return false
			end
		else
			outputDebugString ("mySQL connection or user data missing",1 )
			return false
		end
	end
	
	function IPB:getUserData(UID, column)
		if IPB["connection"] and UID and column then
				local data = dbQuery( IPB["connection"], "SELECT "..column.." FROM forum_members WHERE member_id = '"..UID.."'")	
				local result, num_affected_rows, last_insert_id = dbPoll( data, -1 )
				if result then
				for k,table in pairs (result) do
					for k,v in pairs (table) do
						return true, v
					end
				end
				else
					return false
				end
		else
			outputDebugString ("mySQL connection or function data missing",1 )
			return false
		end
	end
	
		function IPB:getPlayerAvatar(UID)
			local files = {}
			function file (responseData, errno, gravatar)
				if errno == 0 then
					outputChatBox ("coś znaleziono")
					return true, responseData
				elseif gravatar then
				  return false
				end
			end
		local bool, email = IPB:getUserData(UID, "email")
		local email = md5 (email)	
		local gravatar = fetchRemote ( "http://gravatar.com/avatar/"..email.."",  file, "", false, true)	
		local file = fetchRemote ( "http://iroleplay.pl/uploads/profile/photo-"..UID..".jpg", file, "")
	end
	IPB:getPlayerAvatar(4)

	