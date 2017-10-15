# begin by running a quick rpart to determine key variables
baseModel <- rpart(LowestRisk ~. -Approved -Id -X1, data = train)
#
# use summary to find key variables for the model, then futher analyze these particular variables
summary(baseModel)

#Variable importance
#BMI                 Wt Medical_History_23 Medical_Keyword_15  Medical_History_4 
#28                 15                 14                 12                 11 
#Medical_History_15     Product_Info_4  Medical_Keyword_3 Medical_Keyword_48  Medical_History_6 
#5                  3                  2                  2                  2 
#Medical_History_24 Medical_Keyword_23 Medical_History_33 Medical_Keyword_25 Medical_Keyword_12 
#1                  1                  1                  1                  1 
#Medical_History_32 
#1

#Let's start plotting to get a stronger pulse on the data! I'm using pirateplot, which is an awesome R library that creates RDI plots, and mosaicplot
#With these tools, we can create visualizations that will be able to determine major differenators that make a client "Lowest Risk"
mosaicplot(Approved ~ LowestRisk, data = train, main = "Approval VS Risk Factor", color = c("green", "red"))
pirateplot(Wt ~ LowestRisk, data = train, main = "Lowest Risk vs Weight")

#One major differentiator: weight! If a person's normalized weight is greater than 0.5, we can see that there is no way they can be considered "Lowest Risk"
#With this established, we can subset those under 0.5 normalized weight, and conduct further analysis on these particular applicants

lowWeight <- subset(train, Wt < 0.5)
