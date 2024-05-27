df <- read.csv("SSDSE-2019A.csv", fileEncoding = "SJIS")
df <- subset(df, df$都道府県 != "福島県")

df$一人当たり歳出総額 <- df$歳出決算総額 / df$総人口
plot(df$総人口, df$一人当たり歳出総額, pch = 20)

result1 <- lm(一人当たり歳出総額 ~ 総人口, data = df)
summary(result1)


#対数線形モデル
plot(log(df$総人口), log(df$一人当たり歳出総額), pch = 20)
result2 <- lm(log(一人当たり歳出総額) ~ log(総人口), data = df)
summary(result2)

result3 <- lm(log(一人当たり歳出総額) ~ log(総人口) + I(log(総人口)^2), data = df)
summary(result3)

plot(log(df$総人口), log(df$一人当たり歳出総額), pch = 20)
b <- result3$coefficients
x <- seq(5, 16, 0.01)
y.hat <- b[1] + b[2] * x + b[3] * x^2
lines(x, y.hat, col = "red")

b[2]/(-2*b[3])
exp(b[2]/(-2*b[3]))

#交差項
df$人口密度 <- df$総人口 / df$可住地面積
hist(df$人口密度)
result4 <- lm(log(一人当たり歳出総額) ~ log(総人口) + log(人口密度) + I(log(総人口) * log(人口密度)), data = df)
summary(result4)

df$一人当たり歳出総額_log <- log(df$一人当たり歳出総額)
df$総人口_log <- log(df$総人口)
df$人口密度_log <- log(df$人口密度)
res5 <- lm(一人当たり歳出総額_log ~ 総人口_log + 人口密度_log +総人口_log * 人口密度_log, data = df)
summary(res5)

library(marginaleffects)
g <- plot_slopes(res5, variables = "総人口_log", condition = "人口密度_log", conf.level = 0.95)

g

