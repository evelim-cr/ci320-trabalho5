class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.string :publishing
      t.string :date

      t.timestamps
    end
  end
end
