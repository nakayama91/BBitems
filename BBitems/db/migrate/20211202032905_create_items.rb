class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.integer :genre_id,     null: false
      t.string  :name,         null: false
      t.text    :introduction, null: false
      t.string  :image_id
      t.string  :maker
      t.integer :user_id,      null: false
      t.float   :evaluation
      t.string  :price
      t.timestamps
    end
  end
end
