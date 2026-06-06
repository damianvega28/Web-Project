class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :event, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end