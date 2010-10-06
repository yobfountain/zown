class Node < ActiveRecord::Base
  has_many :captures
  has_and_belongs_to_many :clusters
  belongs_to :game
end
