<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = fw_Query
	o_Query = UrlDecode( o_Query )
	
	Token   = ParseCircuit( "token", o_Query )
	Edit    = ParseCircuit( "edit", o_Query )
	
	If Token = "" Then
	  Token = Global_Token
	Else
	  Token = Token
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Token
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	MemSQL  = "SELECT COUNT(uIndex) AS NumberOFRecords FROM members WHERE customerid='" & Token & "'"
	          Call FetchData( MemSQL, MemRs, ConnTemp )

	MemCount = MemRs("NumberOfRecords")
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Member Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	If MemCount > "0" Then
	
	  MemSQL = "SELECT * FROM members WHERE customerid='" & Token & "'"
		         Call FetchData( MemSQL, MemRs, ConnTemp )
						 
						 Email      = MemRs("emailaddress")
						 Firstname  = MemRs("firstname")
	
	
	End If
	
	Response.Redirect "/paymenthandler/actions/?paymethod:2;token:" & Token
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='mainheader'>Choose a Payment Method</div>
<div class='maintext'>
As part of the registration process, we need you to pay &pound;100. This is our one off registration fee.<br/><br/>
Please select a payment method below.
</div>


<div class='basicformtable'>
  <div class='basicformholder'>
	
	
	  <div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'>&nbsp;</span>
		  <span class='cell'></span>
    </div>
	
	<!-- start form -->
	
		
	  <div class='row'>
		  <span class='cell' style='width:80px;'>&nbsp;</span>
			<span class='cell'><span class='label'><input type='radio' name='paymethod' id='paymethod1' value='1' autocomplete='off' class='radio'/></span></span>
		  <span class='cell'><span class='label'><b>Cheque</b></span></span>
    </div>
		
	  <div class='row'>
		  <span class='cell' style='width:80px;'>&nbsp;</span>
			<span class='cell'><span class='label'><input type='radio' name='paymethod' id='paymethod2' value='2' autocomplete='off' class='radio'/></span></span>
		  <span class='cell'><span class='label'><b>Bank Transfer</b></span></span>
    </div>
	
	
	  <div class='row'>
		  <span class='cell' style='width:80px; text-align:right;'>&nbsp;</span>
		  <span class='cell'>
			<span class='basicform_button' id='actionbutton'><a href='javascript://' onclick="SelectPayMethod('<%=Token%>');">Continue</a></span>
			<span class='basicform_wait'   id='formwait' style='display:none;'>&nbsp;</span>
			</span>
    </div>
	
	<!-- end form -->
	
	  <div class='row'>
		  <span class='cell' style='width:140px; text-align:right;'>&nbsp;</span>
		  <span class='cell'></span>
    </div>
		
		<input type='hidden' name='edit' id='edit' value='<%=Edit%>'/>
	
	
	
	</div>
</div>