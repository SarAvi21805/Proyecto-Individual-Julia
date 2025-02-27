# Alejandra Avilés - 24722
# Materia: Algoritmos y estructuras de datos
# Tarea: Investigación de Lenguajes ----- Fase 2

# Prueba 1: Demostración del uso de un diccionario en Julia
pronombres_en_frances = Dict(
    "yo" => "je",
    "tú" => "tu",
    "él/ella/usted" => "il/elle",
    "nosotros/as" => "nous",
    "vosotros/as" => "vous",
)

# Iteración sobre el diccionario
println("**********Prueba de diccionario**********")
println("los pronombres del español se traducen así en francés: ")
for(pronombre, traduccion) in pronombres_en_frances # Aplicación de un bucle
     println("$pronombre se traduce en francés como: $traduccion.")
end
println()

println("Para decir 'yo' en francés es: ", pronombres_en_frances["yo"]) # Acceso al valor de una clave
println()

pronombres_en_frances["ustedes"] = "vous" # Agregar una clave y valor al inicio del diccionario
println(pronombres_en_frances) # Imprimir el contenido del diccionario actualizado
println()
println()
# Fin de la prueba 1


# Prueba 2: Demostración de los Arreglos
println("**********Prueba de arreglos**********")
arr = [6, 8, 9, 13, 21]
push!(arr, 31) # Añade un elemento (31) al array
println("Array: ", arr)
println()
# Fin de la prueba 2


# Prueba 3: Demostración de las Tuplas
println("**********Prueba de tuplas**********")
tupla = (1, "Alejandra", 21.08)
println("Tupla: ", tupla)
println()
# Fin de la prueba 3


# Prueba 4: Demostración de los Conjuntos
println("**********Prueba de Conjuntos**********")
using DataStructures
set1 = Set([1, 10, 100, 1000, 10])
push!(set1, 5)
println("Conjunto: ", set1)
println()
# Fin de la prueba 4


# Prueba 5: Demostración de rango
println("**********Prueba de Rangos**********")
rango = 1:2:10 # Rango con tamaño especificado.
println("Valores del rango: ", collect(rango))
println()

rango2 = 1:10 # Rango con tamaño por default
println("Valores del segundo rango: ", collect(rango2))
println()
# Nota/Aprendizaje: collect permite ver cada uno de los valores de los rangos, para ello los convierte en una lista primero y luego los imprime
# Fin de la prueba 5    


# Prueba 6: Demostración de List Comprehensions
println("**********Prueba de List Comprehensions**********")
cuadrados = [x^2 for x in 1:5]
println("List Comprehension: ", cuadrados)
# Fin de la prueba 6


# Prueba 7: Demostración de Condicionales
println("**********Prueba de condicional**********")
x = -21
if x > 0
    println("x es positivo")
elseif x == 0
    println("x es cero")
else
    println("x es negativo")
end
# Fin de la prueba 7


# Prueba 8: Demostración de bucles
println("**********Prueba de Bucle For**********")
for i in 1:5
    println("For Loop: ", i)
end
println()

println("**********Prueba de Bucle While**********")
global b = 6
while b > 0
    println("While Loop: ", b)
    global b -= 1
end
println()

println("**********Prueba de Bucle do-while**********")
global a = 7
while true # Simulación de do-while en Julia
    println("Do-While Loop: ", a)
    global a -= 1
    if a <= 0
        break
    end
end
println()
# Fin de la prueba 8


# Prueba 9: Demostración de Interruptores (switch)
println("**********Prueba de Interruptores**********")
using MLStyle
valor = 3

@match valor begin
    1 => println("El valor es 1")
    2 => println("El valor es 2")
    3 => println("El valor es 3")
    _ => println("El valor es diferente de 1, 2 o 3")
end
# Fin de la prueba 9