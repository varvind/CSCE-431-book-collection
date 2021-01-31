require 'pg'

class HomeController < ApplicationController
  def index 
    begin 
      conn = PG::Connection.open(:dbname => 'book_collection_development')
      @books = conn.exec "SELECT * From Books"
    rescue
      flash[:notice] = "Error in retreiving books, please check database connection"
    ensure
      conn.close if conn
    end
    
  end
end
