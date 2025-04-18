# Alejandra Avilés - 24722
# Materia: Algoritmos y estructuras de datos
# Tarea: Investigación de Lenguajes ----- Fase 4
# Descripción: Programa que permitirá al usuario agregar, buscar y listar contactos guardados.
# Fecha de última modificación: 18/04/2025

#importando recursos necesarios
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

# Función para buscar un contacto
function buscar_contacto(nombre::String)
    if haskey(contactos, nombre)
        contacto = contactos[nombre]
        println("Contacto con el nombre: $(contacto.nombre) fue encontrado, su número de teléfono es: $(contacto.telefono).")
    else
        println("Contacto no encontrado.")
    end
end

# Función para listar todos los contactos
function listar_contactos()
    if isempty(contactos)
        println("No hay contactos registrados.")
    else
        println("***Lista de contactos***")
        println("Nombre: teléfono")
        for (nombre, contacto) in contactos
            println("$nombre: $(contacto.telefono)")
        end
    end
end

# Función que permite cargar los contactos desde un archivo CSV
function cargar_contactos_archivo_csv(archivo::String)
    if isfile(archivo)
        df = CSV.File(archivo) |> DataFrames
        for row in eachrow(df)
            contactos[row.nombre] = Contacto(row.nombre, row.telefono)
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
        contactos[nombre].telefono = nuevo_telefono
        println("Contacto modificado: $nombre")
    else
        println("Contacto $nombre no encontrado.")
    end
end

#Función para efectuar búsquedas de contactos por número de teléfono parciales
function buscar_por_telefono(telefono::String)
    println("Resultados de búsqueda para el número: $telefono")
    for contacto in values(contactos)
        if eccursin(telefono, contacto.telefono)
            println("Nombre: $(contacto.nombre), Teléfono: $(contacto.telefono)")
        end
    end
end

# Prueba del programa
agregar_contacto("Ana", "25649684")
agregar_contacto("Juan", "25649685")
buscar_contacto("Ana")  # Buscar un contacto
listar_contactos()