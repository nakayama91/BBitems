require 'rails_helper'

describe 'ジャンルモデル' do
  describe '新規投稿' do

    it "名前があれば登録できる" do
      expect(FactoryBot.build(:genre)).to be_valid
    end

  end
end