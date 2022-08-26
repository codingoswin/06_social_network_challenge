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

   it '#find method returns a single user account' do
    repo = UserAccountRepository.new
    user = repo.find(1)
    expect(user.id).to eq  1
    expect(user.username).to eq  'username1'
   expect(user.email_address).to eq  'username1@gmail.com'
   end

   it '#create method returns newly created user record' do
    repo = UserAccountRepository.new
    user = UserAccount.new
    user.username = 'username3'
    user.email_address = 'username3@gmail.com'
    repo.create(user)
    users = repo.all 
    last_user = users.last 
    expect(last_user.username).to eq 'username3'
    expect(last_user.email_address).to eq 'username3@gmail.com'
   end

   it '#delete method deletes a record from the user account table' do
        repo = UserAccountRepository.new
        id_to_delete = 1
        repo.delete(id_to_delete)
        users = repo.all
        expect(users.length).to eq 1
        expect(users.first.id).to eq 2
   end
end