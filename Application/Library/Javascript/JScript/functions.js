function OpenModalBox(){
	
	var dumbBox = document.getElementById('dumbBox');
  document.getElementById('dumbBoxWrap').style.display="block";
	document.documentElement.style.overflow = 'hidden';
	document.body.scroll = "no";
	dumbBox.innerHTML = "<div class='load-dumbBox'>Please Wait...</div>";
}

function CloseModalBox(){
  var dumbBox = document.getElementById('dumbBox');
  document.getElementById('dumbBoxWrap').style.display="none";
	document.documentElement.style.overflowY = 'auto';
	document.body.scroll = "yes";
	dumbBox.innerHTML = "<div class='load-dumbBox'>Please Wait...</div>";
}

function OpenGalleryBox(){
  var galleryBox = document.getElementById('galleryBox');
	document.getElementById('galleryBoxWrap').style.display = "block";
	galleryBox.innerHTML = "<div class='load-galleryBox'>Loading Gallery...</div>";
}

function CloseGalleryBox(){
  var galleryBox = document.getElementById('galleryBox');
	document.getElementById('galleryBoxWrap').style.display = "none";
  galleryBox.innerHTML = "<div class='load-galleryBox'>Loading Gallery...</div>";
}

function FetchPage( url, target, method ){
  var url     = url;
	var target  = target;
	var method  = method;
	var params  = "";
	new Ajax.Updater( target, url, { method: method, parameters: params, asynchronous:true });
}

function TrackImpression( page, visitor, os, referrer ){

  var page = page;
	var visitor = visitor;
	var os = os;
	var referrer = referrer;
	var url      = "/savevisit/actions?output:1;cache:" + new Date().getTime()
	var pars     = ";page:" + page + ";visitor:" + visitor + ";os:" + os + ";referrer:" + referrer
	var url      = url + pars
	var method   = "GET";
	new Ajax.Request( url, { method: method, onComplete: function( transport ) { var mydata = transport.responseText; }});
}

function AjaxRequest( url, method, processcmd ){
 // var url        = url;
	//var method     = method;
	//var processcmd = processcmd;
	//new Ajax.Request( url, { method: method, oncomplete: function( transport ) { var mydata = transport.responseText; processcmd }});
}

function RandomCmd( rtext ){
 // alert( 'cmd loaded');
}

function Login(){
  var username  = document.getElementById('username');
	var password  = document.getElementById('password');
	var wait      = document.getElementById('loginwait');
	var error     = document.getElementById('errorbox');
	var button    = document.getElementById('loginbutton');
	
	var usertxt   = username.value;
	var passtxt   = password.value;
	var authurl   = "/authlogin/actions/?output:1;user:" + usertxt + ";pass:" + passtxt + ";cache:" + new Date().getTime();
	var method    = "GET";
	
	button.style.display = "none";
	wait.style.display   = "block";
	
	if ( usertxt == '' ) {
	  error.style.display  = "block";
		error.innerHTML      = "Please enter a Username or Email Address";
		button.style.display = "block";
		wait.style.display   = "none";
	
	} else if ( passtxt == '' ) {
	  error.style.display = "block";
		error.innerHTML     = "Please enter a valid password";
		button.style.display = "block";
		wait.style.display   = "none";
	
	} else {
	  error.style.display = "none";
		new Ajax.Request( authurl, { method: 'get', onComplete: function( transport ) { var mydata = transport.responseText; ProcessLogin( mydata ) }});
	}
}

function ProcessLogin( rtext ){
  var rtext     = rtext;
	var json      = eval("(" + rtext + ")");
	var code      = json.responsecode;
	var user      = json.username;
	var etext     = json.responsetext;
	var wait      = document.getElementById('loginwait');
	var error     = document.getElementById('errorbox');
	var button    = document.getElementById('loginbutton');
	
	if ( code == '1' ) {
	  wait.style.display   = "none";
		button.style.display = "block";
		error.style.display  = "block";
		error.innerHTML      = etext;
	
	} else if ( code == '2' ) {
	  wait.style.display   = "none";
		button.style.display = "block";
		error.style.display  = "block";
		error.innerHTML      = etext;
	
	} else if ( code == '3' ) {
	  wait.style.display   = "none";
		button.style.display = "block";
		error.style.display  = "block";
		error.innerHTML      = etext;
	
	} else if ( code == '4' ) {
	  error.style.display  = "none";
		document.location.href = "/profile/account/?token:" + user;
	} else {
	  error.style.display  = "block";
		wait.style.display   = "none";
		button.style.display = "block";
		error.innerHTML      = "An unknown error has occurred";
	
	}
}

function LogOut(){
  OpenModalBox();
	var url    = "/prompt/alerts/?output:1;responsetext:Are you sure you want to log out*;title:Log Out"
	var target = "top";
	var pars   = ";actionurl:/logout/actions/?output:1" 
	var url    = url + pars
	FetchPage( url, 'dumbBox', 'GET' );
}

function FetchPicture( picture, listingid, sqltable ){
  OpenGalleryBox();
	var sqltable = sqltable;
	var picture  = picture;
	var advertid = advertid; 
	var url      = "/picturegallery/alerts/?output:1;url:" + picture + ";listingid:" + listingid + ";table:" + sqltable;
	var target   = "galleryBox";
	var pars     = "";
	FetchPage( url, target, 'GET' ); 
}

function SwapGalleryThumb( src, imagedesc ) {
  var src          = src;
	var mainimg      = document.getElementById('mainimg');
	var desc         = document.getElementById('smalldescription');
	var imagedesc    = imagedesc;
	
	desc.innerHTML   = imagedesc;
	mainimg.src      = src;
}

function GetErrorResponse( txt ){
  var txt     = txt;
	var url     = "/alert/alerts/?output:1;"
	var pars    = "title:Oops, Something went wrong!;responsetext:<b>A permanent error has occurred:</b><br/>Please try again later.<br/><br/><hr/>" + txt;
	var url     = url + pars;
	var target  = "dumbBox";
  var wait    = document.getElementById('formwait');
	var button  = document.getElementById('actionbutton');
	
	wait.style.display   = "none";
	button.style.display = "block";
	
	OpenModalBox();
	FetchPage( url, target, 'GET');
}

function NewRegistration(){
  var wait       = document.getElementById('formwait');
	var button     = document.getElementById('actionbutton');
	var title      = document.getElementById('title').value;
	var firstname  = document.getElementById('firstname').value;
	var surname    = document.getElementById('surname').value;
	var telephone  = document.getElementById('telephone').value;
	var mobile     = document.getElementById('mobile').value;
	var email      = document.getElementById('email').value;
	var url        = "/checkregister/actions/?output:1;"
	var pars       = "title:" + title + ";firstname:" + firstname + ";surname:" + surname + ";telephone:" + telephone + ";mobile:" + mobile + ";email:" + email +";";
  var url        = url + pars
	
	wait.style.display   = "block";
	button.style.display = "none";
	
	new Ajax.Request( url, { method:'get', onSuccess: function(transport) { var response = transport.responseText || "no response text"; ProcessRegistration( response ); }, onFailure: function(transport) { var rtext = transport.responseText; GetErrorResponse( rtext ) } });
}

function ProcessRegistration( rtext ){

  var rtext   = rtext;
	var wait    = document.getElementById('formwait');
	var button  = document.getElementById('actionbutton');
	var json    = eval("(" + rtext + ")");
	var rcode   = json.responsecode;
	var rtext   = json.responsetext;
	var token   = json.token;
	var url     = "/alert/alerts/?output:1;showclose:0;";
	var target  = "dumbBox";
	
	if ( rcode < 11 ) {
	  wait.style.display   = "none";
		button.style.display = "block";
		var pars = "title:Submission Error;responsetext:" + rtext;
		var url  = url + pars;
		OpenModalBox();
		FetchPage( url, target, 'GET');
	} else {
	  document.location.href = "/regcomplete/account/?token:" + token;
	}
}

// Select Payment Method


function SelectPayMethod( token ){
  var token  = token;
	var cheque = document.getElementById('paymethod1');
	var bank   = document.getElementById('paymethod2');
	var edit   = document.getElementById('edit');
	var evalue = edit.value;
	
	if ( ( cheque.checked == false ) && ( bank.checked == false ) ) {
		var target = "dumbBox";
		var url    = "/alert/alerts/?output:1;"
		var pars   = "title:Submission Error;responsetext:Please select a payment method"
		var url    = url + pars;
		OpenModalBox();
		FetchPage( url, target, 'GET');
	} else {
		
		// get selected values
		
    if (( cheque.checked == true ) ) {
		  var selectedmethod = cheque.value;
		} else if (( bank.checked == true ) ){
		  var selectedmethod = bank.value;
		} else {
		  var selectedmethod = "";
		}
		
		
		
		if (( selectedmethod == 1 )) {
		  document.location.href='/paymenthandler/actions/?paymethod:' + selectedmethod + ';token:' + token + ";edit:" + evalue;
		} else if (( selectedmethod == 2 )) {
		  document.location.href='/paymenthandler/actions/?paymethod:' + selectedmethod + ';token:' + token + ";edit:" + evalue;
		} else if (( selectedmethod == 3 )) {
		  document.location.href='/paymenthandler/actions/?paymethod:' + selectedmethod + ';token:' + token + ";edit:" + evalue;
		} else {
		// do nothing
		}
	}
	
}

function TxDetails( url ){
  var url = url;

  OpenModalBox();
	FetchPage( url, 'dumbBox', 'GET' );
}


function SaveProfile() {
  var wait      = document.getElementById('formwait');
	var button    = document.getElementById('actionbutton');
  var title     = document.getElementById('title').value;
	var firstname = document.getElementById('firstname').value; 
	var surname   = document.getElementById('surname').value;
	var telephone = document.getElementById('telephone').value;
	var mobile    = document.getElementById('mobile').value;
	var email     = document.getElementById('email').value;
	var pass      = document.getElementById('pass').value;
	var pass1     = document.getElementById('pass1').value;
  var url       = "/saveprofile/actions/?output:1;" 
	var pars      = "title:" + title + ";firstname:" + firstname + ";surname:" + surname + ";telephone:" + telephone + ";mobile:" + mobile + ";email:" + email + ";pass:" + pass + ";pass1:" + pass1;
	var url       = url + pars;
	
	wait.style.display   = "block";
	button.style.display = "none";
	
  new Ajax.Request( url, { method:'get', onSuccess: function(transport) { var response = transport.responseText || "no response text"; ProcessSaveProfile( response ); }, onFailure: function(transport) { var rtext = transport.responseText; GetErrorResponse( rtext ) } });

}

function ProcessSaveProfile( rtext ){
  var rtext   = rtext;
	var wait    = document.getElementById('formwait');
	var button  = document.getElementById('actionbutton');
	var json    = eval("(" + rtext + ")");
	var rcode   = json.responsecode;
	var rtext   = json.responsetext;
	var token   = json.token;
	var url     = "/alert/alerts/?output:1;showclose:0;"
	var target  = "dumbBox"
	
	if ( rcode < 12 ) {
	  wait.style.display   = "none";
		button.style.display = "block";
		var pars  = "title:Submission Error;responsetext:" + rtext;
		var url   = url + pars;
		OpenModalBox();
		FetchPage( url, target, 'GET');
	} else {
	  wait.style.display   = "none";
		button.style.display = "block";
	  OpenModalBox();
		FetchPage( '/notify/alerts/?output:1;showclose:0;title:Details Updated;responsetext:Your details were updated successfully.', target, 'GET' );
	}
}

function ChangePassword() {
  OpenModalBox();
	var url    = "/changepassword/alerts/?output:1"
	var target = "dumbBox";
	FetchPage ( url, target, 'GET' );
}

function DoChangePassword(){
}

function SendMessage(){
  var fullname = document.getElementById('fullname').value;
	var telephone = document.getElementById('telephone').value;
	var email     = document.getElementById('email').value;
	var message   = document.getElementById('message').value;
	var url       = "/sendmessage/actions/?output:1;"
	var pars      = "fullname:" + fullname + ";telephone:" + telephone + ";email:" + email + ";message:" + message
	var url       = url + pars;
	
	alert( "Sorry, this feature is unavailable at the moment" );
	
}