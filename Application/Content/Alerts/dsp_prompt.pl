<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
	o_Query       = UrlDecode( o_Query )
	ResponseText  = ParseCircuit( "responsetext", o_Query )
	ResponseText  = Replace( ResponseText, "*", "?" )
	Title         = ParseCircuit( "title", o_Query )
	Title         = Replace( Title, "*", "?" )
	ActionUrl     = ParseCircuit( "actionurl", o_Query )
	ActionUrl     = Replace( ActionUrl, "*", "?" )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='modal-header-notify'>
  <span class='modal-label'><%=Title%></span>
	<span class='modal-close'><a href='javascript://' onclick="CloseModalBox();" title='Close'></a></span>
</div>

<div class='modal-content'><%=ResponseText%></div>

<div class='modal-footer'>
  <span class='closebutton' style='float:left;'><a href='javascript://' onclick="CloseModalBox();" title='Click to dismiss this message'>Cancel</a></span>
  <span class='promptbutton' id='actionbutton' style='float:right;'><a href="<%=ActionUrl%>" title='Click to continue'>YES</a></span>
	<span class='modal-wait' id='modalwait' style='float:right; display:none;'></span>
</div>