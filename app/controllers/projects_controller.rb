class ProjectsController < ApplicationController
  require 'csv'
  before_filter :authenticate_user!
  before_filter  :check_for_project_owner , only:[:show ,:edit]
  
  def index
    #show the list of projects 
    @project = Project.new
    @users = User.all
    @projects = Project.search(params[:search],current_user).order("title").page(params[:page]).per(1)
  end

  def new
    @project = Project.new
    @users = User.all
  end

  def create
    params[:project][:user_ids] << params[:project_admin]
    @project = Project.new(params[:project])
    @project.admin_id = params[:project_admin]
    @team_members=  @project.users

    if @project.save 

        #@team_members.each do |team_member|
          #UserMailer.project_creation(team_member,@project).deliver
           EmailNotifyWorker.perform_async(project_id , user_ids)
        #end
       respond_to do |format|
         
          format.html {

             redirect_to projects_path , :notice => "Save successfully"
           }


           format.js{
            render json: { success: true,message: "Saved successfully"}
           }
        end 
    else
      @users = User.all
     # flash[:alert] = @project.errors.full_messages.collect(&:humanize).join(", ") 
      respond_to do |format|
        format.html {
          redirect_to projects_path
        }
        format.js {
          render json: { success: false,message: "Please correct the following errors", errors: @project.errors }
        }
      end 
    end
  end

  def show
    @project = Project.find(params[:id])  #show the project
    @team_members=  @project.users
    @users = User.all

    #binding.pry
    @tasks  = @project.search_task(params) || @project.tasks

    @task = Task.new
    respond_to do |format|
      format.html
    #format.csv { send_data Task.to_csv(@tasks)}
    format.csv { send_data Task.to_csv(@tasks), :filename => '<file_name>.csv' }
    end
    
    #@tasks = @project.search_status(params[:status])
  end

  def destroy
    @project = Project.find(params[:id])
    team_members=  @project.users.collect(&:email)
    title = @project.title

     @project.destroy
=begin
        team_members.each do |team_member|
                 UserMailer.delay.project_deletion(team_member,title)
              end
=end

      redirect_to projects_path ,:notice => "Destroy successfully"#redirect to show page ifproject delete 
      
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
       respond_to do |format|
          format.html {
             redirect_to project_path , :notice => "Update successfully"
           }

           format.js{
            render json: { success: true,message: " Update successfully"}
           }
        end 
      
    else
      @users = User.all
      #flash.now.alert = "Attributes are not updated successfully"
      respond_to do |format|
        format.html {
          redirect_to project_path
        }
        format.js {
          render json: { success: false,message: "Please correct the following errors", errors: @project.errors }
        }
      end 
    
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

  def edit_action
    @project = Project.find(params[:project_id])
    @users = User.all
    respond_to do |format|
      #binding.pry
      format.js{
          
          render json: { success: true,message: " Update successfully",:partial_string => render_to_string(:partial => "/projects/project_model")}
        }
    end  
  end
end