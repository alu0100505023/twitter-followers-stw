# -*- coding: utf-8 -*-
require 'twitter'
require 'sinatra'

require './configure'

set :port, 4444

get '/' do
  @todo_tweet = []
  @name = ''
  @number = 0		
  erb :twitter
end

post '/' do
  @todo_tweet = []
  client = my_twitter_client() 
  @name = params[:firstname] || ''
  @number = params[:n].to_i
  @number = 1 if @number <= 0

  if client.user? @name 
	
	seguidores=client.friends(@name,{})
	
	seguidores=seguidores.map { |i| [i.name , i.followers_count]}

	@todo_tweet=seguidores.sort_by{|a,b| b }.reverse!.take(@number)
	
  end

  erb :twitter
end

