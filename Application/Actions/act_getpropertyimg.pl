<!--#include virtual="/includes.inc"-->

<%
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ' --------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
	o_Query     = UrlDecode( o_Query )
	AdvertId    = ParseCircuit( "advertid", o_Query )
	LeasedMark  = "/application/library/media/leasedlabel.png"
	LeasedMark  = Server.MapPath( LeasedMark )
	NoImage     = "/application/library/media/notlet_nopic.png"
	NoImage     = Server.MapPath( NoImage ) 

// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Image Information
// ' --------------------------------------------------------------------------------------------------------------------------------------

  ImgSQL = "SELECT COUNT(uIndex) AS NumberOfRecords FROM propertiestorent WHERE advertid='" & AdvertId & "'"
	         Call FetchData( ImgSQL, ImgRs, ConnTemp )
					 
	ImgCount = ImgRs("NumberOfRecords")
	
	If ImgCount > "0" Then
	
	  ImgSQL = "SELECT * FROM propertiestorent WHERE advertid='" & AdvertId & "'"
		         Call FetchData( ImgSQL, ImgRs, ConnTemp )
						 
		ImgSrc = ImgRs("thumb")
		ImgSrc = "/uploads/thumbs/" & ImgSrc
		ImgSrc = Server.MapPath( ImgSrc )
		Leased = ImgRs("leased")
		
		If Leased = "" Then
		  Leased = "0"
		End If
	
	End If
					 
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Check if file exists
// ' --------------------------------------------------------------------------------------------------------------------------------------

  FileExists    = CheckFileSource( ImgSrc )
	FileDoesExist = FileExists
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Write Image output
// ' --------------------------------------------------------------------------------------------------------------------------------------

  If FileDoesExist = 1 Then
	
	  Set Img  = Server.CreateObject("persits.jpeg")
		Set Img2 = Server.CreateObject("persits.jpeg")
		
		Img.Open ImgSrc
		Img2.Open ImgSrc
		ImgWidth  = Img.OriginalWidth
		ImgHeight = Img.OriginalHeight
		
		Set Jpeg = Server.CreateObject("Persits.Jpeg")
		  Jpeg.Open ImgSrc
			Jpeg.New ImgWidth-1, ImgHeight, &Hffffff
			Jpeg.Canvas.DrawImage -1, -1, Img
			If Leased = 1 Then
			  Jpeg.Canvas.DrawPng ImgWidth-240, ImgHeight-240, LeasedMark
			End If
			
			Jpeg.SendBinary
			
		Set Jpeg = Nothing
		Set Img  = Nothing
		Set Img2 = Nothing
	
	Else
	
	    Set Img  = Server.CreateObject("Persits.Jpeg")
			Set Img2 = Server.CreateObject("Persits.Jpeg")
			  
				Img.Open NoImage
				Img2.Open NoImage
				ImgWidth = Img.OriginalWidth
				ImgHeight = Img.OriginalHeight
			
			Set Jpeg = Server.CreateObject("Persits.Jpeg")
			  Jpeg.Open NoImage
				Jpeg.New ImgWidth-1, ImgHeight, &Hffffff
				Jpeg.Canvas.DrawImage - 1, -1, Img
				If Leased = 1 Then
				  Jpeg.Canvas.DrawPng ImgWidth-220, ImgHeight-185, LeasedMark
				End If
				
				Jpeg.SendBinary
				
			Set Jpeg = Nothing
			Set Img  = Nothing
			Set Img2 = Nothing
	
	End If
	

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>