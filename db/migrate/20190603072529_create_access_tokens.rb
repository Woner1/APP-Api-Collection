class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens do |t|
      t.belongs_to :user,index: true
      t.string :token
      t.string :refresh_token
      t.integer :expires_in
      t.datetime :revoked_at

      t.timestamps
    end
    add_index :access_tokens,:token,:unique => true
    add_index :access_tokens,:refresh_token,:unique => true
  end
end
