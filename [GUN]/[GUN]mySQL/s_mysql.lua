
	IPB = {}
	
	function mySQL_connect()
			IPB["connection"] = dbConnect ( "mysql", "dbname=iroleplay.pl;host=185.25.148.85;port=3306" ,"mta", "patr0" )
			if IPB["connection"] then
				outputDebugString ("mySQL connected", 3)
				return true
			else return false end
		
	end
	mySQL_connect()
	
	function IPB_loginPlayer(login, pass)
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
	
	function IPB_isUser(user)
		if IPB["connection"] and user then
				if type(user) ~= "string" and type(user) ~= "number" then
					local user = getPlayerName (user)
				end
			local user = dbQuery( IPB["connection"], "SELECT member_id FROM forum_members WHERE member_id = '"..user.."' OR members_l_username = '"..user.."'")	
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
	
	function IPB_getUserData(UID, column)
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
	
	function IPB_getPlayerAvatar(UID)
				function file (image, errno, gravatar)
					if errno == 0 then
						if image then
							return true, image
						end
					elseif gravatar then
						return false
					end
				end
			local bool, email = IPB_getUserData(UID, "email")
			local email = md5 (email)	
			local gravatar = fetchRemote ( "http://gravatar.com/avatar/"..email.."",  file, "", false, true)	
			local _ = fetchRemote ( "http://iroleplay.pl/uploads/profile/photo-"..UID..".jpg", file, "")
	end


	