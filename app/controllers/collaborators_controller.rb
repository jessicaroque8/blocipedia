class CollaboratorsController < ApplicationController

   def new
      @wiki = Wiki.find_by(id: params[:wiki_id])
      @input = ''
   end

   def create
      @wiki = Wiki.find_by(id: params[:wiki_id])
      @count = 0
      @errors = []
      @input = params[:emails]
         @input.split(',').map(&:strip).each do |email|
            errors = validate_email(@wiki, email)

            if errors.length == 0
               user = User.find_by(email: email)
               collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: user.id, owner: false)
               collaborator.save
               @count += 1
            else
               @errors << errors
            end
         end

      unless @errors.nil?
         flash[:alert] = @errors.join.to_s
         redirect_to new_wiki_collaborator_path
      else
         flash[:notice] = "#{@count} collaborators added."
         redirect_to new_wiki_collaborator_path
      end

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

   private

      def validate_email(wiki, email)
         errors = []
         user = User.find_by(email: email)
         if !User.find_by(email: email)
            errors << "#{email} does not exist as a User. "
         elsif Collaborator.where('wiki_id AND user_id', wiki.id, user.id)
            errors << "#{email} is already a collaborator on this wiki. "
         elsif !email.include?('@')
            errors << "#{email} is not a valid email. "
         end
      end

end
