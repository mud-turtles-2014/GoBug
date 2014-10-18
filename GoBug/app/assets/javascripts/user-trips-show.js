$(document).ready(function(){
	$('.trip').hover(function(){
		$(this).css('background-color','red')
	},function(){
		$(this).css('background','none')
	});
});