require 'pg'
class RemoveController < ApplicationController
  def remove
    @title = params[:title]
    @urltitle = URI.encode_www_form_component(params[:title])
    
  end

  def remove_book
    title = URI.decode_www_form_component(params[:title])

    url = ENV['DATABASE_URL']

    uri = URI.parse(url)
    begin
        conn = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
        puts "DELETE FROM Books WHERE title = '#{title}';"
        conn.exec ("DELETE FROM Books WHERE title = '#{title}';")
        flash[:notice] = "Removed book: #{title}"
        redirect_to '/'
    rescue
        flash[:notice] = "Error in deleting book, please try again"
        redirect_to "/remove/#{title}"
    ensure
        conn.close if conn
    end
  end
end