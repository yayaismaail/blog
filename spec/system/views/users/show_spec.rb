require 'rails_helper'

RSpec.describe 'User#Show', type: :system do
  describe 'The User#Show page' do
    it 'displays the profile picture of ALL users' do
      User.all.each do |user|
        visit user_path(user.id)
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end

    it 'displays the username of ALL users' do
      User.all.each do |user|
        visit user_path(user.id)
        expect(page).to have_content(user.name)
      end
    end

    it 'diplay the number of posts of ALL users' do
      User.all.each do |user|
        visit user_path(user.id)
        expect(page).to have_content(user.posts_counter)
      end
    end

    it 'displays the bio of ALL users' do
      User.all.each do |user|
        visit user_path(user.id)
        expect(page).to have_content(user.bio)
      end
    end

    it 'displays the "See all posts" button of ALL users' do
      User.all.each do |user|
        visit user_path(user.id)
        expect(page).to have_content('See all posts')
      end
    end

    it 'redirects to the user posts page on ALL users' do
      User.all.each do |user|
        visit user_path(user.id)
        click_on 'See all posts'
        expect(page).to have_current_path(user_posts_path(user.id))
        visit user_path(user.id)
      end
    end

    it 'displays the first 3 posts of ALL users' do
      User.all.each do |user|
        # Assuming each user has at least 3 posts for demonstration purposes
        create_list(:post, 3, user:)

        visit user_path(user.id)

        # Check for the presence of the first 3 posts
        user.posts.take(3).each do |post|
          expect(page).to have_content(post.title)
          expect(page).to have_content(post.text)
        end
      end
    end
  end
end
