class InquiryMailer < ApplicationMailer

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => inquiry.email, :subject => 'お問い合わせを承りました')
    mail bcc: ENV['INQUIRE_MAILER_ADDRESS']
  end

end
