require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require './db'

class DirtApp < Sinatra::Base
  register Sinatra::CrossOrigin

  enable :cross_origin

  get '/' do
    cross_origin
    return "DIRT api"
  end

  post '/incidents/new' do
    incident = Incident.create(:description => params[:description],
                               :location => params[:location],
                               :severity => params[:severity],
                               :status => 0,
                               :user_id => 1)

    puts "description: '#{params[:description]}'"
    if incident.saved?
      return json incident
    else
      return json "Failed to create incident"
    end
  end

  get '/incidents/:id' do |id|
    return Incident.get(id).to_json(relationships: { user: {} })
  end

  post '/incidents/:id' do |id|
    fields = [:description, :location, :severity, :status]
    incident = Incident.get(id)
    fields.each do |field|
      if params[field] and not incident.update field => params[field]
        return json "Failed to update #{field}"
      end
    end
    return json incident
  end

  get '/incidents' do
    fields = [
              :id,
              :severity,
              :description,
              #            :departments,
              :created_at,
              :status,
             ]
    return json Incident.all(:fields => fields)
  end

  get '/user/:id' do |id|
    return json User.get(id)
  end

  post '/user/new' do
    user = User.create(:first_name => params[:first_name], 
                       :last_name => params[:last_name])

    if user.saved?
      return json user
    else
      return "Failed to create user"
    end
  end
end
