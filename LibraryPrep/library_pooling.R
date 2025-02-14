library_pooling <- list(
  list(
    step     = "Pool all barcoded samples in equimolar ratios (use the dynamic table below) in a 1.5 ml Eppendorf DNA LoBind tube.",
    note     = "Note: Please ensure you have quantified your samples prior to this step and take forward an equimolar concentration of each of the samples for optimal barcode balancing. Samples may vary in concentration following the barcoded PCR, therefore the volume of each barcoded sample added to the pool will be different.",
    substeps = list(NULL),
    element  = tagList(reactableOutput("pooling_ratios"))
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))