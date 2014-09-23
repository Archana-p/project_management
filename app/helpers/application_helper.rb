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

end
