class RemoveOccupationColumnFromSecretIdentity < ActiveRecord::Migration
  def up
    add_column :secret_identities, :ocupation, :string, default: true
  end

  def down
    remove_column :secret_identities, :occupation
  end
end
