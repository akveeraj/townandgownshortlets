<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
	o_Query        = fw_Query
	o_Query        = UrlDecode( o_Query )
	n_Query        = Request.QueryString
	n_Source       = ParseCircuit( "source", o_Query )
	n_Circuit      = ParseCircuit( "circuit", o_Query )
	n_ForceLogout  = ParseCircuit( "flgt", o_Query )
	n_Query        = UrlDecode( n_Query )
	n_Query        = Replace( n_Query, n_Circuit, "" )
	n_Query        = Replace( n_Query, n_Source, "" )
	n_Query        = Replace( n_Query, "&", "" )
	n_Query        = Replace( n_Query, "source=", "" )
	n_Query        = Replace( n_Query, "circuit=", "" )
	n_Query        = Replace( n_Query, ";", "^" )      
	
	If n_Query > "" Then
	  n_ReturnPath = "?returnpath:/" & n_Source & "/" & n_Circuit & "/*" & n_Query
	Else
	  n_ReturnPath = "?returnpath:/" & n_Source & "/" & n_Circuit & "/"
	End If
	
	'// Force Logout Actions
	
	If n_ForceLogout = 1 Then
	  
		Response.Cookies("bm")("token")       = ""
	  Response.Cookies("bm")("userid")      = ""
	  Response.Cookies("bm")("loggedin")    = 0
	  Response.Cookies("bm")("firstname")   = ""
	  Response.Cookies("bm")("surname")     = ""
	  Response.Cookies("bm")("email")       = ""
	  Response.Cookies("bm")("username")    = ""
	  Response.Cookies("bm")("accounttype") = ""
	  Response.Cookies("bm")("accountpuse") = ""
	  Response.Cookies("bm")("paypalid")    = ""
		
		Response.Redirect "/signin/account/" & n_ReturnPath
	
	ElseIf n_ForceLogout = "" AND Global_UserId = "" or n_ForceLogout = 1 AND Global_UserId = "" Then
	  
		 Response.Cookies("bm")("token")       = ""
	   Response.Cookies("bm")("userid")      = ""
	   Response.Cookies("bm")("loggedin")    = 0
	   Response.Cookies("bm")("firstname")   = ""
	   Response.Cookies("bm")("surname")     = ""
	   Response.Cookies("bm")("email")       = ""
	   Response.Cookies("bm")("username")    = ""
	   Response.Cookies("bm")("accounttype") = ""
	   Response.Cookies("bm")("accountpuse") = ""
	   Response.Cookies("bm")("paypalid")    = ""
	
	   Response.Redirect "/signin/account/" & n_ReturnPath
		 
	Else
	  '// Do Nothing
	End If
	
	
	
	
	
	'// Validate Login Session

  'o_Query       = fw_Query
	'o_Query       = UrlDecode( o_Query )
	
	'CustomerId    = ParseCircuit( "cuid", o_Query )
	'ReturnPrompt  = ParseCircuit( "returnpath", o_Query )
	'ReceiptId    = ParseCircuit( "receiptid", o_Query )
	'ReLogin       = ParseCircuit( "rlgn", o_Query )
	'nSource       = ParseCircuit( "source", o_Query )
	'nCircuit      = ParseCircuit( "circuit", o_Query )
	'nQuery        = Request.QueryString
	'nQuery        = UrlDecode( nQuery )
	'nQuery        = Replace( nQuery, "source=", "" )
	'nQuery        = Replace( nQuery, "&", "/" )
	'nQuery        = Replace( nQuery, "circuit=", "" )
	'nQuery        = Replace( nQuery, "returnpath:1", "?" )
	'nQuery        = Replace( nQuery, "?;", "?" )
	'nQuery        = Replace( nQuery, "rlgn:1;", "" )
	'nQuery        = Replace( nQuery, ";", "" )
	'nQuery        = "/" & nQuery
	'LoginPath     = "/signin/account/?returnpath:" & nQuery
	'LoginPath     = Replace( LoginPath, ";", "*" )
	
	
	'If CustomerId <> Global_UserId or Global_UserId = "" Then
	  
	'	Response.Cookies("bm")("token")       = ""
	'  Response.Cookies("bm")("userid")      = ""
	'  Response.Cookies("bm")("loggedin")    = 0
	' Response.Cookies("bm")("firstname")   = ""
	'  Response.Cookies("bm")("surname")     = ""
	'  Response.Cookies("bm")("email")       = ""
	'  Response.Cookies("bm")("username")    = ""
	'  Response.Cookies("bm")("accounttype") = ""
	'  Response.Cookies("bm")("accountpuse") = ""
	'  Response.Cookies("bm")("paypalid")    = ""
	
	'  Response.Redirect LoginPath
	
	'Else
	
	'// Do Nothing, Person is logged in!
	
	'End If


%>