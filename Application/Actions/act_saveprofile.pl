<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query
	o_Query      = UrlDecode( o_Query )
	
	Title        = ParseCircuit( "title", o_Query )
	Firstname    = ParseCircuit( "firstname", o_Query )
	Surname      = ParseCircuit( "surname", o_Query )
	Telephone    = ParseCircuit( "telephone", o_Query )
	Mobile       = ParseCircuit( "mobile", o_Query )
	Email        = ParseCircuit( "email", o_Query )
	Token        = Global_Token
	Pass         = ParseCircuit( "pass", o_Query )
	Pass1        = ParseCircuit( "pass1", o_Query )
	NewPassword  = Sha1( Pass )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	If Pass > "" Then
	  ChangePassword = 1
	Else
	  ChangePassword = 0
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Email Address
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  EmSQL      = "SELECT COUNT(uIndex) AS NumberOfRecords FROM MEMBERS WHERE emailaddress='" & Email & "'"
	             Call FetchData( EmSQL, EmRs, ConnTemp )
					 
	EmailCount = EmRs("NumberOfRecords")
	
	
	If EmailCount > "0" Then
	
	  EmSQL = "SELECT * FROM MEMBERS WHERE emailaddress='" & Email & "'"
		        Call FetchData( EmSQL, EmRs, ConnTemp )
						
						EmailAddress = EmRs("emailaddress")
						CustomerId   = EmRs("customerid")
					  
						If Email = EmailAddress  AND Global_UserId = CustomerId Then
						  OwnerEmail = 1
						Else
						  OwnerEmail = 0
						End If
	
	End If
	          
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate Form
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Global_LoggedIn = "" Then
	  Proceed      = 0
		ResponseCode = 1
		ResponseText = "You need to be logged in to do that"
	
	ElseIf title = "-" Then
	  Proceed      = 0
		ResponseCode = 2
		ResponseText = "Please select your Title"
	ElseIf Firstname = "" Then
	  Proceed      = 0
		ResponseCode = 3
		ResponseText = "Please enter your First Name"
	ElseIf Surname = "" Then
	  Proceed      = 0
		ResponseCode = 4
		ResponseText = "Please enter your Surname"
  ElseIf Telephone = "" or IsNumeric( Telephone ) = 0 Then
	  Proceed      = 0
		ResponseCode = 5
		ResponseText = "Please enter a valid Telephone Number<br/>Numbers only, no spaces or special characters"
	ElseIf Email = "" or Instr( Email, "@" ) = 0 Then
	  Proceed      = 0
		ResponseCode = 6
		ResponseText = "Please enter a valid Email Address"
	ElseIf Instr( Email, " " ) > 0 Then
	  Proceed      = 0
		ResponseCode = 7
		ResponseText = "Please enter a valid Email Address<br/>Email Addresses do not contain spaces or special characters"
	ElseIf Instr( Email, "." ) = 0 Then
	  Proceed      = 0
		ResponseCode = 8
		ResponseText = "Please enter a valid Email Address"
	
	ElseIf EmailCount > "0" AND OwnerEmail = 0 Then
	  Proceed      = 0
		ResponseCode = 9
		ResponseText = "The Email Address `" & Email & "` is in use by another member.<br/><br/>Please enter another email address"
		
	ElseIf ChangePassword = 1 AND Pass1 = "" Then
	  Proceed      = 0
		ResponseCode = 10
		ResponseText = "Please confirm your new password by typing what you entered in New Password"
	
	ElseIf ChangePassword = 1 AND Pass1 <> Pass Then
	  Proceed      = 0
		ResponseCode = 11
		ResponseText = "Your New Password combinations do not match.<br/>Please ensure to enter your new password in both `New Password` and `Confirm Password` fields."
	
	Else
	  Proceed      = 1
		ResponseCode = 12
		ResponseText = ""
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Set Cookie
// ---------------------------------------------------------------------------------------------------------------------------------------------------
'
   If Proceed = 1 Then
	
	   Response.Cookies("tandg")("firstname")   = Firstname
	   Response.Cookies("tandg")("surname")     = Surname
	   Response.Cookies("tandg")("email")       = Email
	
	 End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
	
	  MemSQL = " UPDATE members" & _
		         " SET "
						 
		
		
		If OwnerEmail = "1" Then
		
		  MemSQL = MemSQL & ""
			
		Else
		  
			MemSQL = MemSQL & " emailaddress='" & Email & "', "
		
		End If
		
		
		
		
		If ChangePassword = "1" Then
		
		  MemSQL = MemSQL & " password='" & NewPassword & "', "
		
		End If
		  
			MemSQL = MemSQL & " salutation='" & Title       & "', "   & _
			                  " firstname='" & Firstname    & "', "   & _
												" surname='" & Surname        & "', "   & _
												" telephone='" & Telephone    & "', "   & _
												" mobilenumber='" & Mobile    & "'"     & _
			                  " WHERE customerid='" & Token & "'"
												
												Call SaveRecord( MemSQL, MemRs, ConnTemp )
									
						 
						 
  End If

						 

  'If Proceed = 1 Then

   ' MemSQL = " UPDATE members" & _
	 '          " SET salutation='" & Title & "', firstname='" & Firstname & "', surname='" & Surname & "', telephone='" & Telephone & "',"
	
	 ' If OwnerEmail = 1 Then
	
	'    MemSQL   = MemSQL & " mobilenumber='" & Mobile & "'" & _
	'	                      " WHERE customerid='" & Token & "'"
	'  Else
	'    MemSQL   = MemSQL & "mobilenumber='" & Mobile & "', emailaddress='" & Email & "'" & _
	'	                      " WHERE customerid='" & Token & "'"
	'  End If
	
	  'Call SaveRecord( MemSQL, MemRs, ConnTemp )
		
	'End If 
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSOn Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
  JSOn = "{'responsecode':'" & ResponseCode & "', 'responsetext':'" & ResponseText & "', 'token':'" & Token & "', 'changepassword':'" & NewPassword & "', 'owneremail':'" & OwnerEmail & "'}"
  Response.Write JSOn
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>