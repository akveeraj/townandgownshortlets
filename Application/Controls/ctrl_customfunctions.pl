<%
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' File Name : ctrl_customfunctions.pl
// ' Function  : Put all your custom SUBROUTINES and FUNCTIONS here
// ' Author    : Patrick Johnson - me@patrickjohnson.co.uk
// ' Updated   : 26 May 2013
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Email Template
// ---------------------------------------------------------------------------------------------------------------------------------------------

  EmailTemplateTop     = "<div style='margin-bottom:15px;'><img src='http://" & fw__FQDN & "/application/library/media/emailheader.png'/></div>" & _
	                       "<div style='display:block; margin-left:30px;'>"
	EmailTemplateBottom  = Chr(13) & Chr(13) & "Kind Regards," & chr(13) & _
	                       "Town and Gown Lettings Ltd" & chr(13) & _
												 "http://" & Fw__FQDN & chr(13) & _
												 "</div>"

	
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Get date in the past
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function GetPastDate( DayMonthWeek, PlusMinusDate, FormatDate )
	  Date1       = DateAdd( DayMonthWeek, PlusMinusDate, FormatDate )
		GetPastDate = Date1
	End Function

// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Write Record Paging
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function WriteRecordPaging( PageSize, PageWidth )
	
	End Function
	
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if file exists
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function CheckFileSource( String )
	
	  SET fs = Server.CreateObject("Scripting.FileSystemObject")
		
		If FS.FileExists( String ) = true Then
		  FileDoesExist = 1
		Else
		  FileDoesExist = 0
		End If
		
		CheckFileSource = FileDoesExist
		
		SET fs = Nothing
	
	End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
%>