require 'data_mapper'
require 'dm-mysql-adapter'
require 'dm-timestamps'

username = ENV['DIRT_USERNAME']
password = ENV['DIRT_PASSWORD']
host     = ENV['DIRT_HOST']
database = ENV['DIRT_DATABASE']

DataMapper.setup :default, "mysql://#{username}:#{password}@#{host}/#{database}"

class Incident
  include DataMapper::Resource

  property :id, Serial
  property :severity, Integer, :min => 0, :max => 3, :required => true
  property :status, Integer, :min => 0, :max => 2, :default => 0
  property :description, String, :length => 255, :required => true
  property :location, String, :length => 255
  property :created_at, DateTime

  belongs_to :user
  has n, :departments, :through => Resource
end

class User
  include DataMapper::Resource
  
  property :id, Serial
#  property :first_name, String, :length => 60, :required => true
#  property :last_name, String, :length => 60, :required => true
#  property :email_address, String, :length => 255, :required => true
#  property :phone_number, String, :length => 15, :required => true
#  property :role, String, :length => 60

  has n, :incidents
end

class IncidentType
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
end

class Department
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String

  has n, :incidents, :through => Resource
end

repository(:default).adapter.execute("SET sql_mode = ''")
DataMapper.finalize.auto_upgrade!
