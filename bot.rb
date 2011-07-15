#!/usr/bin/env ruby

require 'rumpy'

class MyBot
  include Rumpy::Bot

  def initialize
    @config_path = 'config'
    @models_path = File.dirname(__FILE__) + '/models/*.rb'
    @main_model  = :user
  end

  def parser_func(m)
    { :respond => ( m == "u r so cute" ) }
  end

  def backend_func
    sleep 5
    result = Array.new
    User.find_each do |user|
      result << [ user.jid, "#{user.jid} r u here?" ]
    end
    result
  end

  def do_func(model, params)
    "and u r 2 :3" if params[:respond]
  end
end

case ARGV[0]
when '--start'
  Rumpy.start MyBot
when '--stop'
  Rumpy.stop MyBot
end
