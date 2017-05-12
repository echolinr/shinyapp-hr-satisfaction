
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
#install.packages("randomForest")
library(randomForest)

HR<-read.csv("./HR_comma_sep.csv")
attach(HR)
set.seed(1)
trainsample=sample(dim(HR)[1],dim(HR)[1] * 0.5)
model_rf = randomForest(satisfaction_level~number_project+time_spend_company+average_montly_hours+last_evaluation, data=HR, nsize=20, ntree=200, subset=trainsample)
summary(HR)

fb<-read.csv("./feedback.csv")
fb<-fb[,2:10]


shinyServer(function(input, output) {

  data <-eventReactive(input$estimate,{
    temp<-data.frame(number_project=c(input$number_project),
                     time_spend_company=c(as.numeric(sub(",", ".",input$time_spend_company))),
                     average_montly_hours=c(as.numeric(sub(",", ".",input$average_montly_hours))),
                     last_evaluation=c(as.numeric(sub(",", ".",input$last_evaluation))))
    predicted<-predict(model_rf,temp)
    num<-as.numeric(sub(",", ".",predicted))
    num
  })
  output$estimation <- renderPrint({
    data()
  })
  
  data2 <-eventReactive(input$add,{
    wc=c("No","Yes")
    l=c("No","Yes")
    ply=c("No","Yes")
    
    temp3<-data.frame(number_project=c(input$number_project),
                     time_spend_company=c(as.numeric(sub(",", ".",input$time_spend_company))),
                     average_montly_hours=c(as.numeric(sub(",", ".",input$average_montly_hours))),
                     last_evaluation=c(as.numeric(sub(",", ".",input$last_evaluation))))
    predicted3<-predict(model_rf,temp3)
    num3<-as.numeric(sub(",", ".",predicted3))
    
    record<-data.frame(number_project=c(input$number_project),
                     time_spend_company=c(as.numeric(sub(",", ".",input$time_spend_company))),
                     average_montly_hours=c(as.numeric(sub(",", ".",input$average_montly_hours))),
                     satisfaction_level=c(num3),
                     last_evaluation=c(as.numeric(sub(",", ".",input$last_evaluation))),
                     Work_accident=c(which(input$Work_accident==wc)-1),
                     left=c(which(input$left==l)-1),
                     promotion_last_5years=c(which(input$promotion_last_5years==ply)-1),
                     sales=c(input$sales),
                     salary=c(input$salary))
    HR<-rbind(HR,record)
    "success!"
  })
  
  output$result <- renderText(data2())
  
  data3 <-eventReactive(input$feedback,{
    temp4<-data.frame(number_project=c(input$number_project),
                      time_spend_company=c(as.numeric(sub(",", ".",input$time_spend_company))),
                      average_montly_hours=c(as.numeric(sub(",", ".",input$average_montly_hours))),
                      last_evaluation=c(as.numeric(sub(",", ".",input$last_evaluation))))
    predicted4<-predict(model_rf,temp4)
    num4<-as.numeric(sub(",", ".",predicted4))
    feedback<-data.frame(company=c(input$company),
                         email=c(input$email),
                         grade=c(input$score),
                         comment=c(input$comment),
                         number_project=c(input$number_project),
                         time_spend_company=c(as.numeric(sub(",", ".",input$time_spend_company))),
                         average_montly_hours=c(as.numeric(sub(",", ".",input$average_montly_hours))),
                         last_evaluation=c(as.numeric(sub(",", ".",input$last_evaluation))),
                         satisfaction_level=c(num4))
    fb<-rbind(fb,feedback)
    write.csv(fb,file = "./feedback.csv")
    "Thank you!"
  })
  
  output$fb <- renderText(data3())
  

})
