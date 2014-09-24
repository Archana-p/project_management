class Task < ActiveRecord::Base
  attr_accessible :description, :status, :title,:user_id,:attachments_attributes
  belongs_to :project
  validates_presence_of :title , :description 
  validates :description, length: { minimum: 5 ,too_short: "must have at most %{count} words"}
  validates :status, inclusion: { in: %w(not_started started done) , message: "%{value} is reserved." }
  belongs_to :task_owner ,:class_name => 'User' , :foreign_key => "user_id" 
  has_many :attachments , :dependent => :destroy
  accepts_nested_attributes_for :attachments ,:reject_if => :all_blank

  def self.task_status
    [['Not Done','not_done'],['Not Started','not_started'],['Started','started'],['Done','done']]
  end

  def formatted_status
    status.humanize
    #Hash[self.class.task_status].fetch(status)  rescue nil
  end 

  def self.search_mytask(params,user)
    project_tasks = nil
    if params[:project_title].present?
      #binding.pry
      project_tasks = user.tasks.includes(:project).where('projects.title LIKE ?',"%#{params[:project_title]}%")
    end
    if params[:title].present? && project_tasks.present?
      project_tasks = project_tasks.where(title: params[:title])  
    elsif params[:title].present?
      project_tasks = user.tasks.where(title: params[:title])
    end

    if params[:status].present? && project_tasks.present?
      project_tasks = project_tasks.where(status: params[:status])
    elsif params[:status].present?
      project_tasks = user.tasks.where(status: params[:status])
    end
    project_tasks
  end

  def self.to_csv(tasks)
    CSV.generate do |csv|
      csv << ["Task ID",  "Title",  "Description",  "Status"] ## Header values of CSV
      tasks.each do |task|
      csv << [task.id, task.title, task.description, task.status]##Row values of CSV
      end
    end
  end

end
