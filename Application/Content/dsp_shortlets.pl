<!--#include virtual="/includes.inc"-->

<%
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ' --------------------------------------------------------------------------------------------------------------------------------------

        o_Query       = fw_Query
	o_Query       = UrlDecode( o_Query )
	o_Page        = ParseCircuit( "page", o_Query )
	o_Error       = ParseCircuit( "ecode", o_Query )
	o_Scroll      = ParseCircuit( "scroll", o_Query )
	
	CurrentDay    = Day(Now)
	CurrentMonth  = Month(Now)
	CurrentYear   = Year(Now)
	DateNow       = Date()
	 
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Fix Empty Page
// ' --------------------------------------------------------------------------------------------------------------------------------------

  If IsEmpty( o_Page ) Then
	  o_Page    = 1
	Else
	  o_Page    = o_Page
	End If
	
	CurrentPage = o_Page
	PageSize    = 100
	
	Limit1      = ( o_Page - 1 ) * PageSize
	Limit2      = PageSize

// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Build Property List
// ' --------------------------------------------------------------------------------------------------------------------------------------

  ProSQL = "SELECT COUNT(uIndex) AS NumberOfRecords FROM propertiestorent WHERE status='1'"	        
			 Call FetchData( ProSQL, ProRs, ConnTemp )					
					 AdCount   = ProRs("NumberOfRecords")
					 PageCount = CountPages( CLng( AdCount ) / CLng( PageSize )) 
					 
	If AdCount > "0" Then
	
	  ProSQL = "SELECT * FROM propertiestorent WHERE status='1' ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
		Call FetchData( ProSQL, ProRs, ConnTemp )
	
	End If 
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Build Paging Links
// ' --------------------------------------------------------------------------------------------------------------------------------------

     PageNumber = 0
		 
		 For Ni = 1 to PageCount
		   PageNumber = PageNumber + 1
			 
			 If Ni < CInt(CurrentPage) Then
			   PageLinks = PageLinks & "<span class='pagingon'><a href='/propertiestorent/doc/?page:" & Ni & "' title='Go to page " & Ni & "'>" & Ni & "</a></span>"
			 ElseIf Ni > CInt(CurrentPage) Then
			   PageLinks = PageLinks & "<span class='pagingon'><a href='/propertiestorent/doc/?page:" & Ni & "' title='Go to page " & Ni & "'>" & Ni & "</a></span>"
			 Else
			   PageLinks = PageLinks & "<span class='pagingoff'>" & Ni & "</span>"
			 End If
			 
		 Next
		 
		 PageLinks = PageLinks

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Shortlets to Rent ~ Town and Gown Lettings Ltd. Oxford";
});
</script>



<div class='mainheader'>Shortlets to Rent</div>
<div class='maintext'>

<!-- start edit -->

<div style='font-size:15pt; margin-top:30px; text-align:centre;'>For Landlords looking for Tenants, please contact us to discuss your requirements.</div>

<!-- end edit -->

</div>

<%
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Build List
// ' --------------------------------------------------------------------------------------------------------------------------------------

  AdNumber = 0
	  If AdCount > "0" Then
		  DO WHILE NOT ProRs.Eof
			  AdNumber = AdNumber + 1
				
			If AdNumber Mod 2 = 1 Then
			  TableStyle = "propertyrow_on"
			Else
			  TableStyle = "propertyrow"
			End If

// ' --------------------------------------------------------------------------------------------------------------------------------------
	
	ListingId          = ProRs("listingid")
	AdvertId           = ProRs("advertid")
	CustomerId         = ProRs("customerid")
	DateStamp          = ProRs("datestamp")
	DateTimeStamp      = ProRs("datetimestamp")
	LetType            = ProRs("lettype")
	ShortDescription   = ProRs("shortdescription")
	Description        = ProRs("description")
	ShortLetPrice      = ProRs("shortletprice")
	ShortLetCycle      = ProRs("shortletcycle")
	ShortLetLength     = ProRs("shortletlength")
	ShortLetDuration   = ProRs("shortletduration")
	ShortLetIncBills   = ProRs("shortletincbills")
	LongLetPrice       = ProRs("longletprice")
	LongLetCycle       = ProRs("longletcycle")
	LongLetLength      = ProRs("longletlength")
	LongLetDuration    = ProRs("longletduration")
	LongLetIncBills    = ProRs("longletincbills")
	Thumb              = ProRs("thumb")
	LargeThumb         = ProRs("srcimage")
	Status             = ProRs("status")
	AvailableFromDay   = ProRs("availablefromday")
	AvailableFromMonth = ProRs("availablefrommonth")
	AvailableFromYear  = ProRs("availablefromyear")
	Leased             = ProRs("leased")
	NextAvail          = AvailableFromDay & " / " & AvailableFromMonth & " / " & AvailableFromYear
	Reference          = AdvertId
	LetStatus          = Leased
	
	If Len( LargeThumb ) > 39 Then
	  ShowLargeThumb = 1
	Else
	  ShowLargeThumb = 0
	End If
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Format Content
// ' --------------------------------------------------------------------------------------------------------------------------------------

  ShortDescription = Replace( ShortDescription, ".", "" )
	ShortDescription = UCase( ShortDescription )
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Image Count
// ' --------------------------------------------------------------------------------------------------------------------------------------

  ImgCSQL = "SELECT COUNT(uIndex) AS NumberOFRecords FROM galleryphotos WHERE advertid='" & ListingId & "'"
	          Call FetchData( ImgCSQL, ImgCRs, ConnTemp )
						
	ImageCount = ImgCRs("NumberOfRecords")
	ImageCount = CInt( ImageCount ) + 1
	
	If ImageCount = "1" Then
	  ImgCountLabel = "<span class='imgcount'><a href='javascript://' onclick=""FetchPicture('" & LargeThumb & "', '" & ListingId & "', 'propertiestorent');"">1 of " & ImageCount & " image/s - click to enlarge</a></span>"
	ElseIf ImageCount > "0" Then
	  ImgCountLabel = "<span class='imgcount'><a href='javascript://' onclick=""FetchPicture('" & LargeThumb & "', '" & ListingId & "', 'propertiestorent');"">1 of " & ImageCount & " image/s - click to enlarge</a></span>"
	Else
	  ImgCountLabel = ""
	End If
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Format Prices
// ' --------------------------------------------------------------------------------------------------------------------------------------

    LetPriceLabelStart = "<span class='price'>"
		LetPriceLabelEnd   = "</span>"
		
		If LetType = 1 Then
		  
			LetPriceLabel = "<b>Price&nbsp;:</b><br/>&pound;" & LongLetPrice & "&nbsp;per&nbsp;" & LongLetCycle & " - Longlet (minimum " & LongLetLength & "&nbsp;" & LongLetDuration & ")"
			
			  If LongLetIncBills = "1" or LongLetIncBills = true Then
				  LetPriceLabel = LetPriceLabel & "&nbsp; Including main utility bills"
				Else
				  LetPriceLabel = LetPriceLabel & "&nbsp; Excluding Bills"
				End If 
		
		ElseIf LetType = 2 Then
		  
			LetPriceLabel = "<b>Price&nbsp;:</b><br/>&pound;" & ShortLetPrice & "&nbsp;per&nbsp;" & ShortLetCycle & " - Shortlet (minimum " & ShortLetLength & "&nbsp;" & ShortLetDuration & ")"
			
			If ShortLetIncBills = "1" or ShortLetIncBills = true Then
			  LetPriceLabel = LetPriceLabel & "&nbsp; Including main utility bills"
			Else
			  LetPriceLabel = LetPriceLabel & "&nbsp; Excluding Bills"
			End If
		
		Else
		
		  LongPriceLabel  = "<b>Price&nbsp;:</b><br/>&pound;" & LongLetPrice & "&nbsp;per&nbsp;" & LongLetCycle & " - Longlet (minimum " & LongLetLength & "&nbsp;" & LongLetDuration & ")"
			ShortPriceLabel = "<br/>&pound;" & ShortLetPrice & "&nbsp;per&nbsp;" & ShortLetCycle & " - Shortlet (minimum " & ShortLetLength & "&nbsp;" & ShortLetDuration & ")" 
		  
			If LongLetIncBills = "1" or LongLetIncBills = true Then
			  LongPriceLabel = LongPriceLabel & "&nbsp; Including main utility bills"
			Else
			  LongPriceLabel = LongPriceLabel & "&nbsp; Excluding Bills"
			End If
			
			If ShortLetIncBills = "1" or ShortLetIncBills = true Then
			  ShortPriceLabel = ShortPriceLabel & "&nbsp; Including main utility bills"
			Else
			  ShortPriceLabel = ShortPriceLabel & "&nbsp; Excluding Bills"
			End If
			
			LetPriceLabel = LongPriceLabel & ShortPriceLabel
			
		End If
		
		  LetPriceLabel = LetPriceLabelStart & LetPriceLabel & LetPriceLabelEnd

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>

  <div class='<%=TableStyle%>'>
	
<!-- property information -->
		
		  <div class='cell' style='width:570px;'>
			
			
			<span class='smalldescription'><%=ShortDescription%></span>
			<span class='description'><%=Description%></span>
			<span class='letpricelabel'><%=LetPriceLabel%></span>
			<span class='contact'>For a viewing, call&nbsp;&nbsp;<span class='contactlarge'><%=Fw_Telephone2%></span> quoting reference&nbsp;&nbsp;<span class='contactlarge'><%=Reference%></span>
			
			
		  </div>
			
<!-- end property information -->
		
<!-- property picture -->
			
			
<div class='cell' style='width:212px;'>
			
<%
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Property Image
// ' --------------------------------------------------------------------------------------------------------------------------------------

  If LetStatus = 1 AND ShowLargeThumb = 1 or LetStatus = true AND ShowLargeThumb = 1 Then

	  Response.Write "<div class='cell' style='width:215px;'>" & vbcrlf & _
		               "<div class='picture' style='margin-right:5px;'>" & vbcrlf & _
									 "<a href='javascript://' onclick=""FetchPicture('" & LargeThumb & "', '" & ListingId & "', 'propertiestorent');"" title='Click to enlarge'>" & vbcrlf & _
									 "<img src='/getpropertyimg/actions/?output:1;advertid:" & Advertid & "'/>" & vbcrlf & _
									 "</a></div>" & vbcrlf & _
									 ImgCountLabel & vbcrlf & _
									 "<span class='availabledate'>Next Available:&nbsp;" & NextAvail & "</span>" & vbcrlf & _
								   "</div>" & vbcrlf & vbcrlf
	
	ElseIf LetStatus = 1 AND ShowLargeThumb = 0 or LetStatus = true AND ShowLargeThumb = 0 Then
	  Response.Write "<div class='cell' style='width:215px;'>" & _
		               "<div class='let_nopic'><span class='letnoimg'>&nbsp;</span></div>" & _
									 "<span class='availabledate'>Next Available:&nbsp;" & NextAvail & "</span>" & _
									 "</div>" 
	
	ElseIf LetStatus = 0 AND ShowLargeThumb = 1 or LetStatus = false AND ShowLargeThumb = 1 Then
    Response.Write "<div class='cell' style='width:215px;'>" & vbcrlf & _
	                 "<div class='picture' style='margin-right:5px;'>" & vbcrlf & _
									 "<a href='javascript://' onclick=""FetchPicture('" & LargeThumb & "', '" & ListingId & "', 'propertiestorent');"" title='Click to enlarge'>" & vbcrlf & _
									 "<img src='/getpropertyimg/actions/?output:1;advertid:" & Advertid & "'/>" & vbcrlf & _
									 "</a></div>" & vbcrlf & _
									 ImgCountLabel & vbcrlf & _
								   "</div>" & vbcrlf
	
	ElseIf LetStatus = 0 AND ShowLargeThumb = 0 or LetStatus = false AND ShowLargeThumb = 0 Then
	  Response.Write "<div class='cell' style='width:215px;'>" & _
	                 "<div class='notlet_nopic'><span class='notletnoimg' title='No Photo'>&nbsp;</span></div>" & _
	                 "</div>"
	
	Else
	  Response.Write "<div class='cell' style='width:215px;'>" & _
	                 "<div class='notlet_nopic'><span class='notletnoimg' title='No Photo'>&nbsp;</span></div>" & _
	                 "</div>"
	End If

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>
			
</div>
			
<!-- end property picture -->

	</div>


<%
// ' --------------------------------------------------------------------------------------------------------------------------------------

    ProRs.MoveNext
	  Loop
		
	Else
	
	  Response.Write "<div style='display:block; clear:both; margin-left:0px; margin-top:15px;'><img src='/application/library/media/torent_splash1.png'/></div>"
	
	End If
	

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>

<% If AdCount > "0" Then %>
<div class='pageholder'>

  <span class='cell'> <span class='label'><b>Page:</b></span> </span>
	<span class='cell' style='width:440px;'><%=PageLinks%></span>
	<span class='cell' style='float:right;'> <span class='label' style='text-align:right;'>Page <%=CurrentPage%> of <%=PageCount%></span> </span>

</div>

<% End If %>
