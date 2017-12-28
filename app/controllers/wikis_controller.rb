class WikisController < ApplicationController
  def index
     @wikis = policy_scope(Wiki)
  end

  def new
     @wiki = Wiki.new
     authorize @wiki
  end

  def show
     @wiki = Wiki.find(params[:id])
     authorize @wiki
  end

  def edit
     @wiki = Wiki.find(params[:id])
     authorize @wiki
  end

  def create
     @wiki = Wiki.new
     authorize @wiki
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]
     @wiki.user = current_user

     if @wiki.save
        flash[:notice] = "Wiki created."
        redirect_to @wiki
     else
        flash.now[:alert] = "There was an error when trying to create your wiki. Please try again."
        render :new
     end
  end


  def update
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     @wiki.assign_attributes(params.require(:wiki).permit(:title, :body, :private))

     if @wiki.save
        flash[:notice] = "Wiki updated."
        redirect_to [@wiki]
     else
        flash.now[:alert] = "There was an error when trying to save the wiki. Please try again."
        render :edit
     end
  end

  def destroy
     @wiki = Wiki.find(params[:id])
     authorize @wiki

     if @wiki.destroy
        flash[:notice] = "Wiki deleted."
        redirect_to [@wiki]
     else
        flash.now[:alert] = "There was an error when trying to delete the wiki. Please try again."
        render :show
     end
  end

end
