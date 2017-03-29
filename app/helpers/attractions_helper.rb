module AttractionsHelper
  def admin_new_attraction(user)
    if user.admin?
      link_to "New Attraction", new_attraction_path
    end
  end

  def admin_show_attraction(user, attraction)
    if user.admin?
      link_to "Show #{attraction.name}", attraction_path(attraction)
    end
  end

  def admin_edit_attraction(user, attraction)
    if user.admin?
      link_to "Edit Attraction", edit_attraction_path(attraction)
    end
  end

  def ride_attraction(user, attraction)
    link_to "Go on #{attraction.name}", attraction_path(attraction) unless user.admin?
  end
end
