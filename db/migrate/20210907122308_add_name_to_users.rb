class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :address, :text
    add_column :users, :contatno, :numeric
  end
end
