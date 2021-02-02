require 'pg'
class RemoveController < ApplicationController
  def remove
    @title = params[:title]
    @urltitle = URI.encode_www_form_component(params[:title])
    
  end

  def remove_book
    title = URI.decode_www_form_component(params[:title])
    begin
        Book.destroy_by(:title => title)
        flash[:notice] = "Removed book: #{title}"
        redirect_to '/'
    rescue
        flash[:notice] = "Error in deleting book, please try again"
        redirect_to "/remove/#{title}"
    end
  end
end