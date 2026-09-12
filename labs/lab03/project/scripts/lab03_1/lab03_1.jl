using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
default(fmt = :png)

a = 0.505
b = 0.77
c = 0.6
h = 0.404

x0 = 87700
y0 = 91400
u0 = [x0,y0]
tspan = (0.0,1.5)

P(t) = sin(2*t)+2
Q(t) = cos(5*t)+2

function combat_mixed!(du,u,p,t)
	x,y = u
	du[1] = -a * x - b * y + P(t)
	du[2] = -c * x * y - h * y + Q(t)
end

prob1 = ODEProblem(combat_mixed!, u0, tspan)
sol1 = solve(prob1, Tsit5(), saveat = 0.01)

script_name = "lab03"
mkpath(plotsdir(script_name))

p1 = plot(sol1, title = "Регулярные войска  vs партизанские войска", xlabel="Время", ylabel="Численность армии", label = ["Армия Х" "Армия У"], lw=2)

savefig(p1, plotsdir(script_name, "combat_mixed.png"))

p1
