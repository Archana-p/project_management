class ProjectsController < ApplicationController

	require 'csv'
before_filter :authenticate_user!
before_filter  :check_for_project_owner , only:[:show ,:edit]
	def index
		 #show the list of projects 
    @project = Project.new
    @users = User.all
		@projects = Project.search(params[:search],current_user)
		
	end

	def new
		@project = Project.new
		@users = User.all
	end

	def create
		 @project = Project.new(params[:project])
		 @project.admin_id = params[:project_admin]
	   @team_members=  @project.users
	   
	   if @project.save 
	   	@team_members.each do |team_member|
	   	 UserMailer.project_creation(team_member,@project).deliver
	   	end
	    redirect_to projects_path , :notice => "Save successfully"
	   else
	   	@users = User.all
	   	#binding.pry
	   	 flash[:alert] = @project.errors.full_messages.collect(&:humanize).join(", ") 
	   	redirect_to projects_path
	   	end
	end

	def show
		@project = Project.find(params[:id])  #show the project
		@team_members=  @project.users.collect(&:name).join(", ")
		@users = User.all
		
		#binding.pry
		@tasks  = @project.search_task(params) || @project.tasks
		@task = Task.new
		respond_to do |format|
      format.html
      #format.csv { send_data Task.to_csv(@tasks)}
      ##we can also change the downloaded CSV file name by setting filename attribute of send_data method
      format.csv { send_data Task.to_csv(@tasks), :filename => '<file_name>.csv' }
    end
		##binding.pry
		#@tasks = @project.search_status(params[:status])

	end

	def destroy
		@project = Project.find(params[:id])
    team_members=  @project.users.collect(&:email)
    title = @project.title
       	 

   if @project.destroy
   	
   	 	team_members.each do |team_member|
	   	 UserMailer.project_deletion(team_member,title).deliver
	   	end
	  
   redirect_to projects_path ,:notice => "Destroy successfully"#redirect to show page ifproject delete 
	end
	end 
	

	def edit

		@project = Project.find(params[:id])
		@users = User.all
	end

   def update
   	#binding.pry
      @project = Project.find(params[:id])
      @project.admin_id = params[:project_admin]
      if @project.update_attributes(params[:project])
      	redirect_to project_path , :notice => "Update successfully"
      else
      	@users = User.all
      	 flash.now.alert = "Attributes are not updated successfully"
      	render('edit')
      end
   end


	def update_tasks
	#binding.pry		
  @project = Project.find(params[:id])
  project_tasks = @project.tasks.where(id: params[:task_ids])
	  project_tasks.each do |task|
	  	task.update_attributes(status: params[:check_status])

	  end
  redirect_to project_path
	end 

   def check_for_project_owner

		@project = Project.find(params[:id])
		#binding.pry
		
		redirect_to homes_path unless @project.users.pluck(:id).include? current_user.id
	end

end
