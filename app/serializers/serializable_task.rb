class SerializableTask < JSONAPI::Serializable::Resource
  type 'tasks'

  attributes :id, :title
  has_many :tags
end
