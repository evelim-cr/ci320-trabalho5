class Hero < ActiveRecord::Base
	has_and_belongs_to_many :comics
	has_one :secretIdentity, dependent: :destroy
	has_many :enemies, dependent: :destroy
	validates :name, :skills, :city, presence: true	
end
