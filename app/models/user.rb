class User < ActiveRecord::Base
  has_many :tweets

  # El usuario tiene michos "relationships" donde follower_id = self.id
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  # A través de los "relationships" se pueden obtener las personas que el usuario sige
  has_many :followings, :through => :relationships, :source => :followed
  
  validates :name, :presence => true

  validates :password, 
            :length => {:mininum => 6, :maximum => 30},
            :confirmation => true

  validates :email, 
            :presence => true, 
            :uniqueness => true, 
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end

  #
  # Métodos relacionados con "follow"
  #
  
  # Devuelve true si el usuario sigue a followed.
  #
  def follows?(followed)
    relationships.find_by_followed_id(followed)
  end

  #
  # Crea la relación entre el usuario y followed.
  # Si no se puede crear la relación, sale error.
  # 
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  #
  # Eliminar la relación entre el usuario y el followed.
  #
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
end
