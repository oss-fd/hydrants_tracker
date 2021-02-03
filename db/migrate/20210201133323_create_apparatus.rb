class CreateApparatus < ActiveRecord::Migration[6.1]
  def change
    create_table :apparatus do |t|
      t.uuid :guid, default: -> { "uuid_generate_v4()" }
      t.string :name
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :apparatus, :guid, unique: true
    add_index :apparatus, :deleted_at
  end
end
