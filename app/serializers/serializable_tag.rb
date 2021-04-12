class SerializableTag < JSONAPI::Serializable::Resource
  type 'tags'

  attributes :id, :title
  has_many :tasks
end
