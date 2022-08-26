require 'posts_repository' 

def reset_post_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
end

RSpec.describe PostsRepository do
    before(:each) do
        reset_post_table
    end  
    it '#all method will return all user posts' do
        repo = PostsRepository.new
        posts = repo.all

        expect(posts.length).to eq 2
        expect(posts.first.id).to eq 1
        expect(posts.first.title).to eq 'title1'
        expect(posts.first.content).to eq 'content1'
        expect(posts.first.number_of_views).to eq 100
        expect(posts.first.user_account_id).to eq 1
    end

    it '#find method will return a single post' do
        repo = PostsRepository.new
        post = repo.find(1)
        expect(post.id).to eq  1
        expect(post.title).to eq  'title1'
        expect(post.content).to eq  'content1'
        expect(post.number_of_views).to eq  100
    end
    it '#create method will create a new user post' do
        repo = PostsRepository.new
        post = Posts.new
        post.title = 'title3'
        post.content = 'content3'
        post.number_of_views = 300
        post.user_account_id = 3

        repo.create(post)
        posts = repo.all 
        last_post= posts.last 
        expect(last_post.title).to eq 'title3'
        expect(last_post.content).to eq 'content3'
        expect(last_post.number_of_views).to eq 300
        expect(last_post.user_account_id).to eq 3
    end

    it '#delete method deletes a post from the posts table' do
        repo = PostsRepository.new
        id_to_delete = 1
        repo.delete(id_to_delete)
        posts= repo.all
        expect(posts.length).to eq 2
        expect(posts.first.id).to eq 2
   end
end

