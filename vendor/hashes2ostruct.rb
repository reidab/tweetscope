def hashes2ostruct(object)
  return case object
  when Hash
    object = object.clone
    object.each do |key, value|
      object[key] = hashes2ostruct(value)
    end
    OpenStruct.new(object)
  when Array
    object = object.clone
    object.map! { |i| hashes2ostruct(i) }
  else
    object
  end
end