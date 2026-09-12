using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
default(fmt = :png)

a = 0.13
b = 0.041
c = 0.31
d = 0.042

x0 = [7.0, 20.0] # Начальная точка
tspan = (0.0, 100.0)

function lotka_volterra!(du, u, p, t)
	x, y = u
	du[1] = -a*x + b*x*y
	du[2] = c*y - d*x*y
end

prob = ODEProblem(lotka_volterra!, x0, tspan)
sol = solve(prob, Tsit5(), saveat=0.1)

p1 = plot(sol, title = "Динамика популяций (Вариант 54)", xlabel = "Численность жертв", ylabel = "Численность хищников", label = "Траектория", lw = 2)

p2 = plot(sol, vars = (2,1), title = "Фазовый портрет", xlabel = "Численность жертв", ylabel = "Численность хищников", label = "Траектория", lw = 2)

scatter!([c/d],[a/b], color = :red, label = "Стационарная точка")

layout = plot(p1, p2, layout = (1,2))
display(layout)

script_name = "lab05"
mkpath(plotsdir(script_name))

savefig(layout, plotsdir(script_name, "lab5_54.png"))
