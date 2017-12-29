class AddVotesCountToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts,:votes_count,:integer,default:0
    Post.pluck(:id).each do |i|
      Post.reset_counters(i,:votes)
    end
  end
end
