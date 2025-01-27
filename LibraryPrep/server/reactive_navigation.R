
navigate <- function(input, setup) {
  
  nav_select("setup.nav", "basics")
  nav_hide("setup.nav", "samples")
  nav_hide("setup.nav", "barcodes")
  nav_hide("setup.nav", "lsk_input")
  nav_hide("setup.nav", "setup")
  nav_hide("setup.nav", "conclude")
  nav_hide("main.nav" , "part1" )
  nav_hide("main.nav" , "part2" )
  nav_hide("main.nav" , "part3" )
  
  observeEvent(input$basics_done, {
    nav_show("setup.nav", "samples", select = TRUE)
    nav_hide("setup.nav", "basics")
  })
  
  observeEvent(input$confirm_samples, {
    accordion_panel_open("samples_selected", "review_samples")
  })
  
  observeEvent(input$samples_done, {
    nav_hide("setup.nav", "samples")
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      nav_show("setup.nav", "barcodes", select = TRUE)
      nav_remove("setup.nav", "lsk_input")
    } else if (setup$workflow == "lsk") {
      nav_select("setup.nav", "lsk_input", select = TRUE)
      nav_remove("setup.nav", "barcodes")
    }
  })
  
  observeEvent(input$barcode_cols_confirm, {
    accordion_panel_open("barcode_tables", "barcodes_b")
    
  })
  
  observeEvent(input$barcode_wells_confirm, {
    accordion_panel_open("barcode_tables", "barcodes_c")
  })
  
  observeEvent(input$dynamic_done, {
    nav_show("setup.nav", "setup", select = TRUE)
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      nav_hide("setup.nav", "barcodes")
    } else if (setup$workflow == "lsk") {
      nav_hide("setup.nav", "lsk_input")
    }
  })
  
  observeEvent(input$setup_done, {
    nav_hide("setup.nav", "setup")
    nav_show( "main.nav" , "part3", select = FALSE )
    nav_show( "main.nav" , "part2", select = FALSE )
    nav_show( "main.nav" , "part1", select = TRUE)
    nav_select( "main.nav" , "part1")
  }, ignoreInit = FALSE)
  
  tab.link <- function(tab1, tab2, input, nav_id = "main.nav") {
    observeEvent(input[[paste0(tab1, "_done")]], {
      req(nav_id, tab2) 
      nav_select(nav_id, tab2)
    }, ignoreInit = FALSE)
  }
  tab.link("part1" , "part2"  , input)
  tab.link("part2" , "part3"  , input)
  
  observeEvent(input$part3_done, {
    nav_hide("main.nav" , "part1" )
    nav_hide("main.nav" , "part2" )
    nav_hide("main.nav" , "part3" )
    nav_show("setup.nav", "conclude")
    nav_select( "setup.nav" , "conclude" )
  })
}

