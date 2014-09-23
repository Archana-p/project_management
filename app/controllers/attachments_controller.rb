class AttachmentsController < ApplicationController
	def destroy
		@project = Project.find(params[:project_id])
		@task = Task.find(params[:task_id])
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
   redirect_to edit_project_task_path(@project,@task) , :notice => "Destroy successfully"
	end 
end
