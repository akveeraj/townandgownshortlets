<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query  = Request.QueryString
	o_Query  = UrlDecode( o_Query )
	o_Query  = Replace( o_Query, "=", ":" )
	o_Query  = Replace( o_Query, "&", ";" )
	o_Query  = Replace( o_Query, "-", ";" )
	o_Query  = Replace( o_Query, ";", vbcrlf )
	
	UserName = ParseCircuit( "user", o_Query )
	Password = ParseCircuit( "pass", o_Query )
	AuthPass = Sha1( Password )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Username or Email Address
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  LoginSQL = "SELECT COUNT(uIndex) AS NumberOfRecords FROM members WHERE screenname='" & UserName & "' AND status='1' " & _
	           " OR emailaddress='" & UserName & "' AND status='1'"
						 Call FetchData( LoginSQL, LoginRs, ConnTemp )
						 
	LoginCount = LoginRs("NumberOfRecords")
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get original password for authentication
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If LoginCount > "0" Then
	
	  LoginSQL = "SELECT * FROM members WHERE screenname='" & UserName & "' AND status='1' " & _
		           " OR emailaddress='" & UserName & "' AND status='1'"
							 Call FetchData( LoginSQL, LoginRs, ConnTemp )
							 
		CurrentPassword = LoginRs("password")
		AccountStatus   = LoginRs("status")
		Token           = LoginRs("customerid")
		UserId          = Token
		Firstname       = LoginRs("firstname")
		Surname         = LoginRs("surname")
		EmailAddress    = LoginRs("emailaddress")
		Username        = LoginRs("screenname")
	
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
	If LoginCount = "0" Then
	  ResponseCode = 1
		ResponseText = "User / Email Address not found"
	
	ElseIf AuthPass <> CurrentPassword Then
	  ResponseCode = 2
		ResponseText = "Invalid Password"
	
	ElseIf AccountStatus = "2" Then
    ResposnseCode = 3
		ResponseText  = "Account Suspended. Please contact us"
		
	Else ' Authorized
	
	  ResponseCode = 4
		ResponseText = ""
		
		Response.Cookies("tandg")("token")       = Token
		Response.Cookies("tandg")("userid")      = UserId
		Response.Cookies("tandg")("loggedin")    = 1
		Response.Cookies("tandg")("firstname")   = Firstname
		Response.Cookies("tandg")("surname")     = Surname
		Response.Cookies("tandg")("email")       = EmailAddress
		Response.Cookies("tandg")("username")    = Username
		
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	JSOn = "{'responsecode':'" & ResponseCode & "','username':'" & UserId & "', 'responsetext':'" & ResponseText & "'}"
	Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>