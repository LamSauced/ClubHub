sub init()
    m.top.functionName = "readcontent"
  end sub

  sub readcontent()
    videocontent = createObject("RoSGNode","ContentNode")

    videocontentxml = createObject("roXMLElement")

    ' don't need this... maybe
    xmlstring = ReadAsciiFile(m.top.videocontenturi)
    videocontentxml.parse(xmlstring)

    ' imternet
    ' readInternet = createObject("roUrlTransfer")
    ' readInternet.setUrl(m.top.foocontentxmluri)
    ' foocontentxml.parse(readInternet.GetToString())

    if videocontentxml.getName()="Row"
      for each contentrow in videocontentxml.GetNamedElements("ContentRow")
        

      end for
    end if

    m.top.videocontent = videocontent
  end sub