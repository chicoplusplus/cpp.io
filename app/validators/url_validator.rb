class UrlValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    # Add protocol as a courtesy
    unless value =~ /^https?:\/\//
      value = "http://#{value}"
      record[attribute] = value
    end

    # Test it
    unless value =~ /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
      record.errors[attribute] << (options[:message] || "is invalid") and return false
    end
    
    true
  end
end
