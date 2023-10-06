class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.text :details
      t.text :location
      t.integer :num_of_guests
      t.float :price_per_night
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
