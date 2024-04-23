sales <- read.csv("sales.csv", na.strings="***", fileEncoding="SJIS")
highway <- read.csv("highway.csv", fileEncoding="SJIS")
sales15 <- subset(sales, 調査年 == "2015年度")

# データの結合（テーブルくっつけるみたいなイメージ）
sales15.m <- merge(sales15, highway, by.x = "地域", by.y = "都道府県")

hist(sales15.m$X.C04401_製造品出荷額等.従業者1人当たり..万円.,
     freq = TRUE, ylim = c(0, 20),
     xlab = "従業者1人当たり製造品出荷額(万円)",
     main = "都道府県の製造品出荷額の分布")
hist(sales15.m$X.C04505_商業年間商品販売額.卸売業.小売業..従業者1人当たり..万円., 
     freq = TRUE, ylim = c(0, 20),
     xlab = "従業者1人当たり商業年間商品販売額(万円)",
     main = "都道府県の商品販売額の分布")

hist(sales15.m$高速道路,
     breaks = seq(from = 0.5, to = 5.5, by = 1),
     freq = TRUE, ylim = c(0, 20),
     xlab = "高速道路の路線数",
     main = "都道府県の高速道路の分布")

boxplot(list(製造品出荷額 = sales15.m$X.C04401_製造品出荷額等.従業者1人当たり..万円. ~
             商品販売額 = sales15.m$X.C04505_商業年間商品販売額.卸売業.小売業..従業者1人当たり..万円.),
        ylab = "従業者一人当たり金額(万円)",
        main = "都道府県の製造品出荷額・商品販売額の分布")

#ここから課題
education <- read.csv("asignment2.csv", na.strings="***", fileEncoding="SJIS")
education21 <- subset(education, 調査年 == "2021年度")
rounded_variable <- round(education21$X.L02418_教育費割合.二人以上の世帯...., digits = 0)
education21$四捨五入された養育費割合 <- rounded_variable
boxplot(sales15.m$X.C04401_製造品出荷額等.従業者1人当たり..万円.
        ~ sales15.m$高速道路,
        xlab = "高速道路の路線数",
        ylab = "従業者一人当たり金額(万円)",
        main = "都道府県の製造品出荷額の分布")
boxplot(education21$X.E09211_小学校長期欠席児童比率.年度間30日以上..児童千人当たり.... ~
        education21$四捨五入された養育費割合,
        xlab = "教育費割合(%)",
        ylab = "小学校長期欠席児童比率(児童1000人当たり)",
        main = "教育費割合と小学校長期欠席児童比率の関係")


