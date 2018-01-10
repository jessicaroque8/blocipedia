class CollaboratorsController < ApplicationController

   def new
      @wiki = Wiki.find_by(id: params[:wiki_id])
      @input = ''
   end

   def create
      @wiki = Wiki.find_by(id: params[:wiki_id])
      @count = 0
      @input = params[:emails].split(',').map(&:strip).each do |email|
         user = User.find_by(email: email)
         collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: user.id, owner: false)
         collaborator.save!
         @count += 1
      end

      flash[:notice] = "#{@count} collaborators added."
      redirect_to new_wiki_collaborator_path

      rescue ActiveRecord::RecordInvalid => e
         flash[:alert] = e
         redirect_to new_wiki_collaborator_path
   end

   def destroy
      @collaborator = Collaborator.find(params[:id])

      if @collaborator.destroy
         flash[:notice] = "The user has been removed as a collaborator on this wiki."
         redirect_to new_wiki_collaborator_path
      else
         flash.now[:alert] = "There was an error in removing that user as a collaborator."
         redirect_to new_wiki_collaborator_path
      end
   end

end
