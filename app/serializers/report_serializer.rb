class ReportSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :message
end
