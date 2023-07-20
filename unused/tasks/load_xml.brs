sub init()
    m.top.functionname = "getxml"
end sub

function getxml()
    contentxml = createobject("roXMLElement")
    url = CreateObject("roUrlTransfer")
    url.SetUrl(m.top.load_url)
    contentxml = url.GetToString()
    m.top.content = contentxml
end function



