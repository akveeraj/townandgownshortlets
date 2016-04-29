<!--#include virtual="/includes.inc"-->
<%
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ' --------------------------------------------------------------------------------------------------------------------------------------
	
	o_Query    = fw_Query
	o_Query    = UrlDecode( o_Query )
	
	ImgUrl     = ParseCircuit( "url", o_Query )
	ListingId  = ParseCircuit( "listingid", o_Query )
	Table      = ParseCircuit( "table", o_Query )
	
// ' --------------------------------------------------------------------------------------------------------------------------------------

  ImgSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM " & Table & " WHERE listingid='" & ListingId & "'"
	           Call FetchData( ImgSQL, ImgRs, ConnTemp )
					 
	ImgCount = ImgRs("NumberOfRecords")
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Initial Image
// ' --------------------------------------------------------------------------------------------------------------------------------------

  If ImgCount > "0" Then
	
    ImgSQL = "SELECT * FROM " & Table & " WHERE listingid='" & ListingId & "'"
		         Call FetchData( ImgSQL, ImgRs, ConnTemp )
						 
						 ShortDescription = ImgRs("shortdescription")
	
	End If
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Gallery Images
// ' --------------------------------------------------------------------------------------------------------------------------------------

  GalSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
					 
	GalCount = GalRs("NumberOfRecords")
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
	
	If GalCount > "0" Then
	
	  GalSQL = "SELECT * FROM galleryphotos WHERE advertid='" & ListingId & "' ORDER BY uIndex ASC"
		         Call FetchData( GalSQL, GalRs, ConnTemp )
						 
		ImgNumber = 1
						 
		Do While Not GalRs.Eof
		  ImgNumber = ImgNumber + 1
		  ImgSrc    = "/uploads/thumbs/" & GalRs("photo")
			OrigSrc   = "/uploads/src/" & GalRs("photo") 
		  GalImg    = GalImg &  "<span class='modal-imgthumb'><a href='javascript://' title='Click to view image " & ImgNumber & "' onclick=""SwapGalleryThumb('" & OrigSrc & "', '" & ShortDescription & " - Image " & ImgNumber & "');""><img src='" & ImgSrc & "'/></a></span>" & vbcrlf
		
		GalRs.MoveNext
		Loop
	
	End If 
	
	NewGalCount = GalCount

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='gallery-header'>
  <span class='gallery-label'>Gallery</span>
	<span class='gallery-close'><a href='javascript://' onclick="CloseGalleryBox();" title='Close'></a></span>
</div>



<div class='modal-galleryholder'>

<% If GalCount > "0" Then %>

  <span class='cell' style='width:430px; margin-right:5px;'><img src='/uploads/src/<%=ImgUrl%>' id='mainimg'/><span class='smalldescription' id='smalldescription'><%=ShortDescription%> - Image 1</span></span>
	
	
	<!-- get image list -->
	
  <div class='modal-imglist'>
	
	<span class='modal-imgthumb'><a href='javascript://' title='Click to view image 1' onclick="SwapGalleryThumb('/uploads/src/<%=ImgUrl%>', '<%=ShortDescription%> - Image 1');"><img src='/uploads/thumbs/<%=ImgUrl%>'/></a></span>
	<%=GalImg%>
	
	</div>
	
<% Else %>

  <span class='largecell' style='width:540px;'><img src='/uploads/src/<%=ImgUrl%>'/><span class='largedescription'><%=ShortDescription%></span></span>

<% End If %>
	
	
	<!-- end get image list -->

</div>