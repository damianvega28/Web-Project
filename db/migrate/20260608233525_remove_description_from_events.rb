class RemoveDescriptionFromEvents < ActiveRecord::Migration[8.1]
  def change
    remove_column :events, :description, :text
  end
end
