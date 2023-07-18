sub init()
  m.video_row = m.top.findNode("video_row")
  m.video_row.content = CreateObject("roSGNode", "videoSelectContent")
  m.top.observefield("visible", "onVisibleChange")
end sub

sub onVisibleChange()
  if m.top.visible = true then
    m.video_row.setFocus(true)
  end if
end sub

sub onItemSelect()
  m.video_selected_uri.setField("video_selected_uri", m.video_row.content.getField("url"))
  video_content = CreateObject("roSGNode", "ContentNode")
	video_content.url = m.video_row.content.getField("url")
	video_content.streamformat = "mp4"
	m.selected_video.content = video_content
	m.selected_video.control ="prebuffer"
	m.selected_video.visible = true
	m.selected_video.setFocus(true)
	m.selected_video.control = "play"
end sub

