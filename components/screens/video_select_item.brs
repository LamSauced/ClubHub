sub init()
  m.itemposter = m.top.findNode("itemPoster") 
  m.itemlabel = m.top.findNode("itemLabel")
 end sub

sub showcontent()
  itemcontent = m.top.itemContent
  m.itemposter.uri = itemcontent.HDPosterUrl
  m.itemlabel.text = itemcontent.title
end sub