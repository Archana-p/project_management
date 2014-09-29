class UserMailer < ActionMailer::Base
  default from: "archana10dpatil@gmail.com"

  def project_creation(user , project)
    @project = project
    mail(:to => user.email , :subject => "Registered")
  end
  
  def project_deletion(email , title)
    @title=title
    mail(:to => email , :subject => "Project Destroy")
  end
    
  def task_creation(user , task)
    @task = task
    mail(:to => user.email , :subject => "Registered")
  end
   
  def task_deletion(email , title)
    @title=title
    mail(:to => email , :subject => "Task Destroy")
  end
end
