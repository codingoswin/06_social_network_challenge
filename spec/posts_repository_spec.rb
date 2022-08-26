require 'posts_repository' 

def reset_post_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
end

RSpec.describe UserAccountRepository do
    before(:each) do
        reset_post_table
    end 
    it '#all method will return all user posts' do
        repo = PostRepository.new
        posts = repo.all

        expect(posts.length).to eq 2
        expect(posts.first.id).to eq 1
        expect(posts.first.title).to eq 'title1'
        expect(posts.first.contents).to eq 'contents1'
        expect(posts.first.number_of_views).to eq 100
        expect(posts.first.user_account_id).to eq 1
    end
end

