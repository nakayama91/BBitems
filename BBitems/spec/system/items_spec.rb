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
      it '編集リンクが存在しているか' do
        if item.user_id == @user.id
          expect(page).to have_link '編集する'
        end
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        if item.user_id == @user.id
          edit_link.click
          expect(current_path).to eq('/items/' + item.id.to_s + '/edit')
        end
      end
    end
    context 'item削除のテスト' do
      it 'itemの削除' do
        expect{ item.destroy }.to change{ Item.count }.by(-1)
      end
    end
  end

  # 5.編集画面テスト
  describe '編集画面のテスト' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
      visit edit_item_path(item)
    end
    context '表示の確認' do
      it '編集前の名前と説明文がフォームに表示されている' do
        if item.user_id == @user.id
          expect(page).to have_field 'item[name]', with: item.name
          expect(page).to have_field 'item[introduction]', with: item.introduction
        end
      end
      it '変更するボタンが表示される' do
        if item.user_id == @user.id
          expect(page).to have_button '変更する'
        end
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        if item.user_id == @user.id
          fill_in 'item[name]', with: Faker::Lorem.characters(number:5)
          fll_in 'item[introduction]', with: Faker::Lorem.characters(number:20)
          click_button '変更する'
          expect(page).to have_current_path item_path(item)
        end
      end
    end
  end

end