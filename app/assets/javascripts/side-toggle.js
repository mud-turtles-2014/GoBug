$(document).ready(function(){
	$('#menu-toggle').click(function(){
		$('#menu-toggle').css('background-color','red')
		$.ajax ({
			url: '/toggle',
			type: 'POST'
		})
	});
})