<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Global Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = fw_Query 
	o_Query = UrlDecode( o_Query )
	
	ShelfId = ParseCircuit( "shelfid", o_Query )
	
  If ShelfId = "" Then
	  ShelfId = 3
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Project Cookies
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Global_Token         = Request.Cookies("tandg")("token")
	Global_UserId        = Request.Cookies("tandg")("userid")
	Global_FirstName     = Request.Cookies("tandg")("firstname")
	Global_Surname       = Request.Cookies("tandg")("surname")
	Global_Email         = Request.Cookies("tandg")("email")
	Global_Username      = Request.Cookies("tandg")("username")
	Global_AccountType   = Request.Cookies("tandg")("accounttype")
	Global_AccountPUse   = Request.Cookies("tandg")("accountpuse") 
	Global_Avatar        = Request.Cookies("tandg")("avatar")
	Global_PayPalID      = Request.Cookies("tandg")("paypalid")
	Global_ClearLimit    = 7
	Global_Fee           = 100.00
	Global_AcceptCookies = Request.Cookies("tandg")("acceptcookies")
	Global_Telephone     = "07585 703 177"
	Global_LoginCheck    = Request.Cookies("tandg")("loggedin")
	
	
	If Global_Token = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_UserId = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_FirstName = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_Surname = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_LoginCheck = "" OR Global_LoginChek = "0" Then
	  Session_LoggedIn = 0
	Else
	  Session_LoggedIn = 1
	End If
	
	Global_LoggedIn = Session_LoggedIn
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>