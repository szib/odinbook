module LikesHelper

  def like_sentence(count)
    return '' if count < 0
    case count
    when 0
      "Nobody likes this post."
    when 1
      "#{count} person likes this post."
    else
      "#{pluralize(count, 'person')} like this post."
    end
  end

end
