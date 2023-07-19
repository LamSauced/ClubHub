sub init()
    m.top.functionname = "parse_xml"
    'm.top.response = ""
end sub
  
function parse_xml()
    ? "started parse_xml"
    videocontent = createObject("RoSGNode","ContentNode")

    videoxml = createObject("roXMLElement")

    'readInternet = createObject("roUrlTransfer")
    'readInternet.setUrl(m.top.postergriduri)
    xmlascii = ReadAsciiFile("pkg:/source/badminton_videos.xml")
    videoxml.parse(xmlascii)

    if videoxml.getName()="video_rows"
        for each node in videoxml.GetNamedElements("videosinarow")
            for each vidinfo in node.GetNamedElements("url")
                ? "vidinfo: "; vidinfo
                videocontent = videocontent.createChild("ContentNode")
                videocontent.setFields(vidinfo.getAttributes())
            end for
            print "videocontent: "; videocontent
        end for
        ? "completed parse_xml"
    end if

    m.top.thing = videocontent
  end function

  'what's the color of the electric sheep you see?