<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Log out user
// ---------------------------------------------------------------------------------------------------------------------------------------------------

		Response.Cookies("tandg")("token")       = ""
		Response.Cookies("tandg")("userid")      = ""
		Response.Cookies("tandg")("loggedin")    = ""
		Response.Cookies("tandg")("firstname")   = ""
		Response.Cookies("tandg")("surname")     = ""
		Response.Cookies("tandg")("email")       = ""
		Response.Cookies("tandg")("username")    = ""
		
		Response.Redirect "/login/account/?loggedin:0"

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>