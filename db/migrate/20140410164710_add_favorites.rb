class AddFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.column :user_id, :integer
      t.column :photo_id, :integer

      t.timestamps
    end
  end
end
