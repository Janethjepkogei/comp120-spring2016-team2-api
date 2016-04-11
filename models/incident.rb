require 'rubygems'
require 'dm-core'
require 'dm-timestamps'

class Incident
  include DataMapper::Resource

  property :id, Serial
  property :severity, Integer, :min => 0, :max => 3, :required => true
  property :status, Integer, :min => 0, :max => 2, :default => 0
  property :description, String, :length => 255, :required => true
  property :location, String, :length => 255
  property :created_at, DateTime
  property :updated_at, DateTime
  #property :incident_time, DateTime


  belongs_to :user
  has n, :departments, :through => Resource
end
