module LikesHelper

  def like_sentence(count, type = 'post')
    return '' if count < 0
    case count
    when 0
      "Nobody likes this #{type}."
    when 1
      "#{count} person likes this #{type}."
    else
      "#{pluralize(count, 'person')} like this #{type}."
    end
  end

end
