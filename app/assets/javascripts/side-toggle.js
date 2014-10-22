$(document).ready(function(){
	$('#wrapper').click(function(){
		$.ajax ({
			url: '/toggle',
			type: 'POST'
		})
	});
})