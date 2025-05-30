# Alejandra Avilés - 24722
# Materia: Algoritmos y estructuras de datos
# Tarea: Investigación de Lenguajes ----- Fase 5
# Descripción: Programa que permitirá optimizar un modelo matemático.
# Fecha de última modificación: 29/05/2025
# Para ejecutarlo, colocar en la terminal: julia Maximizacion.jl

using Pkg

# Instalación de paquetes necesarios
Pkg.add("JuMP")
Pkg.add("GLPK")

using JuMP
using GLPK

# Creación del modelo de optimización
model = Model(GLPK.Optimizer)

# Definición de variables
@variable(model, x >= 0)
@variable(model, y >= 0)

# Definir la función objetivo
@objective(model, Max, 3x + 2y)

# Definir las restricciones
@constraint(model, c1, x + 2y <= 4)
@constraint(model, c2, 3x + y <= 6)

# Resolver el modelo
optimize!(model)

# Obtener los resultados
optimal_x = value(x)
optimal_y = value(y)
optimal_z = objective_value(model)

# Devolución de resultados redondeados a dos decimales.
println("Optimazión de x: ", round(optimal_x, digits=2))
println("Optimazión de y: ", round(optimal_y, digits=2))
println("Optimazión de z: ", round(optimal_z, digits=2))