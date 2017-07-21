# ОСНОВНОЙ ЗАПУСКАЕМЫЙ ФАЙЛ

# Команда установки зависимостей для Bundler
require 'rubygems'
require 'bundler/setup'

require 'pry'
# binding.pry - точка останова

# Подключение внешних классов, которые располагаются в текущей папке
require './coord.rb'
require './ship.rb'
require './shot.rb'
require './string.rb'

# Хэш-константа (буква - цифра)
# Требуется для интерпретации пользовательского ввода из формата 'A1' в индексы
LETTERS_TO_INT = Hash[('A'..'J').map.with_index { |e, i| [e, i] }]

# Метод, инициирующий постройку кораблей заданного типа
# Тип - количество палуб
# Бесконечный цикл выполняется до тех пор,
# пока не будут построены все доступные корабли
# Для тестирования при вводе типа = 0 открывается дебаггер
def build_ships
  puts
  puts 'Choose ship\'s type (1/2/3/4):'
  type = gets.chomp.to_i
  if (1..4).cover? type
    build_ship(type)
  elsif type.zero?
    binding.pry
  else puts 'Type is incorrect! Try again'.red
  end
  build_ships unless Ship.all_ships_ready?
end

# Метод постройки корабля заданного типа
# Проверяет есть ли доступные корабли для постройки
# Выводит полученный результат
def build_ship(type)
  if Ship.ships_avaliable[type].zero?
    puts "You have reached limit for #{type}-deck ships".red
    return nil
  end
  assembling_ship(type)
  # TODO: добавить блокировку координат, окружающих корабль
  puts "#{type}-deck ship has been build".green
  puts "#{type}-deck ships left avaliable to build: "\
    "#{Ship.ships_avaliable[type]}".yellow
end

# Метод сборки корабля заданного типа по координатам
# Проверяет пользотельский ввод с помощью регулярного выражения
# Буквенные координаты введёные пользователем преобразуются в цифровые
# Бесконечный цикл выполняется до тех пор, пока корабль не достроен
def assembling_ship(type)
  ship = Ship.new(type)
  loop do
    puts "Enter coordinate (like \'a1 or A1\'):"
    inpt = gets.chomp.match(/^([a-k])([1-9]|10)$/i)
    unless inpt
      puts 'Incorrect coordinate'.red
      next
    end
    coord = Coord.new(LETTERS_TO_INT[inpt[1].upcase], inpt[2].to_i - 1)
    ship.add_coord(coord)
    break if ship.ready?
  end
end

# TODO: Метод, расставляющий корабли противника
# TODO: Метод, реализующий логику игры
def play_game
end

# ЗАПУСК ПРОГРАММЫ
#
system 'cls'
puts 'Start building ships'.light_blue
build_ships
puts
puts 'Now PLAY!'.light_blue
play_game
