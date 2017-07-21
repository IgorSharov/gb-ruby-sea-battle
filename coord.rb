# Класс координат
#
class Coord
  # Массив координат, использованных в ходе постройки кораблей
  @@used_coords = []

  # Добавление координаты в массив
  def self.add_used_coord(coord)
    @@used_coords << coord
  end

  # Ридер массива
  def self.used_coords
    @@used_coords
  end

  attr_reader :x, :y

  # Конструктор по умолчанию
  # Параметры от 0 до 9
  def initialize(x, y)
    @x = x
    @y = y
  end

  # Переопределение метода сравнения
  # Требуется для работы методов класса нумератора
  def ==(other)
    @x == other.x && @y == other.y ? true : false
  end
end
