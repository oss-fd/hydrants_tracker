class CreateHydrantChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :hydrant_checks do |t|
      t.uuid :guid, default: -> { "uuid_generate_v4()" }
      t.references :hydrant, null: false
      t.references :pump_operator, null: false
      t.references :apparatus, null: false
      t.boolean :needs_follow_up, default: false, null: false
      t.boolean :vegetation_overgrown, default: false, null: false
      t.boolean :tank_locked, default: true, null: false
      t.boolean :lock_operable, default: true, null: false
      t.boolean :prime_pulled, default: true, null: false
      t.boolean :circulated, default: true, null: false
      t.integer :line_used
      t.integer :minutes_pumped
      t.boolean :in_service, default: true, null: false
      t.text :notes
      t.timestamps
    end

    add_index :hydrant_checks, :guid, unique: true
  end
end
