class CreateSecretIdentities < ActiveRecord::Migration
  def change
    create_table :secret_identities do |t|
      t.string :name
      t.string :address
      t.string :occupation
      t.integer :hero_id

      t.timestamps
    end
  end
end
