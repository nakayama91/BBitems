require 'rails_helper'

describe 'アイテムモデル' do
  describe '新規投稿' do

    before do
      # ジャンルモデルのインスタンスを生成する
      @genre = FactoryBot.create(:genre)
      # ジャンルモデルのインスタンスからidを抽出する
      @item = FactoryBot.build(:item, genre_id: @genre.id)
      sleep 0.1
    end

    it "製品名・説明・ジャンルがあれば登録できる" do
      expect(@item).to be_valid
    end

  end
end