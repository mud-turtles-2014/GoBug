$(document).ready(function(){
	$('#menu-toggle').click(function(){
		$.ajax ({
			url: '/toggle',
			type: 'POST'
		})
	});
})