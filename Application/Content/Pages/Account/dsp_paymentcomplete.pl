<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query  = fw_Query
	o_Query  = UrlDecode( o_Query )
	Token    = ParseCircuit( "token", o_Query )
	Edit     = ParseCircuit( "edit", o_Query )
	
	AccSQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM members WHERE customerid='" & Token & "'"
	           Call FetchData( AccSQL, AccRs, ConnTemp )
						 
	AccCount = AccRs("NumberOfRecords")
	
	If AccCount > "0" Then
	
	  AccSQL = "SELECT * FROM members WHERE customerid='" & Token & "'"
		         Call FetchData( AccSQL, AccRs, ConnTemp )
						 
						 Firstname = AccRs("firstname")
						 Email     = AccRs("emailaddress")
	
	End If
	
	If Edit = 1 Then
	  Response.Redirect "/profile/account/"
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<% If AccCount > "0" Then %>

<div class='mainheader'>Registration Complete</div>



<div class='basictext'>
  <br/><b>Welcome, <%=Firstname%></b><br/>Thank you for registering, We have sent a message to 
	`<span class='green'><b><%=Email%></b></span>` confirming your registration.<br/>
	We will be in touch shortly to discuss your requirements.
</div>

<% Else %>
  Sorry, Something Went Wrong
<% End If %>