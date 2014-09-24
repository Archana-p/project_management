$(document).ready(function(){
  $("#all").change(function(){
 // $(this).isalert("all checked")
    var check_value = $(this).is(":checked")

     if(check_value == true)
     	 $(".check_box").prop( "checked", true );
     	else
     		$(".check_box").prop( "checked", false );

  });
	
	$(".submit").click(function(e){
		
     var task_check_value = $(".check_box").is(":checked")
     if((task_check_value == true) && ($("#check_status").val() != ""))
      {}
     else
			{e.preventDefault();}
  });
  
  $("#save_task").click(function(){ 
    $("form#new_task").submit() 
  });

  $("#save_project").click(function(){ 
    $("form#new_project").submit() 
  });

});