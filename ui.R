
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  titlePanel("Dumbledore's Army Data Product"),
  
             fluidRow(
               column(6,
                      h3("Employee Information"),
                      textInput(inputId = "name",label = "Name"),
                      textInput(inputId = "last_evaluation",label = "Last Evaluation(0-1)"),
                      numericInput(inputId = "number_project",label = "Number of Poject(0-10integer)",value = 0,min=0,max=10),
                      textInput(inputId = "average_montly_hours",label = "Average Montly Hours"),
                      textInput(inputId = "time_spend_company",label = "Time Spend in the Company(years)"),
                      selectInput(inputId = "sales",label = "Apartment",c("accounting"="accounting","hr"="hr","IT"="IT","management"="management","marketing"="marketing","product_mng"="product_mng","RandD"="RandD","sales"="sales","support"="support","technical"="technical")),
                      br(),
                      actionButton(inputId ="estimate" ,label="calculate"),
                      br(),
                      br(),
                      h5("Estimation of Satisfaction Level:"),
                      verbatimTextOutput("estimation")
               ),
               column(5, offset = 1,
                      br(),
                      br(),
                      p("For an introduction, visit the ",
                        a("User Guide.", 
                          href = "https://echolinr.github.io/#/projects/project_a")),
                      br(),
                      radioButtons(inputId = "Work_accident",label = "Work Accident",c("Yes"="Yes","No"="No")),
                      br(),
                      radioButtons(inputId = "left",label = "left",c("Yes"="Yes","No"="No")),
                      br(),
                      radioButtons(inputId = "promotion_last_5years",label = "Promotion within last 5 years",c("Yes"="Yes","No"="No")),
                      br(),
                      radioButtons(inputId = "salary",label = "Salary",c("low","medium","high")),
                      br(),
                      actionButton(inputId ="add" ,label="Add into the Dataset"),
                      br(),
                      br(),
                      textOutput("result")
                      
               )
             ), 
             br(),
             br(),
             br(),
             br(),
             fluidRow(
               column(6,
                      h3("Feedback"),
                      br(),
                      textInput(inputId = "company",label = "Company Name"),
                      textInput(inputId = "email",label = "Email Address"),
                      br()
               ),
               column(5, offset = 1,
                      br(),
                      br(),
                      br(),
                      sliderInput(inputId = "score",label = "Grade the Product",value = 6 ,min = 0,max=10),
                      textInput(inputId = "comment",label = "Comments")
               )
             ),
             actionButton(inputId = "feedback",label = "Submit"),
             br(),
             br(),
             textOutput("fb"),
             br(),
             br()
 
))
