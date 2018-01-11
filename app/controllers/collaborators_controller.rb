class CollaboratorsController < ApplicationController

   def new
      @wiki = Wiki.find_by(id: params[:wiki_id])
      @input = ''
   end

   def create
      @wiki = Wiki.find_by(id: params[:wiki_id])
      @added = []
      @errors = []
      @input = params[:emails]
         @input.split(',').map(&:strip).each do |email|
            errors = validate_email(@wiki, email)

            if errors.length == 0
               user = User.find_by(email: email)
               collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: user.id, owner: false)
               collaborator.save
               @added << email
            else
               @errors << errors
            end
         end

      unless @errors == []
         flash[:alert] = @errors.join.to_s
         redirect_to new_wiki_collaborator_path
      else
         flash[:notice] = "#{@added.join(',')} added as collaborator(s)."
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
         e = []
         user = User.find_by(email: email)
         existing_collaborator = Collaborator.where('wiki_id = ? AND user_id = ?', wiki.id, user.id)
         if !User.find_by(email: email)
            e << "#{email} does not exist as a User. "
         elsif existing_collaborator.present?
            e << "#{email} is already a collaborator on this wiki. "
            byebug
         elsif !email.include?('@')
            e << "#{email} is not a valid email. "
         end
         e
      end

end
