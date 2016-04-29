<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession.pl"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = fw_Query
	o_Query = UrlDecode( o_Query )
	
	Updated = ParseCircuit( "updated", o_Query )
	Error   = ParseCircuit( "ecode", o_Query )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Account Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  MemberId = Global_UserId
	
	MemSQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM members WHERE customerid='" & MemberId & "'"
	           Call FetchData( MemSQL, MemRs, ConnTemp )
						 
	MemCount = MemRs("NumberOfRecords")
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	If MemCount > "0" Then
	
	  MemSQL = "SELECT * FROM members WHERE customerid='" & MemberId & "'"
		         Call FetchData( MemSQL, MemRs, ConnTemp )
						 
						 
		Salutation     = MemRs("salutation")
		Firstname      = MemRs("firstname")
		Surname        = MemRs("surname")
		ScreenName     = MemRs("screenname")
		EmailAddress   = MemRs("emailaddress")
		Telephone      = MemRs("telephone")
		MobileNumber   = MemRs("mobilenumber")
		Status         = MemRs("status")
		DateTimeStamp  = MemRs("datetimestamp")
		DateStamp      = MemRs("datestamp")
		PaidMember     = MemRs("paidmember")	 
		PayMethod      = MemRs("paymentmethod")
		CustomerId     = MemRs("customerid")
		
		If PayMethod > "0" Then
		
		  Select Case( PayMethod )
			  Case(1)
				  PayMethodLabel = "Cheque Payment"
					PayUrl         = "/chequedetails/alerts/?output:1"
					PayUrlLabel    = "Where to send your cheque"
				Case(2)
				  PayMethodLabel = "Bank Transfer"
					PayUrl         = "/transferdetails/alerts/?output:1"
					PayUrlLabel    = "View Bank Transfer information"
			End Select
		
		End If
	
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "My Profile ~ Town and Gown Lettings Ltd. Oxford";
});
</script>

<div class='mainheader'>My Profile</div>
<div class='maintext'>
Use the form below to update your Personal Details we hold about you. <br/>This information will not appear on your adverts, it is for internal use only.
</div>



<% If PaidMember = "0" AND PayMethod = "0" Then %>
<div class='nopayment'>
  <b>You have not yet paid your registration fee</b><br/>Your adverts will not appear on the site until your payment has been processed.<br/>
	<span class='makepayment'><a href='/regcomplete/account/?token:<%=Global_Token%>;edit:1'>Click here to make a payment</a></span>
	
	If you have already paid your &pound;100.00 fee, please disregard this message, you will receive an email message once
	 we have processed your payment. 
</div>

<% ElseIf PaidMember = "0" AND PayMethod > "0" Then %>
<div class='nopayment'>
<b>We are waiting on your <%=PayMethodLabel%> of &pound;100</b><br/>You will receive a confirmation email once we process your payment.<br/><br/>
  <a href='/regcomplete/account/?token:<%=Global_Token%>;edit:1'><b>Change Payment Method</b></a>&nbsp;&nbsp;&middot;&nbsp;&nbsp;<a href='javascript://' onclick="TxDetails('<%=PayUrl%>');"><b><%=PayUrlLabel%></b></a>
</div>
<% End If %>

<div class='basicformtable'>
  <div class='basicformholder'>
	
	
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'>&nbsp;</span>
			<span class='cell'>&nbsp;</span>
		</div>
	  
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>Username</b></span></span>
			<span class='cell'><span class='label'><%=ScreenName%></span></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>Title</b></span></span>
			<span class='cell'>
			<select name='title' id='title' autocomplete='off'>
			<option value='-'>-- Select a Title --</option>
			<option value='-'>------------------------------</option>
			<% If Salutation > "" Then %>
			<option value='<%=Salutation%>' selected><%=Salutation%></option>
			<option value='-'>------------------------------</option>
			<% End If %>
			<option value='Mr'>Mr</option>
			<option value='Mrs'>Mrs</option>
			<option value='Miss'>Miss</option>
			<option value='Ms'>Ms</option>
			</select>
			</span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>First Name</b></span></span>
			<span class='cell'><input type='text' id='firstname' name='firstname' value='<%=Firstname%>' autocomplete='off' class='input' placeholder='Required Field'/></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>Surname</b></span></span>
			<span class='cell'><input type='text' id='surname' name='surname' value='<%=Surname%>' autocomplete='off' class='input' placeholder='Required Field'/></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>Telephone Number</b></span></span>
			<span class='cell'><input type='text' id='telephone' name='telephone' value='<%=Telephone%>' autocomplete='off' class='input' placeholder='Required Field'/></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>Alternative Number</b></span></span>
			<span class='cell'><input type='text' id='mobile' name='mobile' value='<%=MobileNumber%>' autocomplete='off' class='input'/></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>Email Address</b></span></span>
			<span class='cell'><input type='text' id='email' name='email' value='<%=EmailAddress%>' autocomplete='off' class='input' placeholder='Required Field'/></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>New Password</b></span></span>
			<span class='cell'><input type='password' id='pass' name='pass' value='' autocomplete='off' class='input' placeholder='Enter a new password to update your old one'/></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'><span class='label'><b>Confirm New Password</b></span></span>
			<span class='cell'><input type='password' id='pass1' name='pass1' value='' autocomplete='off' class='input' placeholder='Re-type your new password for confirmation'/></span>
		</div>
		
	  <div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'>&nbsp;</span>
		  <span class='cell'>
			<span class='basicform_button' id='actionbutton'><a href='javascript://' onclick="SaveProfile();">Save Details</a></span>
			<span class='basicform_wait'   id='formwait' style='display:none;'>&nbsp;</span>
			</span>
    </div>
		
		
		<div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'>&nbsp;</span>
			<span class='cell'>&nbsp;</span>
		</div>
		
		
		
	</div>
</div>