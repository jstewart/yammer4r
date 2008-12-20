class String
  def to_boolean
    case self
    when 'true'
      true
    when 'false'
      false
    else
      nil
    end
  end
end