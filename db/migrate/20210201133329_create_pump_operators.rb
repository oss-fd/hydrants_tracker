class CreatePumpOperators < ActiveRecord::Migration[6.1]
  def change
    create_table :pump_operators do |t|
      t.uuid :guid, default: -> { "uuid_generate_v4()" }
      t.string :name
      t.string :email_address
      t.string :phone_number
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :pump_operators, :guid, unique: true
  end
end
