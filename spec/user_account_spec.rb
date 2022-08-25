require 'user_account_repository'

def reset_useraccount_table
    seed_sql = File.read('spec/seeds_user_accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
end

RSpec.describe UserAccountRepository do
    before(:each) do
        reset_useraccount_table
    end 
   it '#all method returns list of user accounts' do
    repo = UserAccountRepository.new
    accounts = repo.all

    expect(accounts.length).to eq 2
    expect(accounts[0].id).to eq 1
    expect(accounts[0].username).to eq 'username1'
    expect(accounts[0].email_address).to eq 'username1@gmail.com'

    expect(accounts[1].id).to eq  2
    expect(accounts[1].username).to eq 'username2'
    expect(accounts[1].email_address).to eq 'username2@gmail.com'
   end
end