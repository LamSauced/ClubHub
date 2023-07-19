sub init()
  m.video_row = m.top.findNode("video_row")
  m.video_row.content = CreateObject("roSGNode", "VolleyballSelectContent")
  m.top.observefield("visible", "onVisibleChange")
  m.selected_video = m.top.findNode("selected_video")
end sub

sub onVisibleChange()
  if m.top.visible = true then
    m.video_row.setFocus(true)
  end if
end sub

sub onItemSelect()
  video_content = CreateObject("roSGNode", "ContentNode")
  ? "it made it here"
  video_content.url = m.video_row.content.getChild(m.video_row.rowItemFocused[0]).getChild(m.video_row.rowItemFocused[1]).url
  video_content.streamFormat = "mp4"
  ? "url", video_content.url
  m.selected_video.content = video_content
	m.selected_video.control ="prebuffer"
	m.selected_video.visible = true
  m.video_row.visible = false
	m.selected_video.setFocus(true)
	m.selected_video.control = "play"
end sub

function onKeyEvent(key, press) as Boolean
	if key = "back" and press
		if m.selected_video.visible
			m.selected_video.visible=false
			m.video_row.visible=true
      m.video_row.setFocus(true)
      m.selected_video.control = "stop"
			return true
		end if
	end if
  return false
end function