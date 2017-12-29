class AddVoteCountToPost < ActiveRecord::Migration[5.0]
  # 这个表单是多余的
  def change
    add_column :posts,:vote_count,:integer,default:0
    Post.pluck(:id).each do |i|
      Post.reset_counters(i,:vote)
    end
  end
end
