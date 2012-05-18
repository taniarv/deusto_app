class Tweet < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, :presence => true
  
  validates :content,
            :presence => true, 
            :length => {:maximum => 160}
            
  default_scope :order => 'created_at DESC'            
  
  scope :recent, where("created_at > ?", 1.day.ago)
  
  # Lista de los tweets del usuario user y de todos los usuarios que este sigue
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private
  
    # Condición SQL para coger los tweets que corresponden al usuario user
    def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships 
                               WHERE follower_id = :user_id)
                                  
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
            {user_id: user.id })
    end
  
end
