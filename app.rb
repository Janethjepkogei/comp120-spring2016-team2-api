require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require './db'
require 'time'
require './message_sender'

class DirtApp < Sinatra::Base
  register Sinatra::CrossOrigin

  enable :cross_origin

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
    incident = Incident.create(:description => params[:description],
                               :location => params[:location],
                               :severity => params[:severity],
                               :created_at => params[:created_at],
                               :updated_at => Time.now.utc.iso8601,
                               :status => 0,
                               :user_id => 1)
    puts params
    puts incident.inspect
    if incident.saved?
      as_json = json get_attributes incident
      publish as_json
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
      incident.update(:last_modified => Time.now.utc.iso8601)
    end
    as_json = json get_attributes incident
    publish as_json
    return as_json
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

  get '/incidents/timestamp' do |timestamp|
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
    time = Time.parse(some_string)
    incidents = Incident.all(params(:order => [ :updated_at.desc ], :updated_at.gt => time)).map do |incident|
      attributes = incident.attributes
      attributes[:user] = incident.user.attributes
      attributes
    end
    return json incidents
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
