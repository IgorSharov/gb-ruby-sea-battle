# Класс кораблей
#
class Ship
  # Хэш для подсчёта доступных к построению кораблей каждого типа
  # Формат: (тип - количество)
  # TODO: для тестирования каждого корабля доступно по 1 штуке
  # @@ships_avaliable = Hash[Array.new(4) { |e| [e + 1, 4 - e] }]
  @@ships_avaliable = Hash[Array.new(4) { |e| [e + 1, 1] }]

  # Ридер массива
  def self.ships_avaliable
    @@ships_avaliable
  end

  # Проверка готовности всех кораблей
  # (В хэше не осталось доступных кораблей ни одного типа)
  def self.all_ships_ready?
    @@ships_avaliable.map { |a| a[1] }.inject(:+).zero?
  end

  attr_reader :length, :coords

  # При создании корабля заданного типа происходит уменьшение
  # доступных кораблей этого типа в хэше
  def initialize(type)
    puts
    puts "Start building #{type}-deck ship".pink
    @length = type
    @coords = []
    @@ships_avaliable[type] -= 1
  end

  # Метод добавления координаты кораблю
  # Проверки:
  # 1. Координата не использовалась в других кораблях
  # 2. Корабль строится сплошным (можно добавлять только соседние координаты
  # 3. Корабль строится как прямая линия
  # При положительном результате выводится сообщение о добавлении координаты
  def add_coord(coord)
    if Coord.used_coords.include?(coord)
      puts 'The coordinate has been already used'.red
    elsif !integrity?(coord)
      puts 'Ship must be continuous'.red
    elsif @coords.size >= 2 && !proper_row_or_col?(coord)
      puts 'Ship must be one line'.red
    else
      row_or_col_set(coord) if @coords.size == 1
      Coord.add_used_coord(coord)
      @coords << coord
      puts "Coordinate (#{coord.x}, #{coord.y}) added to ship".green
    end
  end

  # Корабль готов
  def ready?
    @coords.size == @length
  end

  # Проверка сплошности построения
  def integrity?(coord_new)
    return true if @coords.empty?
    @coords.each do |coord|
      if coord.x == coord_new.x && (coord.y - coord_new.y).abs == 1 ||
         coord.y == coord_new.y && (coord.x - coord_new.x).abs == 1
        return true
      end
    end
    false
  end

  # Определение вдоль какой линии строится корабль
  # (по горизонтали или вертикали)
  # Сохранение ряда или столбца
  def row_or_col_set(coord)
    if @coords[0].x == coord.x
      @row = coord.x
    else
      @column = coord.y
    end
  end

  # Проверка построения в линию
  # по сохранённому ряду или столбцу
  def proper_row_or_col?(coord)
    instance_variable_defined?(:@row) ? @row == coord.x : @column == coord.y
  end
end
