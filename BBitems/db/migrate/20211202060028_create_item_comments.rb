class CreateItemComments < ActiveRecord::Migration[5.2]
  def change
    create_table :item_comments do |t|
      t.integer :user_id
      t.integer :item_id
      t.text    :comment, null: false
      t.timestamps
    end
  end
end
