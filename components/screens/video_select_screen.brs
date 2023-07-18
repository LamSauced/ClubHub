sub init()
  m.video_row = m.top.findNode("video_row")
  m.video_row.content = CreateObject("roSGNode", "VideoSelectContent")
  m.top.observefield("visible", "onVisibleChange")
end sub

sub onVisibleChange()
  if m.top.visible = true then
    m.video_row.setFocus(true)
  end if
end sub

sub onItemSelect()
  m.video_content = CreateObject("roSGNode", "ContentNode")
  'initialize variable to row list array
  'parse through list from video_row content to a 2d array
  m.url_list = m.video_row.content.getNamedElements("ContentNode")
  'creates list ro_url initialized to the one of the arrays corresponding with the row selected and initializes that list
  m.row_url = m.url_list[ m.video_row.rowItemSelected[0]].getNamedElements("video_append_node")
  'initializes video_content to the link associated with the element
  m.video_content.url = m.row_url[m.video_row.rowItemSelected[1]]
  
  
	video_content.url = m.video_row.content.getField("url")
	video_content.streamformat = "mp4"
	m.selected_video.control ="prebuffer"
	m.selected_video.visible = true
	m.selected_video.setFocus(true)
	m.selected_video.control = "play"
end sub

