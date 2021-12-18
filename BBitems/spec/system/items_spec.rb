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

end