# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:item) { create(:item, name:'name',introduction:'---')}

  describe 'index画面(items_path)のテスト' do
    before do
      visit items_path
    end
    context '表示の確認' do
      it 'index画面(items_path)に「投稿一覧」が表示されているか' do
        expect(page).to have_content '投稿一覧'
      end
      it 'items_pathが"items"であるか' do
        expect(current_path).to eq('/items')
      end
    end
  end

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
      context '投稿処理のテスト' do
        it '投稿後のリダイレクト先は正しいか' do
          fill_in 'item[name]', with: Faker::Lorem.characters(number:5)
          fill_in 'item[introduction]', with: Faker::Lorem.characters(number:20)
          click_button '投稿する'
          expect(page).to have_current_path items_path
        end
      end
    end
  end

end