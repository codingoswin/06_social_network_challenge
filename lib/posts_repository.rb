require_relative './posts'

class PostsRepository
    def all
        sql = 'SELECT id, title, content, number_of_views, user_account_id FROM posts;'
        result_set = DatabaseConnection.exec_params(sql, [])

        all_posts = []
        result_set.each do |record|
          post = Posts.new
          post.id = record['id'].to_i
          post.title = record['title']
          post.content = record['content']
          post.number_of_views = record['number_of_views'].to_i
          post.user_account_id = record ['user_account_id'].to_i
          all_posts << post
        end
        return all_posts
    end

    def find(id)
        sql = 'SELECT id, title, content, number_of_views, user_account_id FROM posts WHERE id = $1;'
        sql_params = [id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        record = result_set[0]
        post = Posts.new
        post.id = record['id'].to_i
        post.title = record['title']
        post.content = record['content']
        post.number_of_views = record['number_of_views'].to_i
        post.user_account_id = record['user_account_id'].to_i
        return post
    end

    def create(post)
        sql = 'INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES($1, $2, $3, $4);'
        sql_params = [post.title, post.content, post.number_of_views, post.user_account_id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return nil
    end

    def delete(id)
        sql = 'DELETE FROM posts WHERE id = $1;'
        sql_params = [id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return nil
      end
end