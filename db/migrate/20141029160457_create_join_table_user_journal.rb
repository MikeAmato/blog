class CreateJoinTableUserJournal < ActiveRecord::Migration
  def change
    create_join_table :users, :journals do |t|
      # t.index [:user_id, :journal_id]
      # t.index [:journal_id, :user_id]
    end
  end
end
