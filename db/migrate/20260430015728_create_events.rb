class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :capacity, null: false
      t.string :status, default: 'draft'

      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :venue, null: false, foreign_key: true

      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end