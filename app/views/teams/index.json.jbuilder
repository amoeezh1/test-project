json.array! @teams do |m|
    json.extract! m, :id, :name
end