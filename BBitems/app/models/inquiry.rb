class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :message

  validates :name, :presence => {:message => 'ユーザー名を入力してください'}
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}

end