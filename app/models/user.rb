class User < ActiveRecord::Base
  has_many :rides
  has_many :attractions, through: :rides

  has_secure_password

  def happy_scale
    if self.happiness >= 2
      "happy"
    else
      "not happy"
    end
  end

  def mood
    if self.happiness > self.nausea
      "happy"
    else
      "sad"
    end
  end

end
