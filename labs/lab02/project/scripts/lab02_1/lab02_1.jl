using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
default(fmt = :png)

# Определение путей
script_name = "lab02"
mkpath(plotsdir(script_name))

k = 17.7
n = 3.8
fi = 3*pi/4

r0_1 = k / (n+1) # Случай 1
r0_2 = k / (n-1) # Случай 2

function f(r, p, theta)
	return r / sqrt(n^2 - 1)
end

tspan1 = (0.0, 2*pi)
prob1 = ODEProblem(f, r0_1, tspan1)
sol1 = solve(prob1, Tsit5(), saveat = 0.01)

tspan2 = (-pi, pi)
prob2 = ODEProblem(f, r0_2, tspan2)
sol2 = solve(prob2, Tsit5(), saveat = 0.01)

t_boat = 0:1:800
x_boat = t_boat
y_boat = tan(fi) * t_boat

r_boat = sqrt.(x_boat.^2 + y_boat.^2)
theta_boat = atan.(y_boat, x_boat)

p1 = plot(sol1.t, sol1.u, proj=:polar, lims=(0,20), title="Случай 1",  label="Катер", lw=2)
plot!(p1, theta_boat, r_boat, label="Лодка", linestyle=:dash, color=:red)

p2 = plot(sol2.t, sol2.u, proj=:polar, lims=(0,20), title="Случай 2",  label="Катер", lw=2)
plot!(p2, theta_boat, r_boat, label="Лодка", linestyle=:dash, color=:red)

final_plot = plot(p1, p2, layout = (1, 2), size=(1000,500))

r_meet1 = sol1(fi)
r_meet2 = sol2(fi)

println("Точка пересечения 1 : r = ", round(r_meet1, digits=3), " км, θ = ", round(fi, digits=3))
println("Точка пересечения 2 : r = ", round(r_meet2, digits=3), " км, θ = ", round(fi, digits=3))

savefig(final_plot, plotsdir(script_name, "pursuit.png"))
final_plot
