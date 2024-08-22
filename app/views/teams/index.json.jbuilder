# frozen_string_literal: true

json.array! @teams do |m|
  json.extract! m, :id, :name
end
