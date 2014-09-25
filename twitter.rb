# -*- coding: utf-8 -*-
require 'twitter'
require 'sinatra'

require './configure'

set :port, 2222

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
	
	ultimos_t=client.friends(@name,{})
	
	ultimos_t=ultimos_t.map { |i| [i.name , i.followers_count]}

	@todo_tweet=ultimos_t.sort_by{|a,b| b }.reverse!.take(@number)
	
		

  end

  erb :twitter
end

