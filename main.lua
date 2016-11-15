local voiceToText = require "plugin.voiceToText"
local myText2 = display.newText( "blank", display.contentCenterX, display.contentCenterY-100 , native.systemFont )
local myText = display.newText( "Start", display.contentCenterX, display.contentCenterY , native.systemFont )
local showPermissionPopup
local microphoneAccess = false

local function appPermissionsListener( event )
    
    for k,v in pairs( event.grantedAppPermissions ) do
        if ( v == "Microphone" ) then
            microphoneAccess = true
            print( "Microphone permission granted!" )
        end
    end
    if microphoneAccess == false then
        print( "Microphone permission not granted" )
    end
end

function showPermissionPopup(  )
    local options =
    {
        appPermission = "Microphone",
        urgency = "Critical",
        listener = appPermissionsListener,
        rationaleTitle = "Microphone access required",
        rationaleDescription = "Microphone access is required to take photos. Re-request now?",
        settingsRedirectTitle = "Alert",
        settingsRedirectDescription = "Without the ability to use microphone, this app cannot properly function. Please grant microphone access within Settings."
    }
    native.showPopup( "requestAppPermission", options )
end

myText:addEventListener("tap", function(e)
    if(myText.text == "Start")then
        voiceToText.startRecording()
        myText.text ="Stop"
    elseif(myText.text == "Stop")then
        myText.text ="Start"
        voiceToText.stopRecording()
    end
end)

voiceToText.init(function(e)
    local json = require("json")
    if(e) then
        print("init")
        print("--------")
        print(json.encode(e))
        print("--------")
    end
    if e.speech then
        myText2.text =e.speech
    end
    if e.response == "stopped" then
        myText.text ="Start"
    end

end)

--show permission
showPermissionPopup(  )