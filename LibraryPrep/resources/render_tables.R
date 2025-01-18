# Rapid 16S

output$card_I.1. <- renderUI(reactableOutput("table_I.1."))


output$card_I.6. <- renderUI(reactableOutput("I.6.16sPCR"))

output$card_I.8. <- renderUI(reactableOutput("I.8.barcodes"))


output$card_II.4. <- renderUI("II.4.qc1_values")

output$card_II.5. <- renderUI(reactableOutput("II.5.pooling_ratios"))

output$card_II.4. <- renderUI("II.4.bead_volume")

output$card_II.17. <- renderUI("II.17.qc2_values")


table_I.1.   <- renderReactable({
  reactable(
    isolate(samples$calculations),
    columns = cols_I.1.
    
  )
})

table_I.5.   <- renderReactable({
  reactable(
    isolate(samples$calculations),
    columns = cols_I.5.
    
  )
})


table_I.10.  <- render_gt(expr = rap16s_cycles)
table_II.1.  <- render_gt(expr = part2_reagents_rap16s)
table_II.19. <- render_gt(expr = rxn_rapadapt)

part3 sequencing mix 

card(
card_header("IMPORTANT"),
"Take care when drawing back buffer from the flow cell. Do not remove more
than 20-30 µl, and make sure that the array of pores are covered by buffer
at all times. Introducing air bubbles into the array can irreversibly damage
pores."
)


card(
  card_header("IMPORTANT"),
  tags$h5("The Library Beads (LIB) tube contains a suspension of beads. These beads
settle very quickly. It is vital that they are mixed immediately before use."),
  "We recommend using the Library Beads (LIB) for most sequencing experiments. However,
the Library Solution (LIS) is available for more viscous libraries."
)


