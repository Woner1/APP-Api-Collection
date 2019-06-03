class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :phone_number
      t.string :password_digest
      t.string :openid
      t.string :nickname
      t.integer :sex
      t.string :province
      t.string :country
      t.string :headimgurl
      t.string :unionid

      t.timestamps
    end
  end
end
