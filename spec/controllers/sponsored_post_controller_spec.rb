require 'rails_helper'

RSpec.describe SponsoredPostController, type: :controller do
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsored_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(999999999)) }

  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to have_http_status(:success)
    end
    it 'renders the #show view' do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to render_template :show
    end
    it 'assigns my_sponsored_post to @sponsored_post' do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
    it 'renders the #new view' do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end
    it 'instantiates @sponsored_post' do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe 'POST create' do
    it 'increases the number of Post by 1' do
       expect{post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(999999999)}}.to change(Post,:count).by(1)
    end
    it 'assigns the new post to @post' do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(999999999)}
      expect(assigns(:sponsored_post)).to eq SponsoredPost.last
    end
    it 'redirects to the new post' do
       post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(999999999)}
       expect(response).to redirect_to [my_topic, SponsoredPost.last]    
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
