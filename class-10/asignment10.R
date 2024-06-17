ssdse <- read.csv("SSDSE-2020B.csv", fileEncoding = "SJIS")
ssdse$転入超過率 <- (ssdse$転入者数.日本人移動者. - ssdse$転出者数.日本人移動者.) / ssdse$総人口
ssdse$小学校教師一人当たり生徒数 <- ssdse$小学校児童数 / ssdse$小学校教員数
ssdse$中学校教師一人当たり生徒数 <- ssdse$中学校生徒数 / ssdse$中学校教員数
ssdse$高等学校教師一人当たり生徒数 <- ssdse$高等学校生徒数 / ssdse$高等学校教員数
ssdse$大学進学率 <- ssdse$高等学校卒業者のうち進学者数 / ssdse$高等学校卒業者数
ssdse$食料費割合 <- ssdse$食料費.二人以上の世帯. / ssdse$消費支出.二人以上の世帯.
ssdse$有効求人倍率 <- ssdse$月間有効求人数.一般. / ssdse$月間有効求職者数.一般.

# ssdse17 <- subset(ssdse, 年度 == 2017)
# plot(ssdse17$中学校教師一人当たり生徒数, ssdse17$大学進学率, type = "n",
#      xlab = "中学校教師一人当たり生徒数", ylab = "大学進学率")
# text(ssdse17$中学校教師一人当たり生徒数, ssdse17$大学進学率,
#      ssdse17$都道府県, cex = 0.6)

result1 <- feols(大学進学率 ~ 中学校教師一人当たり生徒数 + 食料費割合 + log(総人口), cluster = "都道府県", data = ssdse)
summary(result1)

library(fixest)
result2 <- feols(大学進学率 ~ 中学校教師一人当たり生徒数 + 食料費割合 + log(総人口) | 年度 + 都道府県, cluster = "都道府県", data = ssdse)
summary(result2)

tab <- etable(result1, result2, fitstat = c("n", "ar2"))
tab


