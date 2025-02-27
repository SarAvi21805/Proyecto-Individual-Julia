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