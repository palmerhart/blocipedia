class CreateWikisAndUsers < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :wiki_id
      t.integer :user_id
      t.boolean :auth_collaborate
      t.timestamps
    end
    
    add_index :users, :id, unique: true
    add_index :wikis, :id, unique: true
    add_index :collaborators, :id, unique: true
    add_index :collaborators, :user_id
    add_index :collaborators, :wiki_id
  end
end
