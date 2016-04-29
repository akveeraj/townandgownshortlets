<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
	o_Query     = UrlDecode( o_Query )
	
	Title       = ParseCircuit( "title", o_Query )
	Firstname   = ParseCircuit( "firstname", o_Query )
	Surname     = ParseCircuit( "surname", o_Query )
	Telephone   = ParseCircuit( "telephone", o_Query )
	Mobile      = ParseCircuit( "mobile", o_Query )
	Email       = ParseCircuit( "email", o_Query )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Username
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  UserSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE screenname='" & User & "'"
	             Call FetchData( UserSQL, UserRs, ConnTemp )
						
	UserCount = UserRs("NumberOfRecords")
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Email Address
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  EmailSQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM members WHERE emailaddress='" & Email & "'"
	              Call FetchData( EmailSQL, EmailRs, ConnTemp )
						 
	EmailCount = EmailRs("NumberOfRecords")
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate Form
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If title = "-" Then
	  Proceed      = 0
		ResponseCode = 1
		ResponseText = "Please select your Title"
	ElseIf Firstname = "" Then
	  Proceed      = 0
		ResponseCode = 2
		ResponseText = "Please enter your First Name"
	ElseIf Surname = "" Then
	  Proceed      = 0
		ResponseCode = 3
		ResponseText = "Please enter your Surname"
	ElseIf Telephone = "" or IsNumeric( Telephone ) = 0 Then
	  Proceed      = 0
		ResponseCode = 4
		ResponseText = "Please enter a valid Telephone Number<br/>Numbers only, no spaces or special characters"
	ElseIf Email = "" or Instr( Email, "@" ) = 0 Then
	  Proceed      = 0
		ResponseCode = 5
		ResponseText = "Please enter a valid Email Address"
	ElseIf Instr( Email, " " ) > 0 Then
	  Proceed      = 0
		ResponseCode = 5
		ResponseText = "Please enter a valid Email Address<br/>Email Addresses do not contain spaces or special characters"
	ElseIf Instr( Email, "." ) = 0 Then
	  Proceed      = 0
		ResponseCode = 5
		ResponseText = "Please enter a valid Email Address"
	'ElseIf EmailCount > "0" Then
	  'Proceed      = 0
		'ResponseCode = 6
		'ResponseText = "The Email Address `" & Email & "` is in use by another member.<br/><br/>Please enter another email address"
	'ElseIf User = "" Then
	'  Proceed      = 0
	'	ResponseCode = 7
	'	ResponseText = "Please enter a Username<br/>This will be used to identify you when you log in"
	'ElseIf Instr( User, " " ) > 0 Then
	'  Proceed      = 0
	'	ResponseCode = 7
	'	ResponseText = "Your username cannot contain spaces!<br/>Please re-enter your username without spaces"
	'ElseIf UserCount > "0" Then
	'  Proceed      = 0
	'	ResponseCode = 8
	'	ResponseText = "The username `" & User & "` is in use by another member.<br/>Please choose a unique username and try again"
	'ElseIf Pass = "" or Len( Pass ) < 5 Then
	'  Proceed      = 0
	'	ResponseCode = 9
	'	ResponseText = "Please enter a Password<br/>Your password must be a minimum of 5 characters/numbers"
	'ElseIf Pass2 <> Pass Then
	'  Proceed      = 0
	'	ResponseCode = 10
	'	ResponseText = "Please re-enter your password.<br/>Your password combinations do not match"
	Else
	  Proceed      = 1
		ResponseCode = 11
		ResponseText = ""
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Member Data
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	If Proceed = 1 Then
	
	  DayNow   = Day(Now)
		MonthNow = Month(Now)
		YearNow  = Year(Now)
		TimeNow  = Time
		
		If Len( DayNow ) = 1 Then
		  DayNow = "0" & DayNow
		End If
		
		If Len( MonthNow ) = 1 Then
		  MonthNow = "0" & MonthNow
		End If
		
		DateStamp     = YearNow & "-" & MonthNow & "-" & DayNow
		DateTimeStamp = YearNow & "-" & MonthNow & "-" & DayNow & " " & TimeNow
		CustomerId    = Sha1( Timer() & Rnd() )
		Token         = CustomerId
		
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    //'On Error Resume Next
	
	  SaveSQL = "INSERT INTO members" & _
		          " ( customerid, salutation, firstname, surname, emailaddress, telephone, mobilenumber, status, datetimestamp, datestamp ) " & _
							" VALUES(" & _
							" '" & CustomerId    & "'," & _
							" '" & Title         & "'," & _
							" '" & Firstname     & "'," & _
							" '" & Surname       & "'," & _
							" '" & Email         & "'," & _
							" '" & Telephone     & "'," & _
							" '" & Mobile        & "'," & _
							" '1'," & _
							" '" & DateTimeStamp & "'," & _
							" '" & DateStamp     & "'"  & _
							")"
							
							Call SaveRecord( SaveSQL, SaveRs, ConnTemp )

	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Session Cookie
// ---------------------------------------------------------------------------------------------------------------------------------------------------

		'Response.Cookies("tandg")("token")       = CustomerId
		'Response.Cookies("tandg")("userid")      = CustomerId
		'Response.Cookies("tandg")("loggedin")    = 1
		'Response.Cookies("tandg")("firstname")   = Firstname
		'Response.Cookies("tandg")("surname")     = Surname
		'Response.Cookies("tandg")("email")       = Email
		'Response.Cookies("tandg")("username")    = User
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSOn Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	JSOn = "{'responsecode':'" & ResponseCode & "', 'responsetext':'" & ResponseText & "', 'token':'" & Token & "'}"
	Response.Write JSOn
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>