class CreateRegistrations < ActiveRecord::Migration[8.1]
  def change
    create_table :registrations do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :event, null: false, foreign_key: true
      t.string :status, default: 'confirmed', null: false

      t.timestamps
    end

    add_index :registrations, [:user_id, :event_id], unique: true
  end
end