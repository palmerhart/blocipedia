class Collaborator < ActiveRecord::Base
    belongs_to :user
    belongs_to :wiki
    
    
    #method to update collaborators via checkboxes on edit record of wiki - Has Many Through relationship
    def self.update_collaborators(collaborator, params)
        attributes = params.require(:user).permit( { wiki_id: [] })
            user.wiki_id = attributes[:wiki_id].select{ |x| x.to_i > 0}
            user.save
        
        !user.errors.present?
    end
   
    def self.wikis
        Wiki.where( id: pluck(:wiki_id))
    end
    
    def self.users
        User.where( id: pluck(:user_id))
    end
    
    def wiki
        Wiki.find(wiki_id)
    end
    
    def user
        User.find(user_id)
    end
end
