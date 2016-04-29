<!--#include virtual="/includes.inc"-->

<h1>Service Unavailable</h1>

<%
// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// --------------------------------------------------------------------------------------------------------------------------------------------

	FullName      = Request("fullname" )
	Telephone     = Request( "telephone" )
	EmailAddress  = Request( "email" )
	Message       = Request( "message" )
	Message       = Replace( Message, vbcrlf, "<br/>" )
	Message       = Replace( Message, Chr(13), "<br/>" )
	DateTimeStamp = Year(Now) & "-" & Month(Now) & "-" & Day(Now) & " " & Time
	MessageId     = Sha1( Timer() & Rnd() )
	Subject       = "You have received a message from your website"
	Subject       = FixSingleQuotes( Subject )
	Returnpath    = "/contact/doc/"

// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Temporary Session
// --------------------------------------------------------------------------------------------------------------------------------------------

  Session("frm_contact_fullname")  = FullName
	Session("frm_contact_telephone") = Telephone
	Session("frm_contact_email")     = EmailAddress
	Session("frm_contact_message")   = Message
	
// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Build Message
// --------------------------------------------------------------------------------------------------------------------------------------------

  MessageBody = "<b>You have received a message from " & FullName & "</b>" &  Vbcrlf & Vbcrlf & _
	              "<b>Email Address:</b>&nbsp;&nbsp;" & EmailAddress & vbcrlf & _
								"<b>Telephone Number:</b>&nbsp;&nbsp;" & Telephone & vbcrlf & _
								"<b>Message:</b>&nbsp;&nbsp;" & vbcrlf & vbcrlf & _
								Message & vbcrlf & vbcrlf & _
								"----------------------------------------------------------------------------------------------------------------" & vbcrlf & _
								"To reply to the sender, simply hit the reply button on your email application" & vbcrlf & _
								"----------------------------------------------------------------------------------------------------------------" & vbcrlf
								
								MessageBody = FixSingleQuotes( MessageBody )
								MessageBody = Replace( MessageBody, vbcrlf, "<br/>" )
								MessageBody = Replace( MessageBody, Chr(13), "<br/>" )
								MessageBody = Replace( MessageBody, Chr(10), "<br/>" )
								MxBody      = MessageBody
								MxSubject   = Subject
								MxTo        = "info@townandgownlettings.co.uk"
								MxFrom      = "info@townandgownlettings.co.uk"
								MxReplyTo   = MxFrom
								MxFromName  = "T&G Webmaster"
								MxQueue     = True
								MxIsHtml    = True
								MxAppend    = 0
								
// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// --------------------------------------------------------------------------------------------------------------------------------------------

  If FullName = "" Then
	  Proceed = 0
		Response.Redirect ReturnPath & "?ecode:1"
  ElseIf Telephone = "" or IsNumeric( Telephone ) = False or IsNumeric( Telephone ) = false Then
	  Proceed = 0
		Response.Redirect ReturnPath & "?ecode:2"
	ElseIf EmailAddress = "" or Instr( EmailAddress, "@" ) = 0 or Instr( EmailAddress, "." ) = "0" Then
	  Proceed = 0
		Response.Redirect Returnpath & "?ecode:3"
	ElseIf Message = "" Then
	  Proceed = 0
		Response.Redirect ReturnPath & "?ecode:4"
	Else
	  Proceed = 1
	End If


// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Message
// --------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = 1 Then
  
	SQL = " INSERT INTO mailbox" & _
	      " ( messageid, datesent, mailfrom, mailto, folder, message, subject, status )" & _
				" VALUES( " & _
				" '" & MessageId & "', " & _
				" '" & DateTimeStamp & "', " & _
				" '" & EmailAddress & "', " & _
				" 'info@townandgownlettings.co.uk', " & _
				" '1', " & _
				" '" & MessageBody & "', " & _
				" '" & Subject & "', " & _
				" '1'" & _
				" )"
				
				Call SaveRecord( SQL, RsTemp, ConnTemp )
	
	End If

// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Send Message
// --------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = 1 Then
	
	  Call PersitsMailer( MxBody, MxSubject, MxTo, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend )
	  
		Session("frm_contact_fullname")  = ""
	  Session("frm_contact_telephone") = ""
	  Session("frm_contact_email")     = ""
	  Session("frm_contact_message")   = ""
		
		Response.Redirect ReturnPath & "?sent:1"
	
	End If

// --------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------
%>