require 'pg'

class HomeController < ApplicationController
  def index 
    @books = []
    db_name = 'book_collection_development'
    if Rails.env == 'production'
        db_name = Rails.configuration.database_configuration["production"]["database"]
    end

    begin 
      conn = PG::Connection.open(:dbname => db_name, :user => "arvind2529")
      @books = conn.exec "SELECT * From Books"
    rescue
      flash[:notice] = "Error in retreiving books, please check database connection"
    ensure
      conn.close if conn
    end
    
  end
end
