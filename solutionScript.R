model.rf<- randomForest(LowestRisk ~ BMI + Wt + Medical_History_23 + Medical_History_4 + Medical_Keyword_15 + Medical_History_15 + Product_Info_4, data = lowWeight)

lowWeightT <- subset(HackRU_test, Wt < 0.5)
highWeightT <- subset(HackRU_test, Wt >= 0.5)
lowWeightT$LowestRisk <- predict(model.rf, newdata = lowWeightT)
highWeightT$LowestRisk <- "Not Lowest Risk"

final <- rbind(lowWeightT, highWeightT)
final <- final[c(1,128)]
final$LowestRisk = as.character(final$LowestRisk)
final$LowestRisk[final$LowestRisk == "Not Lowest Risk"] <- 0
final$LowestRisk[final$LowestRisk == "Lowest Risk"] <- 1
final$LowestRisk = as.numeric(final$LowestRisk)

write.csv(final, file = "solution.csv")