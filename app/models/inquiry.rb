class Inquiry < MailForm::Base
  attributes :email, :name, :subject, :body
  validates :name, :subject, :body, :presence => true
  validates :email, :presence => true, :email => true
  append :remote_ip, :user_agent

  def headers
    {
      :from => Rails.application.config.technical_sender_email,
      :to => Rails.application.config.nontechnical_recipient_email,
      :subject => "New inquiry from website"
    }
  end
end
