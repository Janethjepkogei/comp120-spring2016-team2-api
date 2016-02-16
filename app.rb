require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require './db'

configure do
  enable :cross_origin
end

get '/' do
  return "DIRT api"
end

post '/incidents/new' do
  incident = Incident.create(:description => params[:description],
                             :location => params[:location],
                             :severity => params[:severity],
                             :status => 0,
                             :user_id => 1)

  if incident.saved?
    return json incident
  else
    return "Failed to create incident"
  end
end

get '/incidents' do
  fields = [
            :id,
#            :user,
            :severity,
            :description,
#            :departments,
            :created_at,
            :status,
           ]
  return json Incident.all(:fields => fields)
end
