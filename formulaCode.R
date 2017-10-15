partition<- function(dataset, splitpercent, seed){
  #Used to generate a random split in a dataset
  #splitpercent = percent given to training, remaining is given to testing set
  #seed = generates the random split. allows for the process to be replicated as needed
  smp_size = floor(splitpercent * nrow(dataset))
  set.seed(seed)
  train_ind <- sample(seq_len(nrow(dataset)), size = smp_size)
  
  train <- dataset[train_ind, ]
  test <- dataset[-train_ind, ]
  return(list("training" = train, "testing" = test))
}

currentbestformula <- function(trainset, testset){
  trainset1x2 <- trainset
  trainset1x2$INPUT1x2 <- trainset$INPUT1 * trainsetINPUT2
  
}

linModel <- function(trainset, testset){
  perf.lm <- lm(OUTPUT ~ . , data = trainset)
  trainpred.lm <- predict(perf.lm, newdata = trainset) 
  pred.lm <- predict(perf.lm, newdata = testset)
  trainperf <- mean((trainpred.lm - trainset$OUTPUT)^2)
  testperf <- mean((pred.lm - testset$OUTPUT)^2)
  print(perf.lm)
  print(trainperf)
  print(testperf)
}

randForest <- function(trainset, testset){
  tree.rf = randomForest(OUTPUT ~ ., data = trainset)
  trainpred.rf <- predict(tree.rf, newdata = trainset)
  pred.rf = predict(tree.rf, newdata = testset)
  trainperf <- mean((trainpred.rf - trainset$OUTPUT)^2)
  testperf<- mean((pred.rf-testset$OUTPUT)^2)
  print(trainperf)
  print(testperf)
  return(tree.rf)
}

ldatest <- function(trainset, testset){
  #lda = linear discriminant analysis
  tree.lda = lda(OUTPUT ~ ., data = trainset)
  trainpred.lda <- predict(tree.lda, newdata = trainset)$class
  trainpred.lda <- as.numeric(trainpred.lda)
  pred.lda = predict(tree.lda, newdata = testset)$class
  pred.lda = as.numeric(pred.lda)
  trainperf <- mean((trainpred.lda - trainset$OUTPUT)^2)
  testperf<- mean((pred.lda-testset$OUTPUT)^2)
  print(trainperf)
  print(testperf)
}

svmtest <- function(trainset, testset){
  # support vector machine, e1071
  tree.svm = svm(OUTPUT ~ ., data = trainset)
  trainpred.svm = predict(tree.svm, newdata = trainset)
  pred.svm = predict(tree.svm, newdata = testset)
  trainperf <- mean((trainpred.svm - trainset$OUTPUT)^2)
  testperf<- mean((pred.svm - testset$OUTPUT)^2)
  print(tree.svm)
  print(trainperf)
  print(testperf)
}

neuraltest <- function(trainset, testset){
  #nnet 
  perf.nn = nnet(OUTPUT/250 ~. , data = trainset, size = 10)
  trainpred.nn = predict(perf.nn, newdata = trainset) * 250
  pred.nn = predict(perf.nn, newdata = testset) * 250
  trainperf <- mean((trainpred.nn - trainset$OUTPUT)^2)
  testperf <- mean((pred.nn-testset$OUTPUT)^2)
  print(perf.nn)
  print(trainperf)
  print(testperf)
}

naivetest <- function(trainset, testset){
  #naive bayes
  train$OUTPUT <- factor(train$OUTPUT)
  test$OUTPUT <- factor(test$OUTPUT)
  perf.nb <- naiveBayes(OUTPUT ~., data = trainset)
  trainpred.nb <- predict(perf.nb, newdata = trainset)
  pred.nb <- predict(perf.nb, newdata = testset)
  trainperf <- mean((trainpred.nb - trainset$OUTPUT)^2)
  testperf <- mean((pred.nb - testset$OUTPUT)^2)
  print(trainperf)
  print(testperf)
}