class Project < ActiveRecord::Base
	# attr_accessible :title, :body
	attr_accessible :title , :description ,:admin_id,:user_ids
	validates_presence_of :title , :description 

	validates :description, length: { minimum: 20 }

	has_and_belongs_to_many :users
	belongs_to :project_owner ,:class_name => 'User' ,:foreign_key => "admin_id"
	has_many :tasks


	def self.search(search,current_user)
		if search
			current_user.projects.where('title LIKE ?', "%#{search}%")
			#find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
		else
			current_user.projects
		end
	end

	def search_task(params)
	  if params[:title].present?
			project_tasks = tasks.where('title LIKE ?', "%#{params[:title]}%")
		end

		if params[:status].present? && project_tasks.present?
			project_tasks.where('status LIKE ?', "%#{params[:status]}%")
		elsif params[:status].present?
			tasks.where('status LIKE ?', "%#{params[:status]}%")
		end
  end
end
