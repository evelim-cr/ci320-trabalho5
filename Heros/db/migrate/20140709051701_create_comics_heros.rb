class CreateComicsHeros < ActiveRecord::Migration
  def change
    create_table :comics_heros do |t|
      t.integer :hero_id
      t.integer :comic_id

      t.timestamps
    end
  end
end
