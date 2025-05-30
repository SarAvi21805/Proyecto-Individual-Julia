# Función para buscar un contacto mediante una búsqueda parcial (Especifica)
#function buscar_contacto(nombre::String)
 #   resultados = filter(x -> occursin(nombre, x.nombre), collect(values(contactos))) # Se transforma en array para filter
  #  if isempty(resultados)
   #     println("No se encontraron contactos con el nombre: $nombre.")
    #else
     #   println("*** Resultados de búsqueda ***")
      #  for contacto in resultados
       #     println(" - $(contacto.nombre): $(contacto.telefono)")
        #end    
    #end
#end

# Función para modificar contactos version 1 (sencilla)
function modificar_contacto(nombre::String, nuevo_telefono::String)
    if haskey(contactos, nombre)
        contactos[nombre].telefono = nuevo_telefono
        println("Contacto modificado: $nombre")
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