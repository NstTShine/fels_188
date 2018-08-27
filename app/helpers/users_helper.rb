module UsersHelper
  def gravatar_for user, options ={size: 80}
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def check_activity action_type, target_id, user
    case action_type
    when Activity.activity_types[:follow]
      user.name + t("activity_follow") + User.find_by(id: target_id).name
    when Activity.activity_types[:unfollow]
      user.name + t("activity_unfollow") + User.find_by(id: target_id).name
    when Activity.activity_types[:create_lesson]
      user.name + t("activity_create_lesson")
    when Activity.activity_types[:finished]
      user.name + t("activity_finish_lesson")
    else
      t "none"
    end
  end
end
