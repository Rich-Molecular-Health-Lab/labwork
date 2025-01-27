
protocols <- list(
    lsk = list(
      "name" = "Singleplex Ligation Sequencing",
      "N"          = 1,
      "Input_ng"   = 1000,
      "Input_ul"   = 47,
      "kit"        = LSK114,
      "PCR"        = "no",
      "multiplex"  = "no",
      "expansion"  = NEBNextv2,
      "parts"      = list(
        sample_prep$default,
        endprep$default,
        cleanup$default,
        qc$qubit$default,
        adapter$default,
        cleanup$default,
        qc$qubit$default
      )
    ),
    lsk96 = list(
      "name"    = "Multiplex PCR Ligation Sequencing",
      "N"          = 96,
      "Input_ng"   = 1,
      "Input_ul"   = 21,
      "kit"        = LSK114,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = c(PBC096, LongAmp),
      "parts"      = list(
        sample_prep$default,
        preamplify$tailed,
        cleanup$default,
        qc$qubit$default,
        barcoding$ligation,
        cleanup$default,
        qc$qubit$default,
        preamplify$barcodes,
        cleanup$default,
        qc$qubit$default,
        pooling$default,
        endprep$pooled,
        cleanup$pooled,
        qc$qubit$pooled,
        adapter$pooled,
        cleanup$pooled,
        qc$qubit$pooled
      )
    ),
    lskCultMDA = list(
      "name"    = "WG MDA Ligation Sequencing Direct from Culture",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = LSK114,
      "PCR"        = "yes",
      "multiplex"  = "no",
      "expansion"  = c(scREPLI, NEBNextv2),
      "parts"      = list(
        sampleprep$cultures,
        REPLIgMDA$sc,
        cleanup$default,
        qc$qubit$default,
        cleanup$postMDA,
        qc$qubit$default,
        endprep$default,
        cleanup$default,
        qc$qubit$default,
        adapter$default,
        cleanup$default,
        qc$qubit$default
      )
    ),
    lskBacMDA = list(
      "name"    = "Whole Bacterial Genome MDA Ligation Sequencing",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = LSK114,
      "PCR"        = "yes",
      "multiplex"  = "no",
      "expansion"  = c(scREPLI, NEBNextv2),
      "parts"      = list(
        sampleprep$default,
        REPLIgMDA$sc,
        cleanup$default,
        qc$qubit$default,
        cleanup$postMDA,
        qc$qubit$default,
        endprep$default,
        cleanup$default,
        qc$qubit$default,
        adapter$default,
        cleanup$default,
        qc$qubit$default
      )
    ),
    rapBacMDA = list(
      "name"    = "Whole Bacterial Genome MDA Rapid PCR Barcoding",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = c(scREPLI, LongAmp),
      "parts"      = list(
        sampleprep$cultures,
        REPLIgMDA$sc,
        cleanup$default,
        qc$qubit$default,
        cleanup$postMDA,
        qc$qubit$default,
        barcoding$rapid,
        pooling$default,
        cleanup$pooled,
        qc$qubit$pooled,
        adapter$rapid
      )
    ),
    rapMtMDA = list(
      "name"    = "Whole Mitochondrial Genome MDA Rapid PCR Barcoding",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = c(mtREPLI, LongAmp),
      "parts"      = list(
        sampleprep$default,
        REPLIgMDA$mt,
        cleanup$default,
        qc$qubit$default,
        cleanup$postMDA,
        qc$qubit$default,
        barcoding$rapid,
        pooling$default,
        cleanup$pooled,
        qc$qubit$pooled,
        adapter$rapid
      )
    ),
    lskMtMDA = list(
      "name"    = "Whole Mitochondrial Genome MDA Ligation Sequencing",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 20,
      "kit"        = LSK114,
      "PCR"        = "yes",
      "multiplex"  = "no",
      "expansion"  = c(mtREPLI, NEBNextv2),
      "parts"      = list(
        sampleprep$default,
        REPLIgMDA$mt,
        cleanup$default,
        qc$qubit$default,
        cleanup$postMDA,
        qc$qubit$default,
        endprep$default,
        cleanup$default,
        qc$qubit$default,
        adapter$default,
        cleanup$default,
        qc$qubit$default
      )
    ),
    rapid16s = list(
      "name" = "16S Rapid Barcoding",
      "N"          = 24,
      "Input_ng"   = 10,
      "Input_ul"   = 15,
      "kit"        = rap16S114,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = LongAmp,
      "parts"      = list(
        sample_prep$default,
        barcoding$rap16s,
        qc$qubit$default,
        cleanup$pooled,
        qc$qubit$pooled,
        adapter$rapid
      )
    ),
    rapidSeq = list(
      "name" = "Rapid Singleplex Sequencing",
      "N"          = 1,
      "Input_ng"   = 100,
      "Input_ul"   = 10,
      "kit"        = RAD114,
      "PCR"        = "no",
      "multiplex"  = "no",
      "expansion"  = NULL,
      "extras"     = NULL,
      "parts"      = list(
        sample_prep$default,
        tagment$default,
        adapter$rapid
      )
    ),
    rapid24 = list(
      "name" = "Rapid Barcoding",
      "N"          = 24,
      "Input_ng"   = 200,
      "Input_ul"   = 10,
      "kit"        = RBK114_24,
      "PCR"        = "no",
      "multiplex"  = "yes",
      "expansion"  = NULL,
      "extras"     = NULL,
      "parts"      = list(
        sample_prep$default,
        barcoding$rapid,
        pooling$default,
        cleanup$pooled,
        qc$qubit$pooled,
        adapter$rapid
      )
    ),
    rapidPCR = list(
      "name" = "Rapid HMW PCR Barcoding",
      "N"          = 24,
      "Input_ng"   = 1,
      "Input_ul"   = 3,
      "kit"        = RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = LongAmp,
      "parts"      = list(
        sample_prep$default,
        tagment$default,
        barcoding$pcr,
        qc$qubit$default,
        pooling$default,
        cleanup$pooled,
        qc$qubit$pooled,
        adapter$rapid
      )
    ),
    rapidColPCR = list(
      "name" = "Rapid Bacterial Colony PCR Barcoding",
      "N"          = 24,
      "Input_ng"   = 1,
      "Input_ul"   = 3,
      "kit"        = RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = LongAmp,
      "parts"      = list(
        sample_prep$colonies,
        tagment$default,
        barcoding$pcr,
        qc$qubit$default,
        pooling$default,
        cleanup$pooled,
        qc$qubit$pooled,
        adapter$rapid
      )
    )
  )


inputs <- list(
  colony = list(
    "name"       = "Plated Bacterial Colonies",
    "protocols"  = rapidColPCR,
    "extraction" = c(colBacRapid, colBacMDA)
  ),
  culture = list(
    "name"       = "Bacterial Cultures stored in liquid medium",
    "protocols"  = c(lskCultMDA, rapBacMDA),
    "extraction" = culBacMDA
  ),
  extractMixed = list(
    "name"       = "Variable Length DNA Extract",
    "protocols"  = c(rapid16s, lsk, lsk96, lskBacMDA, lskMtMDA, rapidSeq, rapMtMDA, rapid24),
    "extraction" = c(cultBacBash, fecBacBash, fecHostBash, fecMag)
  ),
  extractShort = list(
    "name"       = "Fragmented DNA Extract",
    "protocols"  = c(rapid16s, lsk, lsk96),
    "extraction" = c(cultBacBash, fecBacBash, fecHostBash)
  ),
  extractLong = list(
    "name"       = "HMW Intact DNA Extract",
    "protocols"  = rapidPCR,
    "extraction" = c(fecHMW, culHMW)
  ),
  amplicons = list(
    "name"       = "Amplicons Purified post-PCR",
    "protocols"  = c(lsk, lsk96, rapidSeq),
    "extraction" = c(cultBacBash, fecBacBash, fecHostBash, fecMag)
  )
  
)



