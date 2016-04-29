// Scrolling sidebar for your website
// Downloaded from Marcofolio.net
// Read the full article: http://www.marcofolio.net/webdesign/create_a_sticky_sidebar_or_box.html

window.onscroll = function()
{
	if( window.XMLHttpRequest ) {
		if (document.documentElement.scrollTop > 90 || self.pageYOffset > 90) {
			$('post-floater').style.position = 'fixed';
			$('post-floater').style.top = '55px';
		} else if (document.documentElement.scrollTop < 90 || self.pageYOffset < 90) {
			$('post-floater').style.position = 'absolute';
			$('post-floater').style.top = '90px';
		}
	}
}