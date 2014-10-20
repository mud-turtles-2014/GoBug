$(document).ready(function(){
	$('.trip').hover(function(){
		$(this).css('background-color','red')
	},function(){
		$(this).css('background','none')
	});

	$('.best_in_place').best_in_place()

	$('body').on('click','.delete',function(e){
		$(e.target).closest('li').hide();
		console.log($(e.target).closest('li'))
	})

	$('.sidebar-nav li a').hover(function(){
		$(this).parent().children('.x-delete').show();
	}, function(){
		$(this).parent().children('.x-delete').hide();
	})
});