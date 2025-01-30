protocols_select <- list(
  "Singleplex, PCR-Free" = list(
     "Singleplex Ligation Sequencing" = "lsk"     ,
     "Rapid Singleplex Sequencing"    = "rapidSeq"
  ),
  "Multiplex, PCR-Free" = list(
     "Rapid Barcoding" = "rapid24"
  ),
  "Multiplex + PCR" = list(
     "Multiplex PCR Ligation Sequencing"    = "lsk96"      ,
     "16S Rapid Barcoding"                  = "rapid16s"   ,
     "Rapid HMW PCR Barcoding"              = "rapidPCR"   ,
     "Rapid Bacterial Colony PCR Barcoding" = "rapidColPCR"
  ),
  "Singleplex with MDA PCR" = list(
    "WG MDA Ligation Sequencing from Extracted DNA"           = "lskBacMDA"  ,
    "WG MDA Ligation Sequencing Direct from Culture"          = "lskCultMDA" ,
    "MDA Ligation Sequencing for Whole Mitochondrial Genomes" = "lskMtMDA"
  ),
  "Multiplex with MDA PCR" = list(
    "WG MDA Rapid PCR Barcoding"                               = "rapBacMDA",
    "MDA Rapid PCR Barcoding for Whole Mitochondrial Genomes"  = "rapMtMDA" 
  )
)

protocols <- list(
     "lsk"         = list(
      "name"       = "Singleplex Ligation Sequencing",
      "N"          = 1,
      "Input_ng"   = 1000,
      "Input_ul"   = 47,
      "kit"        = kits$LSK114,
      "PCR"        = "no",
      "multiplex"  = "no",
      "expansion"  = expansions$NEBNextv2
    ),
    "rapidSeq"    = list(
      "name"       = "Rapid Singleplex Sequencing",
      "N"          = 1,
      "Input_ng"   = 100,
      "Input_ul"   = 10,
      "kit"        = kits$RAD114,
      "PCR"        = "no",
      "multiplex"  = "no",
      "expansion"  = NULL,
      "extras"     = NULL
    ),
    "rapid24"     = list(
      "name"       = "Rapid Barcoding",
      "N"          = 24,
      "Input_ng"   = 200,
      "Input_ul"   = 10,
      "kit"        = kits$RBK114_24,
      "PCR"        = "no",
      "multiplex"  = "yes",
      "expansion"  = NULL,
      "extras"     = NULL
    ),
    "lsk96"       = list(
      "name"       = "Multiplex PCR Ligation Sequencing",
      "N"          = 96,
      "Input_ng"   = 1,
      "Input_ul"   = 21,
      "kit"        = kits$LSK114,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = c(expansions$PBC096, expansions$LongAmp)
    ),
    "rapid16s"    = list(
      "name"       = "16S Rapid Barcoding",
      "N"          = 24,
      "Input_ng"   = 10,
      "Input_ul"   = 15,
      "kit"        = kits$rap16S114,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = expansions$LongAmp
    ),
    "rapidPCR"    = list(
      "name"       = "Rapid HMW PCR Barcoding",
      "N"          = 24,
      "Input_ng"   = 1,
      "Input_ul"   = 3,
      "kit"        = kits$RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = expansions$LongAmp
    ),
    "rapidColPCR" = list(
      "name"       = "Rapid Bacterial Colony PCR Barcoding",
      "N"          = 24,
      "Input_ng"   = 1,
      "Input_ul"   = 3,
      "kit"        = kits$RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = expansions$LongAmp
    ),
    "lskBacMDA"   = list(
      "name"       = "WG MDA Ligation Sequencing Direct from Culture",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = kits$LSK114,
      "PCR"        = "yes",
      "multiplex"  = "no",
      "expansion"  = c(expansions$scREPLI, expansions$NEBNextv2)
    ),
    "lskCultMDA"  = list(
      "name"       = "WG MDA Ligation Sequencing Direct from Culture",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = kits$LSK114,
      "PCR"        = "yes",
      "multiplex"  = "no",
      "expansion"  = c(expansions$scREPLI, expansions$NEBNextv2)
    ),
    "lskMtMDA"    = list(
      "name"       = "Whole Mitochondrial Genome MDA Ligation Sequencing",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 20,
      "kit"        = kits$LSK114,
      "PCR"        = "yes",
      "multiplex"  = "no",
      "expansion"  = c(expansions$mtREPLI, expansions$NEBNextv2)
    ),
    "rapBacMDA"   = list(
      "name"       = "WG MDA Rapid PCR Barcoding",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = kits$RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = c(expansions$scREPLI, expansions$LongAmp)
    ),
    "rapMtMDA"    = list(
      "name"       = "MDA Rapid PCR Barcoding for Whole Mitochondrial Genomes",
      "N"          = 1,
      "Input_ng"   = 2,
      "Input_ul"   = 2.5,
      "kit"        = kits$RPB114_24,
      "PCR"        = "yes",
      "multiplex"  = "yes",
      "expansion"  = c(expansions$mtREPLI, expansions$LongAmp)
    )
)