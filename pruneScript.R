for(i in 3:127){
  print(colnames(lowWeight[i]))
  print(table(lowWeight[, i], lowWeight$LowestRisk))
}

BMI                 Wt Medical_History_23 
28                 14                 14 
Medical_History_4 Medical_Keyword_15 Medical_History_15 
12                 12                  5 
Product_Info_4  Medical_Keyword_3 Medical_History_24 
3                  2                  2 
Medical_Keyword_23 Medical_History_33 Medical_Keyword_48 
2                  2                  1 
Medical_History_6 Medical_Keyword_25 Medical_Keyword_12 
1                  1                  1 
Medical_History_32 
1