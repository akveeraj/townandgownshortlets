<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
	o_Query       = UrlDecode( o_Query )
	ResponseText  = ParseCircuit( "responsetext", o_Query )
	Title         = ParseCircuit( "title", o_Query )
	OkAction      = ParseCircuit( "okaction", o_Query )
	Refresh       = ParseCircuit( "refresh", o_Query )
	
	If Refresh > "" Then
	  RefreshAction = " location.reload();"
	End If
	
	If OkAction = "" Then
	  OkActionUrl = "<a href='javascript://' onclick=""CloseModalBox();" & RefreshAction & """ title='Click here to dismiss this message'>OK</a>"
	Else
	  OkActionUrl = "<a href='" & OkAction & "' title='Click here to dismiss this message'>OK</a>"
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='modal-header-notify'>
  <span class='modal-label'><%=Title%></span>
	<span class='modal-close'><a href='javascript://' onclick="CloseModalBox();" title='Close'></a></span>
</div>

<div class='modal-content'><%=ResponseText%></div>

<div class='modal-footer'>
  <span class='closebutton' style='float:right;'><%=OkActionUrl%></span>
</div>