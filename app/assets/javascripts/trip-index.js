$(document).ready(function(){
	$('.col-md-4').hover(function(){
		// $(this).css('background','rgba(127,245,235,0.8)');
		$(this).find('.wishlist-button').show();
	}, function(){
		// $(this).css('background','white');
		$(this).find('.wishlist-button').hide();
	});

	$('#new_wishlist').submit(function(e){
		e.preventDefault();
		$(this).children('#modal-submit').val("Submitting...")
		$.ajax ({
			url: '/wishlists',
			type: 'POST',
			data: $(e.target).serialize()
		}).done(function(response){
			location.reload();
			$('#modal').modal('toggle');
		})
	})
});