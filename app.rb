require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require './db'
require 'time'
require './message_sender'
require 'aws-sdk'

class DirtApp < Sinatra::Base
  register Sinatra::CrossOrigin

  enable :cross_origin

  # config do
  #   set :cloudinary_api, {api_key: ENV['API_KEY'],
  #                       api_secret: ENV['API_SECRET'],
  #                       cloud_name: ENV['CLOUD_NAME']}
  # end

  # get '/add' do
  #   #user = user.create name: params[:name]
  #   image_meta = params[:image]
  #   filename = image_meta.delete :filename 
  #   url = Cloudinary::Uploader.upload filename, settings.cloudinary_api.merge(image_meta)
  #   return url 
  # end

  
        

  get '/' do
    cross_origin
    return "DIRT api"
  end

  def get_attributes(incident)
    attributes = incident.attributes
    attributes[:user] = incident.user.attributes
    return attributes
  end

  post '/incidents/new' do
    cross_origin
    if params.include? 'file'
      s3_link = upload_photo(params[:file])
      incident = Incident.create(
        :description => params[:description],
        :location => params[:location],                        
        :severity => params[:severity],
        :incident_time => params[:incident_time],
        :photo_link => s3_link,
        :status => 0,
        :user_id => 1
      )
    else
      incident = Incident.create(
        :description => params[:description],
        :location => params[:location],                        
        :severity => params[:severity],
        :incident_time => params[:incident_time],
        :status => 0,
        :user_id => 1
        )
    end
    puts params
    puts incident
    if incident.saved?
      as_json = json get_attributes incident
     # publish as_json
      return as_json
    else
      return json "Failed to create incident"
    end
  end

  get '/incidents/:id' do |id|
    cross_origin
    return json get_attributes Incident.get(id)
  end

  post '/incidents/:id' do |id|
    cross_origin
    #Check photo, if no photo_link already, add
  incident = Incident.get(id)
   if params.include? 'file' and incident.photo_link.nil?
      s3_link = upload_photo(params[:file])
      if not incident.update :photo_link => s3_link
        return json "Failed to update photo_link"
      end
    end

    fields = [:description, :location, :severity, :status]
    
    fields.each do |field|
      if params[field] and not incident.update field => params[field]
        return json "Failed to update #{field}"
      end
    end
    as_json = json get_attributes incident
    #publish as_json
    return as_json
  end
#http://docs.aws.amazon.com/sdk-for-ruby/latest/DeveloperGuide/aws-ruby-sdk-recipes.html#aws-ruby-sdk-s3-recipes
def upload_photo(photo)
  Aws.config.update({
  :access_key_id => ENV['DIRT_AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['DIRT_AWS_SECRET_ACCESS_KEY']
  })

  s3 = Aws::S3::Resource.new(region: 'us-west-2')
  file = photo[:tempfile]
  bucket = 'dirt.frontfish.net'
  
  # Get just the file name
  name = Time.now.utc.iso8601

  # Create the object to upload
  obj = s3.bucket(bucket).object(name)

  # Upload it      
  if obj.upload_file(file)
    return 'https://'+ 'dirt.frontfish.net' + '.s3.amazonaws.com/'+ name
    #return "Uploaded #{file} to bucket #{bucket}"
  else
    return "Could not upload #{file} to bucket #{bucket}!"
  end
end


  get '/incidents' do
    cross_origin
    params[:fields] = [
              :id,
              :severity,
              :description,
              #            :departments,
              :created_at,
              :status,
              :updated_at,
              :incident_time,
             ]
    incidents = Incident.all(params).map do |incident|
      attributes = incident.attributes
      attributes[:user] = incident.user.attributes
      attributes
    end
    return json incidents
  end


  get '/users/:id' do |id|
    cross_origin
    return json User.get(id)
  end

  post '/users/new' do
    cross_origin
    user = User.create(:first_name => params[:first_name], 
                       :last_name => params[:last_name])

    if user.saved?
      return json user
    else
      return "Failed to create user"
    end
  end

  post '/postreceive' do
    `git pull origin master`
    `bundle install`
    `sleep 5`
    `./stop_unicorn`
    `./start_unicorn`
  end
end
