# ==============================
# ANALISIS ANOVA STUDENT PERFORMANCE
# ==============================

# Membaca dataset
data <- read.csv("Student_Performance.csv")

# Mengambil 30 data pertama
data <- data[1:30, ]

# ==============================
# TABEL DATA
# ==============================

cat("\n====================================\n")
cat("        TABEL DATA X DAN Y\n")
cat("====================================\n\n")

tabel_xy <- data[, c("Hours.Studied", "Performance.Index")]
print(tabel_xy)

# ==============================
# MEMBUAT KELOMPOK
# ==============================

data$Kelompok <- cut(
  data$Hours.Studied,
  breaks = c(0, 3, 6, 10),
  labels = c("Rendah", "Sedang", "Tinggi")
)

cat("\n====================================\n")
cat("        JUMLAH TIAP KELOMPOK\n")
cat("====================================\n\n")

print(table(data$Kelompok))

# ==============================
# UJI NORMALITAS
# ==============================

cat("\n====================================\n")
cat("          UJI NORMALITAS\n")
cat("====================================\n\n")

normalitas <- shapiro.test(data$Performance.Index)
print(normalitas)

# ==============================
# UJI HOMOGENITAS
# ==============================

cat("\n====================================\n")
cat("         UJI HOMOGENITAS\n")
cat("====================================\n\n")

homogenitas <- bartlett.test(
  Performance.Index ~ Kelompok,
  data = data
)

print(homogenitas)

# ==============================
# UJI ANOVA
# ==============================

cat("\n====================================\n")
cat("            HASIL ANOVA\n")
cat("====================================\n\n")

anova_model <- aov(
  Performance.Index ~ Kelompok,
  data = data
)

print(summary(anova_model))

# ==============================
# UJI LANJUT TUKEY HSD
# ==============================

cat("\n====================================\n")
cat("          UJI TUKEY HSD\n")
cat("====================================\n\n")

print(TukeyHSD(anova_model))

# ==============================
# KESIMPULAN
# ==============================

cat("\n====================================\n")
cat("             KESIMPULAN\n")
cat("====================================\n\n")

p_value <- summary(anova_model)[[1]][["Pr(>F)"]][1]

if (p_value < 0.05) {
  cat("Karena p-value <", 0.05, "\n")
  cat("Maka H0 ditolak.\n")
  cat("Terdapat perbedaan rata-rata Performance Index\n")
  cat("antar kelompok jam belajar.\n")
} else {
  cat("Karena p-value >", 0.05, "\n")
  cat("Maka H0 gagal ditolak.\n")
  cat("Tidak terdapat perbedaan rata-rata\n")
  cat("Performance Index yang signifikan\n")
  cat("antar kelompok jam belajar.\n")
}