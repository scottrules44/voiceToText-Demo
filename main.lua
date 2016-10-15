local voiceToText = require "plugin.voiceToText"

local myText2 = display.newText( "blank", display.contentCenterX, display.contentCenterY-100 , native.systemFont )

local myText = display.newText( "Start", display.contentCenterX, display.contentCenterY , native.systemFont )

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
        print(json.prettify(e))
        print("--------")
    end
    if e.speech then
        myText2.text =e.speech
    end

end)

