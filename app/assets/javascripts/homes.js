
$(document).ready(function(){
	$("#create_button").click(function() {
		$.ajax({
		type : "GET" ,
    url :"/homes/test_ajax",
    dataType : "json"

  	})
  	.done(function( response ) {
    alert( response.message);
  });
	});
  
	
	

});