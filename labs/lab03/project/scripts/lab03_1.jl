# ## Инициализация проекта
using DrWatson 
@quickactivate "project"
using DifferentialEquations
using Plots 
default(fmt = :png)

# ## 1. Параметры системы 
# Коэффициенты потерь и эффективности взяты из варианта 54
a = 0.505
b = 0.77
c = 0.6
h = 0.404


# Начальные численности 
x0 = 87700
y0 = 91400
u0 = [x0,y0]
tspan = (0.0,1.5)

# Функции подкрепления 
P(t) = sin(2*t)+2
Q(t) = cos(5*t)+2

# ## 2. Определение систем уравнений 
function combat_mixed!(du,u,p,t)
	x,y = u
	du[1] = -a * x - b * y + P(t)
	du[2] = -c * x * y - h * y + Q(t)
end
# ## 3. Решение 
prob1 = ODEProblem(combat_mixed!, u0, tspan)
sol1 = solve(prob1, Tsit5(), saveat = 0.01)

# ## 4. Визуализация
script_name = "lab03"
mkpath(plotsdir(script_name))

# ### График для модели с двумя регулярными армиями
p1 = plot(sol1, title = "Регулярные войска  vs партизанские войска", xlabel="Время", ylabel="Численность армии", label = ["Армия Х" "Армия У"], lw=2)

savefig(p1, plotsdir(script_name, "combat_mixed.png"))

p1
