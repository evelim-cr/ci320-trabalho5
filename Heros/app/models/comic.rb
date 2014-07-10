class Comic < ActiveRecord::Base
	has_and_belongs_to_many :heros
	has_many :secretIdentity, :through => :heros
end
