require 'pg'
require 'uri'

class EditController < ApplicationController
  @@book = nil
  def editbook
    @title = params[:title]
    @urltitle = URI.encode_www_form_component("#{@title}")
    begin
      conn = PG::Connection.open(:dbname => 'book_collection_development')
      @book = conn.exec "SELECT * FROM Books WHERE title = '#{@title}';"  
      @@book = @book
    rescue
      flash[:notice] = "Error in retreiving book, please try again"
      redirect_to "/edit/#{@title}"
    ensure
      conn.close if conn
    end
  end

  def edit
    title = params[:newtitle]
    author = params[:author]
    genre = params[:genre]
    price = params[:price]
    pub_date = params[:published_date]
    conn = PG::Connection.open(:dbname => 'book_collection_development')

    # security to ensure user cannot update a table with an empty item
    if title == "" || author == "" || genre == "" || price == nil || pub_date == "" 
        flash[:notice] = "Error, cannot have empty paramaters"
    end
    

    begin
        conn = PG::Connection.open(:dbname => 'book_collection_development')
    rescue
        flash[:notice] = "Error connecting to database"

    end

    #update title
    begin
        if title != @@book[0]['title']
            conn.exec "UPDATE Books SET title = '#{title}' WHERE title = '#{@@book[0]['title']}';"
        end
    rescue
        flash[:notice] = "Error updating title"

    end

    #update author
    begin
        if author != @@book[0]['author']
            conn.exec "UPDATE Books SET author = '#{author}' WHERE title = '#{@@book[0]['title']}';"
        end
    rescue
        flash[:notice] = "Error updating author"

    end

    #update genre
    begin
        if genre != @@book[0]['genre']
            conn.exec "UPDATE Books SET genre = '#{genre}' WHERE title = '#{@@book[0]['title']}';"
        end
    rescue
        flash[:notice] = "Error updating genre"

    end

    #update price
    begin
        if price != @@book[0]['price']
            conn.exec "UPDATE Books SET price = '#{price}' WHERE title = '#{@@book[0]['title']}';"
        end
    rescue
        flash[:notice] = "Error updating price"

    end

    #update published_date
    begin
        if price != @@book[0]['published_date']
            conn.exec "UPDATE Books SET published_date = '#{pub_date}' WHERE title = '#{@@book[0]['title']}';"
        end
    rescue
        flash[:notice] = "Error updating published_date"
    end
    
    if flash[:notice] 
        redirect_to "/edit/#{@@book[0]['title']}"
    else 
        redirect_to '/'
    end
    
  end
end
