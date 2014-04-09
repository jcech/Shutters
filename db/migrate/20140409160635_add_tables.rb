class AddTables < ActiveRecord::Migration
  def change
    create_table :users do |f|
      f.column :username, :string
      f.column :password, :string
      f.column :password_digest, :string
    end

    create_table :sessions do |f|
      f.column :user_id, :integer
    end

    create_table :photos do |f|
      f.column :user_id, :integer
    end

    create_table :tags do |f|
      f.column :user_id, :integer
      f.column :photo_id, :integer
    end
  end
end
