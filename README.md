# VAPID-GUI
Variants Annotated and Parsed from Imported Data, Graphical Interface Version. A tool to help convert variant call format (VCF) files annotated with SnpEff into a human readable table.

________________________________________________________________________________________________________________________________________________

Use at your own risk.
I cannot provide support. All information obtained/inferred with this script is without any implied warranty of fitness for any purpose or use whatsoever.

ABOUT: 

VCFs annotated with the tool SnpEff (https://pcingola.github.io/SnpEff/) contain information about the potential effect of each sequence variant on gene function. A perl script (vcfEffOnePerLine.pl) is provided with SnpEff to extract the EFF information from an annotated VCF.  The VAPID tool was created to facilitate the use of the perl script so that a common set of annotation information can be easily extracted and formatted from single or multi-sample VCFs.  Creating this code was part of an undergraduate research training program with Anna Grulikowski, who was a student of UC Davis.  We created a command line interface (CLI) version, and a graphical user interface (GUI) version of VAPID.  The command line version provides a feature that allows the batch processing of multiple VCFs.  The GUI version does not support batch processing, but does not require the use of the command line interface, except to launch the program. 

HOW IT WORKS: 

VAPID uses bcftools query to collect sample name information from the input VFC.  The script vcfEffOnePerLine.pl is used to collect the EFF information from the VCF, and SnpSift.jar is used to extract the ANN.GENE, EFF.GENE, ANN.FEATURED, CHROM, POS, EFF.EFFECT, ANN.IMPACT, EFF.AA, ANN.HGVS_C and GEN.GT fields.  Awk is used to create a header for the resulting table.  

REQUIREMENTS:

yad, perl, java, bash, awk


OPERATING SYSTEMS: 

VAPID was built to work on a Linux system with Bash (Bourne-Again SHell). The CLI version will work on Mac Os (tested on X), and in theory will work on a Windows machine running a Bash emulator (this has not been tested).   The GUI version was built using YAD.  Our attempts at installing YAD on Mac Os failed.  If you are interested in making a GUI version for Mac, try Zenity, which can be installed using homebrew.  See the Mutation_Finder_Annotator tool for an example of using Zenity (https://github.com/bjtill/Mutation-Finder-Annotator-GUI/blob/main/Mutation_Finder_Annotator_GUI_V1_5.sh).  

 TO RUN:
 
1. Download the latest version of VAPID_GUI.sh.
2. Download the SnpEff & SnpSift bundle (https://pcingola.github.io/SnpEff/download/)
3.  Provide permission for this program to run on your computer (open a terminal window and type chmod +x VAPID_GUI_V1.sh). In Linux Ubuntu you can right click in the directory and select “Open in Terminal” to open a terminal in the correct location.   Check to make sure that the name you type is an exact match to the .sh file you are using, as the version may change. 
4. Launch the program by typing ./VAPID_GUI_V1.sh (again making sure the name of the program is correct).  A new window should appear.  Click the option to select the SnpSift.jar file and the VCF file you wish to process.  Once finished, click “OK” to start the program. 

OUTPUTS: 

1. A table containing the results with the extension .txt.
2. A log file. 
