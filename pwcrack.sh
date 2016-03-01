#!/bin/bash

###############################################################################
#                                                                             #
# pwcrack.sh                                                                  #
# by _NSAKEY                                                                  #
#                                                                             #
# This script isn't anything too special. It was used to benchmark various    #
# rule sets in hashcat. The results were shared in my hashcat talk at BSides  #
# Nashville 2015, InfoSec Nashville 2015, and PhreakNIC 19.                   #
# If you're wanting to see how a given rule set or dictionary performs        #
# against a given hash list, this script offers a good place to start.        #
#                                                                             #
# The "-w 1" flag throttles hashcat just enough to let you use your machine   #
# for other things, if you're like me and don't have a dedicated cracking rig #
# to throw at the problem. The reason "--potfile-disable" is used is because  #
# when you're evaluating the effectiveness of a rule/dictionary combination,  #
# it makes sense to not remove the founds and dump them in the potfile. If    #
# your needs are different, feel free to rip out --potfile-disable.           #
# The script makes heavy use of bash variables, documented below:             #
#                                                                             #
# $1 = Hashing algorithm, e.g. 0 for unsalted MD5.                            #
# $2 = Hash list, e.g. battlefield_heroes_beta_hashes.txt                     #
# $3 = Rule set, e.g. best64.rule                                             #
# $4 = Dictionary file, e.g. rockyou.txt                                      #
# $UNIXTIME = The number of seconds since 01/01/1970.                         #
#                                                                             #
# An example command looks like this:                                         #
#                                                                             #
# ./pwcrack.sh 0 battlefield_heroes_beta best64.rule rockyou.txt              #
#                                                                             #
# That will generate a text file with a filename like:                        #
#                                                                             #
# battlefield_heroes_beta_best64.rule_1456684393_rockyou.txt                  #
#                                                                             #
# The script makes assumptions about the location of your hash list,          #
# dictionary, rule set location, and even what version of hashcat you use.    #
# Be sure you tweak this script to suit your environment before running it.   #
#                                                                             #
###############################################################################

UNIXTIME=$(date +%s)

cd ~/Downloads/cudaHashcat-2.01

./cudaHashcat64.bin -m $1 -w 1 --potfile-disable -o ~/$2_$3_$4_$UNIXTIME ~/$2_hashes.txt -r rules/$3 ../../$4
