# -*- coding: utf-8 -*-
require 'twitter'
require 'sinatra'

require './configure'

set :port, 9449

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
	
  #  ultimos_t = client.user_timeline(@name,{:count=>@number.to_i})
   # @todo_tweet =(@todo_tweet != '') ? ultimos_t.map{ |i| i.text} : ''	

	#ultimos_t =  client.friend_ids(@name).attrs[:ids].take(@number)
	#amigos={}
   	
	#ultimos_t.map { amigos[client.user.name] = client.user.followers_count }
	#(f)
 	#@todo_tweet=amigos.sort_by { |x, y| -y }
	ultimos_t=client.friends(@name,{})
	
	ultimos_t=ultimos_t.map { |i| [i.name , i.followers_count]}

	@todo_tweet=ultimos_t.sort_by{[:followers_count]}.reverse!.take(@number)
	
		

  end

  erb :twitter
end

