ssdse <- read.csv("SSDSE-2019A.csv", fileEncoding = "SJIS")
ssdse$１０平方キロメートルあたりの病院数 <- ssdse$一般病院数 / ssdse$可住地面積 * 100
# １０平方キロメートルあたりの病院数の対数を取る
ssdse$１０平方キロメートルあたりの病院数[ssdse$１０平方キロメートルあたりの病院数 <= 0] <- NA
ssdse$ログ病院数 = log(ssdse$１０平方キロメートルあたりの病院数)
ssdse$死亡率 <- ssdse$死亡数 / ssdse$総人口 * 1000

plot(ssdse$１０平方キロメートルあたりの病院数, ssdse$死亡率)
# プロットに都道府県名を追加
text(ssdse$ログ病院数, ssdse$死亡率, labels=ssdse$都道府県, pos=4, cex=0.8)

# 福島県の死亡率が高かったため削除
ssdse1 <- subset(ssdse, ssdse$都道府県 != "福島県")


plot(ssdse1$ログ病院数, ssdse1$死亡率, pch = 20, cex = 0.5,
     xlab = "ログ病院数", ylab = "死亡率")

res1 <- lm(ssdse1$死亡率 ~ ssdse1$ログ病院数)
summary(res1)

abline(res1, col = "red")