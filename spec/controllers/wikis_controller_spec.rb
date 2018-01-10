require 'rails_helper'
include RandomData

RSpec.describe WikisController, type: :controller do

   let(:my_user) { create(:user) }
   let(:my_wiki) { create(:wiki) }
   let(:my_collaborator) { Collaborator.new(wiki_id: my_wiki.id, user_id: my_user.id, owner: true) }

   before { allow(controller).to receive(:current_user) { my_user } }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns Wiki.all to wikis" do
      get :index
       expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, params: {id: my_wiki.id}
       expect(response).to render_template :show
    end

    it "assigns wiki to my_wiki" do
      get :show, params: {id: my_wiki.id}
       expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, params: {id: my_wiki.id}
      expect(response).to render_template :edit
    end
  end

  describe "POST create" do
    it "increases the number of Wiki by 1" do
       expect{ post :create, params: { wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Wiki,:count).by(1)
    end

    it "assigns the new wiki to @wiki" do
        post :create, params: { wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(assigns(:wiki)).to eq(Wiki.last)
    end

    it "increases the Collaborator count by 1" do
      expect {post :create, params: { wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph }} }.to change(Collaborator,:count).by(1)
   end

    it "redirects to the new wiki" do
       post :create, params: { wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph } }
       expect(response).to redirect_to (Wiki.last)
    end
  end

  describe "PUT update" do
    it "updates the wiki with the expected attributes" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph

       put :update, params: { id: my_wiki.id, wiki: {title: new_title, body: new_body } }

       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq my_wiki.id
       expect(updated_wiki.title).to eq new_title
       expect(updated_wiki.body).to eq new_body
    end

    it "redirects to the updated wiki in show view" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph


       put :update, params: { id: my_wiki.id, wiki: {title: new_title, body: new_body } }
       expect(response).to redirect_to my_wiki
    end
  end

  describe "DELETE destroy" do
     # These are failing but delete works on local browser. Need to rewrite tests to incorporate owner.
     it "deletes the wiki" do
        wiki = Wiki.new( title: 'my title', body: 'my body' )
        delete :destroy, params: { title: 'my title', body: 'my body' }
        count = Wiki.where({id: my_wiki.id }).size
        expect(count).to eq 0
     end

     it "redirects to the wiki index" do
        post :create, params: { title: 'my title', body: 'my body' }
        delete :destroy, params: { title: 'my title', body: 'my body' }
        expect(response).to redirect_to wikis_path
     end
  end

end
