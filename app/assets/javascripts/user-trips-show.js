$(document).ready(function(){
	$('.trip').hover(function(){
		$(this).css('background-color','red')
	},function(){
		$(this).css('background','none')
	});

	$('.best_in_place').best_in_place()
});