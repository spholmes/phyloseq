\name{import_qiime}
\alias{import_qiime}
\title{Import function to read the now legacy-format QIIME OTU table.}
\usage{
  import_qiime(otufilename = NULL, mapfilename = NULL,
  treefilename = NULL, refseqfilename = NULL,
  refseqFunction = readDNAStringSet, refseqArgs = NULL,
  parseFunction = parse_taxonomy_qiime, verbose = TRUE,
  ...)
}
\arguments{
  \item{otufilename}{(Optional). A character string
  indicating the file location of the OTU file. The
  combined OTU abundance and taxonomic identification file,
  tab-delimited, as produced by QIIME under default output
  settings. Default value is \code{NULL}.}

  \item{mapfilename}{(Optional). The QIIME map file is
  required for processing barcoded primers in QIIME as well
  as some of the post-clustering analysis. This is a
  required input file for running QIIME. Its strict
  formatting specification should be followed for correct
  parsing by this function. Default value is \code{NULL}.}

  \item{treefilename}{(Optional). Default value is
  \code{NULL}. A file representing a phylogenetic tree or a
  \code{\link{phylo}} object. Files can be NEXUS or Newick
  format. See \code{\link{read_tree}} for more details.
  Also, if using a recent release of the GreenGenes
  database tree, try the \code{\link{read_tree_greengenes}}
  function -- this should solve some issues specific to
  importing that tree. If provided, the tree should have
  the same OTUs/tip-labels as the OTUs in the other files.
  Any taxa or samples missing in one of the files is
  removed from all. As an example from the QIIME pipeline,
  this tree would be a tree of the representative 16S rRNA
  sequences from each OTU cluster, with the number of
  leaves/tips equal to the number of taxa/species/OTUs, or
  the complete reference database tree that contains the
  OTU identifiers of every OTU in your abundance table.
  Note that this argument can be a tree object
  (\code{\link[ape]{phylo}}-class) for cases where the tree
  has been --- or needs to be --- imported separately, as
  in the case of the GreenGenes tree mentioned earlier
  (code{\link{read_tree_greengenes}}).}

  \item{refseqfilename}{(Optional). Default \code{NULL}.
  The file path of the biological sequence file that
  contains at a minimum a sequence for each OTU in the
  dataset. Alternatively, you may provide an
  already-imported \code{\link[Biostrings]{XStringSet}}
  object that satisfies this condition. In either case, the
  \code{\link{names}} of each OTU need to match exactly the
  \code{\link{taxa_names}} of the other components of your
  data. If this is not the case, for example if the data
  file is a FASTA format but contains additional
  information after the OTU name in each sequence header,
  then some additional parsing is necessary, which you can
  either perform separately before calling this function,
  or describe explicitly in a custom function provided in
  the (next) argument, \code{refseqFunction}. Note that the
  \code{\link[Biostrings]{XStringSet}} class can represent
  any arbitrary sequence, including user-defined
  subclasses, but is most-often used to represent RNA, DNA,
  or amino acid sequences. The only constraint is that this
  special list of sequences has exactly one named element
  for each OTU in the dataset.}

  \item{refseqFunction}{(Optional). Default is
  \code{\link[Biostrings]{readDNAStringSet}}, which expects
  to read a fasta-formatted DNA sequence file. If your
  reference sequences for each OTU are amino acid, RNA, or
  something else, then you will need to specify a different
  function here. This is the function used to read the file
  connection provided as the the previous argument,
  \code{refseqfilename}. This argument is ignored if
  \code{refseqfilename} is already a
  \code{\link[Biostrings]{XStringSet}} class.}

  \item{refseqArgs}{(Optional). Default \code{NULL}.
  Additional arguments to \code{refseqFunction}. See
  \code{\link[Biostrings]{XStringSet-io}} for details about
  additional arguments to the standard read functions in
  the Biostrings package.}

  \item{parseFunction}{(Optional). An optional custom
  function for parsing the character string that contains
  the taxonomic assignment of each OTU. The default parsing
  function is \code{\link{parse_taxonomy_qiime}},
  specialized for splitting the \code{";"}-delimited
  strings and also attempting to interpret greengenes
  prefixes, if any, as that is a common format of the
  taxonomy string produced by QIIME.}

  \item{verbose}{(Optional). A \code{\link{logical}}.
  Default is \code{TRUE}. Should progresss messages be
  \code{\link{cat}}ted to standard out?}

  \item{...}{Additional arguments passed to
  \code{\link{read_tree}}}
}
\value{
  A \code{\link{phyloseq-class}} object.
}
\description{
  QIIME produces several files that can be directly
  imported by the \code{\link{phyloseq-package}}.
  Originally, QIIME produced its own custom format table
  that contained both OTU-abundance and taxonomic identity
  information. This function is still included in phyloseq
  mainly to accommodate these now-outdated files. Recent
  versions of QIIME store output in the biom-format, an
  emerging file format standard for microbiome data. If
  your data is in the biom-format, if it ends with a
  \code{.biom} file name extension, then you should use the
  \code{\link{import_biom}} function instead.
}
\details{
  Other related files include the mapping-file that
  typically stores sample covariates, converted naturally
  to the \code{\link{sample_data-class}} component data
  type in the phyloseq-package. QIIME may also produce a
  phylogenetic tree with a tip for each OTU, which can also
  be imported specified here or imported separately using
  \code{\link{read_tree}}.

  See \url{"http://www.qiime.org/"} for details on using
  QIIME. While there are many complex dependencies, QIIME
  can be downloaded as a pre-installed linux virtual
  machine that runs ``off the shelf''.

  The different files useful for import to \emph{phyloseq}
  are not collocated in a typical run of the QIIME
  pipeline. See the main \emph{phyloseq} vignette for an
  example of where ot find the relevant files in the output
  directory.
}
\examples{
otufile <- system.file("extdata", "GP_otu_table_rand_short.txt.gz", package="phyloseq")
mapfile <- system.file("extdata", "master_map.txt", package="phyloseq")
trefile <- system.file("extdata", "GP_tree_rand_short.newick.gz", package="phyloseq")
import_qiime(otufile, mapfile, trefile)
}
\references{
  \url{http://qiime.org/}

  ``QIIME allows analysis of high-throughput community
  sequencing data.'' J Gregory Caporaso, Justin Kuczynski,
  Jesse Stombaugh, Kyle Bittinger, Frederic D Bushman,
  Elizabeth K Costello, Noah Fierer, Antonio Gonzalez Pena,
  Julia K Goodrich, Jeffrey I Gordon, Gavin A Huttley,
  Scott T Kelley, Dan Knights, Jeremy E Koenig, Ruth E Ley,
  Catherine A Lozupone, Daniel McDonald, Brian D Muegge,
  Meg Pirrung, Jens Reeder, Joel R Sevinsky, Peter J
  Turnbaugh, William A Walters, Jeremy Widmann, Tanya
  Yatsunenko, Jesse Zaneveld and Rob Knight; Nature
  Methods, 2010; doi:10.1038/nmeth.f.303
}
\seealso{
  \code{\link{phyloseq}}

  \code{\link{merge_phyloseq}}

  \code{\link{read_tree}}

  \code{\link{read_tree_greengenes}}

  \code{\link[Biostrings]{XStringSet-io}}
}

