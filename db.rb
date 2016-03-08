require 'data_mapper'
require 'dm-mysql-adapter'
require 'dm-timestamps'

username = ENV['DIRT_USERNAME']
password = ENV['DIRT_PASSWORD']
host     = ENV['DIRT_HOST']
database = ENV['DIRT_DATABASE']

DataMapper::Logger.new(STDOUT, :debug)

DataMapper.setup :default, "mysql://#{username}:#{password}@#{host}/#{database}"

Dir["./models/*.rb"].each {|file| require file }

repository(:default).adapter.execute("SET sql_mode = ''")
DataMapper.finalize.auto_upgrade!
