class SecretIdentity < ActiveRecord::Base
	belongs_to :hero
	belongs_to :comic
	validates :name, :address, :ocupation, presence: true
end
