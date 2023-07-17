sub init()
	' splash_bool = CreateObject("roSGNode", "ContentNode")
	' m.timer = m.top.findNode("splash_timer")
	m.splash_video = m.top.findNode("splash_video")
	playSplashAnimation()
	' m.timer.ObserveField("fire", "onTimerStateChange")
end sub

sub playSplashAnimation()
	splash_content = CreateObject("roSGNode", "ContentNode")
	splash_content.url = "https://sthsroku.net/clubhub/Content/videos/animation7.mp4"
	splash_content.streamformat = "mp4"
	m.splash_video.content = splash_content
	m.splash_video.control ="prebuffer"
	m.splash_video.visible = true
	m.splash_video.setFocus(true)
	m.splash_video.control = "play"
	' m.timer.control = "start"
end sub

' shit down there is probably useless
' sub onTimerStateChange()
'	? "timer finished"
' 	splash_finished = "true"
' end sub

