using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
default(fmt = :png)

p_cr = 47
t1 = 33
p1 = 9.7
t2 = 27
p2 = 11.7
N = 50
q = 1

a1 = p_cr / (t1^2 * p1^2 * N * q)
a2 = p_cr / (t2^2 * p2^2 * N * q)
b = p_cr / (t1 * t2 * p1 * p2 * N * q)
c1 = (p_cr - p1) / (t1 * p1)
c2 = (p_cr - p2) / (t2 * p2)

M0 = [7.7, 9.7]
tspan = (0.0, 30.0)

function competetion_case1!(dM, M, p, t)
	dM[1] = M[1] - (a1 / c1) * M[1]^2 - (b / c1) * M[1] * M[2]
	dM[2] = (c2 / c1) * M[2] - (a1 / c1) * M[2]^2 - (b / c1) * M[1] * M[2]
end

function competetion_case2!(dM, M, p, t)
	dM[1] = M[1] - (a1 / c1) * M[1]^2 - ((b / c1) + 0.002) * M[1] * M[2]
	dM[2] = (c2 / c1) * M[2] - (a1 / c1) * M[2]^2 - (b / c1) * M[1] * M[2]
end

prob1 = ODEProblem(competetion_case1!, M0, tspan)
sol1 = solve(prob1, Tsit5() , saveat = 0.1)

prob2 = ODEProblem(competetion_case2!, M0, tspan)
sol2 = solve(prob2, Tsit5() , saveat = 0.1)

p1 = plot(sol1, vars=(0,1), label = "Фирма 1", color = :blue, lw=2)
plot!(p1, sol1, vars=(0,2), label = "Фирма 2", color = :green, lw=2, title = "Случай 1: Рыночная конкуренция", xlabel = "Время θ", ylabel = "Оборотные средства M")

p2 = plot(sol2, vars=(0,1), label = "Фирма 1", color = :blue, lw=2)
plot!(p2, sol2, vars=(0,2), label = "Фирма 2", color = :green, lw=2, title = "Случай 1: Конкуренция с фактором выбора предпочтительного бренда ", xlabel = "Время θ", ylabel = "Оборотные средства M")


layout = plot(p1,p2,layout=(2,1), size = (1000, 900))

script_name = "lab08"
mkpath(plotsdir(script_name))

savefig(layout, plotsdir(script_name, "lab8_54.png"))
