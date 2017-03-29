module UsersHelper
  def happy_scale(user)
    if user.happiness >= 2
      "happy"
    else
      "sad"
    end
  end
end
