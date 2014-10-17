class TasksController < ApplicationController
	require 'csv'
	before_filter :authenticate_user!
	before_filter :check_for_project_member ,except: [:mytasks]

	def index
		@tasks = Task.all

	end 

	def create
		@project = Project.find(params[:project_id])
		#binding.pry
		@task = @project.tasks.new(params[:task])

		if @task.save 
				UserMailer.delay.task_creation(@task.task_owner,@task)
			  redirect_to project_path(@project) ,:notice => "Saved successfully"
		
		else
			flash.alert =  @task.errors.full_messages.collect(&:humanize).join(", ") 
			@team_members =  @project.users
		  render('new')
	
		end
	end

	def new
		@project = Project.find(params[:project_id])
		@task = Task.new 
		#binding.pry
		@team_members =  @project.users
		#@file = @task.attachments.build
	end

	def destroy
		@project = Project.find(params[:project_id])
		@task = Task.find(params[:id])
		task_owner=  @task.task_owner
		title = @task.title
		if @task.destroy 
		  UserMailer.delay.task_deletion(task_owner.email,title)
			
			redirect_to project_path(@project) , :notice => "Destroy successfully"
		end
	end

	def show 
		@project = Project.find(params[:project_id])
		@task = Task.find(params[:id])
	end 

	def edit
		@project = Project.find(params[:project_id])
		@task = Task.find(params[:id])
		@team_members =  @project.users
	end 

	def mytasks
		@tasks  = Task.search_mytask(params,current_user) || current_user.tasks 
		respond_to do |format|
		format.html
		#format.csv { send_data Task.to_csv(@tasks)}
		format.csv { send_data Task.to_csv(@tasks), :filename => '<file_name>.csv' }
		end
	end 

	def update
		project = Project.find(params[:project_id])
		@task = Task.find(params[:id])
		if @task.update_attributes(params[:task])
			redirect_to project_task_path , :notice => "Update successfully"
		else
			flash.now.alert = "Attributes are not updated successfully"
			render('edit')
		end
	end 

	def check_for_project_member
		@project = Project.find(params[:project_id])
		redirect_to homes_path unless @project.users.pluck(:id).include? current_user.id
	end
end
