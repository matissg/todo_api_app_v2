class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'

  attributes :id, :title, :content
  has_many :tags
end
