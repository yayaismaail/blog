require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) do
    Post.create(title: 'My first post', text: 'Hello world', author_id: user.id, comments_counter: 0, likes_counter: 0)
  end

  describe 'GET #index' do
    before do
      get "/users/#{user.id}/posts"
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'displays the correct placeholder text' do
      expect(response.body).to include('Here is a list of all posts of a particular user')
    end
  end

  describe 'GET #show' do
    before do
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'displays the correct placeholder text' do
      expect(response.body).to include('Post Title')
    end
  end
end
