class User
  include DataMapper::Resource
  
  property :id, Serial
  property :first_name, String, :length => 60, :required => true
  property :last_name, String, :length => 60, :required => true
  property :email_address, String, :length => 255
  property :phone_number, String, :length => 15
  property :role, String, :length => 60

  has n, :incidents
end
