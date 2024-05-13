ssdse <- read.csv("SSDSE-2019A.csv", fileEncoding = "SJIS")
## 完全失業率（対労働力人口）、婚姻率の計算
ssdse$完全失業率_男 <- ssdse$完全失業者数.男. / (ssdse$就業者数.男.
                                    + ssdse$完全失業者数.男.) * 100
ssdse$完全失業率_女 <- ssdse$完全失業者数.女. / (ssdse$就業者数.女.
                                    + ssdse$完全失業者数.女.) * 100
ssdse$婚姻率 <- ssdse$婚姻件数 / ssdse$総人口 * 1000

## 外れ値の確認
plot(ssdse$完全失業率_男, ssdse$婚姻率)

## 福島県楢葉町（ならはまち）⇒避難指示解除地域Ｊヴィレッジの除染工事・作業員が結婚届を出しているのでは？
ssdse1 <- subset(ssdse, ssdse$都道府県 != "福島県")

## 全国データの散布図の作成
plot(ssdse1$完全失業率_男, ssdse1$婚姻率, pch = 20, cex = 0.5,
     xlab = "完全失業率_男", ylab = "婚姻率")
plot(ssdse1$完全失業率_女, ssdse1$婚姻率, pch = 20, cex = 0.5,
     xlab = "完全失業率_女", ylab = "婚姻率")
## 千葉県データの散布図の作成
ssdse2 <- subset(ssdse, ssdse$都道府県 == "千葉県")
plot(ssdse2$完全失業率_男, ssdse2$婚姻率, type = "n",
xlab = "完全失業率_男", ylab = "婚姻率")
text(ssdse2$完全失業率_男, ssdse2$婚姻率, ssdse2$市区町村,
cex = 0.6)

res1 <- lm(ssdse2$婚姻率 ~ ssdse2$完全失業率_男)
res2 <- lm(ssdse2$婚姻率 ~ ssdse2$完全失業率_女)
summary(res1)
summary(res2)

abline(res1, col = "red")
