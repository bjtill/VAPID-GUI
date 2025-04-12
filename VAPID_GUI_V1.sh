#!/bin/bash
#BT & AG, March 14, 2023
#GUI version May 24, 2024

##################################################################################################################################
wget https://ucdavis.box.com/shared/static/lg3804zgt8j47v5c9agv432o3cd4kqdp.jpg

convert -resize 20% lg3804zgt8j47v5c9agv432o3cd4kqdp.jpg logo.jpeg
rm lg3804zgt8j47v5c9agv432o3cd4kqdp.jpg
YADINPUT=$(yad --width=600 --title="Variants Annotated and Parsed from Imported Data" --image=logo.jpeg --text="

ABOUT: 

This program collects information from VCF files annotated with SnpEff, and creates a human readable table.  It was part of an undergraduate research training program with Anna Grulikowski, a student at UC Davis.  

OUTPUTS: 

1) A table containing DNA sequence variants and their annotation. The genotype of each sample in the VCF is listed. 
2) A log file.  

USAGE: 

This program works on a single VCF. If you have more than one VCF you wish to process, try the command line interface (CLI) version. 


DEPENDENCIES:  YAD, wget, perl, java, bash, curl, awk

Version 1.0

" --form --field="Your Initials for the log file" "Enter" --field="Select the SnpSift.jar file:FL" --field="Select the VCF file:FL") 
echo $YADINPUT |  tr '|' '\t' | datamash transpose | head -n -1  > parameters1

rm logo.jpeg

#Yad progress and logfile 
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>VAPIDt.log 2>&1
now=$(date)  
echo "VAPID-GUI Version 1
Script Started $now."
(#Start
echo "# Downloading perl script and collecting sample names from VCF"; sleep 2
 
wget https://ucdavis.box.com/shared/static/wslxtuktuiunpopjuq3hvz046q7954u0.pl 
mv wslxtuktuiunpopjuq3hvz046q7954u0.pl vcfEffOnePerLine.pl
a=$(awk 'NR==3 {print $1}' parameters1)
b=$(awk -F"/" 'NR==3 {print $NF}' parameters1 | sed 's/.gz//g' | sed 's/.vcf//g') #Filename
bcftools query -l $a | datamash transpose > ${b}.samples
echo "10"
echo "# Extracting information from VCF (This may take some time)"; sleep 2 
c=$(awk 'NR==2 {print $1}' parameters1)
 cat $a | ./vcfEffOnePerLine.pl | java -jar $c extractFields - "ANN[*].GENE" "EFF[*].GENE" "ANN[*].FEATUREID" CHROM POS  "EFF[*].EFFECT" "ANN[*].IMPACT" "EFF[*].AA" "ANN[*].HGVS_C" "GEN[*].GT" > ${b}.tmp
echo "90"
echo "# Formatting data table"; sleep 2 
tail -n +2 ${b}.tmp > ${b}.tmp1
awk '{print "AnnotatedGeneName", "EffGeneName", "FeatureID", "Chrom", "POS", "Effect", "Impact", "AAchange", "NucChange", $0}' ${b}.samples > ${b}.header1
tr ' ' '\t' < ${b}.header1 > ${b}.header2
echo "95"
echo "# Final steps"; sleep 2
cat ${b}.header2 ${b}.tmp1 > ${b}_VAPID.text
rm *.samples *.tmp *.tmp1 *.header1 *.header2
) | zenity --width 800 --title "PROGRESS" --progress --auto-close
now=$(date)
echo "Script Finished" $now
#Collect info on user parameters

d=$(date +"%m_%d_%y_at_%H_%M")
printf 'Initials of person running the program: \nPath to SnpSift.jar file: \nPath to VCF file:' > ulog1
paste ulog1 parameters1 | tr '\t' ' ' > ulog2

cat VAPIDt.log ulog2 > VAPID_${d}.log
rm VAPIDt.log ulog1 ulog2 parameters1




##############END OF PROGRAM #######################################################################################################
