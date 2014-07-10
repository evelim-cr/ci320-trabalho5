class CreateHeros < ActiveRecord::Migration
  def change
    create_table :heros do |t|
      t.string :name
      t.string :skills
      t.string :city

      t.timestamps
    end
  end
end
