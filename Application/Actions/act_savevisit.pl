<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/actions/act_geoip.pl"-->

<%
// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// --------------------------------------------------------------------------------------------------------------------------------------------
	
	o_Query         = Request.Querystring
	o_Query         = UrlDecode( o_Query )
	o_Query         = Replace( o_Query, "&", ";" )
	o_Query         = Replace( o_Query, "=", ":" )
	o_Query         = Replace( o_Query, ";", vbcrlf )
	o_Query         = Replace( o_Query, "/Default.asp", "/" )
	o_RCode         = Sha1( Timer() & Rnd() )
	o_PageUrl       = ParseCircuit( "page", o_Query )
	o_IpAddress     = ParseCircuit( "visitor", o_Query )
	o_OsBrowser     = ParseCircuit( "os", o_Query )
	o_Referrer      = ParseCircuit( "referrer", o_Query )
	o_LocFile       = "/application/actions/geoip.dat"
	o_LocFile       = Server.MapPath( o_LocFile )
	
	If o_Referrer   = "" Then
	  o_Referrer = "-"
	End If
	
// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Fix Date Stamps
// --------------------------------------------------------------------------------------------------------------------------------------------

	o_CurrentDay    = Day(Now)
	o_CurrentMonth  = Month(Now)
	o_CurrentYear   = Year(Now)
	o_CurrentTime   = Time

  If Len( o_CurrentDay ) = 1 Then
	  o_CurrentDay = "0" & o_CurrentDay
	End If
	
	If Len( o_CurrentMonth ) = 1 Then
	  o_CurrentMonth = "0" & o_CurrentMonth
	End If
	
	
	o_DateTimeStamp = o_CurrentYear & "-" & o_CurrentMonth & "-" & o_CurrentDay & " " & o_CurrentTime
	o_DateStamp     = o_CurrentYear & "-" & o_CurrentMonth & "-" & o_CurrentDay
	o_MonthStamp    = o_CurrentMonth
	o_YearStamp     = o_CurrentYear
	
// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Visitor Details
// --------------------------------------------------------------------------------------------------------------------------------------------

  o_OSBrowser     = o_OSBrowser
	o_Referrer      = o_Referrer
	o_IpAddress     = o_IpAddress
	
// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Country and Country Code
// --------------------------------------------------------------------------------------------------------------------------------------------

  On Error Resume Next
	
	Set oGeoIp = New CountryLookup
	
	  oGeoIp.GeoIpDatabase = o_LocFile
		If oGeoIp.ErrNum(strErrMsg) <> 0 Then
		Else
		
		  StrIp = o_IpAddress
			StrCountryName = oGeoIP.LookupCountryName( StrIp )
			StrCountryCode = oGeoIP.LookupCountryCode( StrIp)
		
		End If
		
	
	Set oGeoIp = Nothing

// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if visitor already visited today and add to visitor list
// --------------------------------------------------------------------------------------------------------------------------------------------

  SQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM visitorstats WHERE visitdatestamp='" & o_DateStamp & "' AND ipaddress='" & o_IpAddress & "'"
	Call FetchData( SQL, RsTemp, ConnTemp )
	
	VisitorCount = RsTemp("NumberOfRecords")
	
	If VisitorCount = "0" Then
	  IsUnique = "1"
	Else
	  IsUnique = "0"
	End If
	
	If IsUnique = 1 Then
	
	  SQL = " INSERT INTO visitorstats" & _
			    " ( impressionid, ipaddress, pageurl, osbrowser, pagereferrer, visitdatetimestamp, visitdatestamp, visityearstamp, visitmonthstamp, visitcountry, visitcountrycode )" & _
				  " VALUES (" & _
					" '" & o_RCode             & "', "  & _
					" '" & o_IPAddress         & "', "  & _
					" '" & o_PageUrl           & "', "  & _
					" '" & o_OSBrowser         & "', "  & _
					" '" & o_Referrer          & "', "  & _
					" '" & o_DateTimeStamp     & "', "  & _
					" '" & o_DateStamp         & "', "  & _
					" '" & o_YearStamp         & "', "  & _
					" '" & o_MonthStamp        & "', "  & _
					" '" & StrCountryName      & "', "  & _
					" '" & StrCountryCode      & "'"    & _
					" )"
			   Call SaveRecord( SQL, RsTemp, ConnTemp )
	
	End If

// --------------------------------------------------------------------------------------------------------------------------------------------
// ' Write Page Views
// --------------------------------------------------------------------------------------------------------------------------------------------

   SQL = " INSERT INTO pageviews" & _
	      " ( impressionid, ipaddress, visitdatetimestamp, visitdatestamp, visityearstamp, visitmonthstamp )" & _
				" VALUES (" & _
				" '" & o_RCode         & "', "  & _
				" '" & o_IpAddress     & "', "  & _
				" '" & o_DateTimeStamp & "', "  & _
				" '" & o_DateStamp     & "', "  & _
				" '" & o_YearStamp     & "', "  & _
			  " '" & o_MonthStamp    & "'"    & _
				" )"
				Call SaveRecord( SQL, RsTemp, ConnTemp )
		
// --------------------------------------------------------------------------------------------------------------------------------------------
%>
