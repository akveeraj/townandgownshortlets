<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
	o_Query       = UrlDecode( o_Query )
	ResponseText  = ParseCircuit( "responsetext", o_Query )
	Title         = ParseCircuit( "title", o_Query )
	OKAction      = ParseCircuit( "okaction", o_Query )
	ShowClose     = ParseCircuit( "showclose", o_Query )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='modal-header-alert'>
  <span class='modal-label'><%=Title%></span>
	<% If ShowClose = 1 or ShowClose = "" Then %><span class='modal-close'><a href='javascript://' onclick="CloseModalBox();" title='Close'></a></span><% End If %>
</div>

<div class='modal-content'><%=ResponseText%></div>

<% If OKAction > "" Then %>
<div class='modal-footer'>
  <span class='closebutton' style='float:right;'><a href='<%=OKAction%>' title='Click to dismiss this message'>OK</a></span>
</div>
<% Else %>
<div class='modal-footer'>
  <span class='closebutton' style='float:right;'><a href='javascript://' onclick="CloseModalBox();" title='Click to dismiss this message'>OK</a></span>
</div>

<% End If %>	