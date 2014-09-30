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
  
  $("#save_project").click(function(e) {
    e.preventDefault();
    $.ajax({
      type : "post" ,
      url : $("#new_project").attr("action"),
      data : $("#new_project").serialize(),
      dataType : "json"
    }).done(function( response ) {
      if(response.success == true)
      {
        $("#project_model").modal("hide")
         window.location.reload()
      }
      else
        $.each( response.errors,function(element,value){ 
          var data_attr = '[data-class='+element+']'; 
          $(data_attr).addClass("errors").siblings('span').html(value.join());
        });
        //$(".task_error_message").html(response.errors)
    });
  });


  $("#save_task").click(function(e) {
    e.preventDefault();
    $.ajax({
      type : "post" ,
      url : $("#new_task").attr("action"),
      data : $("#new_task").serialize(),
      dataType : "json"
    }).done(function( response ) {
      if(response.success == true)
      {
        $("#myModal").modal("hide")
         window.location.reload()
      }
      else
        
        //$(".task_error_message").html(response.errors)
      $.each( response.errors,function(element,value){ 
          var data_attr = '[data-class='+element+']'; 
          $(data_attr).addClass("errors").siblings('span').html(value.join());
        });
        //$("
    });
  });

  

  $("#edit_project").click(function(e){
    e.preventDefault();
    $.ajax({
      type :"get",
      url : "/projects/edit_action?project_id="+$(this).attr("data-id")+"",
      dataType : "json"
    }).done(function(response){
      if(response.success == true)
      {
        $("#project_model").modal("show")
        $("#project_model").html(response.partial_string);
        $('.chosen-select').chosen({ width: '200px'});
        $("#Update_project").click(function(e){
          e.preventDefault();
          $.ajax({
            type :"post",
            url : $(".edit_project").attr("action"),
            data : $(".edit_project").serialize(),
            dataType : "json"
          }).done(function(response){
            if(response.success == true)
            {
              $("#project_model").modal("hide")
              window.location.reload()
            }
            else
              //$(".task_error_message").html(response.errors)
              $.each( response.errors,function(element,value){ 
                var data_attr = '[data-class='+element+']'; 
                $(data_attr).addClass("errors").siblings('span').html(value.join());
              });
          });
        });
        //window.location.reload()
      }
    });
  });

  $('#project_model').on('hidden.bs.modal', function (e) {
    $(".errors").removeClass("errors");
    $("span.error_message").html("");
  })


  $('#myModal').on('hidden.bs.modal', function (e) {
    $(".errors").removeClass("errors");
    $("span.error_message").html("");
  })

   $('.chosen-select').chosen({ 
    width: '200px'});
      

  
    

});