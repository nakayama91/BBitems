require 'rails_helper'

describe 'ユーザーモデル' do
  describe '新規登録' do

    it "名前・アドレス・パスワードがあれば登録できる" do
      expect(FactoryBot.build(:user)).to be_valid
    end

  end
end