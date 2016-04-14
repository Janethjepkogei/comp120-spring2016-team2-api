require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require './db'
require 'time'
require './message_sender'
#require 'cloudinary'
#require '/config'
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

    return "DIRT api"
  end

  def get_attributes(incident)
    attributes = incident.attributes
    attributes[:user] = incident.user.attributes
    return attributes
  end

  post '/incidents/new' do
    incident = Incident.create(
      :description => params[:description],
      :location => params[:location],                        
      :severity => params[:severity],
      :incident_time => params[:incident_time],
      :status => 0,
      :user_id => 1
      )
    puts params
    puts incident.inspect
    if incident.saved?
      as_json = json get_attributes incident
     # publish as_json
      return as_json
    else
      return json "Failed to create incident"
    end
  end

  get '/incidents/:id' do |id|
    return json get_attributes Incident.get(id)
  end

  post '/incidents/:id' do |id|
    fields = [:description, :location, :severity, :status]
    incident = Incident.get(id)
    fields.each do |field|
      if params[field] and not incident.update field => params[field]
        return json "Failed to update #{field}"
      end
    end
    as_json = json get_attributes incident
    #publish as_json
    return as_json
  end

  #http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Presigner.html
  #http://docs.aws.amazon.com/sdkforruby/api/
  #https://aws.amazon.com/sdk-for-ruby/
  #https://github.com/flyingsparx/NodeDirectUploader/blob/master/app.js 

  get '/sign_s3' do
    Aws.config.update({
      region: 'oregon',
      credentials: Aws::Credentials.new('AKIAJDUJMG7364YCNVXQ', 'zwYLmPAvnDE+VMJqBZVt7VC4hMTY5kAAyimeKDF4')})
    signer = Aws::S3::Presigner.new
    return_data = {
        :signed_url => signer.presigned_url(:put_object, bucket: "dirt.frontfish.net", key: "uploads/#{SecureRandom.uuid}/${params[:file_name]}",acl: 'public-read', expires_in: 60 ),
        :url =>'https://'+ 'dirt.frontfish.net' + '.s3.amazonaws.com/'#{params[:file_name]}
      }
    return json return_data
  end

  get '/incidents' do
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

  get '/sign_s3' do
    Aws.config.update({
      region: 'oregon',
      credentials: Aws::Credentials.new('AKIAJDUJMG7364YCNVXQ', 'zwYLmPAvnDE+VMJqBZVt7VC4hMTY5kAAyimeKDF4')})

    signer = Aws::S3::Presigner.new
    return_data = {
        :signed_url => signer.presigned_url(:put_object, bucket: "dirt.frontfish.net", key: "uploads/#{SecureRandom.uuid}/${params[:file_name]}",acl: 'public-read', expires_in: 60 ),
        :url =>'https://'+ 'dirt.frontfish.net' + '.s3.amazonaws.com/'#{params[:file_name]}
      }
    return json return_data
  end

  get '/users/:id' do |id|
    return json User.get(id)
  end

  post '/users/new' do
    user = User.create(:first_name => params[:first_name], 
                       :last_name => params[:last_name])

    if user.saved?
      return json user
    else
      return "Failed to create user"
    end
  end
end
