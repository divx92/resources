
	IPB = {}
	
	function mySQL_connect()
			IPB["connection"] = dbConnect ( "mysql", "dbname=iroleplay.pl;host=185.25.148.85;port=3306" ,"mta", "patr0" )
			if mySQL then
				outputDebugString ("mySQL connected", 3)
				return true
			else return false end
		
	end
	mySQL_connect()

	function IPB:isUser(user)
		if IPB["connection"] then
			local nick = "patr0" 
			local user = dbQuery( IPB["connection"], "SELECT member_id FROM forum_members WHERE members_l_username = '"..nick.."'")	
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
			outputDebugString ("mySQL connection missing")
			return false
		end
	end
	IPB:isUser(user)
	
	function IPB:getUserData(UID)
		if IPB["connection"] then
			outputChatBox ("asd")
		else
		
		end
	end
	
	--[[
	function mysql_playerConnect(user, pass)
		login = "patr0"
		password = "ecdca4dee412d925915919067abd369b"
		if mySQL then
			player = dbQuery( mySQL, "SELECT email FROM forum_members WHERE members_l_username = '"..login.."' AND members_pass_hash = '"..tostring(password).."' ")
			
			
			local result, num_affected_rows, last_insert_id = dbPoll( player, -1 )
			for k,v in pairs (result) do
				for k,ID in pairs (v) do
						outputChatBox (tostring(ID))
						setElementData (user, "UID", ID)
						return true, ID
				end
			end
			if result == nil then
				outputConsole( "dbPoll result not ready yet" )
			elseif result == false then
				local error_code,error_msg = num_affected_rows,last_insert_id
				outputConsole( "dbPoll failed. Error code: " .. tostring(error_code) .. "  Error message: " .. tostring(error_msg) )
			else
				outputConsole( "dbPoll succeeded. Number of affected rows: " .. tostring(num_affected_rows) .. "  Last insert id: " .. tostring(last_insert_id) )
			end
			end
		end
		addCommandHandler ("user", mysql_playerConnect)
		]]
	