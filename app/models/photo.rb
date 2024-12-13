# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  # belongs_to :owner, class_name: "User"
  # has_many :comments, dependent: :destroy
  # has_many :likes, dependent: :destroy
  # has_one_attached :image

  validates(:owner, presence: true)
  validates(:image, presence: true)
  validates(:caption, presence: true)
  has_many  :comments, dependent: :destroy
  has_many  :likes, dependent: :destroy
  belongs_to :owner, class_name: "User"
  mount_uploader :image, ImageUploader

  # validates(:poster, { :presence => true })

  # # Association accessor methods to define:
  
  # ## Direct associations

  # # Photo#poster: returns a row from the users table associated to this photo by the owner_id column

  # belongs_to(:poster, class_name: "User", foreign_key: "owner_id")

  # # Photo#comments: returns rows from the comments table associated to this photo by the photo_id column

  # has_many(:comments, class_name: "Comment", foreign_key: "photo_id")

  # # Photo#likes: returns rows from the likes table associated to this photo by the photo_id column

  # has_many(:likes, class_name: "Like", foreign_key: "photo_id")

  # ## Indirect associations

  # # Photo#fans: returns rows from the users table associated to this photo through its likes

  # has_many(:fans, through: :likes, source: :fan)

end
