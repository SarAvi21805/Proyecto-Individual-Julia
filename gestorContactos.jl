# Alejandra Avilés - 24722
# Materia: Algoritmos y estructuras de datos
# Tarea: Investigación de Lenguajes ----- Fase 4
# Descripción: Programa que permitirá al usuario agregar, buscar y listar contactos guardados.
# Fecha de última modificación: 18/04/2025

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

# Prueba del programa
agregar_contacto("Ana", "25649684")
agregar_contacto("Juan", "25649685")
buscar_contacto("Ana")  # Buscar un contacto
listar_contactos()