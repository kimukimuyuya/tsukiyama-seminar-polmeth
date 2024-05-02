x <- rep(NA, 5)

for (i in 1:5) {
  x[i] <- i * 2
}
x

set.seed(12345)

# 大数の法則
n <- 5000
sim <- rep(NA, n)

for (i in 1:n) {
  spl <- sample(c(1,0), i, replace = TRUE, prob = c(0.5, 0.5))
  sim[i] <- mean(spl)
}

plot(1:n, sim, type = "l", ylim = c(0, 1), xlab = "標本サイズ", ylab = "標本平均")
abline(h = 0.5, lty = "dotted", col = "red")

# 中心極限定理
n <-　100
k <- 5000
sim <- rep(NA, k)

for (i in 1:k) {
  spl <- sample(c(1,0), n, replace = TRUE, prob = c(0.5, 0.5))
  sim[i] <- mean(spl)
}

hist(sim, freq = FALSE, breaks = seq(0.25, 0.75, 0.02),
     xlim = c(0.3, 0.7), ylim = c(0, 8),
     xlab = "標本平均", main = "")
abline(v = 0.5, lty = "dotted", col = "red")
x <- seq(from = 0.3, to = 0.7, by = 0.005)
lines(x, dnorm(x, mean = 0.5, sd = sqrt(0.25 / n)), col = "blue")


# 実際のデータを用いてt検定
utasv <- read.csv("utasv.csv", fileEncoding = "SJIS", na.strings = c("NA", "", "66", "99", "999"))
utasv$W1Q16_2_R <- utasv$W1Q16_2
utasv$W1Q16_2_R[utasv$W1Q16_2 == 1] <- 5
utasv$W1Q16_2_R[utasv$W1Q16_2 == 2] <- 4
utasv$W1Q16_2_R[utasv$W1Q16_2 == 4] <- 2
utasv$W1Q16_2_R[utasv$W1Q16_2 == 5] <- 1

tapply(utasv$W1Q16_2_R, utasv$W1F1, mean, na.rm = TRUE)
t.test(utasv$W1Q16_2_R ~ utasv$W1F1)