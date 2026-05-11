data <- read.csv("Student_Performance.csv")

data <- data[1:30, ]

tabel <- data[, c("Hours.Studied", "Performance.Index")]

cat("\n====================================\n")
cat("      HOURS STUDIED DATA\n")
cat("====================================\n\n")

print(tabel)

data$Hours.Group <- cut(
  data$Hours.Studied,
  breaks = c(0,3,6,10),
  labels = c("Rendah","Sedang","Tinggi")
)

cat("\n====================================\n")
cat("      JUMLAH KELOMPOK\n")
cat("====================================\n\n")

print(table(data$Hours.Group))

cat("\n====================================\n")
cat("       UJI NORMALITAS\n")
cat("====================================\n\n")

print(shapiro.test(data$Performance.Index))

cat("\n====================================\n")
cat("         HASIL ANOVA\n")
cat("====================================\n\n")

anova_hours <- aov(
  Performance.Index ~ Hours.Group,
  data = data
)

hasil_hours <- summary(anova_hours)

print(hasil_hours)

cat("\n====================================\n")
cat("         TUKEY HSD\n")
cat("====================================\n\n")

print(TukeyHSD(anova_hours))

p_hours <- hasil_hours[[1]][["Pr(>F)"]][1]

cat("\n====================================\n")
cat("          KESIMPULAN\n")
cat("====================================\n\n")

cat("P-Value :", p_hours, "\n\n")

if (p_hours < 0.05) {

  cat("Karena p-value < 0.05\n")
  cat("Maka H0 ditolak.\n")
  cat("Hours Studied berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n")

} else {

  cat("Karena p-value > 0.05\n")
  cat("Maka H0 gagal ditolak.\n")
  cat("Hours Studied tidak berpengaruh signifikan\n")
  cat("terhadap Performance Index.\n")

}