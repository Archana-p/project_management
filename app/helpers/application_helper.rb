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
end