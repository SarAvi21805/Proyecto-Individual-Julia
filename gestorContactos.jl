# Alejandra Avilés - 24722
# Materia: Algoritmos y estructuras de datos
# Tarea: Investigación de Lenguajes ----- Fase 4
# Descripción: Programa que permitirá al usuario agregar, buscar y listar contactos guardados.
# Fecha de última modificación: 18/04/2025

#importando recursos necesarios
import Pkg
Pkg.add("CSV")
Pkg.add("DataFrames")
using CSV
using DataFrames

# Estructura para los contactos
mutable struct Contacto
    nombre::String
    telefono::String
end

# Diccionario que almacena los contactos
const contactos = Dict{String, Contacto}()

# Función que permite agregar contactos
function agregar_contacto(nombre::String, telefono::String)
    if haskey(contactos, nombre)
        println("El contacto $nombre ya existe.")
    else
        if confirmar_accion("agregar", nombre)
            contactos[nombre] = Contacto(nombre, telefono)
            println("Contacto $nombre agregado con éxito.")
        else
            println("Acción cancelada.")
        end
    end
end

# Función que permite la búsqueda parcial de contactos mediante el nombre
function buscar_contacto(lista::Vector{String}, nombre::String)
    # Conversión del texto a minúsculas
    texto_a_buscar_lower = lowercase(nombre)
    coincidencias = filter(x -> occursin(texto_a_buscar_lower, lowercase(x)), lista)
    return coincidencias
end

# Función para listar todos los contactos
function listar_contactos()
    if isempty(contactos)
        println("No hay contactos registrados.")
    else
        println("***Lista de contactos***")
        println()
        for nombre in sort(collect(keys(contactos))) # Ordenamiento alfabético
            contacto = contactos[nombre]
            println(" - $nombre: $(contacto.telefono)")
        end
    end
end

# Función que permite cargar los contactos desde un archivo CSV
function cargar_contactos(archivo::String)
    if isfile(archivo)
        df = DataFrame(CSV.File(archivo))
        for row in eachrow(df)
            contactos[row.nombre] = Contacto(row.nombre, string(row.telefono))
        end
    end
end

# Función para guardar contactos en el CSV
function guardar_contactos(archivo::String)
    df = DataFrame(nombre=String[], telefono=String[])
    for contacto in values(contactos)
        push!(df, (contacto.nombre, contacto.telefono))
    end
    CSV.write(archivo, df)
end

# Función para eliminar contactos
function eliminar_contacto(nombre::String)
    if haskey(contactos, nombre)
        if confirmar_accion("eliminar", nombre)
        delete!(contactos, nombre)
        println("Contacto $nombre eliminado con éxito.")
        else
            println("Acción cancelada.")
        end
    else
        println("Contacto $nombre no encontrado.")
    end
end

# Función para modificar contactos
function modificar_contacto(nombre::String)
    if haskey(contactos, nombre)
        while true
            println("¿Qué campo desea modificar?\n1. Nombre\n2. Teléfono\n3. Cancelar")
            print("Seleccione una opción: ")
            opcion = parse(Int, readline())
            
            if opcion == 1
                print("Ingrese el nuevo nombre: ")
                nuevo_nombre = readline()
                if confirmar_accion("modificar el nombre a $nuevo_nombre", nombre)
                    contactos[nuevo_nombre] = Contacto(nuevo_nombre, contactos[nombre].telefono)
                    delete!(contactos, nombre)
                    println("Nombre modificado a $nuevo_nombre.")
                    break 
                else
                    println("Acción cancelada")
                end
            elseif opcion == 2
                nuevo_telefono = ""
                while true
                    print("Ingrese el nuevo teléfono (8 dígitos): ")
                    nuevo_telefono = readline()
                    if validar_telefono(nuevo_telefono)
                        if confirmar_accion("modificar el teléfono a $nuevo_telefono", nombre)
                            contactos[nombre].telefono = nuevo_telefono
                            println("Teléfono modificado a $nuevo_telefono")
                            break
                        else
                            println("Acción cancelada.")
                        end
                    else
                        println("Número de teléfono inválido. Debe tener 8 dígitos.")
                    end
                end
                break
            else
                println("Opción inválida.")
            end
        end
    else
        println("Contacto $nombre no encontrado.")
    end
end
            
#Función para efectuar búsquedas de contactos por número de teléfono parciales
function buscar_por_telefono(telefono::String)
    println("Resultados de búsqueda para el número: $telefono")
    for contacto in values(contactos)
        if occursin(telefono, contacto.telefono)
            println("Nombre: $(contacto.nombre), Teléfono: $(contacto.telefono)")
        end
    end
end

# Función para validar el número de teléfono
function validar_telefono(telefono::String)
    return length(telefono) == 8 && all(isdigit, telefono)
end

# Función para confirmar acciones del usuario
function confirmar_accion(accion::String, nombre::String)
    println("¿Está seguro que desea $accion el contacto $nombre? (s/n)")
    respuesta = readline()
    return respuesta == "s"
end

# Menú interactivo
function menu()
    cargar_contactos("contactos.csv") # Carga inicial de datos
    while true
        println("\n***** Menú de Contactos *****") # Menú interactivo
        println("1. Agregar contacto.")
        println("2. Modificar contacto.")
        println("3. Eliminar contacto.")
        println("4. Buscar contacto por nombre.")
        println("5. Buscar contacto por teléfono.")
        println("6. Listar contactos.")
        println("7. Salir.")
        print("Seleccione una opción: ")
        opcion = parse(Int, readline())

        if opcion == 1 # Agregar contacto
            print("Ingrese el nombre: ")
            nombre = readline()
            telefono = ""
            while true
                print("Ingrese el teléfono (Debe tener 8 dígitos: xxxxxxxx): ")
                telefono = readline()
                if validar_telefono(telefono)
                    agregar_contacto(nombre, telefono)
                    guardar_contactos("contactos.csv")
                    break
                else
                    println("Número de teléfono inválido. Debe tener 8 dígitos.")
                end
            end
        elseif opcion == 2 # Modificar contacto
            print("Ingrese el nombre del contacto a modificar: ")
            nombre = readline()
            modificar_contacto(nombre)
            guardar_contactos("contactos.csv")
        elseif opcion == 3 # Eliminar contacto
            print("Ingrese el nombre del contacto a eliminar: ")
            nombre = readline()
            eliminar_contacto(nombre)
            guardar_contactos("contactos.csv")
        elseif opcion == 4 # Buscar contacto por nombre
            print("Ingrese el nombre del contacto a buscar: ")
            nombre = readline()
            coincidencias = buscar_contacto(collect(keys(contactos)), nombre) # Se adjunta el listado de contactos
            if isempty(coincidencias)
                println("No se encontraron contactos con el nombre: $nombre.")
            else
                println("*** Resultados de búsqueda ***")
                for nombre_coincidencia in coincidencias
                    contacto = contactos[nombre_coincidencia]
                    println("- $nombre_coincidencia: $(contacto.telefono)")
                end
            end
        elseif opcion == 5 # Buscar contacto por teléfono
            print("Ingrese el número de teléfono a buscar: ")
            telefono = readline()
            buscar_por_telefono(telefono)
        elseif opcion == 6 # Listar contactos
            listar_contactos()
        elseif opcion == 7 # Salir
            guardar_contactos("contactos.csv") # Guarda los contactos previamente al Salir
            println("Saliendo del programa...")
            break
        else # Manejo de errores
            println("Opción inválida. Por favor, seleccione una opción válida.")
        end
    end
end

# Ejecución del Menú
menu()