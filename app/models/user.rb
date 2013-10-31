class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  before_create :assign_role

  validates_presence_of :name
  validates_uniqueness_of :email, :case_sensitive => false

  def assign_role
    # assign a default role if no role is assigned
    self.add_role :user if self.roles.first.nil?
  end

end
