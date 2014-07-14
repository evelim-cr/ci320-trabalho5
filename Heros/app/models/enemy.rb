class Enemy < ActiveRecord::Base
	belongs_to :hero
	validates :name, presence: true
end
