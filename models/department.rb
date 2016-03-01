class Department
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String

  has n, :incidents, :through => Resource
end
