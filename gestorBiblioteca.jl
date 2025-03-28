# Alejandra Avilés - 24722
# Materia: Algoritmos y estructuras de datos
# Tarea: Investigación de Lenguajes ----- Fase 3

# Definición de la clase Libro
struct Libro
    titulo::String
    autor::String
    anio::Int
end

# Definición de la clase Biblioteca
struct Biblioteca
    libros::Vector{Libro}

    function Biblioteca()
        new(Vector{Libro}())
    end
end

# Método para agregar un libro
function agregar_libro(biblioteca::Biblioteca, libro::Libro)
    push!(biblioteca.libros, libro)
end

# Método para buscar libros por autor
function buscar_por_autor(biblioteca::Biblioteca, autor::String)
    return filter(libro -> libro.autor == autor, biblioteca.libros)
end

# Método para listar todos los libros
function listar_libros(biblioteca::Biblioteca)
    for libro in biblioteca.libros
        println("Título: $(libro.titulo), Autor: $(libro.autor), Año: $(libro.anio)")
    end
end

# Función principal
function main()
    # Crear una nueva biblioteca
    biblioteca = Biblioteca()

    # Agregar libros a la biblioteca
    agregar_libro(biblioteca, Libro("Cien años de soledad", "Gabriel García Márquez", 1967))
    agregar_libro(biblioteca, Libro("Don Quijote de la Mancha", "Miguel de Cervantes", 1605))
    agregar_libro(biblioteca, Libro("El amor en los tiempos del cólera", "Gabriel García Márquez", 1985))


    # Listar todos los libros
    println("Libros en la biblioteca:")
    listar_libros(biblioteca)

    println()

    # Buscar libros por autor
    autor_a_buscar = "Gabriel García Márquez"
    println("Libros de $autor_a_buscar:")
    libros_encontrados = buscar_por_autor(biblioteca, autor_a_buscar)

    for libro in libros_encontrados
        println("Título: $(libro.titulo), Año: $(libro.anio)")
    end
end

# Ejecutar la función principal
main()
