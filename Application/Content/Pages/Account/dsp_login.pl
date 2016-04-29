<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
	o_Query     = UrlDecode( o_Query )
	
	User        = ParseCircuit( "user", o_Query )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='mainheader'>Customer Login</div>
<div class='maintext'>
In order to place an advert on the site or edit your Personal Details, log in below, or <a href='/register/account/'><b>click here</b></a> to register.
</div>

<div class='login_error' id='errorbox' style='display:none;'>&nbsp;</div>


<div class='login_box'>

	<div class='login_row'>
    <span class='login_cell' style='width:120px; height:1px;'>&nbsp;</span>
	</div>
  
	<div class='login_row'>
    <span class='login_cell' style='width:120px;'><b>Username<br/>or Email Address</b></span>
	  <span class='login_cell'><input type='text' id='username' name='username' value='<%=User%>' autocomplete='off'/></span>
	</div>
	
	<div class='login_row'>
    <span class='login_cell' style='width:120px;'><b>Password</b></span>
	  <span class='login_cell'><input type='password' id='password' name='password' value='' autocomplete='off'/></span>
	</div>
	
	<div class='login_row'>
    <span class='login_cell' style='width:120px;'>&nbsp;</span>
	  <span class='login_cell'> <span class='login_button' id='loginbutton'> <a href='javascript://' onclick="Login();" title='Log in'>Log in</a></span> <span class='login_wait' id='loginwait' style='display:none;'>&nbsp;</span> </span>
		<%'<span class='login_cell'> <span class='getpassword'> <a href='javascript://'>Forgot Password?</a></span> </span>%>
	</div>
	
	<div class='login_row'>
    <span class='login_cell' style='width:120px; height:1px;'>&nbsp;</span>
	</div>
	
</div>