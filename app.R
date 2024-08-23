source("data_cleaning.R")

thematic_shiny()

ui <- page_navbar(
  theme = bs_theme(preset = "minty"),
  tabPanel("Table 3",
  headerPanel("Table 3 - Characteristics of included studies"),
  reactableOutput("table3"),
  textInput("footnote", "Note. RCT: Randomised controlled trial. QE: Quasi-experimental. NE: Non-experimental. Nr: Not reported. SEM: Structural equation modelling.",
            width = "100%")),
  tabPanel("Table 4",
           headerPanel("Table 4 - Outcome of the quality appraisal across individual studies"),
           reactableOutput("Table4"),
           textInput("footnote", "Note. Studies with an asterisk(*) assessed dosage only; the maximum score they can receive across Section 2, and the checklist, is 12 and 29 respectively. All other studies can score 19 and 36 across Section 2 and the checklist respectively.",
                     width = "100%"))
)


server <- function(input, output) {
  output$table3 <- renderReactable({
    reactable(Table3,
              theme = default(centered = TRUE),
              filterable = TRUE,
              bordered = FALSE,
              striped = FALSE,
              highlight = TRUE,
              searchable = TRUE,
              defaultPageSize = 16,
              columns = list(
                Study_ID = colDef(
                  align = "center",
                  name = "Study ID",
                  cell = function(value, index) {
                    label1 <- DOITable[index, "Study_ID"] 
                    # had to create a separate file for the DOIs to 
                    # be read because I kept failing to get them using Table 3
                    DOI <- DOITable[index, "DOI"]
                    htmltools::div(
                      htmltools::p(
                        htmltools::tags$a(href = DOI,
                                          target = "_blank",
                                          label1)
                      ),
                    )
                  }
                ),
                DOI = colDef(
                  show = FALSE
                ),
                "First Author" = colDef(
                  align = "left"
                ),
                Year = colDef(
                  align = "center"
                ),
                Country = colDef(
                ),
                CountryFlag = colDef(
                  name = "",
                  maxWidth = 70,
                  align = "center",
                  cell = embed_img("Country",
                                   height = "25",
                                   width = "40")),
                Design = colDef(
                  align = "center"
                ),
                "Student Sample Size" = colDef(
                  align = "center",
                  minWidth = 160,
                  cell = data_bars(Table3,
                                   text_position = "outside-end",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)
                ),
                "Mean Age (years)" = colDef(
                  header = with_tooltip("Mean Age", 
                                        "Mean age in years"),
                  na = "–",
                  align = "center",
                  minWidth = 90,
                  cell = data_bars(Table3,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)
                ),
                "Age Range (years)" = colDef(
                  header = with_tooltip("Age Range", 
                                        "Age range in years"),
                  na = "–",
                  align = "center",
                  minWidth = 90
                ),
                Programme = colDef(
                  header = with_tooltip("Programme", 
                                        "Programme being delivered"),
                  align = "left",
                  minWidth = 220),
                "Implementation Dimensions" = colDef(
                  name = "Implementation Dimensions (IDs)",
                  align = "left",
                  minWidth = 250),
                "Length of Intervention Period (months)" = colDef(
                  header = with_tooltip("Duration", 
                                        "Length of intervention period in years"),
                  align = "center",
                  cell = data_bars(Table3,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)
                ),
                "Number of Implementation Dimensions" = colDef(
                  header = with_tooltip("Number of IDs", 
                                        "Number of Implementation Dimensions"),
                  align = "center",
                  minWidth = 125,
                  cell = data_bars(Table3,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)
                ),
                "Statistical Test" = colDef(
                  align = "left",
                  minWidth = 120
                )
              )
    )
  })
 
  output$Table4 <- renderReactable({
    reactable(Table4,
              theme = default(centered = TRUE),
              filterable = TRUE,
              bordered = FALSE,
              striped = FALSE,
              highlight = TRUE,
              searchable = TRUE,
              defaultPageSize = 16,
              columnGroups = list(
                colGroup(name = "Section Scores - Total Score",
                         columns = c("Section 1 - Study Design Score",
                                     "Section 2 - Implementation - Data Collection Score",
                                     "Section 3 - Implementation - Data Analysis Score")
                )
              ),
              columns = list(
                Study_ID = colDef(
                  align = "center",
                  maxWidth = 130,
                  name = "Study ID",
                  cell = function(value, index) {
                    label1 <- DOITable[index, "Study_ID"] # had to create a separate file for the DOIs to be read because I kept failing to get them using Table 4
                    DOI <- DOITable[index, "DOI"]
                    htmltools::div(
                      htmltools::p(
                        htmltools::tags$a(href = DOI, target = "_blank", label1)
                      ),
                    )
                  }
                ),
                "First Author" = colDef(
                  align = "left",
                  maxWidth = 130
                ),
                Year = colDef(
                  align = "center",
                  maxWidth = 130
                ),
                Country = colDef(
                  header = with_tooltip("Country", 
                                        "Country where data was collected"),
                  maxWidth = 130
                ),
                CountryFlag = colDef(
                  name = "",
                  maxWidth = 70,
                  align = "center",
                  cell = embed_img("Country",
                                   height = "25",
                                   width = "40")),
                "Total Score" = colDef(
                  align = "center",
                  header = with_tooltip("Total Score", 
                                        "Sum score of Sections 1, 2, and 3"),
                  cell = data_bars(Table4,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)
                ),
                "Percentage_Score" = colDef(
                  align = "center",
                  header = with_tooltip("Percentage Score", 
                                        "0-100%, with 100% being maximum possible score"),
                  cell = data_bars(Table4,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)
                ),
                "Section 1 - Study Design Score" = colDef(
                  align = "center",
                  header = with_tooltip(
                    "Section 1 Score", 
                    "Score assigned to Study Design"),
                  cell = data_bars(Table4,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)),
                "Section 2 - Implementation - Data Collection Score" = colDef(
                  align = "center",
                  header = with_tooltip(
                    "Section 2 Score", 
                    "Score assigned to Data Collection process"),
                  cell = data_bars(Table4,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)),
                "Section 3 - Implementation - Data Analysis Score" = colDef(
                  align = "center",
                  header = with_tooltip(
                    "Section 3 Score", 
                    "Score assigned to Data Analysis process"),
                  cell = data_bars(Table4,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)),
                "Classification" = colDef(
                  header = with_tooltip("Classification", "Overall classification"),
                  align = "center",
                  minWidth = 90,
                  cell = pill_buttons(Table4,
                                      color_ref = "Classification_colours", 
                                      opacity = 0.7),
                ),
                "Classification_colours" = colDef(
                  show = FALSE)
              )
    )
  })
   
}


# Run the application 
shinyApp(ui = ui, server = server)
