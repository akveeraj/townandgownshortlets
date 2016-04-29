<!--#include virtual="/includes.inc"-->

<%
// ' --------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query
  o_Query      = UrlDecode( o_Query )
	
	Token        = ParseCircuit( "token", o_Query )
	PayMethod    = ParseCircuit( "paymethod", o_Query )
	ReturnPath   = "/regcomplete/account/?token:" & Token & ";edit:" & Edit
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Member Details
// ' --------------------------------------------------------------------------------------------------------------------------------------

  MemSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Token & "'"
	         Call FetchData( MemSQL, MemRs, ConnTemp )
					 
	MemCount = MemRs("NumberOfRecords")
	
// ' --------------------------------------------------------------------------------------------------------------------------------------

  If MemCount > "0" Then
    
		MemSQL = "SELECT * FROM members WHERE customerid='" & Token & "'"
		         Call FetchData( MemSQL, MemRs, ConnTemp )
						 
						 Firstname = MemRs("firstname")
						 Surname   = MemRs("surname")
						 Email     = MemRs("emailaddress")	
	
	End If
  
// ' --------------------------------------------------------------------------------------------------------------------------------------
  
	PayExt       = Sha1(Timer() & Rnd())
	PayExt       = Left( PayExt, 3 )
	PayReference = Left( Firstname,1 ) & Left(Surname, 3 ) & PayExt
	PayReference = UCase( PayReference )
	
// ' --------------------------------------------------------------------------------------------------------------------------------------
// ' Set Instruction
// ' --------------------------------------------------------------------------------------------------------------------------------------

  'If Proceed = 1 Then

   ' Select Case( PayMethod )
		'  Case(1)
		'	  PayLabel     = "Cheque"
	'			SelectedText = "<b><a href='" & ReturnPath & "'>Change your payment method</a></b>" & _
				              ' ""
	'	  Case(2)
			  'PayLabel     = "Bank Transfer"
				'SelectedText = "<b><a href='" & ReturnPath & "'>Change your payment method</a></b>" & _
		'		               ""
	'  End Select	
	
	'End If
	
  PayLabel      = "Bank Transfer"
	
	Response.Redirect "/finishpayment/actions/?output:1;token:" & Token & ";paymethod:2;ref:" & PayReference

// ' --------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='mainheader' style='margin-bottom:20px;'>Make a Payment by Bank Transfer</div>


	<% If PayMethod = 1 Then %>
	  
<div class='basicformtable'>
  <div class='basicformholder'>
	
	<span class='bigtext'>Sending your Cheque</span>
	<span class='smalltext'>
	Please send your payment of <span class='green'><b>&pound;100</b></span> to the address below.<br/>
	Remember to write the reference <span class='green'>`<b><%=PayReference%></b>`</span> on the back of the cheque.
	</span>
	
	
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Payee</b></span>
			<span class='cell'>Town and Gown Lettings Ltd</span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Amount</b></span>
			<span class='cell'>&pound;100</span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Address</b></span>
			<span class='cell'>
			Town and Gown Lettings Ltd<br/>
			123 Some Street<br/>
			Some Town<br/>Some City<br/>
			$postcode
			</span>
		</div>
		
		
	  <div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'>&nbsp;</span>
		  <span class='cell'>
			<span class='basicform_button' id='actionbutton'><a href='/finishpayment/actions?output:1;token:<%=Token%>;paymethod:<%=PayMethod%>;ref:<%=PayReference%>'>Finish</a></span>
			<span class='basicform_wait'   id='formwait' style='display:none;'>&nbsp;</span>
			</span>
    </div>

	</div>
</div>
	
	<% Else %>
	
<div class='basicformtable'>
  <div class='basicformholder'>
	
	
	
	<span class='bigtext'>Our Bank Details</span>
	<span class='smalltext'>
	
	  Please send your payment of <span class='green'><b>&pound;100</b></span> to the bank account below.<br/>
		Remember to include <span class='green'>`<b><%=PayReference%></b>`</span> as the reference for the payment.<br/><br/>
		
		Once we have received your cleared payment, you will receive a confirmation email, and we will contact you to discuss your requirements.
	</span>
	
	
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Account Number</b></span>
			<span class='cell'>00000000</span>
		</div>
		
		
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Sort Code</b></span>
			<span class='cell'>00-00-00</span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Payee</b></span>
			<span class='cell'>Town and Gown Lettings Ltd</span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Payment Reference</b></span>
			<span class='cell'><%=PayReference%></span>
		</div>
		
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'><b>Amount</b></span>
			<span class='cell'>&pound;100</span>
		</div>
	
	  <div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'>&nbsp;</span>
		  <span class='cell'>
			<span class='basicform_button' id='actionbutton'><a href='/finishpayment/actions?output:1;token:<%=Token%>;paymethod:<%=PayMethod%>;ref:<%=PayReference%>'>Complete Registration</a></span>
			<span class='basicform_wait'   id='formwait' style='display:none;'>&nbsp;</span>
			</span>
    </div>
		
		<div class='row'>
		  <span class='cell' style='width:150px; text-align:right;'>&nbsp;</span>
			<span class='cell'>&nbsp;</span>
		</div>
	
	</div>
</div>
	
	<% End If %>