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
    def find(id)
      sql =  'SELECT id, username, email_address FROM user_accounts WHERE id = $1;'
      sql_params = [id]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      record = result_set[0]
      user = UserAccount.new
      user.id = record['id'].to_i
      user.username = record['username']
      user.email_address= record['email_address']

      return user
    end
    
    def create(user)
      sql = 'INSERT INTO user_accounts (username, email_address) VALUES($1,$2);'
      sql_params = [user.username, user.email_address]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      return nil
    end

    def delete(id)
      sql = 'DELETE FROM user_accounts WHERE id = $1;'
      sql_params = [id]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      return nil
    end


end