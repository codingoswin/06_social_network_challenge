require_relative './user_account'

class UserAccountRepository
    def all
      sql = 'SELECT id, username, email_address FROM user_accounts;'
      result_set = DatabaseConnection.exec_params(sql, [])

      all_users = []
      result_set.each do |record|
        user = UserAccount.new
        user.id = record['id'].to_i
        user.username = record['username']
        user.email_address = record['email_address']

        all_users << user
      end
      return all_users
    end
end