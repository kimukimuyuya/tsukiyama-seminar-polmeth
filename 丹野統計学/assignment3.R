library(splancs)
data(burkitt)
print(burkitt)

# 座標データの準備
coordinates <- cbind(burkitt$x, burkitt$y)

# 観測領域の設定 (データの範囲を自動計算)
Poly <- bboxx(bbox(as.points(coordinates)))

# 点パターンのプロット
x11(); par(mfrow=c(2,2),mar=c(2,2,2,0.5))
polymap(Poly) #観察境界をプロット
points(coordinates, pch = 16) #点のプロット


# L関数の計算
Kyori_r <- seq(0, 200, by = 5)
L <- cbind(Kyori_r, sqrt(khat(pts = coordinates, poly = Poly, s = Kyori_r) / pi) - Kyori_r)
plot(L, ylim = c(-20, 20))

#シミュレーション・エンベロープの計算と図示
Kfunciton_Sim <- Kenv.csr(nptg = length(burkitt$x), poly = Poly, nsim = 19, s = Kyori_r)
lines(Kyori_r, sqrt(Kfunciton_Sim$lower/pi)-Kyori_r)
lines(Kyori_r, sqrt(Kfunciton_Sim$upper/pi)-Kyori_r)


# 10歳未満とそれ以上に分割
under_10 <- burkitt[burkitt$age < 10, ]
over_10 <- burkitt[burkitt$age >= 10, ]

# 各グループの座標データ
coords_under_10 <- cbind(under_10$x, under_10$y)
coords_over_10 <- cbind(over_10$x, over_10$y)

Kyori_r <- seq(5,100,5) 
Poly2 <- bboxx(bbox(as.points(list(x = c(under_10$x, over_10$x), y = c(under_10$y, over_10$y)))))
x11(); par(mfrow=c(2,2),mar=c(2,2,2,0.5))
polymap(Poly2)
points(coords_under_10, pch = 16, col = 1)
points(coords_over_10, pch = 16, col = 2)

K1 <- khat(pts = coords_under_10, poly = Poly2, s = Kyori_r)
K2 <- khat(pts = coords_over_10, poly = Poly2, s = Kyori_r)
Kdiff <- K1 - K2
plot(Kyori_r,Kdiff,ylim=c(-3000,3000))

Kfunction_Sim1 <- Kenv.label(pts1 = as.points(coords_under_10), pts2 = as.points(coords_over_10), poly = Poly2, nsim = 19, s = Kyori_r)
lines(Kyori_r, Kfunction_Sim1$upper, col = 1)
lines(Kyori_r, Kfunction_Sim1$lower, col = 1)


# 10歳未満のL関数
L_under_10 <- cbind(Kyori_r, sqrt(khat(pts = coords_under_10, poly = Poly, s = Kyori_r) / pi) - Kyori_r)

# 10歳以上のL関数
L_over_10 <- cbind(Kyori_r, sqrt(khat(pts = coords_over_10, poly = Poly, s = Kyori_r) / pi) - Kyori_r)

# プロット
plot(L_under_10, type = "l", col = "red", ylim = c(-20, 20), main = "L関数によるパターンの比較", xlab = "距離 (r)", ylab = "L(r)")
lines(L_over_10, col = "blue")
legend("topright", legend = c("10歳未満", "10歳以上"), col = c("red", "blue"), lty = 1)
