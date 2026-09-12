# ## Лабораторная работа №6. Задача об эпидемии
using DrWatson 
@quickactivate "project"
using DifferentialEquations
using Plots 
default(fmt = :png)

# ## 1. Параметры модели (Вариант 54)
a = 0.01 # Коэффициент заболеваемости
b = 0.02 # Коэффициент выздоровления
N = 8439 # Количество особей
I0 = 86 # Количество заболевших
R0 = 25 # Количество выздоровевших
S0 = N - I0 - R0 # Количество не заболевших вообще
u0 = [S0, I0, R0]
tspan = (0.0, 60)

# ## 2. Определение функции  
# Случай 1: I(t) <= I* (Больные изолированы)
function epidemic_case1!(du, u, p, t)
	S, I, R = u
	du[1] = 0
	du[2] = -b*I
	du[3] = b*I
end

# Случай 2: I(t) > I* (Эпидемия распространяется)
function epidemic_case2!(du, u, p, t)
	S, I, R = u
	du[1] = -a*S
	du[2] = a*S-b*I
	du[3] = b*I
end

# ## 3. Решение
# Моделирование первого случая
prob1 = ODEProblem(epidemic_case1!, u0, tspan)
sol1 = solve(prob1, Tsit5(), saveat = 0.1)

# Моделирование второго случая
prob2 = ODEProblem(epidemic_case2!, u0, tspan)
sol2 = solve(prob2, Tsit5(), saveat = 0.1)


# ## 4. Визуализация
p1 = plot(sol1, title = "Эпидемия при I(t) <= I* (Вариант 54)", xlabel = "Время t", ylabel = "Численность", label = ["S(t)" "I(t)" "R(t)"], lw = 2, color = [:blue :red :green])
p2 = plot(sol2, title = "Эпидемия при I(t) > I* (Вариант 54)", xlabel = "Время t", ylabel = "Численность", label = ["S(t)" "I(t)" "R(t)"], lw = 2, color = [:blue :red :green])
layout = plot(p1, p2, layout = (2, 1))
display(layout)
# Сохранение графика
script_name = "lab06"
mkpath(plotsdir(script_name))

savefig(layout, plotsdir(script_name, "lab6_54.png"))
