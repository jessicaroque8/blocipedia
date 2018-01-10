class WikisController < ApplicationController

  def index
     @wikis = policy_scope(Wiki)
  end

  def new
     @wiki = Wiki.new
     authorize @wiki
     @display_private = current_user.admin? || current_user.premium? ? true : false
  end

  def show
     @wiki = Wiki.find(params[:id])
     authorize @wiki
  end

  def edit
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     @display_private = (current_user.admin? || (current_user.premium? && @wiki.owner == current_user)) ? true : false
  end

  def create
     @wiki = Wiki.new(wiki_params)
     authorize @wiki

     if @wiki.save
        owner = Collaborator.new(wiki_id: @wiki.id, user_id: current_user.id, owner: true)
        owner.save

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
     @wiki.assign_attributes(wiki_params)

     if @wiki.save && @wiki.private
        flash[:notice] = "Wiki updated. Now that it's private, you can add collaborators."
        redirect_to [@wiki]
     elsif @wiki.save
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

  private
   def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
   end

end
