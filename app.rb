require 'sinatra'
require 'csv'

get '/' do

  erb :index
end

get '/vote' do
  @name = params['name']
  @vote = params['vote']

  CSV.open("vote.csv", "a") do |row|
    row << [@name, @vote]
  end

  erb :vote
end

get '/result' do
  # @count ={}
  @count = Hash.new(0)
  @list = Array.new
  # @list =[]
  CSV.foreach("vote.csv") do |row|
    @list << row
    @count[row[1]] = @count[row[1]].to_i + 1
  end
  erb :result
end
