df <- read.csv("SSDSE-2019A.csv", fileEncoding = "SJIS")
df <- subset(df, df$都道府県 != "福島県")

df$一人当たり民生費 <- df$民生費.市町村財政. / df$総人口
df$一人当たり民生費_log <- log(df$一人当たり民生費)
df$総人口_log <- log(df$総人口)

#二乗項による推定
result <- lm(一人当たり民生費_log ~ 総人口_log + I(総人口_log^2), data = df)
summary(result)

plot(df$総人口_log, df$一人当たり民生費_log, pch = 20)
b <- result$coefficients
x <- seq(5, 16, 0.01)
y.hat <- b[1] + b[2] * x + b[3] * x^2
lines(x, y.hat, col = "red")

b[2]/(-2*b[3])
exp(b[2]/(-2*b[3]))