require 'pg'

class HomeController < ApplicationController
  def index 
    @books = []
    url = "postgres://arvind2529:arvind00@localhost:5432/book_collection_development"
    
    db_name = 'book_collection_development'
    if Rails.env == 'production'
        url = ENV['DATABASE_URL']
        db_name = Rails.configuration.database_configuration["production"]["database"]
    end

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
