class RemoveUserid < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tweets, :user
  end
end
