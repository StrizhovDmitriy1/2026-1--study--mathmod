using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
default(fmt = :png)

a = 0.354
b = 0.765
c = 0.679
h = 0.845

x0 = 87700
y0 = 91400
u0 = [x0,y0]
tspan = (0.0,1.5)

P(t) = abs(sin(t+10))
Q(t) = abs(cos(t+15))

function combat_regular!(du,u,p,t)
	x,y = u
	du[1] = -a * x - b * y + P(t)
	du[2] = -c * x - h * y + Q(t)
end

prob1 = ODEProblem(combat_regular!, u0, tspan)
sol1 = solve(prob1, Tsit5(), saveat = 0.01)

script_name = "lab03"
mkpath(plotsdir(script_name))

p1 = plot(sol1, title = "Регулярные войска (X) vs регулярные войска (Y)", xlabel="Время", ylabel="Численность армии", label = ["Армия Х" "Армия У"], lw=2)

savefig(p1, plotsdir(script_name, "combat_regular.png"))

p1
