class InquiryMailer < ApplicationMailer

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => inquiry.email)
    mail bcc: ENV['INQUIRE_MAILER_ADDRESS'], subject:'お問い合わせを承りました'
  end

end
