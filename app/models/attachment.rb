class Attachment < ActiveRecord::Base
  attr_accessible :file, :task_id
  mount_uploader :file , FileUploader
  belongs_to :task 

end
