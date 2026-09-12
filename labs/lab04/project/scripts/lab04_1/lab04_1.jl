using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
default(fmt = :png)

w0 = sqrt(13)
g = 13
x0 = [0.9, 0.9]
tspan = (0.0, 48)
f(t) = 0 # Система без действия внешних сил

function oscillator!(du, u, p, t)
	x, y = u
	du[1] = y
	du[2] = -w0^2 * x - g * y - f(t)
end

prob1 = ODEProblem(oscillator!, x0, tspan)
sol1 = solve(prob1, Tsit5(), saveat = 0.05)

p1 = plot(sol1, title="Решение: с затуханием", xlabel="t", label=["x(t)" "y(t)"])
p2 = plot(sol1, vars=(1,2), title="Фазовый портрет", xlabel="x", ylabel="y", label="Траектория")
final_plot = plot(p1, p2, layout=(1,2))

display(final_plot)

script_name = "lab04"
mkpath(plotsdir(script_name))

savefig(final_plot, plotsdir(script_name, "oscillator_2.png"))
