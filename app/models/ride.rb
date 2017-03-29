class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    user = User.find(self[:user_id])
    attraction = Attraction.find(self[:attraction_id])

    if tickets_check!(user, attraction) && height_check!(user, attraction)
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    elsif tickets_check!(user, attraction)
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif height_check!(user, attraction)
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      user.tickets -= attraction.tickets
      user.nausea += attraction.nausea_rating
      user.happiness = attraction.happiness_rating
      user.save
      "Thanks for riding the #{attraction.name}!"
    end
  end

  private
  def tickets_check!(user, attraction)
    user.tickets < attraction.tickets
  end

  def height_check!(user, attraction)
    user.height < attraction.min_height
  end
end
