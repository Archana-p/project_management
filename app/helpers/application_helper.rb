module ApplicationHelper
	def class_for_flash_message(flash_type)
		case flash_type
		when "notice"
			"alert-success"
		when "alert"
			"alert-danger"
		when "error"
			"alert-danger"
		end	 	   
	end


	def class_for_task_label(status_type)
		#binding.pry
		case status_type

		when "done"
			"label label-success"
		when "not_started"
			"label label-default"
		when "started"
			"label label-primary"
		end
	end


	def add_breadcrumb
		breadcrumb_html = "<li><a href=#{homes_path}> Home</a></li>"
		breadcrumb_html += "<li><a href=#{projects_path}> Project List</a></li>" 
    breadcrumb_html += "<li><a href=#{project_path(@project)}> #{@project.title}</a></li>" if @project.present? && !@project.new_record?
    breadcrumb_html += "<li><a href=#{project_task_path(@task.project.id , @task.id)}> #{@task.title}</a></li>" if  @task.present? && !@task.new_record?
		breadcrumb_html.html_safe
	end
end