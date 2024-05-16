df <- read.csv("SSDSE-2019A.csv", fileEncoding = "SJIS")
df <- subset(df, df$都道府県 != "福島県")

df$粗死亡率 <- df$死亡数 / df$総人口 * 10000
df$人口当たり一般病院数 <- df$一般病院数 / df$総人口 * 10000
df$高齢化率 <- df$`６５歳以上人口` / df$総人口 * 100
df$人口密度 <- df$総人口 / df$可住地面積

plot(df$人口当たり一般病院数, df$粗死亡率)

model1 <- lm(粗死亡率 ~ 人口当たり一般病院数, data = df)
summary(model1)

plot(df$高齢化率, df$粗死亡率)
plot(df$高齢化率, df$人口当たり一般病院数)

model2 <- lm(df$粗死亡率 ~ df$人口当たり一般病院数 + df$高齢化率)
model3 <- lm(df$粗死亡率 ~ df$人口当たり一般病院数 + df$高齢化率 + df$人口密度)
summary(model2)
summary(model3)

library(memisc)
results <- mtable(model1, model2, model3, digits = 4)
results