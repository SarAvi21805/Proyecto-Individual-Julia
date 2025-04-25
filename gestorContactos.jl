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
struct Contacto
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
        contactos[nombre] = Contacto(nombre, telefono)
        println("Contacto $nombre agregado con éxito.")
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
        for (nombre, contacto) in contactos
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
        delete!(contactos, nombre)
        println("Contacto $nombre eliminado con éxito.")
    else
        println("Contacto $nombre no encontrado.")
    end
end

# Función para modificar contactos
function modificar_contacto(nombre::String, nuevo_telefono::String)
    if haskey(contactos, nombre)
        nuevo_telefono = ""
        
        while true
            nuevo_telefono = readLine("Ingrese el nuevo teléfono (8 dígitos): ")
            if validar_telefono(nuevo_telefono)
                contactos[nombre].telefono = nuevo_telefono
                println("Contacto modificado: $nombre")
                break
            else
                println("Número de teléfono inválido. Debe contener 8 dígitos.")
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
            print("Ingrese el teléfono: ")
            telefono = readline()
            agregar_contacto(nombre, telefono)
            guardar_contactos("contactos.csv")
        elseif opcion == 2 # Modificar contacto
            print("Ingrese el nombre del contacto a modificar: ")
            nombre = readline()
            print("Ingrese el nuevo teléfono: ")
            nuevo_telefono = readline()
            modificar_contacto(nombre, nuevo_telefono)
            guardar_contactos("contactos.csv")
        elseif opcion == 3 # Eliminar contacto
            print("Ingrese el nombre del contacto a eliminar: ")
            nombre = readline()
            println("¿Está seguro que desea eliminar el contacto $nombre? (s/n)")
            confirmacion = readline()
            if confirmacion == "s"
                eliminar_contacto(nombre)
            end
            guardar_contactos("contactos.csv")
        elseif opcion == 4 # Buscar contacto por nombre
            print("Ingrese el nombre del contacto a buscar: ")
            nombre = readline()
            #buscar_contacto(nombre)
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