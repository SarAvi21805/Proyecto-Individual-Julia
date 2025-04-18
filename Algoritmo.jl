# Alejandra Avilés - 24722
# Materia: Algoritmos y estructuras de datos
# Tarea: Investigación de Lenguajes ----- Fase 5
# Descripción: Programa que permitirá al usuario buscar un elemento dentro de un array.
# Fecha de última modificación: 18/04/2025

function busqueda_binaria(arr::Vector{Int}, Objetivo::Int)
    bajo = 1
    alto = length(arr)

    while bajo <= alto
        medio = div(bajo + alto, 2) # División de la suma de bajo y alto entre 2
        if arr[medio] == Objetivo
            return medio # Retornará el índice del elemento encontrado
        elseif arr[medio] < Objetivo
            bajo = medio + 1
        else
            alto = medio - 1 
        end
    end
    return -1 # En caso que el elemento no sea encontrado
end

# Prueba del programa
arr = [1, 2, 3, 4, 5, 6, 10, 23, 25, 30]
Objetivo = 35
resultado = busqueda_binaria(arr, Objetivo)

if resultado != -1
    println("Elemento $Objetivo encontrado en el índice: $resultado.")
else
    println("Elemento $Objetivo no encontrado en el array.")
end