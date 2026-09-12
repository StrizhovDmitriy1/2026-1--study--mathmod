using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
default(fmt = :png)

const N = 1403 # общее количество потенциальных потребителей
const n0 = 9 # начальное число потребителей
const tspan = (0.0, 40.0)
u0 = [n0]

const a1_1 = 0.64
const a1_2 = 0.00004

const a2_1 = 0.00007
const a2_2 = 0.7

a3_1(t) = 0.4*t
a3_2(t) = 0.3*sin(2*t)

function ad_case1!(du, u, p, t)
	n = u[1]
	du[1] = (a1_1 + a1_2 * n)*(N - n)
end

function ad_case2!(du, u, p, t)
	n = u[1]
	du[1] = (a2_1 + a2_2 * n)*(N - n)
end

function ad_case3!(du, u, p, t)
	n = u[1]
	du[1] = (a3_1(t) + a3_2(t) * n)*(N - n)
end

prob1 = ODEProblem(ad_case1!, u0, tspan)
sol1 = solve(prob1, Tsit5(), saveat = 0.1)

prob2 = ODEProblem(ad_case2!, u0, tspan)
sol2 = solve(prob2, Rosenbrock23(), saveat = 0.1)

prob3 = ODEProblem(ad_case3!, u0, tspan)
sol3 = solve(prob3, Rosenbrock23(), saveat = 0.1)

plt1 = plot(sol1, xlims = (0.0, 15.0), ylims = (0.0, N*1.05), title = "Эффективность рекламы: Случай 1", xlabel = "Время t", ylabel = "n(t)", label = "n(t)", color = :red, legend = :bottomright)
plt2 = plot(sol2, xlims = (0.0, 15.0), ylims = (0.0, N*1.05), title = "Эффективность рекламы: Случай 2", xlabel = "Время t", ylabel = "n(t)", label = "n(t)", color = :red, legend = :bottomright)
plt3 = plot(sol3, xlims = (0.0, 15.0), ylims = (0.0, N*1.05), title = "Эффективность рекламы: Случай 3", xlabel = "Время t", ylabel = "n(t)", label = "n(t)", color = :red, legend = :bottomright)

layout = plot(plt1, plt2, plt3, layout = (3, 1), size = (1000, 900))
display(layout)

script_name = "lab07"
mkpath(plotsdir(script_name))

savefig(layout, plotsdir(script_name, "lab7_54.png"))
