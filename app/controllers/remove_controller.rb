require 'pg'
class RemoveController < ApplicationController
  def remove
    @title = params[:title]
    @urltitle = URI.encode_www_form_component(params[:title])
    
  end

  def remove_book
    title = URI.decode_www_form_component(params[:title])
    
    begin
      conn = PG::Connection.open(:dbname => 'book_collection_development')
      puts "DELETE FROM Books WHERE title = '#{title}';"
      conn.exec ("DELETE FROM Books WHERE title = '#{title}';")
      redirect_to '/'
    rescue
      flash[:notice] = "Error in deleting book, please try again"
      redirect_to "/remove/#{title}"
    ensure
      conn.close if conn
    end
  end
end