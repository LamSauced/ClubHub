function init()
	? "[home_scene] init"
	m.splash_screen = m.top.findNode("splash_screen")
	m.club_select_screen = m.top.findNode("club_select_screen")
	m.video_select_screen = m.top.findNode("video_select_screen")
	m.error_dialog = m.top.findNode("error_dialog")
	m.videoplayer = m.top.findNode("videoplayer")
	initializeVideoPlayer()

	m.splash_screen.observeField("splash_finished", "onSplashFinished")
	m.club_select_screen.observeField("club_selected", "onClubSelected") 
	'm.video_select_screen.observeField("video_selected", "onVideoSelected") 
	m.splash_screen.setFocus(true)
	loadConfig()
end function

sub initializeVideoPlayer()
	m.videoplayer.EnableCookies()
	m.videoplayer.setCertificatesFile("common:/certs/ca-bundle.crt")
	m.videoplayer.InitClientCertificates()
	'set position notification to 1 second
	m.videoplayer.notificationInterval=1
	m.videoplayer.observeFieldScoped("position", "onPlayerPositionChanged")
	m.videoplayer.observeFieldScoped("state", "onPlayerStateChanged")
end sub

sub loadConfig()
    m.config_task = createObject("roSGNode", "load_config_task")
    m.config_task.observeField("error", "onConfigError")
    m.config_task.filepath = "resources/config.json"
    m.config_task.control="RUN"
end sub

sub onConfigError(obj)
	showErrorDialog(obj.getData())
end sub

'sub onVideoSelected(obj)
'	selected_index = obj.getData()
'	'm.media = videoSelectContent.getBody()
'	m.video_select_screen.visible = false
'	m.videoplayer.visible = true
'	m.videoplayer.setFocus(true)
'	m.videoplayer.content = m.selected_media
'	m.videoplayer.control = "play"
'end sub

sub onClubSelected(obj)
	m.club_select_screen.visible=false
	m.video_select_screen.visible=true
end sub

sub onSplashFinished(obj)
	if m.splash_screen.getField("splash_finished") = "finished" then
		m.splash_video = m.splash_screen.findNode("splash_video")
		m.splash_video.visible = false
		m.splash_screen.visible = false
		m.club_select_screen.visible = true
		m.club_select_screen.setFocus(true)
	end if
end sub

sub loadFeed(url)
	m.feed_task = createObject("roSGNode", "load_feed_task")
	m.feed_task.observeField("response", "onFeedResponse")
	m.feed_task.observeField("error", "onFeedError")
	m.feed_task.url = url
	m.feed_task.control = "RUN"
end sub

sub onFeedError(obj)
	showErrorDialog(obj.getData())
end sub

sub onPlayerStateChanged(obj)
    state = obj.getData()
	? "onPlayerStateChanged: ";state
	if state="error"
    	showErrorDialog(m.videoplayer.errorMsg+ chr(10) + "Error Code: "+m.videoplayer.errorCode.toStr())
	else if state = "finished"
		closeVideo()
	end if
end sub

sub closeVideo()
	m.videoplayer.control = "stop"
	m.videoplayer.visible=false
	m.video_select_screen.visible=true
end sub

sub showErrorDialog(message)
	m.error_dialog.title = "ERROR"
	m.error_dialog.message = message
	m.error_dialog.visible=true
	'tell the home scene to own the dialog so the remote behaves'
	m.top.dialog = m.error_dialog
end sub

' Main Remote keypress handler
function onKeyEvent(key, press) as Boolean
	? "[home_scene] onKeyEvent", key, press
	' we must capture the 'true' for press, it comes first (true=down,false=up) to keep the firmware from handling the event
	if key = "back" and press
		if m.video_select_screen.visible
			m.video_select_screen.visible=false
			m.club_select_screen.visible=true
			return true
		else if m.videoplayer.visible
			closeVideo()
			return true
		end if
    else if key = "left" and press
        if m.splash_screen.visible
            m.splash_screen.visible = false
            m.club_select_screen.visible = true
            m.club_select_screen.setFocus(true)
			m.videoplayer.control = "stop"
            return true
        end if
	end if
  return false
end function