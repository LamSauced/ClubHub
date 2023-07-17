sub init()
  m.club_list = m.top.findNode("club_row")
  m.club_list.content = CreateObject("roSGNode", "ClubSelectContent")
  m.top.observefield("visible", "onVisibleChange")
end sub

sub onVisibleChange()
  if m.top.visible = true then
    m.club_row.setFocus(true)
  end if
end sub