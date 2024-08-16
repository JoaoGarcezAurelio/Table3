source("data_cleaning.R")

thematic_shiny()

ui <- page_fluid(
  theme = bs_theme(preset = "minty"),
  headerPanel("Table 3 - Characteristics of included studies"),
  reactableOutput("table3"),
  textInput("footnote", "Note. RCT: Randomised controlled trial. QE: Quasi-experimental. NE: Non-experimental. Nr: Not reported. SEM: Structural equation modelling.",
            width = "100%")
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
  
}


# Run the application 
shinyApp(ui = ui, server = server)
