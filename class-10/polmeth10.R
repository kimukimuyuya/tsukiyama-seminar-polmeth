ssdse <- read.csv("SSDSE-2020B.csv", fileEncoding = "SJIS")
ssdse$転入超過率 <- (ssdse$転入者数.日本人移動者. - ssdse$転出者数.日本人移動者.) / ssdse$総人口
ssdse$有効求人倍率 <- ssdse$月間有効求人数.一般. / ssdse$月間有効求職者数.一般.

# ssdse17 <- subset(ssdse, 年度 == 2017)
# plot(ssdse17$有効求人倍率, ssdse17$転入超過率, type = "n",
#      xlab = "有効求人倍率", ylab = "転入超過率")
# text(ssdse17$有効求人倍率, ssdse17$転入超過率,
#      ssdse17$都道府県, cex = 0.6)
# 
# ssdseA <- subset(ssdse, 都道府県 == "北海道")
# plot(ssdseA$有効求人倍率, ssdseA$転入超過率, type = "n",
#      xlab = "有効求人倍率", ylab = "転入超過率")
# text(ssdseA$有効求人倍率, ssdseA$転入超過率,
#      ssdseA$年度, cex = 0.6)

library(fixest)
model1 <- feols(転入超過率 ~ 有効求人倍率, cluster = "都道府県", data = ssdse)
summary(model1)

model1.p <- feols(転入超過率 ~ 有効求人倍率 + as.factor(年度) + as.factor(都道府県), cluster = "都道府県", data = ssdse)
summary(model1.p)

model2 <- feols(転入超過率 ~ 有効求人倍率 | 年度 + 都道府県, cluster = "都道府県", data = ssdse)
summary(model2)

model3 <- feols(転入超過率 ~ 有効求人倍率 +log(標準価格.平均価格..住宅地.) | 年度 + 都道府県, cluster = "都道府県", data = ssdse)
summary(model3)

tab <- etable(model1, model2, model3, fitstat = c("n", "ar2"))
tab
