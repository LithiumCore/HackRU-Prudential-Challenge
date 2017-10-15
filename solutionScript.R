HackRU_train$LowestRisk = as.character(HackRU_train$LowestRisk)
HackRU_test$LowestRisk = as.character(HackRU_test$LowestRisk)


lowWeight <- subset(HackRU_train, Wt < 0.5)
highWeight <- subset(HackRU_train, Wt >= 0.5)
lowWeight$LowestRisk <- predict(model.rf, newdata = lowWeight)
highWeight$LowestRisk <- "Not Lowest Risk"

model.rf<- randomForest(LowestRisk ~ BMI + Wt + Medical_History_23 + Medical_History_4 + Medical_Keyword_15 + Medical_History_15 + Product_Info_4, data = lowWeight)

lowWeightT <- subset(HackRU_test, Wt < 0.5)
highWeightT <- subset(HackRU_test, Wt >= 0.5)
lowWeightT$LowestRisk <- predict(model.rf, newdata = lowWeightT)
highWeightT$LowestRisk <- "Not Lowest Risk"

final <- rbind(lowWeightT, highWeightT)
final <- final[c(1,128)]
finalTrain <- finalTrain[c(1,129)]
finalCombo <- rbind(final, finalTrain)
final$LowestRisk = as.character(final$LowestRisk)
final$LowestRisk[final$LowestRisk == "Not Lowest Risk"] <- 0
final$LowestRisk[final$LowestRisk == "Lowest Risk"] <- 1
final$LowestRisk = as.numeric(final$LowestRisk)

finalCombo$LowestRisk = as.character(finalCombo$LowestRisk)
finalCombo$LowestRisk[finalCombo$LowestRisk == "Not Lowest Risk"] <- 0
finalCombo$LowestRisk[finalCombo$LowestRisk == "Lowest Risk"] <- 1
finalCombo$LowestRisk = as.numeric(finalCombo$LowestRisk)
write.csv(final, file = "testSolution.csv")
write.csv(finalCombo, file = "fullSolution.csv")