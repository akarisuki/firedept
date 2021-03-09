class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :title ,null: false
      t.string :text ,null: false
      t.string :image
      t.string :video

      t.timestamps
    end
  end
end
