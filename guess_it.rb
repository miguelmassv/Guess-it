require 'pry'
# 1. Leer el archivo con Q-A
#   Preguntar por nombre y extencion del archivo
#   Guardar Q-A
#   Separar Q-A en un array de hash
#   Agregar key de solucionado: true false
#  
# 2. Realizar preguntas al usuario
#   Escoger primer hash del arreglo que no este solucionado
#   Realizar la pregunta del Hash seleccionado 
# 3. Validar respuesta
#   si la respuesta es correcta cambiar estado de solucionado a true
#   sino volver a preguntar hasta responder correctamente
# 4. Siguiente pregunta
#    cuando todas las preguntas esten respuestas salir del juego

class ReadFile
    attr_reader :Q_A

    def initialize(file_name)
        @Q_A = []
        read_file(file_name)
    end
  
    private
        def read_file(file_name)
            if File.file?(file_name)
                file_info = IO.readlines(file_name)
                i = 0
                file_info.each do |info|
                  line = info.chomp.split('-')
                  @Q_A[i] = {question: line[0], answer: line[1], done: false}
                  i+=1
                end
              end
              return @Q_A            
        end
  end
  



class Game
    def initialize        
        @questions = ReadFile.new('q_a.txt').Q_A  
        puts "Bienvenido a Guess it, Para jugar, solo ingresa el termino correcto para cada una de las definiciones, Listo? (Y/N)"
        ready = gets.chomp
        if ready == "Y"
            play
        elsif ready == "N"
            "Vuelve cuando te sientas preparado"
        end        
    end

    def play
        puts    
        @questions.each do |question|
            while question[:done] === false
                puts "-------------------"
                puts "Definición:"
                puts question[:question]
                puts
                puts "Adivina: "
                answer = gets.chomp
                puts
                if answer === question[:answer]
                    question[:done] = true
                    puts "Correcto!"
                else
                    puts "Incorrecto!, intentalo de nuevo"               
                end
            end
        end
        puts
        puts "Felicitaciones has respondido todas las preguntas"
    end
end

Game.new
