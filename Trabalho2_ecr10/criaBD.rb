require 'rubygems'
require 'active_record'

require 'sqlite3' # Sqlite3
# -*- coding: utf-8 -*-
# SQlite3 (aquivo Aulas.sqlite3)
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Herois.sqlite3" 

ActiveRecord::Base.connection.create_table :heros do |t|  
  t.string   :name
  t.string   :skills
  t.string   :city  
end

ActiveRecord::Base.connection.create_table :secret_identities do |t|  
  t.string   :name 
  t.string   :address 
  t.string   :occupation
  t.integer  :hero_id

end

ActiveRecord::Base.connection.create_table :comics do |t|  
  t.string   :name
  t.string   :publishing
  t.string   :date 
end

ActiveRecord::Base.connection.create_table :enemies do |t|  
  t.string   :name
  t.integer  :hero_id
end

ActiveRecord::Base.connection.create_table :comics_heros do |t|  
  t.integer :hero_id
  t.integer :comic_id
end

