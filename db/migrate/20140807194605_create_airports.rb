class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :city
      t.string :code
      t.string :country
      t.decimal :lat, :precision => 16, :scale => 13
      t.decimal :lng, :precision => 16, :scale => 13
      t.string :name
      t.string :timezone

      t.timestamps
    end
    add_index :airports, :city
    add_index :airports, :code
    add_index :airports, :country
  end
end
