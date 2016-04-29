
<script runat="server" language="JavaScript">
// VBScript is missing Left Shift, so this fixes that 
function leftshift(op,n) {
	return op << n;
}
</script>
<%
Class CountryLookup
	Private COUNTRY_BEGIN
	Private countryCode 
	Private countryName
	Private objStream
	Private mIntError
	Private mStrError
		
	private sub class_initialize
		set objStream = Server.CreateObject("ADODB.Stream")	
		COUNTRY_BEGIN = 16776960
		countryCode = Array("--","AP","EU","AD","AE","AF","AG","AI","AL","AM","AN","AO","AQ","AR","AS","AT","AU","AW","AZ","BA","BB","BD","BE","BF","BG","BH","BI","BJ","BM","BN","BO","BR","BS","BT","BV","BW","BY","BZ","CA","CC","CD","CF","CG","CH","CI","CK","CL","CM","CN","CO","CR","CU","CV","CX","CY","CZ","DE","DJ","DK","DM","DO","DZ",_
							"EC","EE","EG","EH","ER","ES","ET","FI","FJ","FK","FM","FO","FR","FX","GA","GB","GD","GE","GF","GH","GI","GL","GM","GN","GP","GQ","GR","GS","GT","GU","GW","GY","HK","HM","HN","HR","HT","HU","ID","IE","IL","IN","IO","IQ","IR","IS","IT","JM","JO","JP","KE","KG","KH","KI","KM","KN","KP","KR","KW","KY","KZ",_
							"LA","LB","LC","LI","LK","LR","LS","LT","LU","LV","LY","MA","MC","MD","MG","MH","MK","ML","MM","MN","MO","MP","MQ","MR","MS","MT","MU","MV","MW","MX","MY","MZ","NA","NC","NE","NF","NG","NI","NL","NO","NP","NR","NU","NZ","OM","PA","PE","PF","PG","PH","PK","PL","PM","PN","PR","PS","PT","PW","PY","QA",_
							"RE","RO","RU","RW","SA","SB","SC","SD","SE","SG","SH","SI","SJ","SK","SL","SM","SN","SO","SR","ST","SV","SY","SZ","TC","TD","TF","TG","TH","TJ","TK","TM","TN","TO","TP","TR","TT","TV","TW","TZ","UA","UG","UM","US","UY","UZ","VA","VC","VE","VG","VI","VN","VU","WF","WS","YE","YT","YU","ZA","ZM","ZR","ZW","A1","A2")
	
		countryName	= Array("N/A","Asia/Pacific Region","Europe","Andorra","United Arab Emirates","Afghanistan","Antigua and Barbuda","Anguilla","Albania","Armenia","Netherlands Antilles","Angola","Antarctica","Argentina","American Samoa","Austria","Australia","Aruba","Azerbaijan","Bosnia and Herzegovina","Barbados","Bangladesh","Belgium",_
							"Burkina Faso","Bulgaria","Bahrain","Burundi","Benin","Bermuda","Brunei Darussalam","Bolivia","Brazil","Bahamas","Bhutan","Bouvet Island","Botswana","Belarus","Belize","Canada","Cocos (Keeling) Islands","Congo, The Democratic Republic of the","Central African Republic","Congo","Switzerland","Cote D'Ivoire",_
							"Cook Islands","Chile","Cameroon","China","Colombia","Costa Rica","Cuba","Cape Verde","Christmas Island","Cyprus","Czech Republic","Germany","Djibouti","Denmark","Dominica","Dominican Republic","Algeria","Ecuador","Estonia","Egypt","Western Sahara","Eritrea","Spain","Ethiopia","Finland","Fiji","Falkland Islands (Malvinas)",_
							"Micronesia, Federated States of","Faroe Islands","France","France, Metropolitan","Gabon","United Kingdom","Grenada","Georgia","French Guiana","Ghana","Gibraltar","Greenland","Gambia","Guinea","Guadeloupe","Equatorial Guinea","Greece","South Georgia and the South Sandwich Islands","Guatemala","Guam","Guinea-Bissau","Guyana",_
							"Hong Kong","Heard Island and McDonald Islands","Honduras","Croatia","Haiti","Hungary","Indonesia","Ireland","Israel","India","British Indian Ocean Territory","Iraq","Iran, Islamic Republic of","Iceland","Italy","Jamaica","Jordan","Japan","Kenya","Kyrgyzstan","Cambodia","Kiribati","Comoros","Saint Kitts and Nevis",_
							"Korea, Democratic People's Republic of","Korea, Republic of","Kuwait","Cayman Islands","Kazakstan","Lao People's Democratic Republic","Lebanon","Saint Lucia","Liechtenstein","Sri Lanka","Liberia","Lesotho","Lithuania","Luxembourg","Latvia","Libyan Arab Jamahiriya","Morocco","Monaco","Moldova, Republic of","Madagascar",_
							"Marshall Islands","Macedonia, the Former Yugoslav Republic of","Mali","Myanmar","Mongolia","Macau","Northern Mariana Islands","Martinique","Mauritania","Montserrat","Malta","Mauritius","Maldives","Malawi","Mexico","Malaysia","Mozambique","Namibia","New Caledonia","Niger","Norfolk Island","Nigeria","Nicaragua","Netherlands",_
							"Norway","Nepal","Nauru","Niue","New Zealand","Oman","Panama","Peru","French Polynesia","Papua New Guinea","Philippines","Pakistan","Poland","Saint Pierre and Miquelon","Pitcairn","Puerto Rico","Palestinian Territory, Occupied","Portugal","Palau","Paraguay","Qatar","Reunion","Romania","Russian Federation","Rwanda","Saudi Arabia",_
							"Solomon Islands","Seychelles","Sudan","Sweden","Singapore","Saint Helena","Slovenia","Svalbard and Jan Mayen","Slovakia","Sierra Leone","San Marino","Senegal","Somalia","Suriname","Sao Tome and Principe","El Salvador","Syrian Arab Republic","Swaziland","Turks and Caicos Islands","Chad","French Southern Territories","Togo",_
							"Thailand","Tajikistan","Tokelau","Turkmenistan","Tunisia","Tonga","East Timor","Turkey","Trinidad and Tobago","Tuvalu","Taiwan, Province of China","Tanzania, United Republic of","Ukraine","Uganda","United States Minor Outlying Islands","United States","Uruguay","Uzbekistan","Holy See (Vatican City State)","Saint Vincent and the Grenadines",_
							"Venezuela","Virgin Islands, British","Virgin Islands, U.S.","Vietnam","Vanuatu","Wallis and Futuna","Samoa","Yemen","Mayotte","Yugoslavia","South Africa","Zambia","Zaire","Zimbabwe","Anonymous Proxy","Satellite Provider")
	End Sub

	private sub class_terminate
		If IsObject(objStream) Then
			objStream.Close()
			Set objStream = Nothing
		End If
	end sub

	Public Property Get ErrNum(byref message)
		message = mStrError
		ErrNum = mIntError
	End Property

	Public Property Let GeoIPDataBase(filename)
		On Error Resume Next
		objStream.Type = 1 'adTypeBinary
		objStream.Open 
		objStream.LoadFromFile filename
		If Err.Number <> 0 Then
			mIntError = Err.Number
			mStrError = "Error: " & Err.Number & " Source: GeoIP.asp line 56: " & Err.Description
		End If
		On Error Goto 0
	End Property

	Public Function lookupCountryCode(addr)
		lookupCountryCode = countryCode(seekCountry(0, addrToNum(addr), 31))
	End Function

	Public Function lookupCountryName(addr)
		lookupCountryName = countryName(seekCountry(0, addrToNum(addr), 31))
	End Function

	Public Function addrToNum(addr)
		Dim arrIP : arrIP = split(addr,".")
		If Ubound(arrIP) = 3 Then
			addrToNum = Cdbl(16777216 * arrIP(0) + 65536 * arrIP(1) + 256 * arrIP(2) + arrIP(3))
		Else
			addrToNum = 0
		End If
	End Function
	
	Public Function numToAddr(ipnum)
		Dim w : w = Cstr(int ( ipnum / 16777216 ) Mod 256)
		Dim x : x = Cstr(int ( ipnum / 65536    ) Mod 256)
		Dim y : y = Cstr(int ( ipnum / 256      ) Mod 256)
		Dim z : z = Cstr(int ( ipnum            ) Mod 256)

		numToAddr = w & "." & x & "." & y & "." & z
	End Function

	Private Function ConvertBin2Array(Binary)
		Dim tmpArr()
	  	Dim i
		ReDim tmpArr(LenB(Binary))
		for i = 1 to LenB(Binary)
			tmpArr(i-1) = AscB(MidB(Binary,i,1))
		Next
		ConvertBin2Array = tmpArr
	End Function

	Private Function seekCountry(offset,ipnum,depth) 
	
		Dim buf,x(2)
		Dim i,j,y,shift
		
		if (depth = 0) Then
     		Err.Raise vbObjectError + 93, "GeoIP.asp", "Error seeking country"
			Exit Function
		End If

		objStream.Position = 0
		objStream.Position = 6 * offset
		buf = ConvertBin2Array(objStream.Read(6))
		
		For i = 0 to 1
			x(i) = 0
			For j = 0 to 2
				y = buf(i*3+j)
				If y < 0 Then 
					y = y + 256
				End If
				shift = j * 8
				x(i) = x(i) + leftshift(y,shift)
			Next
		Next
		If LongToUnsigned(UnsignedToLong(ipnum) AND leftshift(1,depth)) > 0 Then
			If (x(1) >= COUNTRY_BEGIN) Then
				seekCountry = x(1) - COUNTRY_BEGIN
				Exit Function
			End If
			seekCountry = seekCountry(x(1), ipnum, depth-1)
		Else		
			If (x(0) >= COUNTRY_BEGIN) Then
				seekCountry = x(0) - COUNTRY_BEGIN
				Exit Function
			End If
			seekCountry = seekCountry(x(0), ipnum, depth-1)
		End If		
	End Function


'****************************************************
' These two functions from Microsoft Article Q189323
' "HOWTO: convert between Signed and Unsigned Numbers"

	Function UnsignedToLong(value)
		Dim OFFSET_4 : OFFSET_4 = 4294967296
		Dim MAXINT_4 : MAXINT_4 = 2147483647

		If value < 0 Or value >= OFFSET_4 Then Err.raise(6) ' Overflow
		If value <= MAXINT_4 Then
			UnsignedToLong = value
		Else
			UnsignedToLong = value - OFFSET_4
		End If
	End Function

	Public Function LongToUnsigned(value)
		Dim OFFSET_4 : OFFSET_4 = 4294967296
		Dim MAXINT_4 : MAXINT_4 = 2147483647

		If value < 0 Then
			LongToUnsigned = value + OFFSET_4
		Else
			LongToUnsigned = value
		End If
	End Function

End Class
%>