# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[8.1]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      # email already exists in this app
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
    end

    add_index :users, :email, unique: true, if_not_exists: true
    add_index :users, :reset_password_token, unique: true
  end

  def self.down
    remove_index :users, :reset_password_token, if_exists: true
    remove_index :users, :email, if_exists: true

    remove_column :users, :encrypted_password, if_exists: true
    remove_column :users, :reset_password_token, if_exists: true
    remove_column :users, :reset_password_sent_at, if_exists: true
    remove_column :users, :remember_created_at, if_exists: true
  end
end