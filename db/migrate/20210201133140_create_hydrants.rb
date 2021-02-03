class CreateHydrants < ActiveRecord::Migration[6.1]
  def change
    create_table :hydrants do |t|
      t.uuid :guid, default: -> { "uuid_generate_v4()" }
      t.string :name
      t.st_point :coordinates, geographic: true
      t.integer :hydrant_type, null: false, default: 0
      t.text :staff_notes
      t.datetime :last_tested_at
      t.boolean :in_service, default: true, null: false
      t.datetime :needs_follow_up
      t.text :last_check_note
      t.string :tank_capacity
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :hydrants, :guid, unique: true
    add_index :hydrants, :deleted_at
  end
end
