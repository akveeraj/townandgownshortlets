<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query   = fw_Query
	o_Query   = UrlDecode( o_Query )
	
	Token     = ParseCircuit( "token", o_Query )
	PayMethod = ParseCircuit( "paymethod", o_Query ) 
	PayRef    = ParseCircuit( "ref", o_Query )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PaySQL  = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Token & "'"
	          Call FetchData( PaySQL, PayRs, ConnTemp )
						
// ---------------------------------------------------------------------------------------------------------------------------------------------------
						
	PayCount = PayRs("NumberOfRecords")
	
	If PayCount > "0" Then
	
	  UpdateSQL = " UPDATE members" & _
		            " SET paymentmethod='" & PayMethod & "', " & _
								" payreference='" & PayRef & "'" & _
								" WHERE customerid='" & Token & "'"
								Call SaveRecord( UpdateSQL, UpdateRs, ConnTemp )
								
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Send welcome email
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	  MemSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Token & "'"
		           Call FetchData( MemSQL, MemRs, ConnTemp )
						 
		MemCount = MemRs("NumberOfRecords")
		
		If MemCount > "0" Then
		
		  MemSQL = "SELECT * FROM members WHERE customerid='" & Token & "'"
			         Call FetchData( MemSQL, MemRs, ConnTemp )
							 
							 Title      = MemRs("salutation")
							 Firstname  = MemRs("firstname")
							 Surname    = MemRs("surname")
							 Telephone  = MemRs("telephone")
							 Mobile     = MemRs("mobilenumber")
							 Email      = MemRs("emailaddress")
		End If
		
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	  MxBody =         "<style type='text/css'>" & _
		                 "div.row { display:block; clear:both; padding:5px; }" & _
										 "span.cell { display:block; float:left; margin-right:5px; }" & _
		                 "</style>" & _
		                 "Hello, " & Firstname & Chr(13) & Chr(13) & _
		                 "Thank you for registering on Town and Gown Lettings" & Chr(13) & _
										 " Your registration has been received, A team member will be in touch shortly to discuss your requirements" & Chr(13) & Chr(13) & _

										 "Kind Regards," & Chr(13) & _
										 "Town and Gown Lettings Ltd" & Chr(13) & _
										 "<b>WEBSITE:</b> <a href='http://www.townandgownlettings.co.uk'>www.townandgownlettings.co.uk</a>" & Chr(13) & _
										 "<b>EMAIL:</b> townandgowninfo@aol.com"
										 
		MxBody     = Replace( MxBody, vbcrlf, "<br/>" )
		MxBody     = Replace( MxBody, Chr(13), "<br/>" )
		MxSubject  = "Your Town and Gown Lettings Registration"
		MxTo       = Email
		MxFrom     = "townandgowninfo@aol.com"
		MxReplyTo  = "townandgowninfo@aol.com"
		MxFromName = "Town and Gown Lettings Ltd"
		MxQueue    = True
		MxIsHtml   = True
		MxAppend   = 0
		
		Call PersitsMailer( MxBody, MxSubject, MxTo, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend )
		
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Send notification to site owner
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  MxBody = Firstname & " " & Surname & " has registered their details on" & _
	         " Town and gown Lettings, click the link below to review their account." & Chr(13) & Chr(13) & _
					 " <a href='http://" & Fw__AdminFQDN & "/memberdetails/doc/?customerid:" & Token & "'>http://" & Fw__AdminFQDN & "/memberdetails/doc/?customerid:" & Token & "</a>" & _
					 " ( you may need to log in first or visit the Customer Manager via the control panel )."
					 
	MxBody     = Replace( MxBody, vbcrlf, "<br/>" )
	MxBody     = Replace( MxBody, Chr(13), "<br/>" )
	MxBody     = Replace( MxBody, Chr(10), "<br/>" )
	MxSubject  = Firstname & " " & Surname & " has registered on Town and Gown Lettings"
	MxTo       = "dpostuk@hotmail.com"
	MxReplyTo  = "noreply@townandgownlettings.co.uk"
	MxFromName = "T&G Admin"
	MxQueue    = True
	MxIsHtml   = True
	MxAppend   = 0
	
	Call PersitsMailer( MxBody, MxSubject, MxTo, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
								
								Response.Redirect "/paymentcomplete/account/?token:" & Token & ";paymethod:" & PayMethod
	
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>