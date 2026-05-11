data <- read.csv("Student_Performance.csv")
data <- data[1:30, ]

tabel <- data[, c("Previous.Scores", "Performance.Index")]

cat("\n====================================\n")
cat("     PREVIOUS SCORES DATA\n")
cat("====================================\n\n")

print(tabel)

data$Previous.Group <- cut(
  data$Previous.Scores,
  breaks = c(0,59,79,100),
  labels = c("Rendah","Sedang","Tinggi")
)

cat("\n====================================\n")
cat("      JUMLAH KELOMPOK\n")
cat("====================================\n\n")

print(table(data$Previous.Group))

cat("\n====================================\n")
cat("       UJI NORMALITAS\n")
cat("====================================\n\n")

print(shapiro.test(data$Performance.Index))

cat("\n====================================\n")
cat("         HASIL ANOVA\n")
cat("====================================\n\n")

anova_previous <- aov(
  Performance.Index ~ Previous.Group,
  data = data
)

hasil_previous <- summary(anova_previous)

print(hasil_previous)

cat("\n====================================\n")
cat("         TUKEY HSD\n")
cat("====================================\n\n")

print(TukeyHSD(anova_previous))

p_previous <- hasil_previous[[1]][["Pr(>F)"]][1]

cat("\n====================================\n")
cat("          KESIMPULAN\n")
cat("====================================\n\n")

cat("P-Value :", p_previous, "\n\n")

if (p_previous < 0.05) {

  cat("Karena p-value < 0.05\n")
  cat("Maka H0 ditolak.\n")
  cat("Previous Scores berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n")

} else {

  cat("Karena p-value > 0.05\n")
  cat("Maka H0 gagal ditolak.\n")
  cat("Previous Scores tidak berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n")

}