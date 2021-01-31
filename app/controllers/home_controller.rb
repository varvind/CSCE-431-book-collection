require 'pg'

class HomeController < ApplicationController
  def index 
    @books = []

    url = ENV['DATABASE_URL']

    uri = URI.parse(url)

    begin 
      conn = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      @books = conn.exec "SELECT * From Books"
    rescue => e
        puts e.message
        flash[:notice] = "Error in retreiving books, please check database connection"
    ensure
      conn.close if conn
    end
    
  end
end
