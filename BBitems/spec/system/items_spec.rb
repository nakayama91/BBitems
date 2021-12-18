# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:item) { create(:item, name:'name',introduction:'---')}

  # 1.top画面
  describe 'top画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'top画面(root_path)に「Welcom to BBitems」が表示されているか' do
        expect(page).to have_content 'Welcom to BBitems'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  # 2.新規投稿画面
  describe "投稿画面(new_item_path)のテスト" do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      visit new_item_path
    end
    context '表示の確認' do
      it 'new_item_pathが"/items/new"であるか' do
        expect(current_path).to eq('/items/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_content '投稿する'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'item[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'item[introduction]', with: Faker::Lorem.characters(number:20)
        click_button '投稿する'
        expect(page).to have_current_path items_path
      end
    end
  end

  # 3.投稿一覧のテスト
  describe "投稿一覧のテスト" do
    before do
      visit items_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content item.name
        expect(page).to have_link item.name
      end
    end
  end

  # 4.詳細画面のテスト
  describe "詳細画面のテスト" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
      visit item_path(item.id)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        if item.user_id == @user.id
          expect(page).to have_link '削除する'
        end
      end
    end
  end

end