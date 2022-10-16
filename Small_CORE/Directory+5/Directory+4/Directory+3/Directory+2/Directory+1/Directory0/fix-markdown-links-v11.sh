#!/bin/bash
#
# Read Me
# What does this program do
# This program fix-markdown-links.sh is a program writen in BASH by me, that loops recursively through my CORE OF NOTES and fixes all the Markdown Links.
# It requires that each markdown note to have an 14 digit uniquie ID number to be able to find the note inside the CORE OF NOTES.
#
# What does it replace exactly in a md link?
# Well a link is of the form [name of file 99999999999999.md](Broken/Path/To/Directory/name of file 99999999999999.md)
# My program, if it finds the link to be broken
# will replace "](Broken/Path/To/Directory/name of file 99999999999999.md)"
# with the right path "](Correct/Path/To/Directory/name of file 99999999999999.md)"
# So I limited the power of my program to not touch the name of the link, aka whatever is inside the [square brackets] my program will not ovewirte that
# It was a personal design decision, in case something goes wrong, I do still have the id in there..
#
#
#
#
# ATTENTION ATTENTION
# I HARD WRITTEN THE PATH TO MY CORE OF NOTES IN A GLOBAL VARIABLE. I DID THAT BECAUSE I NEEDED FOR MY PROGRAM TO KNOW WHICH DIRECTORY TO USE TO SEARCH FOR IDS:
# core_directory="/home/zen101/Notebooks/coreNotebook/CORE";

# Where to run the program?
# It must be run under "/CORE" Directory for it to not go and loop over other irelevant directories in my Linux PC.
# To do that you need to copy it first under "/CORE" directory and then open the Terminal and run it.
# Or add it to a special linx directory and run it from anywhere...
#
# How to run it?
# Just open the Terminal and run
# ./fix-markdown-links.sh
#
# How long did it take to write this program?
# It took me like around a week...
#
# What types of files will open?
# It only opens files that end in ".md" extension and it will ignore any other extension like .txt; .c; .jpeg; .zip; .js; etc...
#
#
#
#
#
#

# Enable or disable sed from writing to the fiels or not wringint to the files:
# Go to this line:
# sed "s|$old_markdown_link_for_sed|$new_markdown_link_for_sed|g" "$current_file_location";
# or
# sed --in-place "s|$old_markdown_link_for_sed|$new_markdown_link_for_sed|g" "$current_file_location";
# and enable or disable it no not OVERWRITE A FILE just for testing...!!


# Pseudocode

# fix-markdown-links-v00: This program will open 1 markdown file and fix its links. Because the md links stoped working because a Directory was renamed


# Open the CORE OF MY NOTES and Loop through all the ".md" files
	# Set the code block flag variable to False
	# Open one by one at the time each of those .md files
	# Open a .md file
	# Loop through the file line by line
		# And another functionality I want to implement is for the BASH program to ignore the code block
			# Basically chec if the line contains a 3 tilda sign ''' like this,
			# If the line contains the 3 tilda sign
				# Then ignore all the lines until you find the 3 tilda sign again
					# Do that by setting a boolean variable True or False.
					# There is no reson to pass a code block and parse it by the replace_broken_markdown_link()
					# Because I don't want to mess with actuall source code..
		# Pass the line to the replace_broken_markdown_link() function
			# The function will call other smaller function to implement this find and replace functionality
			# Identify a markdown pattern and handle any other file (.md .jpg .pdf .c  .anything...)
				# Now here I may need to implement more functionality...
				# Just in case there are more than just 1 md link in one paragraph, one line...
				# I am not sure exactly how I am suppose to do that but I could do a function
			# Save old markdown link in a variable
			# Extract the id from the old markdown link
			# Find the file in the Small CORE of notes
			# Find its absolute path for the targeted file
			# Figure out the relative path from source_file to target_file
			# Save the new markdown link in a variable
			# Compare the old markdown link to the new markdown link
			# If old_markdown_link == new_markdown_link
			# Then: Do nothing
			# Else: Rename the old_markdown_link with new_markdown_link
	# End of "Loop through the file line by line" loop, jump back up and repeat until the end of the file
# Reset all the variables, because there is no reason to hold to a variable when I go to a new line
# Because a markdown link can only exist in one line, there are not markdown links on multiple lines. There could be multiple md links on the same line but not no markdown link will start on one line and it will finish on the next.
# But don't reset the code block 3 tilda boolean flag yet..
# End of "Loop through all the '.md' files" loop, jump up and repeat again until you will go through all the files in the CORE direcotry recursively
# Finished


main() {

## HARD WRITEN VARIALBES:
# The "realpath" utility needs an absoule path of the source file directory and not the path of the source file itself,:
# realpath --relative-to="$absolute_path_of_source_file" "$absolute_path_of_target_file"
#absolute_path_of_source_directory="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Directory+5/Directory+4/Directory+3/Directory+2/Directory+1/Directory0";
#DONE You may need to go inside search_for_current_file_id_inside_core() function and dinamically update the PWD variable pressent workid directory variable...
# TODO Go to this line sed "s|$old_markdown_link_for_sed|$new_markdown_link_for_sed|g" "$current_file_location"; and enable it no not OVERWRITE A FILE just for testing...!!


# ATTENTION!!! file titles can't have "[,],(,)" symbols. for example if a file is named like this:
# documentation_page(1)_of_manual_20220510113353.md
# Then to link to this file I will have to write this link:
# "[documentation_page(1)_of_manual_20220510113353](DirectoryX/documentation_page(1)_of_manual_20220510113353.md)"
# Because I have "(1)" in the actual tile I have to have the same "(1)" in the markdown link
# So this is bad becasue I confuse the parser and I get this error from grep utility:
# grep: Unmatched ( or \(
# And then this error from find
# find: paths must precede expression: `delete-me.txt.save'
# find: possible unquoted pattern after predicate `-name'?




# HARD WRITTEN GLOBAL VARIABLE
#core_directory="/home/zen101/Notebooks/coreNotebook/CORE";
#core_directory="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-versions/Tiny_core";
core_directory="/home/zen101/Notebooks/Small_CORE";

# Debug variables:
debug_name_of_target_file_with_slash="";


# GLOBAL VARIABLES:
# code_block_flag I defined as Boolean datatype for efficiency purposes, make the code faster...
code_block_flag=false;
# This is a variable used by return_an_array_of_md_patterns_from_a_line() function
declare -a global_array_of_md_patterns=();
index_global_array=0;


# GLOBAL LOG VARIABLES
# This is the output that this function will give after each line:

#LOG CURRENT FILE PATH                 =
#LOG CURRENT NUMBER OF DIRECTORIES PATH=
#LOG CURRENT MD LINK FOUND             =
#LOG CURRENT BROKEN OLD MD LINK FOUND  =
#LOG CURRENT FIXED WITH NEW MD LINK    =
#LOG CURRENT NUMBER OF MD LINKS ON LINE=
#LOG CURRENT LINE TEXT CONTENT         =
#----------------------------------------------------------------------------------------------------------------
#NEXT LINE
#----------------------------------------------------------------------------------------------------------------

log_current_file_path="";
log_current_number_of_directories_path="";
log_current_md_link_found="";
log_current_broken_old_md_link_found="";
log_current_fixed_with_new_md_link="";
log_current_number_of_md_links_on_line="";
log_current_line_text_content="";

#GLOBAL LOG FINAL VARIABLES

#( ▀ ͜͞ʖ▀) MARKDOWN-LINKS-FIXER BY CONSTANTIN LUCIU
#
####################################################################
# LOG FINAL STATISTICS:
# LOG TOTAL NUMBER OF IDS THAT DO NOT EXIST IN MY CORE OF NOTES=
# LOG TOTAL NUMBER OF FILES CHECKED=
# LOG TOTAL NUMBER OF LINES READ=
# LOG TOTAL NUMBER OF CODE BLOCKS AVOIDED=
# LOG TOTAL NUMBER OF MARKDOWN LINKS CHECKED=
# LOG TOTAL NUMBER OF BROKEN MARKDOWN LINKS FOUND=
# LOG TOTAL NUMBER OF MARKDOWN LINKS FIXED=
#
# LOG THE MOST MARKDOWN LINKS ON 1 SINGLE LINE OF TEXT=
# LOG THE DEEPEST DIRECTORY PATH HAS THIS NUMBER OF DIRECTORIES=
####################################################################
file_log_final_number_of_ids_do_not_exist="/tmp/temp00.tmp";
file_log_final_number_of_files_checked="/tmp/temp01.tmp";
file_log_final_number_of_lines_read="/tmp/temp02.tmp";
file_log_final_number_of_code_blocks_avoided="/tmp/temp03.tmp";
file_log_final_number_of_markdown_links_checked="/tmp/temp04.tmp";
file_log_final_number_of_broken_markdown_links_found="/tmp/temp05.tmp";
file_log_final_number_of_markdown_links_fixed="/tmp/temp06.tmp";

file_log_final_the_most_md_links_in_one_line="/tmp/temp07.tmp";
file_log_final_the_directories_in_one_path="/tmp/temp08.tmp";


## Initialise the counter variables that are stored in files to 0 zero
# echo 0 > $tempfile;
echo 0 > $file_log_final_number_of_ids_do_not_exist;
echo 0 > $file_log_final_number_of_files_checked;
echo 0 > $file_log_final_number_of_lines_read;
echo 0 > $file_log_final_number_of_code_blocks_avoided;
echo 0 > $file_log_final_number_of_markdown_links_checked;
echo 0 > $file_log_final_number_of_broken_markdown_links_found;
echo 0 > $file_log_final_number_of_markdown_links_fixed;

echo 0 > $file_log_final_the_most_md_links_in_one_line;
echo 0 > $file_log_final_the_directories_in_one_path;

#  log_final_number_of_lines_read=$(($log_final_number_of_lines_read+1));



# Bellow I will need to recursiveley go through all my Directories and and my markdown files
# And fix md links for each file from my CORE OF NOTES

find "$PWD" -type f -name "*.md" | while read fname; do
    #echo "$DEBUG fname";
    #echo "---------"
	# CODE BLOCK
	# Save the absolute path of source file in a variable
	absolute_path_of_source_file="";
	absolute_path_of_source_file="$fname";
	log_current_file_path="$absolute_path_of_source_file";

	# log_current_number_of_directories_path by countin how many "/" slashes are in an absolute path of a file
	log_current_number_of_directories_path=$(tr -dc '/' <<<"$absolute_path_of_source_file" | wc -c);

	# Log final: The highes number of directory fond in my CORE OF NOTES
	# AKA the deepest directory found in my CORE of notes
	#file_log_final_the_directories_in_one_path
	max_nr_of_directories=$[$(cat $file_log_final_the_directories_in_one_path)];
	#echo "DEBUG 20 max_links_on_a_line="$max_links_on_a_line;
	#echo "DEBUG length_of_md_patterns_array="$length_of_md_patterns_array;
	if (( log_current_number_of_directories_path > max_nr_of_directories )); then
		# It meas I found a new maximum number of links on one single line of text, then update the max_links_on_a_line log variable
		max_nr_of_directories=$log_current_number_of_directories_path;
		#echo "DEBUG 25 max_links_on_a_line="$max_links_on_a_line;
		#echo "DEBUG length_of_md_patterns_array="$length_of_md_patterns_array;

		# And save it to the file
		# Store the new value
		echo $max_nr_of_directories > $file_log_final_the_directories_in_one_path;

	else
		# Do nothing
		#echo "var1 is less than var2";
		empty_if_block="empty";
	fi




	#echo "DEBUG absolute_path_of_source_file="$absolute_path_of_source_file;
	# Point to current md file
	current_file_location="";
	current_file_location="$absolute_path_of_source_file";

	absolute_path_of_source_directory="";
	absolute_path_of_source_directory=${absolute_path_of_source_file%/*};
	#echo "DEBUG absolute_path_of_source_directory="$absolute_path_of_source_directory;
	# Open the md file
	#current_file_location=$(open_one_markdown_file);
	#echo "DEBUG current_file_location="$current_file_location;



	# Do this steps for all the links in the file..
	# Do this for each line in the md file

	# This function will be called for each file.
	process_line_by_line_an_markdown_file "$current_file_location";

	# Log final count number of files checket
	# The bellow method doesn't work
	#  count=$(($count+1));
	#log_final_number_of_files_checked=$((log_final_number_of_files_checked+1));
	#But writing to the file method of keeping a counter works! so I will use that
	# Fetch the value and increase it
	counter=$[$(cat $file_log_final_number_of_files_checked) + 1];

	# Store the new value
	echo $counter > $file_log_final_number_of_files_checked;


done





# Print on the screen the final log
log_final ;


# Delete the temporary files that I have to use to keep track of my counter varialbes
# becasue BASH shells and subshells don't pass variables values correctly
# It is the only solution that I found...
unlink $file_log_final_number_of_ids_do_not_exist;
unlink $file_log_final_number_of_files_checked;
unlink $file_log_final_number_of_lines_read ;
unlink $file_log_final_number_of_code_blocks_avoided ;
unlink $file_log_final_number_of_markdown_links_checked ;
unlink $file_log_final_number_of_broken_markdown_links_found ;
unlink $file_log_final_number_of_markdown_links_fixed ;

unlink $file_log_final_the_most_md_links_in_one_line ;
unlink $file_log_final_the_directories_in_one_path ;

}

















#########################################################################################################################################
############################ BELOW I DECLARED MY FUNCTION THAT I USED IN MY MAIN PROGRAM
#########################################################################################################################################







# This function will be called for each file.
# I can call this function process_md_links_in_one_file(); process_line_by_line_an_markdown_file(); and pass it as Attribute the file path.
# By doing so the code will be clean and easyer to read
# Argument1 a path to a file
# Return nothing
process_line_by_line_an_markdown_file(){

	local current_file_location="$1"
	local file="$current_file_location";

	local number_of_line=0;


	while read line;
	do

		# Print the line number
		#echo "DEBUG number_of_line="$number_of_line;
		number_of_line=$(($number_of_line+1));

		# Log final: count the number of lines read
		#log_final_number_of_lines_read=$(($log_final_number_of_lines_read+1));
		#file_log_final_number_of_lines_read
		# Fetch the value and increase it
		counter=$[$(cat $file_log_final_number_of_lines_read) + 1];

		# Store the new value
		echo $counter > $file_log_final_number_of_lines_read;

		#  count=$(($count+1));
		#Read line by line a filename
		#echo -e "DEBUG line="$line;

		# Check if you are inside a Markdown Code Block
		# If after this function call the global variable code_block_flag is true that means I am inside a code block else it means I am outside a code block
		are_you_inside_a_code_block "$line";
		if [ "$code_block_flag" == true ]; then
			# I am inside a code block therefore do nothing
			empty_if_blocks="empty";
		else
			# I am outside a code block so parse the line

			#Rest the global array of md patterns
			global_array_of_md_patterns=();
			index_global_array=0;

			# Pass the current file path and the current line to the replace_broken_markdown_link() function
			# The function will call other smaller function to implement this find and replace functionality
			replace_broken_markdown_link "$current_file_location" "$line";
			#echo "DEBUG debug_name_of_target_file_with_slash="$debug_name_of_target_file_with_slash;

			# Print the log once per line
			log_current ;

		fi




	done < "$file"

# Return value: nothing

}









# Pass the line to the replace_broken_markdown_link() function
	# The function will call other smaller function to implement this find and replace functionality
	# Identify a markdown pattern
		# Now here I may need to implement more functionality...
		# Just in case there are more than just 1 md link in one paragraph, one line...
		# I am not sure exactly how I am suppose to do that but I could do a function
	# Save old markdown link in a variable
	# Extract the id from the old markdown link
	# Find the file in the Small CORE of notes
	# Find its absolute path for the targeted file
	# Figure out the relative path from source_file to target_file
	# Save the new markdown link in a variable
	# Compare the old markdown link to the new markdown link
	# If old_markdown_link == new_markdown_link
	# Then: Do nothing
	# Else: Rename the old_markdown_link with new_markdown_link
	###########################################################
	# Arguments for replace_broken_markdown_link() function
	# Argument1 current file location
	# Argument2 current line inside the current file location
replace_broken_markdown_link(){
	local current_file_location=$1;
	local current_line_in_current_file=$2;
	#echo "DEBUG 02 current_file_location="$current_file_location;
	# Identify a markdown pattern in the curren line of the curren file
	# A markdown links looks like [foo](Directory A/Direcotry B/foo_20220503183504.md)
	#echo "DEBUG current_line_in_current_file="$current_line_in_current_file;

	# Log the current line of text that is searched throught for md links
	log_current_line_text_content="$current_line_in_current_file";

	#This function will take as input the current line in the current file and return as output all the links in an Array of old md links
	#return_an_array_of_old_md_links_in_a_line "$current_line_in_current_file";
	return_an_array_of_md_patterns_from_a_line "$current_line_in_current_file";

	local length_of_md_patterns_array="${#global_array_of_md_patterns[@]}";

	# Log the number of markdown patterns (probably markdown links) on 1 line (up to `\n` character)
	log_current_number_of_md_links_on_line="$length_of_md_patterns_array";





		# Log final: The the highes number of md links on 1 single line
		#file_log_final_the_most_md_links_in_one_line
		# Fetch the value and increase it
		#counter=$[$(cat $tempfile) + 1];
		max_links_on_a_line=$[$(cat $file_log_final_the_most_md_links_in_one_line)];
		#echo "DEBUG 20 max_links_on_a_line="$max_links_on_a_line;
		#echo "DEBUG length_of_md_patterns_array="$length_of_md_patterns_array;
		if (( length_of_md_patterns_array > max_links_on_a_line )); then
			# It meas I found a new maximum number of links on one single line of text, then update the max_links_on_a_line log variable
			max_links_on_a_line=$length_of_md_patterns_array;
			#echo "DEBUG 25 max_links_on_a_line="$max_links_on_a_line;
			#echo "DEBUG length_of_md_patterns_array="$length_of_md_patterns_array;

			# And save it to the file
			# Store the new value
			echo $max_links_on_a_line > $file_log_final_the_most_md_links_in_one_line;

		else
			# Do nothing
			#echo "var1 is less than var2";
			empty_if_block="empty";
		fi





	# If the array is empty that means there are no md links inside that line
	if [ "$length_of_md_patterns_array" != "0" ];then

		# DEBUG Loop
		# Lets print the array after the abocve charater after character Loop to see what it is inside:
		#for i in "${global_array_of_md_patterns[@]}"
		#	do
		#	   echo "DEBUG i="$i;
		#	done

		#execute my souce code
		# Loop through the array element by element
		for i in "${global_array_of_md_patterns[@]}"
			do
				# For each element execute my code block
			   #echo ">>>>DEBUG 193 i="$i;
			   local md_pattern="$i";
			   #echo "DEBUG 195 md_pattern="$md_pattern;
			   #Then I can loop through the the array_of_old_md_links and call my resot of my program for each element of that array
			   local old_markdown_link=$( grep -E -o -m 1 --include="*.md" '\[.*\]\(.*\)' <<< "$md_pattern");
			   #echo "DEBUG old_markdown_link="$old_markdown_link;


			   #old_markdown_link="[second_note_20220503134544.md](Other notes/second_note_20220503134544.md)";
			   old_markdown_link_length=${#old_markdown_link};
			   #echo "DEBUG old_markdown_link_length="$old_markdown_link_length;


			   if [ "$old_markdown_link_length" == "0" ]; then
				   #echo "DEBUG There is no old_markdown_link found on the line";
				   local empty_if_blocks="empty";
			   else
				   #echo "DEBUG An old_markdown_link found! on the line";

				   #Find the extension of the targeted file
				   #local extension=$(extract_extension_from_path "$old_markdown_link");

				   #Print the log only for md matches
				   #log_current ;

				   # Log the log_current_md_link_found the current markdown link found

				   log_current_md_link_found="$old_markdown_link";

				   # Log final: count the number of markdown links checked:
				   #file_log_final_number_of_markdown_links_checked
				   # Fetch the value and increase it
				   counter=$[$(cat $file_log_final_number_of_markdown_links_checked) + 1];
				   # Store the new value
				   echo $counter > $file_log_final_number_of_markdown_links_checked;

				   # Extract the id from the old markdown link
				   local id_of_target_file=$(extract_id_from_markdown_link "$old_markdown_link");
				   #echo "DEBUG id_of_target_file="$id_of_target_file;
				   #echo "DEBUG old_markdown_link="$old_markdown_link;

				   # Find the file in the Small CORE of notes
				   # Find its absolute path for the targeted file
				   local absolute_path_of_target_file=$( search_for_current_file_id_inside_core "$id_of_target_file");
				   #echo "DEBUG absolute_path_of_target_file="$absolute_path_of_target_file;



				   # Test if the absolute path actually exist
				   if [ "$absolute_path_of_target_file" == "1" ]; then
					   # Error no absolute path has beed found because the id does not exist
					   echo "LOG MESSAGE: This file does not exist! with the id="$id_of_target_file;

					   # Count the number of ids that wore not found in my core of notes, when searched. Or some sort of false positive..
					   #file_log_final_number_of_ids_do_not_exist
					   # Fetch the value and increase it
					   counter_no_id=$[$(cat $file_log_final_number_of_ids_do_not_exist) + 1];

					   # Store the new value
					   echo $counter_no_id > $file_log_final_number_of_ids_do_not_exist;

				   else
					   # Everything is OK the absolute path exists

					   #Find the extension of the targeted file
					   local extension=$(extract_extension_from_path "$absolute_path_of_target_file");

					   # Figure out the relative path from source_file to target_file
					   local relative_path_source_file_to_target_file=$(figure_out_relative_path_from_source_file_to_target_file "$absolute_path_of_source_file" "$absolute_path_of_target_file");
					   #echo "DEBUG relative_path_source_file_to_target_file="$relative_path_source_file_to_target_file;


					   # If the relative_path_source_file_to_target_file is empty
					   # then I should not call the sed function and compare_old_md_link_to_new_md_link() function
					   # Because I will overwrite an broken md link with an empty path like this:  "[file name 20220514134445]()"
					   relative_path_source_file_to_target_file_length=${#relative_path_source_file_to_target_file};

					   if [ "$relative_path_source_file_to_target_file_length" == "0" ]; then
						   	# Then do nothing
						   	# It means that realpath did not find a relative path between the target file and the source file
						   	empty_if_block="empty";
						   	#echo "DEBUG Do nothing!";
					   else
					   	# Then it measn that realpath retuned an actual relative path between the source file and target file
					   	# So I can call the functions to replace the broken path with a new good relative path outputed by realpath command
					   	#echo "DEBUG Overwrite the file with an relative path";

						   # Save the new markdown link in a variable
						   local new_markdown_link=$(sed "s|\](.*)|\]($relative_path_source_file_to_target_file)|g" <<< "$old_markdown_link");
						   #echo "DEBUG new_markdown_link="$new_markdown_link;
						   #echo "DEBUG old_markdown_link="$old_markdown_link;

						   # Compare the old markdown link to the new markdown link
						   # If they are different Rename the old_markdown_link with new_markdown_link inside the file
						   compare_old_md_link_to_new_md_link "$old_markdown_link" "$new_markdown_link" "$current_file_location";

						   # Return nothing
						   #return 0;
					   fi






				   fi



			   fi







			done


	fi



}


# Open the md file
# open_one_markdown_file() it is a function that opens a file and returns a file path to that file location on hdd
open_one_markdown_file() {
	#local current_file="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Directory+5/Directory+4/Directory+3/Directory+2/Directory+1/Directory0/source_note_test1_20220503134351.md";
	# Function return:
	#echo $current_file;
	local empty_function="empty";
}






# Pseudocode fo the function:
# The Function will extract the id from the old markdown link
# 	# Extract the name of the file from an markdown link
	#If the markdown link contains slashes "/"
	#	Then: Split the link at the first slash "/" from right to left
	#		  Extract the id from file name
	#	Else: Split the link at the first "(" from right to left
	#		  Extract the id from file name
	#	Because if the md link does not have any slash that means the file is not in a subdirectory, which means it does not have any depth, but the target file only lives in the same directory as the source file.

# The extract_id_from_markdown_link will extract the id for example the 14 digit number (for example like "20220505175108" this number) from an markdown link
# Function takes as input:
# Argument1 an markdown link
# The function will outpt an id similar to: "20220505175108"

#Testing values:
#old_markdown_link="[same_directory_file_20220510103216.md](renamed the name of the file same_directory_file_20220510103216.md)";
#old_markdown_link="[same_directory_file_20220510103216.md](Directory1/Direcory 2/ file same_directory_file_20220510103216.md)";
#old_markdown_link="[same_directory_file_20220510103216.md](Only one slash/same_directory_file_20220510109999.md)";
#old_markdown_link="[same_directory_file_20220510103216.md](20220510109999)";
extract_id_from_markdown_link(){
	#local name_of_target_file_with_slash=$( grep -E -o -m 1 --include="*.md" '\/.*\.md' <<< "$1");
	local markdown_link="$1";
	# echo "DEBUG markdown_link="$markdown_link;

	# Extract the name of the file from an markdown link
	#If the markdown link contains slashes "/"
	#	Then: Split the link at the first slash "/" from right to left
	#	Else: Split the link at the first "(" from right to left
	#	Because if the md link does not have any slash that means the file is not in a subdirectory, which means it does not have any depth, but the target file only lives in the same directory as the source file.

	local round_brackets_part_of_md_link=$( grep -E -o -m 1 "\(.*\)" <<< "$markdown_link");
	local slashes_in_md_path=$( grep -E -o -m 1 ".*\/.*)" <<< "$round_brackets_part_of_md_link");
	# echo "DEBUG slashes_in_md_path="$slashes_in_md_path;
	local slashes_in_md_path_length=${#slashes_in_md_path};
	local name_of_target_file="";
	local id_of_target_file="";

	# This is the regex I want to use /([0-9]){14}/g to extract my id from a file name
	# This is "${a##*.}" shell parameter expansion, bascially it cuts everything on the left of the delimiter and keeps everything on the right of delimiter.
	# echo "DEBUG slashes_in_md_path_length="$slashes_in_md_path_length;
	if [ "$slashes_in_md_path_length" == "0" ]; then
		# This means that there are no Direcories and subdirectories in the file path in the Markdown link
		name_of_target_file=${round_brackets_part_of_md_link##*(}
		id_of_target_file=$( grep -E -o -m 1 '([0-9]){14}' <<< "$name_of_target_file");
		empty_if_blocks="empty";
	else
		# This means that there are directories and sub directories in the markdown file path
		name_of_target_file=${round_brackets_part_of_md_link##*/}
		id_of_target_file=$( grep -E -o -m 1 '([0-9]){14}' <<< "$name_of_target_file");

	fi

	# echo "DEBUG name_of_target_file="$name_of_target_file;
	#debug_name_of_target_file_with_slash=$( echo "DEBUG name_of_target_file_with_slash="$name_of_target_file_with_slash);
	# echo "DEBUG round_brackets_part_of_md_link="$round_brackets_part_of_md_link;


	#echo "DEBUG name_of_target_file="$name_of_target_file;
	#echo "DEBUG id_of_target_file="$id_of_target_file;


	# Return the id of the name of the file
	echo "$id_of_target_file";
}







# Find the file in the Small CORE of notes
# Find its absolute path for the targeted file
# The search_for_current_file_id_inside_core() function will take as input:
# Argument1 an id of 14 digit number similar to 00000000000000 and return the absolute path of the targeted filename
# And will return the absolute path for the targeted file
# Or will return "1" if the id number does not exist inside MY CORE OF NOTES
search_for_current_file_id_inside_core(){
	# Find the target file in the Small CORE of notes
	# Basically I will find the absolute path for the targeted file
	# This is the command that I need
	# find $PWD -type f -name *20220503134040*
	# The global variable $PWD contains the present working directory, or the place from which the bash program was run
	#echo "DEBUG 01 ---->>>inside search function PWD="$PWD;
	local id="$1";

	# For example this is one example that needs to be run:
	# find "$PWD" -type f -name *20220503134650*
	#local absolute_path_of_target_file=$( find "$PWD" -type f -name *$1*);


	# Use the core_directory hard writen variable instead of "$PWD" to search for the ID it is the correct place to search for an id
	# I replaced this code that searches for an id number in my core of notes
	#absolute_path_of_target_file=$( find "$core_directory" -type f -name *$id*);
	#I repleced with this code below this line:
	# Because pipeing find output to a while loop makes my absolute_path_of_target_file more resilient and protects it from a rare case when multiple files have the same ID
	# Basically this small loop guarantess that I will alawasy only have 1 PATH FOR 1 FILE. Because everytime I find a new path I will overwrite the old one and so on...
	local absolute_path_of_target_file=$(one_absolute_path_when_multiple_identical_ids_exist "$core_directory" "$id");


	#echo "DEBUG absolute_path_of_target_file="$absolute_path_of_target_file;
	#echo "DEBUG absolute_path_of_source_file="$absolute_path_of_source_file;
	#TODO CHECK FOR FINDE EXIT CODE
	#find_exit_code=$( echo $?);
	#echo $?;
	local grep_message_length=${#grep_message};
	absolute_path_of_target_file_length=${#absolute_path_of_target_file};
	#echo "DEBUG non existen file with absolute_path_of_target_file="$absolute_path_of_target_file;

	# TODO There is a problem below, the conditions return a huge mess of a absolute path if there are multiple notes with the same id.
	#echo "find_exit_code="$find_exit_code;
	if [ "$absolute_path_of_target_file_length" != "0" ]; then
		# The find function found the id insisde my CORE OF NOTES
		#echo "DEBUG The file exists in my core";

		# Return the absolute path for the targeted file
		echo $absolute_path_of_target_file;
	else
		# The find function did not find the id inside my CORE OF NOTES
		# Maybe I deleted it or maybe it never existed or maybe the link was misspeled
		#echo "DEBUG The file does not exist in my core of notes";
		#echo "LOG MESSAGE: This file does not exist! with the id="$1;
		absolute_path_of_target_file="1";
		echo $absolute_path_of_target_file;

	fi

}







# The figure_out_relative_path_from_source_file_to_target_file() takes 2 paramenters:
# 1st parameter: absolute_path_of_source_file
# 2nd paramenter: absolute_path_of_target_file
figure_out_relative_path_from_source_file_to_target_file(){
	# This is the utility that I need:
	# realpath --relative-to=/foo/bar/source /foo/hello/target
	# relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_file" "$absolute_path_of_target_file");

	# Output the absolute_path_of_source_directory out of absolute_path_of_source_file
	local absolute_path_of_source_file=$1;
	local absolute_path_of_target_file=$2;
	#echo "DEBUG --> absolute_path_of_source_file after assignement="$absolute_path_of_source_file;
	#echo "DEBUG --> absolute_path_of_target_file after assignement="$absolute_path_of_target_file;
	#local absolute_path_of_source_directory=${absolute_path_of_source_file%/*};
	local absolute_path_of_source_directory=${absolute_path_of_source_file%/*};
	#echo "absolute_path_of_source_directory="$absolute_path_of_source_directory;
	#echo " ";
	local relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_directory" "$absolute_path_of_target_file");

	#echo "DEBUG relative_path_source_file_to_target_file="$relative_path_source_file_to_target_file;

	# TODO I need an if condition to check if relative path is 0 lenght, then not return if it is 0 or I don't know..
	# Function will return the relative path:
	echo $relative_path_source_file_to_target_file;
}



# The compare_old_md_link_to_new_md_link() function will will compare 2 markedown links and if the old md link will be different with the new md link,
# then it will be replaced
# The function takes 2 arguments
# Parameter1 will be old_markdown_link
# Parameter2 will be the new_markdown_link
# Parameter3 will be the line read from a file.
# Compare the old markdown link to the new markdown link
# If old_markdown_link == new_markdown_link
# Then: Do nothing
# Else: Rename the old_markdown_link with new_markdown_link
compare_old_md_link_to_new_md_link(){
	#echo "DEBUG ---> comparations of strings";
	local old_markdown_link=$1;
	local new_markdown_link=$2;
	local current_file_location=$3;

	# Equality Comparison
	if [ "$old_markdown_link" == "$new_markdown_link" ]; then
		#echo "DEBUG Strings match";
		#echo "DEBUG links are the same";
		local empty_if_blocks="empty";
	else
		#echo "DEBUG Strings don't match";
		#echo "DEBUG links are different";
		# Run sed and overwrite the old markdown link with the new markdown link on the current file
		#echo "DEBUG new_markdown_link="$new_markdown_link;
		#echo "DEBUG old_markdown_link="$old_markdown_link;

		# Log current:
		# Log the old markdwon link that is broken
		log_current_broken_old_md_link_found="$old_markdown_link";
		# Log the new markdown link that will replace the broken markdonw link
		log_current_fixed_with_new_md_link="$new_markdown_link";

		# Log final:
		# Log the total of broken markdonw links and the todal number of markdown links replaced with new fresh working links
		# $file_log_final_number_of_broken_markdown_links_found;
		# Fetch the value and increase it
		counter1=$[$(cat $file_log_final_number_of_broken_markdown_links_found) + 1];
		# Store the new value
		echo $counter1 > $file_log_final_number_of_broken_markdown_links_found;
		# $file_log_final_number_of_markdown_links_fixed;
		# Fetch the value and increase it
		counter2=$[$(cat $file_log_final_number_of_markdown_links_fixed) + 1];
		# Store the new value
		echo $counter2 > $file_log_final_number_of_markdown_links_fixed;


		# Prepare the links for sed
		# Prepare new_markdown_link_for_sed
		local new_markdown_link_for_sed=$new_markdown_link;
		new_markdown_link_for_sed=$(sed "s|\[|\\\[|g" <<< "$new_markdown_link_for_sed");
		new_markdown_link_for_sed=$(sed "s|\]|\\\]|g" <<< "$new_markdown_link_for_sed");

		# Prepare old_markdown_link_for_sed
		local old_markdown_link_for_sed=$old_markdown_link;
		old_markdown_link_for_sed=$(sed "s|\[|\\\[|g" <<< "$old_markdown_link_for_sed");
		old_markdown_link_for_sed=$(sed "s|\]|\\\]|g" <<< "$old_markdown_link_for_sed");

		#echo "DEBUG new_markdown_link_for_sed="$new_markdown_link_for_sed;
		#echo "DEBUG old_markdown_link_for_sed="$old_markdown_link_for_sed;

		# After I prepared the md links for sed now I will use sed on the file itslef!
		sed --in-place "s|$old_markdown_link_for_sed|$new_markdown_link_for_sed|g" "$current_file_location";
		#sed "s|$old_markdown_link_for_sed|$new_markdown_link_for_sed|g" "$current_file_location";
		#echo "DEBUG new sed output ---------------------------------------------------------------------------------";
		#echo "DEBUG old_markdown_link="$old_markdown_link;
		#echo "DEBUG new_markdown_link="$new_markdown_link;
		#echo "DEBUG new sed output ---------------------------------------------------------------------------------";
		return 0;

	fi

}




# And another functionality I want to implement is for the BASH program to ignore the code block
	# Basically chec if the line contains a 3 tilda sign ''' like this,
	# If the line contains the 3 tilda sign
		# Then ignore all the lines until you find the 3 tilda sign again
			# Do that by setting a boolean variable True or False.
			# There is no reson to pass a code block and parse it by the replace_broken_markdown_link()
			# Because I don't want to mess with actuall source code..
#GLOBAL VARIABLES:
# code_block_flag I defined as Boolean datatype for efficiency purposes, make the code faster...
# code_block_flag=false;
#
# are_you_inside_a_code_block() function takes in:
# Argument1: which is a line in a md file
are_you_inside_a_code_block(){
	local current_line=$1;
	local found_tildas=false;

	#current_line="\`\`\`javascript";
	#current_line="\`\`\`js";
	#current_line="\`\`\`css";
	#current_line="\`\`\`c";
	#current_line="something else";
	#echo "DEBUG $current_line";

	local tildas_pattern="\`\`\`";
	local grep_message=$( grep $tildas_pattern <<< "$current_line");
	local grep_message_length=${#grep_message};

	# echo "DEBUG grep_message="$grep_message;

	if [ "$grep_message_length" == "0" ]; then
		#echo "DEBUG The 3 tildas not found";
		#echo false;
		found_tildas=false;
	else
		#echo "DEBUG The 3 tildas found !!!";
		#echo true;
		found_tildas=true;
	fi


	#echo "DEBUG found_tildas="$found_tildas;

	# Check if I am insied a code block
	local empty_if_blocks="empty";

	if [ "$code_block_flag" == false ]; then
		# It means I am outside a code block
		empty_if_blocks="empty";
		if [ "$found_tildas" == true ]; then
			# I found tildas and I am outside a code block
			# Set that I am inside a code block
			code_block_flag=true;

			# Log final: the total number of code blocks that wore avoided/skiped by my program
			#file_log_final_number_of_code_blocks_avoided
			# Fetch the value and increase it
			counter=$[$(cat $file_log_final_number_of_code_blocks_avoided) + 1];
			# Store the new value
			echo $counter > $file_log_final_number_of_code_blocks_avoided;

		else
			# I did not found tildas and I am outside code block
			# Do nothing
			empty_if_blocks="empty";
		fi
	else
		# It means I am inside a code block
		if [ "$found_tildas" == true ]; then
			# I found tildas and I am inside a code block
			# Set that I am outside a code block
			code_block_flag=false;
		else
			# I did not found tildas and I am inside a code block
			# Do nothing
			empty_if_blocks="empty";
		fi
	fi


#echo "DEBUG inside function code_block_flag="$code_block_flag;



}




# Write a function that extracts the extension of the target file from an absolute path.
# The extract_extension_from_path() function takes in a absolute path and extracts the extension of the file that md link points to
# It will be able to extract .md .png .jpeg .pdf .xxx
# and return the extension as a string
#[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)
#Testing extensions...
#old_absolute_path="[this_is_sparta_20220503225740](Wrong Folder/this_is_sparta_20220503225740.jpeg)";
# old_absolute_path="[this_is_sparta_20220503225740](Wrong Folder/this_is_sparta_20220506192225.pdf)";
#old_absolute_path="[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)";
# old_absolute_path="[this_is_sparta_20220503225740](Wrong Folder/this_is_sparta_20220506192225.excel)";
# old_absolute_path="[this_is_sparta_20220503225740](Wrong Folder/this_is_sparta_20220506192225.md)";
# The function takes in:
#Argument1 an markdown link to a file that has an extension.
extract_extension_from_path(){
	local absolute_path=$1;
	#echo "DEBUG absolute_path="$absolute_path;
	#a='he-llo/w.orld.jpeg';
	local extension=${absolute_path##*.};
	extension=${extension%)*};
	#echo "extension="$extension;
	echo $extension;
}









# This function will take a line of file as a string and return an array of markdown links patterns
# It may return in the array false links, but my program can recognise a false link
# I spend a lot of time trying to find the perfect regex pattern but this is the best for now: "(\[(.*?)\]\((.+?)\))"
# I spend a lot of time trying to deal with white space in a md link when passed to the array element...
# And the solution of character by charater to a buffer and then checking that buffer with grep was the only solution that worked after over 10 hours of work
# The arguments the functin takes:
# Argument1: It is a string that represints the current line of current file
# Retunrs an array of md patterns by using a global array variable.


# Pseudocode
#- Grab the line
#- Parse the line character by character
#- Add each character to a temporar buffer variable
#- Test that temporar buffer with grep
#- If I find a match in the temp buffer
#	- Then: Go and add that old markdown link to the array
#		- And reset the buffer to empty ""
#	- Else: Do nothing
#- Jump back up and add the next character to the buffer
#- Do that until I reach the end of the line.
#- At the end of the line I should have all the old md links inside the global array


# Testing the function with this lines:
#line="[first_20220503134650.md](First/first_note_20220503134650.md) [second_note_20220503134650.md](Second/second_note_20220503134650.md) [third_note_20220503134650.md](Third/third_note_20220503134650.md) [forth_note_20220503134650.md](Forth/forth_note_20220503134650.md)";
#line="link1 link2 link3 link4 link5 "
#line="[first_20220503134650.md](First/first_note_20220503134650.md) [second_note_20220503134650.md](Second/second_note_20220503134650.md) [third_note_20220503134650.md](Third/third_note_20220503134650.md) [forth_note_20220503134650.md](Forth/forth_note_20220503134650.md)";
#line="link1 link2 link3 link4 link5 "
#line="[link1](link1.md) [link2](link2.jpeg) [link3](link3.pdf) [link4](link4.ext)";
#line="[link1](link1.md) [link2](link2.jpeg) [link3](link3.pdf) [link4](link4.ext)";
#line=" link  [link1](l ink1.md) link [link2](li nk2.jpeg) [link3](lin k3.pdf) [link4](link 4.ext)";
#line=" link  [l ink1](l in k1.md) link [l ink2](li n k 2.jpeg) [lin k3](l  in k   3.pdf) [li nk4](li nk 4.ext)";
#line=" link  [l ink1](Directory name1/l in k1.md) link [l ink2](Directory name2/ Directory lalal/li n k 2.jpeg) [lin k3](l  in k   3.pdf) [li nk4](li nk 4.ext)";
#line="Lorem ispus (bla bla) lorem lalalal [link1](link1.md)";
#line="Lorem ispus [button] lorem lalalal [link1](link1.md)";
#line="This line does not have no markdown link";
#line="[second_note_20220503134544.md](Renamed link1 Other notes/second_note_20220503134544.md)  [some_note_20220503134511.md](Renamed link2 Other notes/some_note_20220503134511.md)  [apples_20220509203642.md](Renamed Link3 Other notes/apples_20220509203642.md)  ";

return_an_array_of_md_patterns_from_a_line(){
	#- Grab the line
	local current_line_in_current_file="$1";
	#echo "DEBUG current_line_in_current_file="$current_line_in_current_file;

#Testing testing:
#old_markdown_link=$( grep -E -o -m 1 '\[.*\]\(.*\)\ ' <<< "$current_line_in_current_file");
#old_markdown_link=$( grep -E -o -m 1 "link([0-9]){1}[[:space:]]" <<< "$current_line_in_current_file");
#echo "DEBUG old_markdown_link="$old_markdown_link;
# grep -E -o -m 1 "link([0-9]){1}[[:space:]]" <<< "$current_line_in_current_file";
#grep -E -o  "link5" <<< "$current_line_in_current_file";

# Loop one character at the time
# Markdown link looks like this:
# [foo](Directory1/Directory2/file_20220510182039.ext)


local buffer_temp="";
local character="";
local string="$current_line_in_current_file";


#- Parse the line character by character
for (( i=0; i<${#string}; i++ )); do
	#echo $i;
	#This is how to access a character in a string from a "for" loop:
	character=${string:$i:1};
	#echo "DEBUG $character";




	#- Add each character to a temporar buffer variable
	buffer_temp+=$character;
	#echo "DEBUG buffer_temp="$buffer_temp;

	# The regex form to recognise a Markdown link in a string
	local regex_pattern="(\[(.*?)\]\((.+?)\))";
	#local regex_pattern="((!?\[[^\]]*?\])\((?:(?!http|www\.|\#|\.com|\.net|\.info|\.org).)*?\))";
	#local regex_pattern="\[([^\[\]]*)\]\((.*?)\)";

	local md_pattern_found=$(grep -E -o -m 1 "$regex_pattern" <<< "$buffer_temp");
	#echo "md_pattern_found="$md_pattern_found;
	local length_of_md_pattern_found=${#md_pattern_found};

	if [ "$length_of_md_pattern_found" != "0" ]; then
		#echo "DEBUG found!!!";
		#echo "length_of_md_pattern_found="$length_of_md_pattern_found;
		# #	- Then: Go and add that old markdown link to the array
		#		- And reset the buffer to empty ""
		global_array_of_md_patterns[$index_global_array]="$md_pattern_found";
		#echo "DEBUG md_pattern_found="$md_pattern_found;
		index_global_array=$(($index_global_array+1));
		#echo "DEBUG index_global_array="$index_global_array;

		buffer_temp="";

	else
		# Do nothing
		local empty_if_block="empty";
	fi


#- Jump back up and add the next character to the buffer
#- Do that until I reach the end of the line.

done

#echo "buffer_temp="$buffer_temp;

#- At the end of the line I should have all the old md links inside the global array




# Return value
#global_array_of_md_patterns as a global array doesn't need to be returned but this function touches and modifies this array at each line of the file;


}






# Use the core_directory hard writen variable instead of "$PWD" to search for the ID it is the correct place to search for an id
# I replaced this code that searches for an id number in my core of notes
# absolute_path_of_target_file=$( find "$core_directory" -type f -name *$id*);
# I repleced with this function one_absolute_path_when_multiple_identical_ids_exist() below this line:
# Because pipeing find output to a while loop makes my absolute_path_of_target_file more resilient and protects it from a rare case when multiple files have the same ID
# Basically this small loop guarantess that I will alawasy only have 1 PATH FOR 1 FILE. Because everytime I find a new path I will overwrite the old one and so on...

# This function searches through my core of notes for an id. And returns one path to the file
# Even if there are multiple files that have an identical IDs, my functio will exit after one iteration
# Will exit because the "return" command that I put inside the loop.
# This will prevent the loop to keep adding multiple paths.
# This function takes in two Arguments:
# Argument1: The $core_directory path, absolute path where the find utility will search for the ID
# Argument2: Will be the $id. The ID number for the note or file I want to get the absolute path for.
one_absolute_path_when_multiple_identical_ids_exist(){

	local core_directory="$1";
	local id="$2";

	find "$core_directory" -type f -name *$id* | while read fname; do

		# Inside the while loop
		#echo "fname="$fname;
		local absolute_path_of_target_file=$fname;
		echo $absolute_path_of_target_file;
		return 0;
		# I need a tempfile that stores the absolute_path_of_target_file data
		# Because I can't access the absolute_path_of_target_file variable outside the loop
		# I chose to make a function and echo once! and avoid the hassle with files or arrays...
		#echo "DEBUG absolute_path_of_target_file="$absolute_path_of_target_file;
		#echo "-----------------------------------------------------"

	done



}







# This is the output that this function will give after each line:

#LOG CURRENT FILE PATH                 =
#LOG CURRENT NUMBER OF DIRECTORIES PATH=
#LOG CURRENT MD LINK FOUND             =
#LOG CURRENT BROKEN OLD MD LINK FOUND  =
#LOG CURRENT FIXED WITH NEW MD LINK    =
#LOG CURRENT NUMBER OF MD LINKS ON LINE=
#LOG CURRENT LINE TEXT CONTENT         =
#----------------------------------------------------------------------------------------------------------------
#NEXT LINE
#----------------------------------------------------------------------------------------------------------------


log_current(){
echo "LOG CURRENT FILE PATH                 ="$log_current_file_path;
echo "LOG CURRENT NUMBER OF DIRECTORIES PATH="$log_current_number_of_directories_path;
echo "LOG CURRENT MD LINK FOUND             ="$log_current_md_link_found;
echo "LOG CURRENT BROKEN OLD MD LINK FOUND  ="$log_current_broken_old_md_link_found;
echo "LOG CURRENT FIXED WITH NEW MD LINK    ="$log_current_fixed_with_new_md_link;
echo "LOG CURRENT NUMBER OF MD LINKS ON LINE="$log_current_number_of_md_links_on_line;
echo "LOG CURRENT LINE TEXT CONTENT         ="$log_current_line_text_content;
echo "----------------------------------------------------------------------------------------------------------------";
echo "NEXT LINE";
echo "----------------------------------------------------------------------------------------------------------------";

# After printing the log variables reset them:
#log_current_file_path="";
#log_current_number_of_directories_path="";
log_current_md_link_found="";
log_current_broken_old_md_link_found="";
log_current_fixed_with_new_md_link="";
log_current_number_of_md_links_on_line="";
log_current_line_text_content="";


}





# The log_final() function will print a final log after the program runs with interesting statistics..
# Basically sits in the background with a bunch of global variables and counts differents events that I consider important


#( ▀ ͜͞ʖ▀) MARKDOWN-LINKS-FIXER BY CONSTANTIN LUCIU
#
####################################################################
# LOG FINAL STATISTICS:
# LOG TOTAL NUMBER OF IDS THAT DO NOT EXIST IN MY CORE OF NOTES=
# LOG TOTAL NUMBER OF FILES CHECKED=
# LOG TOTAL NUMBER OF LINES READ=
# LOG TOTAL NUMBER OF CODE BLOCKS AVOIDED=
# LOG TOTAL NUMBER OF MARKDOWN LINKS CHECKED=
# LOG TOTAL NUMBER OF BROKEN MARKDOWN LINKS FOUND=
# LOG TOTAL NUMBER OF MARKDOWN LINKS FIXED=
#
# LOG THE MOST MARKDOWN LINKS ON 1 SINGLE LINE OF TEXT=
# LOG THE DEEPEST DIRECTORY PATH HAS THIS NUMBER OF DIRECTORIES=
####################################################################



log_final(){
	#log_final_number_of_ids_do_not_exist=0;
	#log_final_number_of_files_checked=0;
	#log_final_number_of_lines_read=0;
	#log_final_number_of_code_blocks_avoided=0;
	#log_final_number_of_markdown_links_checked=0;
	#log_final_number_of_broken_markdown_links_found=0;
	#log_final_number_of_markdown_links_fixed=0;

	#log_final_the_most_md_links_in_one_line=0;
	#log_final_the_directories_in_one_path=0;



echo "                                                  ";
echo "                                                  ";
echo "                                                  ";
echo "                                                  ";
echo "                                                  ";
echo "                                                  ";
echo "                                                  ";
echo "                                                  ";
echo "# ( ▀ ͜͞ʖ▀) MARKDOWN-LINKS-FIXER BY CONSTANTIN LUCIU";
echo "#                                                  ";
echo "####################################################################";
echo "# LOG FINAL STATISTICS:";
echo "# LOG TOTAL NUMBER OF IDS THAT DO NOT EXIST IN MY CORE OF NOTES="$(cat $file_log_final_number_of_ids_do_not_exist);
echo "# LOG TOTAL NUMBER OF MD FILES CHECKED="$(cat $file_log_final_number_of_files_checked);
echo "# LOG TOTAL NUMBER OF LINES READ="$(cat $file_log_final_number_of_lines_read);
echo "# LOG TOTAL NUMBER OF CODE BLOCKS AVOIDED="$(cat $file_log_final_number_of_code_blocks_avoided);
echo "# LOG TOTAL NUMBER OF MARKDOWN LINKS CHECKED="$(cat $file_log_final_number_of_markdown_links_checked);
echo "# LOG TOTAL NUMBER OF BROKEN MARKDOWN LINKS FOUND="$(cat $file_log_final_number_of_broken_markdown_links_found);
echo "# LOG TOTAL NUMBER OF MARKDOWN LINKS FIXED="$(cat $file_log_final_number_of_markdown_links_fixed);
echo "#                                                        ";
echo "# LOG THE MOST MARKDOWN LINKS ON 1 SINGLE LINE OF TEXT="$(cat $file_log_final_the_most_md_links_in_one_line);
echo "# LOG THE DEEPEST DIRECTORY PATH HAS THIS NUMBER OF DIRECTORIES="$(cat $file_log_final_the_directories_in_one_path);
echo "####################################################################";

}

# $(cat $tempfile)


# Call the main() function that was defined at the top of this file
# The "$@" allows the main function to accept arguments from the command line if I will want to pass.
main "$@";








