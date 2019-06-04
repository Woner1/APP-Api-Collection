class CreatePhoneVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_verifications do |t|
      t.string :phone_number
      t.string :code
      t.datetime :sent_at

      t.timestamps
    end
  end
end
