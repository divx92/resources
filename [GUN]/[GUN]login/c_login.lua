	local cam = {
	{1977.2264404297 , -977.78271484375 , 126.30809783936 , 1977.6353759766 , -978.650390625 , 126.02552032471 , 0 , 70},
	{1939.0523681641 , -862.92730712891 , 121.83540344238 , 1938.5218505859 , -863.7626953125 , 121.69161224365 , 0 , 70},
	{1880.6090087891 , -774.74127197266 , 146.71339416504 , 1879.6925048828 , -775.10314941406 , 146.54260253906 , 0 , 70} ,
	{1747.826171875 , -551.16461181641 , 106.50849914551 , 1746.8763427734 , -550.94128417969 , 106.28943634033 , 0 , 70 },
	{1697.1885986328 , -273.90618896484 , 109.76409912109 , 1696.2749023438 , -273.55422973633 , 109.56107330322 , 0 , 70} ,
	{1628.1657714844 , 34.099300384521 , 63.269500732422 , 1627.1929931641 , 34.267074584961 , 63.109497070313 , 0 , 70 },
	{1645.3226318359 , 360.79470825195 , 127.00910186768 , 1644.4188232422 , 360.63137817383 , 126.61344146729 , 0 , 70 },
	}

	call (getResourceFromName ("[GUN]blur"), "sw_blur_remote", true)
	
	local function LOGIN_receiveAvatar(data)
		if isElement(login.avatar) then
			destroyElement (login.avatar)
			login.avatar = nil
		else
			outputChatBox ("AVATAR CLIENT :")
			login.avatar = dxCreateTexture (data)
		end
	end
	addEvent ("LOGIN:receiveAvatar", true)
	addEventHandler ("LOGIN:receiveAvatar", root,  LOGIN_receiveAvatar)
	
	local function LOGIN_camAnim(bool)
		if bool then
			local table_pos = 1
				function main_anim ()
						local now = getTickCount()
						local elapsedTime = now - anim.startTime
						local duration = anim.endTime - anim.startTime
						local progress = elapsedTime / duration
						local toCam_x, toCam_y, toCam_z, toCam_x1, toCam_y1, toCam_z1 = unpack (cam[table_pos])
						local x, y, z = interpolateBetween ( cCam_x, cCam_y, cCam_z,
						toCam_x, toCam_y, toCam_z, progress, "Linear")
						local x1, y1, z1 = interpolateBetween ( cCam_x1, cCam_y1, cCam_z1,
						toCam_x1, toCam_y1, toCam_z1, progress, "Linear")
						setCameraMatrix(x, y, z, x1,y2,z1)
						if now >= anim.endTime then
							if table_pos < #cam then
								cCam_x, cCam_y, cCam_z, cCam_x1, cCam_y1, cCam_z1 = getCameraMatrix (getLocalPlayer())
								table_pos =  table_pos + 1
								anim.startTime = getTickCount()
								anim.endTime = anim.startTime + 10000
								outputChatBox (table_pos)
								outputChatBox ("END")
							else
								LOGIN_camAnim (false)
							end
						end
				end
				anim = {}
				anim.startTime = getTickCount()
				anim.endTime = anim.startTime + 10000
				isCamAnim = true
				cCam_x, cCam_y, cCam_z, cCam_x1, cCam_y1, cCam_z1 = getCameraMatrix (getLocalPlayer())
				addEventHandler ("onClientRender", root, main_anim)
			elseif isCamAnim then
				removeEventHandler ("onClientRender", root, main_anim)
			end
	end
	LOGIN_camAnim(true)
	
	local x,y = guiGetScreenSize()
	local login = {
					window = {
					{x/2-256, y/2-256, 512, 512, tocolor (10, 10, 10, 100)}, -- bga
					
					{x/2-128, y/2-40, 256, 40, tocolor (220, 220, 220, 250)}, -- login
					{x/2-128, y/2+20, 256,40, tocolor (220, 220, 220, 250)}, -- pass
					
					{x/2-128, y/2+88, 256,40, tocolor (113, 40, 40, 250)}, -- login
					
					 {x/2-32, y/2-128, 64,64, tocolor (10, 10, 10, 255)},
					},
				texts = {

				},
				avatar = {}
	}
	
	function dx_drawLoginWindow()
		for k,v in pairs (login.window) do
			dxDrawRectangle (unpack(v))
		end
		for k,v in pairs (login.texts) do
			dxDrawText (unpack(v))
		end
		if isElement(login.avatar) then
			dxDrawImage (x/2-32, y/2-128, 64, 64, login.avatars)
		end
	end
	addEventHandler ("onClientRender", root, dx_drawLoginWindow)
	
	function login_cegui()
		showCursor (true)
		local log_ = guiCreateEdit (x/2-128, y/2-40, 256, 40, "login", false) 
		local reg_ = guiCreateEdit (x/2-128, y/2+20, 256, 40, "register", false) 
	end
	login_cegui()
	