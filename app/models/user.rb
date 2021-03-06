class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
        has_many :wikis
        
         
        after_initialize { self.role ||= :standard }
  
        enum role: [:standard, :admin, :premium]
         
  def wikis
    Wiki.where(user_id: id)
  end
  
  def collaborating_users
    wikis.auth_collaborate
  end
end
