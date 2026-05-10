class AddRegisteredAtToRegistrations < ActiveRecord::Migration[8.1]
  def change
    add_column :registrations, :registered_at, :datetime
  end
end
