## 「polmeth12.csv」と「polmeth12_2.csv」の読み込み
df <- read.csv("polmeth12.csv", fileEncoding = "SJIS")
df2 <- read.csv("polmeth12_2.csv")
## データフレームの結合
df <- merge(df, df2, by = "番号")
## 5～9歳人口当たりの放課後児童クラブ登録児童率を計算する
df$放課後児童クラブ登録率 <- df$登録児童数 / df$５_９歳人口 * 100

library(ggplot2)
scatter1 <- ggplot(df,
                   aes(x=放課後児童クラブ登録率,
                       y=女性離職率))
+ geom_point()

