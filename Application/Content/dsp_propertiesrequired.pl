<!--#include virtual="/includes.inc"-->

<%
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ' --------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query
	o_Query      = UrlDecode( o_Query )
	o_Page       = ParseCircuit( "page", o_Query )
	o_Error      = ParseCircuit( "ecode", o_Query )
	o_Scroll     = ParseCircuit( "scroll", o_Query )
	
	CurrentDay   = Day(Now)
	CurrentMonth = Month(Now)
	CurrentYear  = Year(Now) 

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
// ' Build Properties Wanted List
// ' --------------------------------------------------------------------------------------------------------------------------------------

  ProReqSQL = "SELECT COUNT(uIndex) AS NumberOfRecords FROM propertiesrequired WHERE status='1'"
	            Call FetchData( ProReqSQL, ProReqRs, ConnTemp )
							
							AdCount   = ProReqRs("NumberOfRecords")
							PageCount = CountPages( CLng( AdCount ) / CLng( PageSize ))
							
	If AdCount > "0" Then
	
	  ProReqSQL = "SELECT * FROM propertiesrequired WHERE status='1' ORDER BY dateinserted DESC LIMIT " & Limit1 & ", " & Limit2
		            Call FetchData( ProReqSQL, ProReqRs, ConnTemp )
								
	End If
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Build Paging Links
// ' --------------------------------------------------------------------------------------------------------------------------------------

     PageNumber = 0
		 
		 For Ni = 1 to PageCount
		   PageNumber = PageNumber + 1
			 
			 If Ni < CInt(CurrentPage) Then
			   PageLinks = PageLinks & "<span class='pagingon'><a href='/propertiesrequired/doc/?page:" & Ni & "' title='Go to page " & Ni & "'>" & Ni & "</a></span>"
			 ElseIf Ni > CInt(CurrentPage) Then
			   PageLinks = PageLinks & "<span class='pagingon'><a href='/propertiesrequired/doc/?page:" & Ni & "' title='Go to page " & Ni & "'>" & Ni & "</a></span>"
			 Else
			   PageLinks = PageLinks & "<span class='pagingoff'>" & Ni & "</span>"
			 End If
			 
		 Next
		 
		 PageLinks = PageLinks

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Properties Required ~ Town and Gown Lettings Ltd. Oxford";
});
</script>


<div class='mainheader'>Properties Required</div>
<div class='maintext' style=''>


<br/>

<!-- start edit -->

<div style='font-size:15pt; margin-top:8px; margin-bottom:5px; text-align:centre;'>For Tenants looking for Properties, please contact us to discuss your requirements.</div>

<!-- end edit -->

</div>

<%
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Build List
// ' --------------------------------------------------------------------------------------------------------------------------------------

  AdNumber = 0
	If AdCount > "0" Then
	  DO WHILE NOT ProReqRs.Eof
		  AdNumber = AdNumber + 1
			
		If AdNumber Mod 2 = 1 Then
		  TableStyle = "propertyrow_on"
		Else
		  TableStyle = "propertyrow"
		End If
		
// ' --------------------------------------------------------------------------------------------------------------------------------------

  AdvertId         = ProReqRs("advertid")
	CustomerId       = ProReqRs("customerid")
	LongDescription  = ProReqRs("description")
	DateInserted     = ProReqRs("dateinserted")
	Telephone        = ProReqRs("telephone")
	EmailAddress     = ProReqRs("emailaddress")
	Salutation       = ProReqRs("salutation")
	Firstname        = ProReqRs("firstname")
	Surname          = ProReqRs("surname")
	Status           = ProReqRs("status")
	'AuthorStamp      = "Submitted By " & Salutation & " " & Left( Surname, 1 )
									 
	NewAdvert      = "<b>" 
	Str            = LongDescription
	
	For i = 1 to 5
	  SpacePos  = Instr( Str, " " )
		Word      = Left( Str, SpacePos )
		Str       = Right( Str, Len( Str ) - SpacePos )
		NewAdvert = NewAdvert & Word
	Next
	  NewAdvert = NewAdvert & "</b>"
		NewAdvert = NewAdvert & Str
  
// ' --------------------------------------------------------------------------------------------------------------------------------------
%>

  <div class='<%=TableStyle%>'>
	  <span class='cell' style='width:760px;'><span class='description'><%=NewAdvert%></span></span>
	</div>

<%
// ' --------------------------------------------------------------------------------------------------------------------------------------

  ProReqRs.MoveNext
	Loop
	
	Else
	  
		Response.Write "<div style='display:block; clear:both; margin-left:10px; margin-top:15px;'><img src='/application/library/media/reqired_splash1.png'/></div>"
	
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