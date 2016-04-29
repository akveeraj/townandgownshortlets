<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Global Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------


        SiteOffline       = "0"
	RemoteAddr        = Request.ServerVariables("REMOTE_ADDR")
	Generator         = "Fusebox v" & fw_Version
	YKey              = Sha1( Timer() & Rnd() )
	ServerAddr        = Request.ServerVariables("REMOTE_HOST")
	o_Query           = fw_Query
	ImageId           = ParseCircuit( "source", o_Query )
	Track__IpAddress  = RemoteAddr
	Track__Referrer   = Request.ServerVariables("HTTP_REFERRER")
	Track__Page       = "/" & fw_File & "/" & Fw_Folder & "/"
	
	If Track__Page = "///" Then
	  Track__Page = "/"
	End If
	
	Track__Page       = Replace( Track__Page, ".", "/" )
	Track__Page       = Replace( Track__Page, "/", "\/" )
	Track__Referrer   = Replace( Track__Referrer, "/", "\/" )
	StrAgent          = Request.ServerVariables( "HTTP_USER_AGENT")
	
	Function ParseBrowserAgent( StrAgent )
    On Error Resume Next
		OSArray           = Split( StrAgent, ";" )
		StrOS             = OSArray(0)
		ParseBrowserAgent = StrOs
  End Function
	
	Track__OS = ParseBrowserAgent( StrAgent )
	Track__OS = Replace( Track__OS, "(", " _ " )
	Track__OS = Replace( Track__OS, "/", "\/" )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Toggle Output
// ---------------------------------------------------------------------------------------------------------------------------------------------

  If fw_OutPut = 0 or fw_OutPut = "" Then

// ---------------------------------------------------------------------------------------------------------------------------------------------
%>

<!DOCTYPE html>
<html>
<head>
<title><%=Fw__AppName%></title>
<meta http-equiv='Content-Type' content='text/html;charset-UTF-8'/>
<meta http-equiv='X-UA-Compatable' content='IE=edge; chrome=1'/>
<meta name='Description' content='Town and Gown Lettings is a new Oxford based letting agency for working professionals and University goers seeking affordable long or shortlet accommodation specifically within the Oxford area. We are an introductory service matching Tenants with Properties.'/>
<meta name='Keywords' content='oxford lettings, oxford lettings agents, properties to rent in oxford, properties required in oxford, oxford shortlets, apartments in oxford, shortlet apartments oxford, smart oxford apartments to rent'/>
<meta name='Server' content='<%=ServerAddr%>'/>
<meta name='Generator' content='<%=Fw__Generator%>'/>
<meta name='Y-Key' content='<%=YKey%>'/>
<meta name='Author' content='<%=fw_Developer%>'/>
<link rel='icon' href='<%=fw_ShortCutIcon%>' type='image/x-icon'/>
<link rel='shortcut icon' href='<%=fw_ShortCutIcon%>' type='image/x-icon'/>

<script src='/application/library/javascript/prototype/source.js' type='text/javascript' language='javascript'></script>
<script src='/application/library/javascript/scripty/scriptaculous.js' type='text/javascript' language='javascript'></script>
<script src='/application/library/javascript/jscript/functions.js' type='text/javascript' language='javascript'></script>
<script src='/application/library/javascript/jscript/jcrop.js' type='text/javascript' language='javascript'></script>

<link href='/styles/css/?output:1' rel='stylesheet' type='text/css'/>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
TrackImpression('<%=Track__Page%>', '<%=Track__IpAddress%>', '<%=Track__OS%>', '<%=Track__Referrer%>');
});
</script>

</head>


<!-- gallery wrapper -->

  <div class='galleryBoxWrap' id='galleryBoxWrap'>
    <div class='galleryBoxOverlay'>&nbsp;</div>
		
		<div class='galleryVerticalOffset'>
		  <div class='galleryBox' id='galleryBox'>
			  <div class='load-galleryBox'>Loading Gallery</div>
			</div>
			</div>
	</div>


<!-- end gallery wrapper -->




<!-- alert wrapper -->

<div class='dumbBoxWrap' id='dumbBoxWrap'>
  <div class='dumbBoxOverlay'>&nbsp;</div>
	
	<div class='vertical-offset'>
	  <div class='dumbBox' id='dumbBox'>
		  <div class='load-dumbBox'>Please Wait...</div>
		</div>
	</div>
</div>

<!-- end alert wrapper -->




<body id='top'>


<div id='container'>
  <div id='templatespacer'>&nbsp;</div>
  <div class='templateholder'>
	
	
	<!-- start template -->
	
	<!--#include virtual="/application/content/template/tmp_header.pl"-->
	
	<% If fw_Query > "" Then %>
	
	<!--#include virtual="/application/content/template/tmp_headerlinks.pl"-->
	
	  <div id='contentholder'>
		  <%'<div class='navigation'><!--#include virtual="/application/content/template/tmp_navigation.pl"--></div>%>
			<div class='content'>
			
			<% Call LoadSourceFile( fw_Circuit ) %><div class='contentspacer'></div>
			</div>
		</div>
		<!--#include virtual="/application/content/template/tmp_footerlinks.pl"-->
		
		
		
		
		
		
		
	<% Else %>
	
	
	
	
	
<!--#include virtual="/application/content/template/tmp_headerlinks.pl"-->

<div class='mainheader' style='padding-left:19px; border-bottom:solid 0px #ffffff; padding-bottom:0px;'>Welcome to Town and Gown Shortlets</div>

<div class='basictext' style='margin-bottom:5px; padding-left:18px; cursor:default;'>
Town and Gown Shortlets is a new Oxford based Agency for anyone needing affordable Shortlet Accommodation within 
the Oxford area. We are an introductory service offering a more economical and versatile solution to hotel accommodation.
</div>
	
<div id='splash_row'>
  <div class='cell'>  <img src='/application/library/media/splash_2_1_shadow.jpg'/> </div>
	<div class='cell'>  <img src='/application/library/media/splash_2_2_shadow.jpg'/> </div>
	<div class='cell'>  <img src='/application/library/media/splash_2_3_shadow.jpg'/> </div>
	<div class='cell'>  <img src='/application/library/media/splash_2_4_shadow.jpg'/> </div>
</div>

<!--#include virtual="/application/content/template/tmp_footerlinks.pl"-->
	
	
	<% End If %>
	
	<!--#include virtual="/application/content/template/tmp_footer.pl"-->
		
	<!-- end template   -->
	
	</div>
</div>

<div class='footer-row' style='width:700px; margin-left:auto; margin-right:auto; color:#ffffff;'>
  <span class='foot-cell' style='width:540px;'><div class="admin"><a href="http://<%=Fw__AdminFQDN%>" target="_blank">Admin login</a></div></span>
	<span class='foot-cell'> <%'<span class='jackfm'><a href="http://www.jackfm.co.uk" target='_blank' title='Visit Jack FM'></a></span>%> </span>
</div>








</body>
</html>

<% 
// ---------------------------------------------------------------------------------------------------------------------------------------------
  
	Else
	  Call LoadSourceFile( fw_Circuit )
	End If

// ---------------------------------------------------------------------------------------------------------------------------------------------
%>