require 'csv'

class User < ApplicationRecord
  
  include GenerateCsv
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: "admin", manager: "manager", user: "user"}


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      users_hash = row.to_hash      
      find_or_create_by!(email: users_hash['email']) do |u|
        u.password = "password123"
        u.firstname = users_hash["firstname"]
        u.lastname = users_hash["lastname"]
        u.role = users_hash["role"]
        u.address = users_hash["address"]
      end
    end
  end
end
