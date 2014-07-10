class ComicsHero < ActiveRecord::Base
	belongs_to :comics
	belongs_to :heros
end
