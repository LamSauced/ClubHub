sub init()
  m.club_row = m.top.findNode("club_row")
  m.club_row.content = CreateObject("roSGNode", "ClubSelectContent")
  m.top.observefield("visible", "onVisibleChange")
end sub

sub onVisibleChange()
  if m.top.visible = true then
    m.club_row.setFocus(true)
  end if
end sub

sub onItemSelect()
  m.top.selected_club_content = m.club_row.content.getChild(0).getChild(m.club_row.rowItemFocused[1]).description
  ? "ref name", m.top.selected_club_content
end sub