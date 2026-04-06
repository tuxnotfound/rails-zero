class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      # OAuth identity — provider + uid are unique together so swapping providers is safe
      t.string :provider,     null: false
      t.string :provider_uid, null: false
      t.string :access_token

      # Profile
      t.string :username,    null: false
      t.string :name
      t.string :email
      t.string :avatar_url

      # Soft delete
      t.datetime :deleted_at

      # Username change cooldown
      t.datetime :username_changed_at

      t.timestamps
    end

    add_index :users, [ :provider, :provider_uid ], unique: true
    add_index :users, :username, unique: true
    add_index :users, :deleted_at
  end
end
