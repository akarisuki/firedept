class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :username, :string
    add_column :users, :firedept, :string
    add_column :users, :firedept_school, :string
    add_column :users, :avatar, :string
      
    
  end
end
