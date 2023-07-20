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
	m.splash_screen.setFocus(true)
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

sub onClubSelected(obj)
	m.video_select_screen.component_name = m.club_select_screen.getField("selected_club_content")
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
	m.top.dialog = m.error_dialog
end sub

function onKeyEvent(key, press) as Boolean
	? "[home_scene] onKeyEvent", key, press
	if key = "back" and press
		if m.video_select_screen.visible
			m.video_select_screen.visible=false
			m.club_select_screen.visible=true
			return true
		end if
	end if
  return false
end function