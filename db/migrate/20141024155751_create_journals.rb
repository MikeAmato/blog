class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :name
      t.string :blog_contents
      
      t.timestamps
    end
  end
end
