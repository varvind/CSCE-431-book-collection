require 'pg'

class HomeController < ApplicationController
  def index 
    @books = []
    puts ENV['DATABASE_URL']
    db_name = 'book_collection_development'
    conn = conn = PG::Connection.open(:dbname => db_name)
    if Rails.env == 'production'
        conn = PG.connect(ENV['DATABASE_URL'])
    end

    begin 
      
      @books = conn.exec "SELECT * From Books"
    rescue => e
        puts e.message
        flash[:notice] = "Error in retreiving books, please check database connection"
    ensure
      conn.close if conn
    end
    
  end
end
