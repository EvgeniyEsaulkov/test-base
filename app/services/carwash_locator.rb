class CarwashLocator
  MAX_DISTANCE = 3000

  def self.nearest(coordinates)
    washes = Carwash.with_coordinates

    washes.select { |wash| wash.distance_to(coordinates) < MAX_DISTANCE }
  end
end
