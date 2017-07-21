# Shot
#
class Shot < Coord
  @@shots_made = []
  @@blocked_coords = []

  def initialize(x, y)
    coord = Coord.new(x, y)
    if @@shots_made.include?(coord)
      puts 'You have already shot this coordinate'
      elseif @@blocked_coords.include?(coord)
      puts 'You should not fire this coord. It\'s too close to killed ship'
    else
      @x = x
      @y = y
    end
  end
end
