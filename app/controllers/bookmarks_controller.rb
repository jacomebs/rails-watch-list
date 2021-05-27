class BookmarksController < ApplicationController
  # GET /lists/:list_id/bookmarks/new(.:format)  bookmarks#new
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  # POST /lists/:list_id/bookmarks(.:format)  bookmarks#create
  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list

    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  # DELETE /bookmarks/:id(.:format)  bookmarks#destroy
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
