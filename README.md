# 0012-fix-markdown-links-in-bash

## BASH SCRIPT TO FIX MARKDOWN LINKS

### Bellow I blogged my experience of building this project. Are logs from my Personal Journal on challenges that I had and how did I overcome them, while writing this large BASH project.





--------------------------------------------------------------------------------------

## Project Folder

Here is the project folder that I worked in and where I developed this script to a working capacity. It took me around 2 weeks and a lot of testing: 

`Small_CORE/Directory+5/Directory+4/Directory+3/Directory+2/Directory+1/Directory0/fix-markdown-links-v11.sh`



To run this bash script:

- Make sure you are on a Linux OS machine
- Go and clone the repository
- Navigate where the bash script is located, by fallowing this path: `Small_CORE/Directory+5/Directory+4/Directory+3/Directory+2/Directory+1/Directory0/fix-markdown-links-v11.sh`
- Open the `fix-markdown-links-v11.sh` file and make sure that the `core_directory` variable points to where `Small_CORE` directory is located on **your** computer. The default path will be set to: `core_directory="/home/zen101/Notebooks/coreNotebook/Small_CORE";`
- Run the script by opening the Terminal and typing `.fix-markdown-links-v11.sh`
- After a couple of seconds, the program will display the final logs message and all the broken markdown links are fixed.

-----------------------------------------------------------------





## Bellow I blogged my experience of building this project.

### To do a BASH script that fixes the markdown links

-   Use some Python script or BASH script to fix the Markdown links inside my files...
    
-   It will be quite a challenge to Automate this process. But once I have this tools/scripts then anytime when I want to modify something or some categories in my CORE of notes, I could just run this scripts and then fix all my notes in seconds and not days!!!!
    

This is what I want to do, but it will be a hard thing to do...  
So lets see what I can do.   
I will go and have a look at that bash script that I wrote a long time ago that was converting ZimWiki links to Markdown links. Maybe I do have some useful code in there.



The Pseudocode should be something like this:

- Start from the CORE root directory
- Move recursively through all the directories
- Open all the .md files or .txt files..  
- When you find an md link of syntax of pattern:
- `[file-name](path/to/file_00000000000000.md)`
- Then search for the `00000000000000.md` file, 
- Save it's relative path for `00000000000000.md` from current directory
- Compare the actual path to file with the searched path to file.
- If they are the same
	- Then: Nothing will be done
	- Else: The `path/to/file_00000000000000.md` will be replaced with `new/path/00000000000000.md`
- Repeat that for all the files in the CORE OF NOTES

Well this is the algorithm that I am thinking to use.. 
Well ...



## Linux relative path between two files

I am looking into how can I get a relative path between two absolute paths..  
It is a bit of work, but from what I read it is possible..  

```bash
zen101@vbox:absolute-to-relative-path$ tree
.
├── directory1
│   └── file1.txt
└── directory2
    └── file2.txt

3 directories, 1 file

```



I used the "realpath" command:
```bash
zen101@vbox:absolute-to-relative-path$ realpath --relative-to=/home/zen101/MY_STUFF/absolute-to-relative-path/directory1/ /home/zen101/MY_STUFF/absolute-to-relative-path/directory2/
```

The Terminal Outputs: 
```bash
../directory2
```

I knew how to use it by fallowing this question and answer web page:  
https://unix.stackexchange.com/questions/85060/getting-relative-links-between-two-paths  





--------------------------------------------------------------------
## Question:
# [Getting relative links between two paths](https://unix.stackexchange.com/questions/85060/getting-relative-links-between-two-paths)

Say I have two paths: `<source_path>` and `<target_path>`. I would like my shell (zsh) to automatically find out if there is a way to represent `<target_path>` from `<source_path>` as a relative path.

E.g. Let's assume

-   `<source_path>` is `/foo/bar/something`
-   `<target_path>` is `/foo/hello/world`

The result would be `../../hello/world`

## Why I need this:

I need like to create a symbolic link from `<source_path>` to `<target_path>` using a **relative** symbolic link whenever possible, since otherwise our samba server does not show the file properly when I access these files on the network from Windows (I am not the sys admin, and don't have control over this setting)

Assuming that `<target_path>` and `<source_path>` are absolute paths, the following creates a symbolic link **pointing to an absolute path**.

```bash
ln -s <target_path> <source_path>
```

so it does not work for my needs. I need to do this for hundreds of files, so I can't just manually fix it.

Any shell built-ins that take care of this?

------------------------------------------------------------------------------------

## Answer: 
Try using [`realpath` command](http://www.gnu.org/software/coreutils/realpath) (part of GNU `coreutils`; _>=8.23_), e.g.:

```bash
realpath --relative-to=/foo/bar/something /foo/hello/world
```

> If you're using macOS, install GNU version via: `brew install coreutils` and use `grealpath`.

Note that both paths need to exist for the command to be successful. If you need the relative path anyway even if one of them does not exist then add the -m switch.

For more examples, see [Convert absolute path into relative path given a current directory](https://stackoverflow.com/q/2564634/55075). 

ATTENTION!!!
THIS GUY FORGOT TO MENTION THAT `--relative-to=` NEEDS A DIRECTORY PATH AS A VALUE AND NOT, **I REPEAT NOT A FILE PATH**

------------------------------------------------------------------------------------



Ok 
```bash
symlinks -cr .
```
would be another option but it does not work for me. So I will stay with `realpath` utility.  



-------------------------------------------



## Find a targeted file using the id, get the absolute path of that file
Now lets find a file!  
Ok so the idea is to find a file and get its absolute path.  
This is the command that I need:

```bash
find $PWD -type f -name *20220503134040*
```

Will output:  
```bash
/home/zen101/MY_STUFF/absolute-to-relative-path/directory1/file_20220503134040.txt
```

I know this because I read this article:  
https://www.baeldung.com/linux/get-absolute-path  

Bellow is the interesting snippet that I really loved and will use!

---------------------

---------------------

## 6. Using the _find_ Command[](https://www.baeldung.com/linux/get-absolute-path#using-the-find-command)

## [](https://www.baeldung.com/linux/get-absolute-path#using-the-find-command)

The [_find_](https://www.baeldung.com/linux/find-command) command searches for files in a directory hierarchy. We can use this command to print the absolute path of a file:

```bash
$ cd /tmp/dir1/
$ find $PWD -type f -name file4.txt 
/tmp/dir1/dir2/dir3/dir4/file4.txt
```

------------------------------------

Which is the absolute path of the file that I am searching for!  
Cool.  
Now If I want to get it's relative path from one directory to another directory I can use `realpath` command.

Another way to get the absolute path of a file you can just run:



## [4. Using the _realpath_ Command](https://www.baeldung.com/linux/get-absolute-path#using-the-realpath-command)

## [get-absolute-path using-the-realpath-command](https://www.baeldung.com/linux/get-absolute-path#using-the-realpath-command)

Alternatively, we can use the [_realpath_](https://man7.org/linux/man-pages/man1/realpath.1.html) command to get the absolute path of a file:

```bash
$ cd /tmp/dir1/dir2/dir3/dir4/
$ realpath file4.txt 
/tmp/dir1/dir2/dir3/dir4/file4.txt
```

------------------------------

Ok I do think I have everything nice and neat :)   
Now I can start writing the source code in BASH...

I will write a simple bash program that only works with one file.  
It will go and fix the Markdown links in that file. 
There will only be one file and one directory with a couple of Attachments. 

![whiteboard_bash_rename_links_v01_20220503142344.png](../../../../../../../../06_Myself/01_My_Journal/Year2022/Month05/00_NOTES/Attachments/whiteboard_bash_rename_links_v01_20220503142344.png)



```bash
# Pseudocode

# fix-markdown-links-v00: This program will open 1 markdown file and fix its links. Because the md links stoped working because a Directory was renamed

# Open the md file
# Identify a markdown pattern
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
# Do this steps for all the links in the file.. 
```

And that is the pseudocode that I come up with. But I would like to eat something. And then I will continue with this small project...
I think it is a robust v01 pseudocode!  Now I will just eat something and then I will give it a try!  





## While loop in bash to iterate through a whole file until the end
I finally found the explanation of the while loop in bash that needs to be used to iterate recursively through directories in bash 
https://unix.stackexchange.com/questions/139363/recursively-iterate-through-files-in-a-directory  

Well I run into a problem.  
I have wrote this BASH code in a .sh file:

```bash
current_file_location="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md";
echo "DEBUG current_file_location="$current_file_location;
# Identify a markdown pattern
old_markdown_link=$( grep -E -o -m 1 --include="*.md" 'duck' $current_file_location);
echo "DEBUG $old_markdown_link="$old_markdown_link;
```



And when I run this code I do have this error:  
```
zen101@vbox:fix-markdown-links-v00$ ./fix-markdown-links-v00.sh 
DEBUG current_file_location=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
grep: /home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix: No such file or directory
grep: the: No such file or directory
grep: md: No such file or directory
grep: links: No such file or directory
grep: after: No such file or directory
grep: renaming/Fix: No such file or directory
grep: links: No such file or directory
grep: bash: No such file or directory
grep: script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md: No such file or directory
DEBUG =

```



So from what I see "grep" program doesn't like **spaces** in a file path. Hmm...  
How can I make "grep" to accept spaces. Well I need to understand the flags`grep -E -o -m 1 --include="*.md"`

What is `-E` flag?  
I got this from Documentation:  

**-E**, **--extended-regexp**
              Interpret _PATTERNS_ as extended regular expressions (EREs,
              see below).

from online grep man page:  
https://www.man7.org/linux/man-pages/man1/grep.1.html  

The alternative options for regular expresions acording to the Documentations are:  

```
   Pattern Syntax
       -E, --extended-regexp
              Interpret PATTERNS as extended regular expressions (EREs,
              see below).

       -F, --fixed-strings
              Interpret PATTERNS as fixed strings, not regular
              expressions.

       -G, --basic-regexp
              Interpret PATTERNS as basic regular expressions (BREs, see
              below).  This is the default.

       -P, --perl-regexp
              Interpret I<PATTERNS> as Perl-compatible regular
              expressions (PCREs).  This option is experimental when
              combined with the -z (--null-data) option, and grep -P may
              warn of unimplemented features.
```



And I read something interesting here on stackoverflow:  
https://stackoverflow.com/questions/67943781/what-are-the-differences-between-gnu-greps-basic-extended-and-pcre-p-regul  

So from what I do understand right now, the `-E` has to do with the type of RegularExpresions the RegEx used by grep when it searches strings..  



Ok what is `-o` flag?  

From documentation:
```text
       -o, --only-matching
              Print only the matched (non-empty) parts of a matching
              line, with each such part on a separate output line.
```





Interesting discution about matches here:  
https://stackoverflow.com/questions/4709912/how-to-make-grep-only-match-if-the-entire-line-matches  
But not exactly what I was looking for.  

I think "-o" it does not pring the whole line but only the match, I will test something 2 sec.. 

Ok so look here I am tired I will just write this and then I will stop.  

I just opened the directory and I have this text:

```text
duck on a lake

duck

chicken

frog
```

If I run this command with`-E --include="*.md"` I get:

```bash
zen101@vbox:Small_CORE$ grep -E --include="*.md" 'duck' note_test1_20220503134351.md 

duck on a lake 
duck

```

And if I run this command in terminal with `-m 1` I get: 

```bash
zen101@vbox:Small_CORE$ grep -E  -m 1 --include="*.md" 'duck' note_test1_20220503134351.md 

duck on a lake 
```

And now if I run this command with `-o` I get:  

```bash
zen101@vbox:Small_CORE$ grep -E -o -m 1 --include="*.md" 'duck' note_test1_20220503134351.md 

duck
```

If I run this command with`-E --include="*.txt"` I get nothing, becuase there is no txt file but one a file that ends up in .md:

```bash
zen101@vbox:Small_CORE$ grep -E --include="*.txt" 'duck' note_test1_20220503134351.md 

```

I do think by now you start to see and get the gist of the flags... that are used in my old grep ussage...  

But still the problem remains, why or how am I going to make get run with spaces.



----------------------------



I am hungry!  

But I made it I fucking made it !!!!!!!!!!!!!!!! Yes!! I found the answer here:
https://www.unix.com/os-x-apple-/208819-file-paths-spaces-variable.html  

And this was the snipet that helped me alot:

-------------------------------------------------------------------
## Question
### File paths with spaces in a variable
[tillett22](https://www.unix.com/member_modal.php?u=302133339)

Registered User

**2,** **0** ![Member Information Avatar](https://www.unix.com/images/user_info_64_64.png) 

**File paths with spaces in a variable**


Hi all my very first post so go easy on me!!  

I am trying to build a very simple script to list a file path with spaces in. But I can't get around this problem. My script is as follows:  

```bash
#!/bin/bash  
X="/Library/Users/Application\ Support/"  
  
LS="ls"  
AL="-al"  
  
$LS $AL $X  
```

The response I get is this  
```  
ls: /Library/Application\: No such file or directory  
ls: Support/: No such file or directory  
```

I know this is a problem with the space in the file path but I thought the "" would pass to the commandline with no issues but I am wrong.


-------------------------------------------------------------------
## Answers: 

[RudiC](https://www.unix.com/member_modal.php?u=302122047)

Registered User

**15,129,** **5,008** ![Member Information Avatar](https://www.unix.com/images/user_info_64_64.png) 

Try double quoting to preserve spaces:

Code:
```bash
$LS $AL "$X"
```


-------------------------------------------
[elixir_sinari](https://www.unix.com/member_modal.php?u=302109747)

Registered User

**1,413,** **498** ![Member Information Avatar](https://www.unix.com/images/user_info_64_64.png) 

And the back-slash is unnecessary in the path:  

Code:
```bash
X="/Library/Users/Application Support/"

```

-----------------------------------------------------------
[tillett22](https://www.unix.com/member_modal.php?u=302133339)

Registered User

**2,** **0** ![Member Information Avatar](https://www.unix.com/images/user_info_64_64.png) 

That has worked ![Smilie](https://www.unix.com/images/smilies/smile.gif "Smilie") Thank you !!  

So am I quoting in the wrong place? Should I quote when the variable is defined or when it is read  

i.e. "$X" and $X

-----------------------------------------------------------------------------
[RudiC](https://www.unix.com/member_modal.php?u=302122047)

Registered User

**15,129,** **5,008** ![Member Information Avatar](https://www.unix.com/images/user_info_64_64.png) 

When defining, you can use quotes, but also escape spaces like "\ ". When referencing, double quotes keep the shell from splitting the variable's contents into several words at spaces.

----------------------------------------------------------------

This blogs are from this website: 
https://www.unix.com/os-x-apple-/208819-file-paths-spaces-variable.html

This is very useful so now I did this and the code is working.  

```bash
current_file_location="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md";
echo "DEBUG current_file_location="$current_file_location;
# Identify a markdown pattern
old_markdown_link=$( grep -E -o -m 1 --include="*.md" 'duck' "$current_file_location");
echo "DEBUG $old_markdown_link="$old_markdown_link;

```

Notice the double quotes in the line where I use grep, here:

```bash
grep -E -o -m 1 --include="*.md" 'duck' "$current_file_location"
                                   here ^             and here ^
```
I use double queotes ` "$current_file_location" ` around the variable that holds the path. I do this to force it to be interpreted as 1 string. And not multiple strings. 

And when I run the .sh script now I get this beautiful output in the Terminal: 

```
zen101@vbox:fix-markdown-links-v00$ ./fix-markdown-links-v00.sh 
DEBUG current_file_location=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG duck=duck
```

Perfect exactly what I wanted.

Ok ok I am really hungry now I am going to eat that soup :) 

-----------------------------------------------------------



Temp testing regex:
```
\/.*\.[md]
```


I figure it out!  
This is the regular expression that I want, to use to identify an id im my filename.
```regex
([0-9]){14}
```

By using the regex above, I was able to extract the id from the file name:

```bash

# Extract the id from the old markdown link
name_of_target_file=$( grep -E -o -m 1 --include="*.md" '\/.*\.md' <<< "$old_markdown_link");
echo "DEBUG name_of_target_file="$name_of_target_file;
# This is the regex I want to use /([0-9]){14}/g
id_of_target_file=$( grep -E -o -m 1 --include="*.md" '([0-9]){14}' <<< "$name_of_target_file");
echo "DEBUG id_of_target_file="$id_of_target_file;
```

Output:

```
zen101@vbox:fix-markdown-links-v00$ ./fix-markdown-links-v00.sh 
DEBUG current_file_location=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG name_of_target_file=/first_note_20220503134650.md
DEBUG id_of_target_file=20220503134650
```

Ok it looks good :) 


Alright I just finished this:

```bash
# Find the target file in the Small CORE of notes
# Basically I will find the absolute path for the targeted file
#This is the command that I need
# find $PWD -type f -name *20220503134040*
echo "DEBUG what is PWD variable="$PWD;

# For example this is one example that needs to be run:
# find "$PWD" -type f -name *20220503134650*
absolete_path_of_target_file=$( find "$PWD" -type f -name *$id_of_target_file*);
echo "DEBUG absolete_path_of_target_file="$absolete_path_of_target_file;


```



At this point I found the absolute path for the targeted file. Which is great!  
Now I will just need to compare the absolute file path to the absolute file path of the source file and see if they are differnt! 
Wanderful yeyeyeyeye 

But Fist I will go and have a break!  



## Errors with realpath

I wrote this.
```bash

# Figure out the relative path from source_file to target_file
# This is the utility that I need:
# realpath --relative-to=/foo/bar/source /foo/hello/target
relative_path_source_file_to_target_file=$( realpath --relative-to="$absolete_path_of_source_file" "$absolete_path_of_target_file" );
echo "DEBUG relative_path_source_file_to_target_file="$relative_path_source_file_to_target_file;


```

And I have this error: 

```
realpath: '': No such file or directory
DEBUG relative_path_source_file_to_target_file=
```

Hmm what is wrong, what did I do wrong?

Hmm I wrote the command manually (not in script) to figure out if it works like that, and it works:

```

zen101@vbox:fix-markdown-links-v00$ ./fix-markdown-links-v00.sh 
DEBUG current_file_location=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG name_of_target_file=/first_note_20220503134650.md
DEBUG id_of_target_file=20220503134650
DEBUG what is PWD variable=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00
DEBUG absolete_path_of_target_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Renamed Other notes/first_note_20220503134650.md
realpath: '': No such file or directory
DEBUG relative_path_source_file_to_target_file=

zen101@vbox:fix-markdown-links-v00$ realpath --relative-to="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md" "/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Renamed Other notes/first_note_20220503134650.md"
../Renamed Other notes/first_note_20220503134650.md

zen101@vbox:fix-markdown-links-v00$ 

```


You see, it outputs correctly:
```
../Renamed Other notes/first_note_20220503134650.md
```

But why doesn't it work while in my script?


I even tryed this 
```bash
realpath --relative-to=`$absolete_path_of_source_file` `$absolete_path_of_target_file`;
```

and still doesn't work. I still get this error:
```
realpath: missing operand
```

So far this code:

```bash
# Figure out the relative path from source_file to target_file
# This is the utility that I need:
# realpath --relative-to=/foo/bar/source /foo/hello/target
echo "DEBUG temp absolute_path_of_source_file="$absolute_path_of_source_file;
echo "DEBUG temp absolete_path_of_target_file="$absolete_path_of_target_file;
# relative_path_source_file_to_target_file=$(realpath --relative-to="$absolete_path_of_source_file"" ""$absolete_path_of_target_file");
my_realpath="realpath --relative-to=";
command1=$(echo "$my_realpath${absolete_path_of_source_file} $absolete_path_of_target_file");
echo "DEBUG command1="$command1;
```

Outputs this:

```
DEBUG temp absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG temp absolete_path_of_target_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Renamed Other notes/first_note_20220503134650.md
DEBUG command1=realpath --relative-to= /home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Renamed Other notes/first_note_20220503134650.md

```

I see something wrong!!!
```
DEBUG command1=realpath --relative-to= /home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Renamed Other notes/first_note_20220503134650.md
```

Here!!!!

```
--relative-to= /home/zen101/MY_STUFF/Im
LOOK SPACE    ^ ATTENTION THERE SHOULD NOT BE ASPACE AT THAT POSITION, I NEED TO FIGURE OUT ANOTHER WAY... 
```
There is a space here, there should not be a space there.



## By the way how do you concatenate strings in bash?


I am trying this 

```bash
command1=$(echo "$my_realpath'$absolete_path_of_source_file' '$absolete_path_of_target_file'");
```

Still no chance :(

I think I am done here, I will stop and maybe tomorrow I will come up with some idea...

--------------------------------------------------------



## I found the bug it was a typo, misspelled the variable name
I found the bug, well a bug. It was a typo!!!  
Look here:

```bash
command1=$(echo "$my_realpath\"$absolete_path_of_source_file \" \"$absolete_path_of_target_file\"");
```

I typed **absolete_path_of_source_file** and then in other places I typed **absolute_path_of_source_file** that is where I f**ed up!!! I messed up "absolete" with "absolute"...
```
absolete_path_of_source_file
```

YEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS.

![this_is_sparta_20220503225740.jpeg](../../../../../../../../06_Myself/01_My_Journal/Year2022/Month05/00_NOTES/Attachments/this_is_sparta_20220503225740.jpeg)



I f**ing did it!!!!!!!!!!!!!!!!!!!!!  
WOW!

I am super happy and proud of myself that I did it!  
I mean I just sat with the problem, because I enjoy programming. I just love conquering this mountain for my own pleasure. I just love this black magic and the ability of becoming more powerful.  
I have fought today for hours and hours. And incredible I won!  
Wow I am very happy that I just persevered and sat with this. 
Ok I will take a quick break!  And maybe a movie?  Why the hell not I do deserve it ;)  



This is my script so far: 

```bash
#!/usr/bin/env bash



# Pseudocode

# fix-markdown-links-v00: This program will open 1 markdown file and fix its links. Because the md links stoped working because a Directory was renamed

# Open the md file
# Save the absolute path of source file in a variable
# Identify a markdown pattern
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
# Do this steps for all the links in the file..



total_of_links_found=0;

# Open the md file
current_file_location="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md";
echo "DEBUG current_file_location="$current_file_location;

# Save the absolute path of source file in a variable
absolute_path_of_source_file=$current_file_location;
echo "DEBUG absolute_path_of_source_file="$absolute_path_of_source_file;


# Identify a markdown pattern
# A markdown links looks like [foo](Directory A/Direcotry B/foo_20220503183504.md)
old_markdown_link=$( grep -E -o -m 1 --include="*.md" '\[.*\]\(.*\)' "$current_file_location");
echo "DEBUG old_markdown_link="$old_markdown_link;

# Extract the id from the old markdown link
name_of_target_file=$( grep -E -o -m 1 --include="*.md" '\/.*\.md' <<< "$old_markdown_link");
echo "DEBUG name_of_target_file="$name_of_target_file;
# This is the regex I want to use /([0-9]){14}/g
id_of_target_file=$( grep -E -o -m 1 --include="*.md" '([0-9]){14}' <<< "$name_of_target_file");
echo "DEBUG id_of_target_file="$id_of_target_file;

# Find the target file in the Small CORE of notes
# Basically I will find the absolute path for the targeted file
#This is the command that I need
# find $PWD -type f -name *20220503134040*
echo "DEBUG what is PWD variable="$PWD;

# For example this is one example that needs to be run:
# find "$PWD" -type f -name *20220503134650*
absolute_path_of_target_file=$( find "$PWD" -type f -name *$id_of_target_file*);
echo "DEBUG absolute_path_of_target_file="$absolute_path_of_target_file;

# Figure out the relative path from source_file to target_file
# This is the utility that I need:
# realpath --relative-to=/foo/bar/source /foo/hello/target
echo "DEBUG temp absolute_path_of_source_file="$absolute_path_of_source_file;
echo "DEBUG temp absolute_path_of_target_file="$absolute_path_of_target_file;
# relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_file"" ""$absolute_path_of_target_file");
relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_file" "$absolute_path_of_target_file");
echo "DEBUG Typo mistake absolute_path_of_source_file="$absolute_path_of_source_file;
my_realpath="realpath --relative-to=";
# command1=$(echo "$my_realpath\"$absolute_path_of_source_file\" \"$absolute_path_of_target_file\"");
# echo "DEBUG command1="$command1;
# $command1;
#realpath --relative-to=`$absolute_path_of_source_file $absolute_path_of_target_file`;
#"$my_realpath{$absolute_path_of_source_file} $absolute_path_of_target_file";
echo "DEBUG relative_path_source_file_to_target_file="$relative_path_source_file_to_target_file;



```



And if run the output would be:

```bash
zen101@vbox:fix-markdown-links-v00$ ./fix-markdown-links-v00.sh 
DEBUG current_file_location=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG name_of_target_file=/first_note_20220503134650.md
DEBUG id_of_target_file=20220503134650
DEBUG what is PWD variable=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00
DEBUG absolute_path_of_target_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Renamed Other notes/first_note_20220503134650.md
DEBUG temp absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG temp absolute_path_of_target_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/Renamed Other notes/first_note_20220503134650.md
DEBUG Typo mistake absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG relative_path_source_file_to_target_file=../Renamed Other notes/first_note_20220503134650.md

```

And this is the file tree if curios:

```bash
zen101@vbox:fix-markdown-links-v00$ tree
.
├── fix-markdown-links-v00.sh
├── old ZimWiki sourcode
│   ├── zimLinks_to_markdownLinks_v9.sh
│   └── zimPictures_to_markdownPictures_v4.sh
└── Small_CORE
    ├── Attachments
    ├── note_test1_20220503134351.md
    └── Renamed Other notes
        ├── first_note_20220503134650.md
        ├── second_note_20220503134544.md
        └── some_note_20220503134511.md

```



The code finaly does what I want it to do. and this line actually works perfectly:

```bash
relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_file" "$absolute_path_of_target_file");
```



So actually when I had this error a couple of hours ago [Errors with realpath](#Errors with realpath) header, it was just the fact that I miss spelled absolute, and I wrote "absolete" instead of "absolute".  What the F! such a small small typo..  
But because I don't know BASH that well I thought it was the syntax or something to do with double quotes or something, but the fact was that I misspelled the name of the variable... 

Hahaha 
I should laugh...
I should cry...

hahah 



------------------------------------------------

I will relax a little, maybe watch a movie and then go to bed.  
Really happy with the results of today. 
If I move at this pace, I will soon have an algo that will fix all my links any time I modify something in my core. And to be hones I learned a little bit of programming to. Which is fine by me :) 

Win win :) 





---------------------------------------------------------------------------------------------------------------------------------------------

Yesterday I pushed really hard into finishing that BASH code, but I didn't finish it. I hope today I will get closer to what I want!  

The this sed code works
```bash
new_markdown_link=$(echo $old_markdown_link | sed s/\]\(\.*\)/foo/g);
```

I had this line of code:
```bash
sed s/\]\(\.*\)/foo\]\("$relative_path_source_file_to_target_file"\)foo/g
```

But it was not working and here I found what why:  
https://www.baeldung.com/linux/sed-substitution-variables  



Basically this is the important snippet:

------------------------------------------------------------------------------------------

### 4.1. Choosing a Delimiter Not Contained in the Variable[](https://www.baeldung.com/linux/sed-substitution-variables#1-choosing-a-delimiter-not-contained-in-the-variable)

### [](https://www.baeldung.com/linux/sed-substitution-variables#1-choosing-a-delimiter-not-contained-in-the-variable)

To understand what has happened, let’s first check what’s in the environment variable _$JAVA_HOME_:

```bash
$ echo $JAVA_HOME 
/usr/lib/jvm/default
```

We’ve learned that shell variables will get expanded within double-quotes. Therefore, after the variable expansion, our second _sed_ command becomes:

```bash
sed -i -r "s/^(JAVA_HOME =).*/\1 /usr/lib/jvm/default/" test.txt
```

Well, the above _sed_ command obviously won’t work because **the slashes (_/_) in the variable’s value interfere with the ‘_s_‘ command** (_s/pattern/replacement/_).

Fortunately, we can **choose other characters as the delimiter of the ‘_s’_ command**.

Let’s modify the second _sed_ command a little bit and use ‘#’ as the delimiter of the _s_ command:

```bash
sed -i -r "s#^(JAVA_HOME =).*#\1 $JAVA_HOME#" test.txt
```

Now, let’s test the script again:

```bash
$ ./solution.sh
$ cat test.txt 
CURRENT_TIME = Wed Jan 27 10:36:57 PM CET 2021
JAVA_HOME = /usr/lib/jvm/default
```

Great! The problem is solved — or is it?


------------------------------------------------------------------------------------------



I wrote this line of code and not it seams that it is working, sort of:
```bash
new_markdown_link=$(echo $new_markdown_link | sed "s|\]\(\.*\)|\]\($relative_path_source_file_to_target_file\)|g");
echo "DEBUG new_markdown_link="$new_markdown_link;
```

The output is:

```
DEBUG new_markdown_link=[first_note_20220503134650.md](../Renamed Other notes/first_note_20220503134650.md)(Other notes/first_note_20220503134650.md)
```

Hmm not what I expected but it is a little bit better...  

**Be very carefull with spaces in bash !!**

Ok I just lerned that:

> **`(` isn't a special character in sed regular expressions. You don't need to escape it.** 

Ohh you sed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



Read more from here:
https://unix.stackexchange.com/questions/80946/how-to-use-sed-with-round-brackets  

I realised that by doing this code:

```bash
# [first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
new_markdown_link=$(sed "s|\](.*\)|DUCK|g" <<< "$old_markdown_link");
```

And the output was something like this:  
```DEBUG relative_path_source_file_to_target_file=../Renamed Other notes/first_note_20220503134650.md
DEBUG before sed, new_markdown_link=
sed: -e expression #1, char 16: Unmatched ) or \)
Testing...
string2=name-link new-back-link
DEBUG new_markdown_link=
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)


```



And I was messing with sed a little to understand it, and this small test pointed me in the right direction:

```bash
# Testing something
echo "Testing...";
string1="name-link back-link";
#string2=$string1;
string2=$( sed "s|back-link|new-back-link|g" <<< "$string1");
echo "string2="$string2;
```

The output was:
```
Testing...
string2=name-link new-back-link
```

So the morale of the story is that I assumed that sed regular expressinos consider a round bracket "()" a special character ;(  

Ok here is the bad sed code:
```bash
new_markdown_link=$(echo $new_markdown_link | sed  "s|\]\(\.*\)|\]\($relative_path_source_file_to_target_file\)|g");
```
And here is the good sed code:
```bash
new_markdown_link=$(sed "s|\](.*)|\]($relative_path_source_file_to_target_file)|g" <<< "$old_markdown_link");
```

Ok that is fine :) 
But I just realised something, that the new relative path is wrong:

```
DEBUG new_markdown_link=[first_note_20220503134650.md](../Renamed Other notes/first_note_20220503134650.md)
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
```

Well the new path should be:
```
Renamed Other notes/first_note_20220503134650.md
```
And not:

```
../Renamed Other notes/first_note_20220503134650.md
```
What is going on, why is this wrong?

Ok I fixed it:
Here is the code:
```bash
echo "DEBUG absolute_path_of_source_file="$absolute_path_of_source_file;
my_directory="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE";
relative_path_source_file_to_target_file=$(realpath --relative-to="$my_directory" "$absolute_path_of_target_file");
echo "DEBUG relative_path_source_file_to_target_file="$relative_path_source_file_to_target_file;
```

The output for this bit is:
```
DEBUG relative_path_source_file_to_target_file=Renamed Other notes/first_note_20220503134650.md
```

Which is exactly what I wanted YES!!  

How did I know to replace the attribute value for the `--relative-to="$my_directory"` to directory instead of the location of the source file?  
Well I read thise posts where they wore talking about some sort of relative to base directory... 
https://unix.stackexchange.com/questions/293894/realpath-relative-base-and-relative-to  
But it didin't help..

Then I went after the official Documenattion for realpath:  
https://www.man7.org/linux/man-pages/man1/realpath.1.html  

Where I discovered this about `--relative-to=` flag. 

---------------------------------

```
DESCRIPTION         top

       Print the resolved absolute file name; all but the last component
       must exist

       -e, --canonicalize-existing
              all components of the path must exist

       -m, --canonicalize-missing
              no path components need exist or be a directory

       -L, --logical
              resolve '..' components before symlinks

       -P, --physical
              resolve symlinks as encountered (default)

       -q, --quiet
              suppress most error messages

       --relative-to=DIR
              print the resolved path relative to DIR

       --relative-base=DIR
              print absolute paths unless paths below DIR

       -s, --strip, --no-symlinks
              don't expand symlinks

       -z, --zero
              end each output line with NUL, not newline

       --help display this help and exit

       --version
              output version information and exit

```

-----------------------------------------------------------------

As you can see in the official documentation:
>        --relative-to=DIR
>             print the resolved path relative to DIR

You need to pass a Directory address to the `--relative-to=` option, and not a file address. That helped me alot to figure out where I did the mistake!  



## If statement, if condition

This is how you compare 2 strings in bash:

```bash
# Equality Comparison
if [ "$a" == "$b" ]; then
    echo "Strings match"
else
    echo "Strings don't match"
fi
```

I just realised that square brackets have special meaning in sed utility. So I will need to escape them. Pre process the markdown links for them to be able to be processed by sed!!!!!!!!!!!!!!  

```bash
	sed "s|\[first_note_20220503134650.md\](Other notes/first_note_20220503134650.md)|foooooooooo|g" "$current_file_location";
```

This will target my links :

```
======= =======

 **::TTaaggss/QQuueessttiioonnss::**


 **::CCoonntteenntt_AAccttuuaall::**

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Pretium aenean  pharetra magna ac placerat vestibulum lectus mauris ultrices. Tortor  condimentum lacinia quis vel eros. Velit ut tortor pretium viverra  suspendisse potenti nullam. Non consectetur a erat nam at. Sed egestas  egestas fringilla phasellus faucibus. Duis ultricies lacus sed turpis  tincidunt id aliquet risus. Metus aliquam eleifend mi in. Viverra vitae  congue eu consequat ac. Amet consectetur adipiscing elit duis. Dolor  magna eget est lorem ipsum dolor. Commodo elit at imperdiet dui accumsan sit amet. Viverra nibh cras pulvinar mattis. Magna sit amet purus  gravida quis blandit turpis. Lacus vel facilisis volutpat est velit  egestas dui. Nibh cras pulvinar mattis nunc sed blandit libero volutpat  sed. Dictum fusce ut placerat orci nulla pellentesque dignissim enim.  Tincidunt praesent semper feugiat nibh sed pulvinar proin gravida  hendrerit. Morbi blandit cursus risus at.



 foooooooooo

foooooooooo

 [second_note_20220503134544.md](Other notes/second_note_20220503134544.md)

 [some_note_20220503134511.md](Other notes/some_note_20220503134511.md)

duck on a lake

duck

chicken eating corn


frog

Test the realpath generated:

[first_note_20220503134650.md](../Renamed Other notes/first_note_20220503134650.md)





 **::CCoonntteenntt_SSuummmmaarryy::**


 **::IInntteerrnnaall LLiinnkkss::**


 **::RReeffeerreenncceess::**


 **::EExxtteerrnnaall LLiinnkkss::**

```



But it does that because I escaped the square fucking brakes `[` fuck!  Another shit to worry about!!!  

I will go for a walk...

Ok it works, I finaly made sed working:

```bash
	# Prepare the links for Sed
	# Prepare new_markdown_link_for_sed
	new_markdown_link_for_sed=$new_markdown_link;
	new_markdown_link_for_sed=$(sed "s|\[|\\\[|g" <<< "$new_markdown_link_for_sed");
	new_markdown_link_for_sed=$(sed "s|\]|\\\]|g" <<< "$new_markdown_link_for_sed");

	# Prepare old_markdown_link_for_sed
	old_markdown_link_for_sed=$old_markdown_link;
	old_markdown_link_for_sed=$(sed "s|\[|\\\[|g" <<< "$old_markdown_link_for_sed");
	old_markdown_link_for_sed=$(sed "s|\]|\\\]|g" <<< "$old_markdown_link_for_sed");

	echo "DEBUG new_markdown_link_for_sed="$new_markdown_link_for_sed;
	echo "DEBUG old_markdown_link_for_sed="$old_markdown_link_for_sed;

	# After I prepared the md links for sed now I will use sed on the file itslef!
	sed "s|$old_markdown_link_for_sed|$new_markdown_link_for_sed|g" "$current_file_location";
```

I basically inserted those special characters inside the old_markdown_link_for_sed and new_markdown_link_for_sed.. 
The output would be:

```
DEBUG new_markdown_link=[first_note_20220503134650.md](Renamed Other notes/first_note_20220503134650.md)
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG new_markdown_link_for_sed=\[first_note_20220503134650.md\](Renamed Other notes/first_note_20220503134650.md)
DEBUG old_markdown_link_for_sed=\[first_note_20220503134650.md\](Other notes/first_note_20220503134650.md)
```

And it replaced the strings I wanted.

I arrived at the last step for this first version:



## Do this steps for all the links in the file..

How Do I do that?

"While loop in bash to iterate through a whole file until the end" in that log of my Journal.

Learn more about "find" tool in linux.

```bash
# find all the file in a directory
find . 

# find all the directories in a directory
find . -type d

# find all the files in the current directory
find . -type f

# find only filex that end up in ".md" extension
find . -type f -name "*.md"












```



By the way this video was useful teaches me how to loop and read a text file line by line using 3 Methods:
https://www.youtube.com/watch?v=fk7G76lyDCI  


--------------------------



While I was walking in my long walk I sort of realised that my only decent solution is to read from a text file line by line. And then deal with one line of text at the time. By one line of text I mean any string that ends in `\n` character aka. the null character or line special character. Anyway after I come home and relaxed a little because I am still annoyed with this script because it takes wayyyy more time than I imagined, but I do have a felling that I am close to that solution. So I don't want to quit and lose all that potential profit. So anyway I created this simple program that I could use next time when I will continue with my bash script.

This little program read from one file, one line at the time, by using a loop until meets the end of file special character:
```bash

file="Small_CORE/note_test1_20220503134351.md";
number_of_line=0;

while read line;
do

	# Print the line number
	echo "number_of_line="$number_of_line;
	number_of_line=$(($number_of_line+1));
	#Read line by line a filename
	echo -e "$line"



done < $file

```

And maybe I could put everything in a neat simple BASH Function...  
But I never made a function in BASH so I don't really know how to use one... 
Anyway that is that.  



I wrote this code in bash

```bash
while read current_file_line;
do
	# CODE BLOCK TO BE EXECUTED...
done < $current_file_location
```

And I was geting this error:  

```
./fix-markdown-links-v00.sh: line 159: $current_file_location: ambiguous redirect
```



And after reading a little bit on this forum: 
https://stackoverflow.com/questions/33562736/bash-error-ambiguous-redirect-while-reading-file  

I realised what was the mistake:

```bash
while read current_file_line;
do
	# CODE BLOCK TO BE EXECUTED...
done < "$current_file_location"
```

I forgot about the blody `" "` double quotes aruond a variable that has a path that has spaces in it. Wanderful :)   

This is how the code currently looks like:

```bash
#!/usr/bin/env bash



# Pseudocode

# fix-markdown-links-v00: This program will open 1 markdown file and fix its links. Because the md links stoped working because a Directory was renamed

# Open the md file
# Save the absolute path of source file in a variable
# Identify a markdown pattern
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
# Do this steps for all the links in the file..



total_of_links_found=0;

# Open the md file
current_file_location="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md";
echo "DEBUG current_file_location="$current_file_location;


# Save the absolute path of source file in a variable
absolute_path_of_source_file=$current_file_location;
echo "DEBUG absolute_path_of_source_file="$absolute_path_of_source_file;
number_of_line=0;


while read current_file_line;
do

# Identify a markdown pattern
# A markdown links looks like [foo](Directory A/Direcotry B/foo_20220503183504.md)
old_markdown_link=$( grep -E -o -m 1 --include="*.md" '\[.*\]\(.*\)' "$current_file_line");
echo "DEBUG old_markdown_link="$old_markdown_link;


# Extract the id from the old markdown link
name_of_target_file=$( grep -E -o -m 1 --include="*.md" '\/.*\.md' <<< "$old_markdown_link");
echo "DEBUG name_of_target_file="$name_of_target_file;
# This is the regex I want to use /([0-9]){14}/g
id_of_target_file=$( grep -E -o -m 1 --include="*.md" '([0-9]){14}' <<< "$name_of_target_file");
echo "DEBUG id_of_target_file="$id_of_target_file;


# Find the target file in the Small CORE of notes
# Basically I will find the absolute path for the targeted file
#This is the command that I need
# find $PWD -type f -name *20220503134040*
echo "DEBUG what is PWD variable="$PWD;


# For example this is one example that needs to be run:
# find "$PWD" -type f -name *20220503134650*
absolute_path_of_target_file=$( find "$PWD" -type f -name *$id_of_target_file*);
echo "DEBUG absolute_path_of_target_file="$absolute_path_of_target_file;
echo "DEBUG absolute_path_of_source_file="$absolute_path_of_source_file;

# Figure out the relative path from source_file to target_file
# This is the utility that I need:
# realpath --relative-to=/foo/bar/source /foo/hello/target
# relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_file" "$absolute_path_of_target_file");
absolute_path_of_source_directory="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE";
relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_directory" "$absolute_path_of_target_file");
echo "DEBUG relative_path_source_file_to_target_file="$relative_path_source_file_to_target_file;



# Save the new markdown link in a variable
# fileMatchedStringSed=$( echo "$fileMatchedStringSed" | sed 's/\[/\\\[/g');
# I want to use sed to recognise the second part of the old md link the part in the round brackets:
# [foo](Directory A/Direcotry B/foo_20220503183504.md)
# new_markdown_link=$old_markdown_link;
# sed `s|\]\(\.*\)|foo|g`
# sed s/\]\(\.*\)/foo\]\("$relative_path_source_file_to_target_file"\)foo/g
#echo "DEBUG before sed, new_markdown_link="$new_markdown_link;
# new_markdown_link=$(echo $new_markdown_link | sed  "s|\]\(\.*\)|\]\($relative_path_source_file_to_target_file\)|g");
# new_markdown_link=$(echo $new_markdown_link | sed  "s|\]\(\.*\)|\]\($relative_path_source_file_to_target_file\)|g");
# new_markdown_link=$(sed "s|\]\(\.*\)|\]\(relative_path_source_file_to_target_file\)|g" <<< "$old_markdown_link");
# [first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
# new_markdown_link=$(sed "s|\](.*)|FUCK|g" <<< "$old_markdown_link");
new_markdown_link=$(sed "s|\](.*)|\]($relative_path_source_file_to_target_file)|g" <<< "$old_markdown_link");

# Testing something
#echo "Testing...";
#string1="name-link back-link";
#string2=$string1;
#string2=$( sed "s|back-link|new-back-link|g" <<< "$string1");
#echo "string2="$string2;


echo "DEBUG new_markdown_link="$new_markdown_link;
echo "DEBUG old_markdown_link="$old_markdown_link;




# Compare the old markdown link to the new markdown link
# If old_markdown_link == new_markdown_link
# Then: Do nothing
# Else: Rename the old_markdown_link with new_markdown_link
echo "comparations of strings";
# Equality Comparison
if [ "$old_markdown_link" == "$new_markdown_link" ]; then
    echo "Strings match";
	echo "links are the same";
else
    echo "Strings don't match";
	echo "links are different";
	# Run sed and overwrite the old markdown link with the new markdown link on the current file
	echo "DEBUG new_markdown_link="$new_markdown_link;
	echo "DEBUG old_markdown_link="$old_markdown_link;
	# sed "s|$old_markdown_link|$new_markdown_link|g" "$current_file_location";
	#var1="duck on";
	#var2="ha ha ha";
	#sed "s|$var1|$var2|g" "$current_file_location";
	#sed "s|$old_markdown_link|$new_markdown_link|g" "$current_file_location";
	#sed "s|[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)|[first_note_20220503134650.md](Renamed Other notes/first_note_20220503134650.md)|g" "$current_file_location";

	##sed "s|\[first_note_20220503134650.md\](Other notes/first_note_20220503134650.md)|foooooooooo|g" "$current_file_location";

	# Prepare the links for Sed
	# Prepare new_markdown_link_for_sed
	new_markdown_link_for_sed=$new_markdown_link;
	new_markdown_link_for_sed=$(sed "s|\[|\\\[|g" <<< "$new_markdown_link_for_sed");
	new_markdown_link_for_sed=$(sed "s|\]|\\\]|g" <<< "$new_markdown_link_for_sed");

	# Prepare old_markdown_link_for_sed
	old_markdown_link_for_sed=$old_markdown_link;
	old_markdown_link_for_sed=$(sed "s|\[|\\\[|g" <<< "$old_markdown_link_for_sed");
	old_markdown_link_for_sed=$(sed "s|\]|\\\]|g" <<< "$old_markdown_link_for_sed");

	echo "DEBUG new_markdown_link_for_sed="$new_markdown_link_for_sed;
	echo "DEBUG old_markdown_link_for_sed="$old_markdown_link_for_sed;

	# After I prepared the md links for sed now I will use sed on the file itslef!
	sed "s|$old_markdown_link_for_sed|$new_markdown_link_for_sed|g" "$current_file_location";

fi


# Do this steps for all the links in the file..
echo "DEBUG variable before the done code current_file_location="$current_file_location;

# Print the line number
echo " DEBUG number_of_line="$number_of_line;
number_of_line=$(($number_of_line+1));

#done < $current_file_location
done < "$current_file_location"



```

It looks too big and too monolitich... 
I don't like it!  
I hope that while I will work at this huge code, I will break it down in functions. then I can labe the functions and make it more modular, and easier to debug!  

---------------------------------------------------------------



## How to make a function in BASH?

This is how you declare a function in BASH:

```bash
function_name () {
	# YOUR CODE BLOCK YOUR COMMANDS GO HERE
}
```

Ok but how do you call the function after you made it?  

This is how you call a function, just write the function name:

```bash
#!/bin/bash

hello () {
	echo "Hello World";
}

hello;
```


Will output:
```
Hello World
```

This also works like a charm:
```bash
#!/bin/bash

print_something(){
	echo "Hello World";
}

print_something;
print_something;

```

The code will output:
```
zen101@vbox:fix-markdown-links-v00$ ./test.sh 
Hello World
Hello World

```



This article was useful on how to make functions in bash:
https://linuxhandbook.com/bash-functions/  

So ok I know how to make functions, but how Do I return a value from a function?

Read this part:

## Returning function values in bash

In many programming languages, functions do return a value when called; however, this is not the case with bash as bash functions do not return values.

When a bash function finishes executing, it returns the exit status of the last command executed captured in the **$?** variable. Zero indicates successful execution or a non-zero positive integer (1-255) to indicate failure.

You can use a **return** statement to alter the function’s exit status. For example, take a look at the following **error.sh** script:

```
#! /bin/bash

error () {
blabla
return 0
}

error
echo "The return status of the error function is: $?"
```

If you run the **error.sh** bash script, you might be surprised of the output:

```
kabary@handbook:~$ ./error.sh
./error.sh: line 4: blabla: command not found
The return status of the error function is: 0
```

Without the **return 0** statement, the **error** function would have never returned a non-zero exit status as **blabla** is results in a **command not found** error.

So as you can see, even though bash functions do not return values, I made a workaround by altering function exit statuses.

**You should also be aware that a return statement immediately terminates a function.**

ATTENTION IN BASH THE "return" KEYWORD DOES NOT RETURN A VARIABLE BUT ONLY RETURNS A STATUS CODE OF 0 OR NOT 0.  
ZERO MEANS SUCCESS AND NOT ZERO MEANS FAILURE OF THAT FUNCTION.. 
YOU CAN'T USE RETURN TO RETURN A VALUE

DON'T DO THIS:
```
function fun1(){
  return 34;
}

res=$(fun1);
echo $res;
```




DO THIS INSTEAD:
You can print a value like this if you want and then pipe it/ redirect it in a variable like bellow:
```bash
function fun1(){
  echo 34;
}

res=$(fun1);
echo $res;
```

An interesting question and answer at this link:
https://stackoverflow.com/questions/17336915/return-value-in-a-bash-function


This is the part:

----------------------------------------------------------------------------------

## Question:
# [Return value in a Bash function](https://stackoverflow.com/questions/17336915/return-value-in-a-bash-function)

Asked 8 years, 10 months ago

Modified [11 months ago](https://stackoverflow.com/questions/17336915/return-value-in-a-bash-function?lastactivity "2021-05-24 14:11:09Z")

Viewed 563k times

480

82

[](https://stackoverflow.com/posts/17336915/timeline)

I am working with a bash script and I want to execute a function to print a return value:

```bash
function fun1(){
  return 34
}
function fun2(){
  local res=$(fun1)
  echo $res
}
```

When I execute `fun2`, it does not print "34". Why is this the case?

--------------------------------------------------------
## Answer:
Although Bash has a `return` statement, the only thing you can specify with it is the function's own `exit` status (a value between `0` and `255`, 0 meaning "success"). So `return` is not what you want.

You might want to convert your `return` statement to an `echo` statement - that way your function output could be captured using `$()` braces, which seems to be exactly what you want.

Here is an example:

```bash
function fun1(){
  echo 34
}

function fun2(){
  local res=$(fun1)
  echo $res
}
```

Another way to get the return value (if you just want to return an integer 0-255) is `$?`.

```bash
function fun1(){
  return 34
}

function fun2(){
  fun1
  local res=$?
  echo $res
}
```

Also, note that you can use the return value to use Boolean logic - like `fun1 || fun2` will only run `fun2` if `fun1` returns a non-`0` value. The default return value is the exit value of the last statement executed within the function.

-------------------------------------------------------------------------------------------------------------------

This was really helpful now I will go and chek how do I pass some arguments to a function.

So in short I can get a value from a function by echoing on the standard in and pipe it in a variable, like what I did bellow:

```bash
print_something(){
	echo "42";
}


number=$(print_something);
echo $number;

```

--------------------------------------

​	Ok I will take a quick break and then continue with my bash script..

-------------------------------------------------

## Ok so how do I pass arguments to a function in bash?
Hmm I found this link:  
https://unix.stackexchange.com/questions/298706/how-to-pass-parameters-to-function-in-a-bash-script  

-----------------------------------------
# [How to pass parameters to function in a bash script?](https://unix.stackexchange.com/questions/298706/how-to-pass-parameters-to-function-in-a-bash-script)

Asked 5 years, 9 months ago

Modified [4 years, 3 months ago](https://unix.stackexchange.com/questions/298706/how-to-pass-parameters-to-function-in-a-bash-script?lastactivity "2018-01-14 18:43:16Z")

Viewed 116k times

20

6

[](https://unix.stackexchange.com/posts/298706/timeline)

I'd like to write a function that I can call from a script with many different variables. For some reasons I'm having a lot of trouble doing this. Examples I've read always just use a global variable but that wouldn't make my code much more readable as far as I can see.

Intended usage example:

```bash
#!/bin/bash
#myscript.sh
var1=$1
var2=$2
var3=$3
var4=$4

add(){
result=$para1 + $para2
}

add $var1 $var2
add $var3 $var4
# end of the script

./myscript.sh 1 2 3 4
```

I tried using `$1` and such in the function, but then it just takes the global one the whole script was called from. Basically what I'm looking for is something like `$1`, `$2` and so on but in the local context of a function. Like you know, functions work in any proper language.

---------------------------------------------------

## Answer:
To call a function with arguments:

```bash
function_name "$arg1" "$arg2"
```

The function refers to passed arguments **by their position (not by name)**, that is $1, $2, and so forth. $0 is the name of the script itself.

Example:

```bash
#!/bin/bash

add() {
    result=$(($1 + $2))
    echo "Result is: $result"
}

add 1 2
```

Output

```bash
./script.sh
 Result is: 3
```

[Share](https://unix.stackexchange.com/a/298717 "Short permalink to this answer")

[Improve this answer](https://unix.stackexchange.com/posts/298717/edit)

Follow

[edited Jan 14, 2018 at 18:43](https://unix.stackexchange.com/posts/298717/revisions "show all edits to this post")

[

![user avatar](https://i.stack.imgur.com/BkKfT.png?s=64&g=1)

](https://unix.stackexchange.com/users/22565/st%c3%a9phane-chazelas)

[Stéphane Chazelas](https://unix.stackexchange.com/users/22565/st%c3%a9phane-chazelas)

463k8383 gold badges915915 silver badges13581358 bronze badges

answered Jul 27, 2016 at 18:44

[![user avatar](https://i.stack.imgur.com/xwKWQ.png?s=64&g=1)](https://unix.stackexchange.com/users/70697/rahul)

[Rahul](https://unix.stackexchange.com/users/70697/rahul)

12.4k33 gold badges3939 silver badges53

----------------------------------------------------------------

The idea would be something like this:
```bash
#!/bin/bash

add() {
    result=$(($1 + $2));
    echo "Result is: $result";
}



nr1=1;
nr2=2;

add "$nr1" "$nr2";

```

Ok I think I have the hang of it. Alright now I will take a look at my bash sourcode and put it in blocks/ functions to make it more readable.

Well just for kicks I did this, I modified the code in such a way that I called a function before I declared it. Check the code bellow: 

```bash
#!/bin/bash


nr1=1;
nr2=2;


add "$nr1" "$nr2";


add() {
    result=$(($1 + $2));
    echo "Result is: $result";
}


```

The output was:

```
zen101@vbox:fix-markdown-links-v00$ ./test.sh 
./test.sh: line 8: add: command not found

```

Hmm ok, so then I realised that I need to figure out a way to write the prototype like in C programming. The name of the function or something simmilar. 
So I went on the Internet and found this good question and answer posts:
https://stackoverflow.com/questions/13588457/forward-function-declarations-in-a-bash-or-a-shell-script   

hmmm interesting...





Ok basically this is the most important posts that I got:

--------------------------------------------------------------------

## Question:
### [Forward function declarations in a Bash or a Shell script?](https://stackoverflow.com/questions/13588457/forward-function-declarations-in-a-bash-or-a-shell-script)

Asked 9 years, 5 months ago

Modified [4 years, 2 months ago](https://stackoverflow.com/questions/13588457/forward-function-declarations-in-a-bash-or-a-shell-script?lastactivity "2018-02-11 13:14:41Z")

Viewed 25k times

105

24

[](https://stackoverflow.com/posts/13588457/timeline)

Is there such a thing in `bash` or at least something similar (work-around) like forward declarations, well known in C / C++, for instance?

Or there is so such thing because for example it is always executed in one pass (line after line)?

If there are no forward declarations, what should I do to make my script easier to read. It is rather long and these function definitions at the beginning, mixed with global variables, make my script look ugly and hard to read / understand)? I am asking to learn some well-known / best practices for such cases.

---

For example:

```bash
# something like forward declaration
function func

# execution of the function
func

# definition of func
function func
{
    echo 123
}
```

[bash](https://stackoverflow.com/questions/tagged/bash "show questions tagged 'bash'") [function](https://stackoverflow.com/questions/tagged/function "show questions tagged 'function'") [sh](https://stackoverflow.com/questions/tagged/sh "show questions tagged 'sh'") [forward-declaration](https://stackoverflow.com/questions/tagged/forward-declaration) prototype prototipe like c

----------------------------------------------------

## Answer:

Great question. I use a pattern like this for most of my scripts:

```bash
#!/bin/bash

main() {
    foo
    bar
    baz
}

foo() {
}

bar() {
}

baz() {
}

main "$@"
```

You can read the code from top to bottom, but it doesn't actually start executing until the last line. By passing `"$@"` to main() you can access the command-line arguments `$1`, `$2`, et al just as you normally would.

------------------------------------------------------------------------------



After reading this post I think I got the hung of it.  
So I modified my test script and now it is running:  

```bash
#!/bin/bash

main() {

nr1=1;
nr2=2;

add "$nr1" "$nr2";

}






add() {
    result=$(($1 + $2));
    echo "Result is: $result";
}





main "$@";

```

Make sure you don't forget  your main function at the end of your script!  



## Global variables vs Local variables in BASH

By default any variable declared in bash will be a global varialbe. Even if that variable is defined inside a function body. 

To force bash to make a variable local you must write `local` keyword before the name of variable. Like this:


Look at this script:

```bash
#!/bin/bash

main() {

nr1=1;
nr2=2;


add "$nr1" "$nr2";
echo "local_number1="$local_number1;
echo "local_number2="$local_number2;
}






add() {
	local_number1=69;
	local local_number2=999;

	result=$(($1 + $2));
    echo "Result is: $result";
}





main "$@";

```

If you run the script the output would be:

```
zen101@vbox:fix-markdown-links-v00$ ./test.sh 
Result is: 3
local_number1=69
local_number2=
```

ATTENTION: So you you see, that `local_number1=69;`  variable is not actually local, but it is a global variable, even it was defined inside a function!
And to force BASH to actually declar a local variale inside a function you MUST write like this `local local_number2=999;` basically you must use the **local** keyword before the name of the variable. Now this second method of declaring a variable is actually declaring a local variable and not a global variable.  
Be careful to remeber that BASH is different about this aspect.  
ATTENTION IN SHORT BASH AUTOMATICALLY DECLARS ALL VARIABLE AS GLOBA UNLESS YOU SPECIFY THE "local" KEYWORD BEFORE THE NAME OF A VARIALBE!!!

This video was very helpful:   
https://www.youtube.com/watch?v=4GR0wum_pOQ

I think I want to eat.  
I just really want to continue with bash but I am very hungry. So I will pause here eat my soup and then continue after my lounch...

I run into some issues....

You see this line:
```bash
name_of_target_file=$( grep -E -o -m 1 --include="*.md" '\/.*\.md' <<< "$1");
echo "DEBUG name_of_target_file="$name_of_target_file;
```

When it parses the variable at $1 place which is :

```
"/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md";
```

It will output this:
```
DEBUG name_of_target_file=/first_note_20220503134650.md
```

This is wrong:
```
/first_note_20220503134650.md
```

I ned to get rid of that `/` it should not be in a name of a file. 
How can I do that?

Maybe I could use sed utility? ....

I fugure it out: I can do this:

I added a sed command:
```bash
	local name_of_target_file_with_slash=$( grep -E -o -m 1 --include="*.md" '\/.*\.md' <<< "$1");
	local name_of_target_file=$( sed "s|/||g" <<< "$name_of_target_file_with_slash");
	echo "DEBUG name_of_target_file="$name_of_target_file;
```

This `sed "s|/||g"` command will replace `/` with nothing :) yes got it. Do you want to see the output?  
Here is the output:
```
DEBUG name_of_target_file_with_slash=/first_note_20220503134650.md
DEBUG name_of_target_file=first_note_20220503134650.md
```

Beautiful 😍 everything goes well :) 

------------------------------------------

I have a serious problem with **sed** I don't get it!  
How the heck I should get a word from right to left, and not the default behaviour which is left to right:

So this is the code that I have so far and I don't seem figuere this out!  

```bash

# The "realpath" utility needs an absoule path of the source file directory and not the path of the source file itself,:
# realpath --relative-to="$absolute_path_of_source_file" "$absolute_path_of_target_file"

# I need to convert this:
# absolute_path_of_source_file=
#/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
# To this:
# absolute_path_of_source_directory="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE";


absolute_path_of_source_file="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md";

echo "absolute_path_of_source_file="$absolute_path_of_source_file;

sed "s|note|DUCK|g" <<< "$absolute_path_of_source_file";
```



I just want to look from right to left <------  and see the first `/` slash character, and then I will just cut, throw away anyting that is between the `/` and the `.md` extension...

So I will go and have a look on the net again how the heck I will suppose to do that!  
I tryed the `^` character but it does not seam it is working ....


I think I spend an hour at this and I don't seem to figure out this thing !!!!!!!!!!!!!!!!!!!!!!!!  


Ok After another 20 min passed, I searched for another way... 
I found this post:    
https://stackoverflow.com/questions/4168371/how-can-i-remove-all-text-after-a-character-in-bash

This is the snipet that I was looking for: 

------------------------------------------------------------------
## Question:

# [How can I remove all text after a character in bash?](https://stackoverflow.com/questions/4168371/how-can-i-remove-all-text-after-a-character-in-bash)

Asked 11 years, 5 months ago

Modified [4 months ago](https://stackoverflow.com/questions/4168371/how-can-i-remove-all-text-after-a-character-in-bash?lastactivity "2021-12-12 07:55:29Z")

Viewed 260k times

208

66

[](https://stackoverflow.com/posts/4168371/timeline)

How can I remove all text after a character, in this case a colon (":"), in bash? Can I remove the colon, too? I have no idea how to.

[bash](https://stackoverflow.com/questions/tagged/bash "show questions tagged 'bash'")



------------------------------------------------------------------
## Answers:

364

[](https://stackoverflow.com/posts/4170409/timeline)

In Bash (and ksh, zsh, dash, etc.), you can use parameter expansion with `%` which will remove characters from the end of the string or `#` which will remove characters from the beginning of the string. If you use a single one of those characters, the smallest matching string will be removed. If you double the character, the longest will be removed.

```bash
$ a='hello:world'

$ b=${a%:*}
$ echo "$b"
hello

$ a='hello:world:of:tomorrow'

$ echo "${a%:*}"
hello:world:of

$ echo "${a%%:*}"
hello

$ echo "${a#*:}"
world:of:tomorrow

$ echo "${a##*:}"
tomorrow
```


------------------------------------------------------------------

An example might have been useful, but if I understood you correctly, this would work:

```bash
echo "Hello: world" | cut -f1 -d":"
```

This will convert `Hello: world` into `Hello`.


------------------------------------------------------------------

#### 3.5.3 Shell Parameter Expansion

Read more from here from BASH MANUAL:  
https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Parameter-Expansion 

Alright now I got it. I wrote this code and it works!! 

```bash
absolute_path_of_source_file="/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md";
echo "$absolute_path_of_source_file";

absolute_path_of_source_directory=${absolute_path_of_source_file%/*};
echo "$absolute_path_of_source_directory";
```

This code will output:  
```
absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md

absolute_path_of_source_directory=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE
```

Perfect! This is exactly whan I wanted, to split the string at the tail and throw everything after the first slash `/` from the right to left which is perfect.  



Ok I run into a dead end agian. 
For some reason this line deoan't work insied a function :(  

So I have this function:

```bash
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
	echo "-------------> absolute_path_of_source_directory after assignement="$absolute_path_of_source_directory;
	local absolute_path_of_source_directory=${absolute_path_of_source_file%/*};
	echo "absolute_path_of_source_directory="$absolute_path_of_source_directory;

	local relative_path_source_file_to_target_file=$(realpath --relative-to="$absolute_path_of_source_directory" "$absolute_path_of_target_file");
	echo "DEBUG relative_path_source_file_to_target_file="$relative_path_source_file_to_target_file;

}
```

And this line:

```bash
local absolute_path_of_source_directory=${absolute_path_of_source_file%/*};
```

It doesn't do what it supose to do. It keeps give me this wirnd meaningless message: 

Output of function:
```
zen101@vbox:fix-markdown-links-v00$ ./fix-markdown-links-v01.sh
DEBUG current_file_location=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG id_of_target_file=20220503134650
DEBUG absolute_path_of_source_file=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE/note_test1_20220503134351.md
-------------> absolute_path_of_source_directory after assignement=/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE
absolute_path_of_source_directory=source
realpath: '': No such file or directory
DEBUG relative_path_source_file_to_target_file=

```

As you can see:
```
absolute_path_of_source_directory=source
```
Why the heck  is "source" word assigned to "absolute_path_of_source_directory" I don't get it...  



## Bug solved: I forgot to call the function
I found the error, when I scrolled up at the function to check how was I calling it I dicovered that I didn't call it correctly:

```bash
# Figure out the relative path from source_file to target_file
figure_out_relative_path_from_source_file_to_target_file   source
```

That is all I wrote as parameter after my function name `source` there is no surprise why the hell my founction was printing source :)  
I fell like such an idiot!   


--------------------

## My new Pseudocode for the fix broken markdown links script

I think I will stop here for today... I basically wrote all the code in functins, and it looks good.

And it sort of works ok, but there is still work to be done at it. I will need it to put this in 2 loops.  
One loop that goes through all the files and grabs only the md files from the CORE direcotry recursivle.  
One Loop that reads line by line  
And maybe even a 3 loop that analises one line to see how many links are in that line partuclar 

But I will write a Pseudocode just for kics to have an idea what I want to do tomorow...

```
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
	# End of "Loop through the file line by line" loop, jump back up and repeat until the end of the file
# Reset all the variables, because there is no reason to hold to a variable when I go to a new line
# Because a markdown link can only exist in one line, there are not markdown links on multiple lines. There could be multiple md links on the same line but not no markdown link will start on one line and it will finish on the next.
# But don't reset the code block 3 tilda boolean flag yet..
# End of "Loop through all the '.md' files" loop, jump up and repeat again until you will go through all the files in the CORE direcotry recursively
# Finished
```

Ok I wrote this Pseudocode, improved...  

---------------------------------------------------

## How to get the lenght of a string in BASH?


Using the `${#VAR}` syntax will calculate the number of characters in a variable.

For example:
```bash
temp1="hello";
echo ${#temp1};
```

It will output: 
```
5
```



```bash
old_markdown_link_length=${#old_markdown_link};
```



----------------------------------------------------------------------------------------



## Nested if condition in BASH

I wrote this nested if then condition but it does not work:

```bash
# Check if I am insied a code block
if [ "$code_block_flag" == false ]; then
	# It means I am outside a code block
	if[ "$found_tildas" == true ]; then
		# I found tildas and I am outside a code block
		# Set that I am inside a code block
		code_block_flag=true;
	else
		# I did not found tildas and I am outside code block
		# Do nothing
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
	fi
fi

	
```



Ufffff, what the heck is wrong with it???  
Ok lets see what id does not work..

Ok I fixed it. Bash doesn't like empty then or else blocks... 
Ok well then I put some empty dummy instructions inside. And kept the logic...



```bash
code_block_flag=true;
found_tildas=true;

empty_if_blocks="empty";

# Check if I am insied a code block
if [ "$code_block_flag" == false ]; then
	# It means I am outside a code block
	empty_if_blocks="empty";
	if [ "$found_tildas" == true ]; then
		# I found tildas and I am outside a code block
		# Set that I am inside a code block
		code_block_flag=true;
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




echo "DEBUG Am I inside a code block?="$code_block_flag;


```

## Pyping my DEBUG variables into grep command

I discovered that I can pipe my debug variables into grep like this:

Instead to run my program normaly:
```
# A MILLION BILION VARIABLES ...
```





```
./fix-markdown-links-v02.sh | grep "code_block_flag"
```

And it will output this:

```
DEBUG code_block_flag=false
DEBUG code_block_flag=false
DEBUG code_block_flag=false
DEBUG code_block_flag=false
DEBUG code_block_flag=false
DEBUG code_block_flag=false
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=true
DEBUG code_block_flag=false

```



I think there is a bug inside `extract_id_from_markdown_link()` function.   
Because I have this error log after runing the `./fix-markdown-links-v03.sh` through grep looking for the `DEBUG old_markdown_link` variable...

```bash
zen101@vbox:fix-markdown-links-v00$ ./fix-markdown-links-v03.sh | grep "old_markdown"
DEBUG old_markdown_link=
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG old_markdown_link=[first_note_20220503134650.md](Other notes/first_note_20220503134650.md)
DEBUG old_markdown_link=
DEBUG old_markdown_link=[second_note_20220503134544.md](Other notes/second_note_20220503134544.md)
DEBUG old_markdown_link=[second_note_20220503134544.md](Other notes/second_note_20220503134544.md)
DEBUG old_markdown_link=[second_note_20220503134544.md](Other notes/second_note_20220503134544.md)
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)
DEBUG old_markdown_link=[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)
find: paths must precede expression: `delete-me.txt.save'
find: possible unquoted pattern after predicate `-name'?
realpath: '': No such file or directory
DEBUG old_markdown_link=[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
DEBUG old_markdown_link=
zen101@vbox:fix-markdown-links-v00$ 

```



## Grabing the extension of a file name
But I just studied continuously for over 7 hours. 

I am happy with the results now. I was thinking... 
Maybe I could use the bash paramenter expansion  by cuting at the first dot from right to left I can grab the extension and then use that extension as a variable named `$extension` and then insert that variable in the places where I have `.md` by doing so I make my code more robust.

Or there are other ways...  
This was just a thought ..

for what ever reason I my search function doesn't seam to be able to find the jpeg file...

Output:
```bash
find: paths must precede expression: `delete-me.txt.save'
find: possible unquoted pattern after predicate `-name'?
DEBUG absolute_path_of_target_file=
realpath: '': No such file or directory

```



I found a way to extract the file extension from a file path:
Using shell parameter expansion, look at the example bellow:

```bash
	a='he-llo/w.orld.jpeg';
	echo "${a##*.}"
```

Output:
```
jpeg
```

Perfect..

So applying what I ave learned here I wrote this function:

```bash
# Write a function that extracts the extension of the target file.
# The extract_extension_from_link() function takes in a Markdown link and extracts the extension of the file that md link points to
# It will be able to extract .md .png .jpeg .pdf .xxx
# and return the extension as a string
#[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)
#Testing extensions...
#old_markdown_link="[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)";
# old_markdown_link="[this_is_sparta_20220503225740](Wrong Folder/this_is_sparta_20220506192225.pdf)";
#old_markdown_link="[this_is_sparta_20220503225740](Attachments/this_is_sparta_20220503225740.jpeg)";
# old_markdown_link="[this_is_sparta_20220503225740](Wrong Folder/this_is_sparta_20220506192225.excel)";
# old_markdown_link="[this_is_sparta_20220503225740](Wrong Folder/this_is_sparta_20220506192225.md)";
# The function takes in:
#Argument1 an markdown link to a file that has an extension.
extract_extension_from_link(){
	local markdown_link=$1;
	echo "DEBUG markdown_link="$markdown_link;
	#a='he-llo/w.orld.jpeg';
	local extension=${markdown_link##*.};
	extension=${extension%)*};
	echo "extension="$extension;

}


extract_extension_from_link "$old_markdown_link";
```



And it outputs the correct extension of the targeted file inside the markdown link which is perfect.



I need a break!  
I explain you after my break how bad things are :(

I think I will stop. Now I am at the version 03. Then code is ok, but it needs more testing... And I don't really have the time today to go through deep.. 

## My markdown version 03 sourcecode

I am happy with what I have today. I hope I will be able to finish this project next week. There will be a lot of work to document every thing I did here..  
But it should be fine :) 

I am soo close but still acutally so far to finish this project. It took almos a week... I don't know but it took a lot of time to fix all this stuff.

## Bash cheat sheet
By random I found this bash cheat sheet that has a lot of useful tips on how to use bash:  
https://devhints.io/bash  



------------------------------------

Ok I was thinking and I thnk I can extract the extension from the absolute path insted to extract the extension from the old markdown link.  
And I can get the absolute path from the id of the note.  
And I can get the id from the old markdown link.



So my function should do something like this.

```
If the markdown link contains slashes "/"
Then: Split the link at the first slash "/" from right to left
Else: Split the link at the first "(" from right to left
	Because if the md link does not have any slash that means the file is not in a subdirectory, which means it does not have any depth, but the target file only lives in the same directory as the source file.
```



----------------------------------------------

So this the last bug that I found:

```
[bla](bla) [bla](bla) [bla](bla) [bla](bla) [bla](bla) [bla](bla) [bla](bla) [bla](bla)  
```

My program will take the whole like of links on the same line and replace them with one link:

```
[bla](bla)  
```

Which is bad, because I will loose all the link. This happnes because the way I recognise a link is I look for first `[` and last `)`


I was thinking I could create a function that:
```
- Takes a line from the file
- And parses that line making an array of old markdown links
- Then it will return that array
- And my rest of my program can be called for each old md link from the array.
- That should do it.
```



## The for loop in BASH

How to loop through a string character by character?

Well I looked on the internet and I found this soruce code:

---------------------------------------------------------------

You can use a C-style `for` loop:

```bash
foo="I love chocolate cookies and cereals";
for (( i=0; i<${#foo}; i++ )); do
  echo "${foo:$i:1}";
done
```

`${#foo}` expands to the length of `foo`. `${foo:$i:1}` expands to the substring starting at position `$i` of length 1.

---------------------------------------------------------------------

I found this code snipet from this web page:  
https://stackoverflow.com/questions/10551981/how-to-perform-a-for-loop-on-each-character-in-a-string-in-bash  


Right now I am taking character by character in a hope that I will crack this nut. But is a tedious work, and it is pretty complicated to make sure that I descriptbe the order corectly to the computer. So I will leave this thing for tomorow...  

But you know if I finish this function, this, **I hope** will be the last functionality, then I will just an loop abole my code that will iterate throught all the files fom all the directories from my CORE OF NOTES and that will be it. If and this is a **BIG IF** ...  if everything will work well I should, be done tomorrow...  

-----------------------------------------------------



I was thinking how to use grep to search a string of links and I come up withthis:

I coudn use grep like this

So lets say I have this string:

```
string_of_links= link1 link2 link3 link4
```

Then I can grep through this string for a link and exclude it from the results with `-v` (inverting) result:

```
grep -v "link1" <<< $string_of_links
```

By doing this I should get:

```
link2 link3 link4
```

As a result!

------------------------------------------------------



I found this regex code that asserts it will capture any markdown link from a string:

```regex
(?:__|[*#])|\[(.*?)\]\(.*?\)
```

I found this code here:  
https://stackoverflow.com/questions/37462126/regex-match-markdown-link 

Ok I will give it a shot..


This workd aswell:
```regex
\[(.*?)\]\(.*?\)
```


So that is how you can loop through an array:

```bash
array_name=("item1" "item2" "item3");

for i in "${array_name[@]}";
	do
	   # do whatever on "$i" here
	   echo "i="$i;
	done
```

the syntax looks very wacky but it works

By the way in regex `.*` it means any number of any characters.  
And the regex `.+` it means any number of any characters but has to be at least 1 or more characters.
And in regex `?` means lazy match, which means it will match the shortest pattern not the longest

This is why you can match for a markdown pattern so easyly with this code:  `\[(.*?)\]\(.*?\)` 
If you want more interactive understanding, then copy that regex and go to https://regexr.com/ website and play arround.

Multiple ways to match for a Markdown link could be:
This regex pattern will match empty markdown links such as `[]()`:
```regex
\[(.*?)\]\(.*?\)
```

This regex will not match empty md links:
```regex
\[(.+?)\]\(.+?\)
```

I think the strongest combination will be this:
Which will match links like `[](path to file)` and `[file name](path to file)` but it will not mathch `[]()`...
```regex
\[(.*?)\]\(.+?\)
```

Because well sometimes the link can have no description inside the square brackets, but it must have a path to some file with id!  
So I think that is the strongest form of md recognision by using regex at this point..


I am very happy that I was able to figure it out!  All I missed was to put more questions and be more pattient with myself. And just be patient, and I finaly figure it out.

I learned more about:
- Loops in bash
- Making arrays in bash
- The `?` in regex means Lazy match, which means it will grab the shortest match and not the whole line which is great for situations where I have a line with many markdown links on the same line.
- That `+` in regex means 1 or more characters but not 0.

Things start too look good. And I said if I fix this function I will take a break, a long one. So I will do that but just give me 2 sec, maybe in half an hours I will do that.


Above I made a mistake. I mean this is the more standard way to write the correct regex:

```regex
(\[(.*?)\]\((.+?)\))
```

Well you can write it like this too:

```
(\[(.*?)(\]\(\S)(.+?)\))
```



How do you reset an global array in bash?

--------------------------------


```bash
declare -a current=("item1" "item2" "item3" "item4")
```


To reset an array just use:

```bash
current=();
```

This will delete old entries and declare a 0 element array.

--------------------------------------------------------

This is a nightmare !!!  
I don't get the results I want...



--------------------------------

Just to let you know I know around where the problem is.  

The problem is here:

```bash
global_array_of_md_patterns=($(grep -E -o -m 1 "$regex_pattern" <<< "$current_line_in_current_file"));
```

Basically grep finds the links with spaces but BASH doesn't pass the elements properly, it slices at white space.

------------------------------

I just realised, that I could use regex with sed to insert new line `\n` after a match, then if I have that new line inside the string I can parse the string and pass it element by element by switching the IFS.  
It is a last chance, I hope it will work..

I am trying to insert a new line in a string but thisngs don't work the way I want 



So I wrote this script:
```bash
#line="[link1](l ink1.md) [link2](li nk2.jpeg) [link3](lin k3.pdf) [link4](link 4.ext) ";
#line="[link1](l ink1.md)"+'\n'+" [link2](li nk2.jpeg) [link3](lin k3.pdf) [link4](link 4.ext) ";
link1="[link1](l ink1.md)";
new_line='\n';
#line="$link1""$new_line""$link1""$new_line""$link1""$new_line""$link1""$new_line";
line=$link1$new_line$link1$new_line$link1$new_line;




#declare global_array_of_md_patterns=();
# Change the IFS (Internal field separator). Because the text splices automatically if path has space in it.
IFS_backup=$IFS;
IFS=$'\n';

declare global_array_of_md_patterns=($line);

# Restore IFS
IFS=$IFS_backup;


	for i in "${global_array_of_md_patterns[@]}"
		do

			echo "------------------------";
			echo "i="$i;
		done



```


And the output is still not the want I want...

```
i=+ [link2](li nk2.jpeg) [link3](lin k3.pdf) [link4](link 4.ext)
zen101@vbox:fix-markdown-links-v00$ ./test.sh 
------------------------
i=[link1](l ink1.md)+\n+ [link2](li nk2.jpeg) [link3](lin k3.pdf) [link4](link 4.ext)
zen101@vbox:fix-markdown-links-v00$ ./test.sh 
------------------------
i=[link1](l ink1.md)\n[link1](l ink1.md)\n[link1](l ink1.md)\n[link1](l ink1.md)\n
zen101@vbox:fix-markdown-links-v00$ ./test.sh 
------------------------
i=[link1](l ink1.md)\n[link1](l ink1.md)\n[link1](l ink1.md)\n
zen101@vbox:fix-markdown-links-v00$ 

```


I don't know what to do.


With a little bit of help from: 
https://stackoverflow.com/questions/3005963/how-can-i-have-a-newline-in-a-string-in-sh  

I figure out the solution.  
Bash has a pretty twisted syntax, but it works. So If I apply what I learned here I could have a chance to pull that off what I am trying in myfunctin...



```bash

line=$' word1 \n word2 \n word3';

IFS=$'\n';
declare global_array_of_md_patterns=($(echo "$line"));
# Restore IFS
IFS=$IFS_backup;


for i in "${global_array_of_md_patterns[@]}"
		do

			echo "------------------------";
			echo "i="$i;
		done



```



This line seams to work:

```bash
sed 's/link /& pink/g' <<< "$line";
```

it is able to replace the `link` with `link pink`... hmm this is a good signal..



--------------------------------------------

## I had an idea for a solution

So I was smoking and thinking to watch an old movie.. And I had an idea about my problem..
I think I can combine 2 bad solutions into 1 good solution.  
what I mean is this.

This is Pseudocode that I think it will work:

- Grab the line
- Parse the line character by character
- Add each character to a temporar buffer variable
- Test that temporar buffer with grep
- If I find a match in the temp buffer
	- Then: Go and add that old markdown link to the array
		- And reset the buffer to empty ""
	- Else: Do nothing
- Jump back up and add the next character to the buffer
- Do that until I reach the end of the line.
- At the end of the line I should have all the old md links inside the global array

I will live this pseudocode for tomorrow, as a hope, maybe a light of hope for me...

---------------------------

---------------------------------------------------------------------------------------------------------------------------------------------

YES IT FINALY WORKS IT DOES WHAT I WANT IT TO DO :)  
After I will put the code in a function and test it some more.. I will past here the results. Ohh it is beautiful. I can't belive that yestarday I come up with that amazing idea


After working hard for many many hours I finaly come up with this funtion that seams to work:

```bash



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
	echo "current_line_in_current_file="$current_line_in_current_file;

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
	echo "$character";

	#- Add each character to a temporar buffer variable
	buffer_temp+=$character;
	echo "buffer_temp="$buffer_temp;

	# The regex form to recognise a Markdown link in a string
	local regex_pattern="(\[(.*?)\]\((.+?)\))";
	#local regex_pattern="((!?\[[^\]]*?\])\((?:(?!http|www\.|\#|\.com|\.net|\.info|\.org).)*?\))";
	#local regex_pattern="\[([^\[\]]*)\]\((.*?)\)";

	local md_pattern_found=$(grep -E -o -m 1 "$regex_pattern" <<< "$buffer_temp");
	#echo "md_pattern_found="$md_pattern_found;
	local length_of_md_pattern_found=${#md_pattern_found};

	if [ "$length_of_md_pattern_found" != "0" ]; then
		echo "found!!!";
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




### MAIN ###


#line="[first_20220503134650.md](First/first_note_20220503134650.md) [second_note_20220503134650.md](Second/second_note_20220503134650.md) [third_note_20220503134650.md](Third/third_note_20220503134650.md) [forth_note_20220503134650.md](Forth/forth_note_20220503134650.md)";
#line="link1 link2 link3 link4 link5 "
#line="[first_20220503134650.md](First/first_note_20220503134650.md) [second_note_20220503134650.md](Second/second_note_20220503134650.md) [third_note_20220503134650.md](Third/third_note_20220503134650.md) [forth_note_20220503134650.md](Forth/forth_note_20220503134650.md)";
#line="link1 link2 link3 link4 link5 "
line="[link1](link1.md) [link2](link2.jpeg) [link3](link3.pdf) [link4](link4.ext)";
#line="[link1](link1.md) [link2](link2.jpeg) [link3](link3.pdf) [link4](link4.ext)";
#line=" link  [link1](l ink1.md) link [link2](li nk2.jpeg) [link3](lin k3.pdf) [link4](link 4.ext)";
#line=" link  [l ink1](l in k1.md) link [l ink2](li n k 2.jpeg) [lin k3](l  in k   3.pdf) [li nk4](li nk 4.ext)";
#line=" link  [l ink1](Directory name1/l in k1.md) link [l ink2](Directory name2/ Directory lalal/li n k 2.jpeg) [lin k3](l  in k   3.pdf) [li nk4](li nk 4.ext)";
#line="Lorem ispus (bla bla) lorem lalalal [link1](link1.md)";
#line="Lorem ispus [button] lorem lalalal [link1](link1.md)";
#line="This line does not have no markdown link";
#line="[second_note_20220503134544.md](Renamed link1 Other notes/second_note_20220503134544.md)  [some_note_20220503134511.md](Renamed link2 Other notes/some_note_20220503134511.md)  [apples_20220509203642.md](Renamed Link3 Other notes/apples_20220509203642.md)  ";


# Identify a markdown pattern in the curren line of the curren file
# A markdown links looks like [foo](Directory A/Direcotry B/foo_20220503183504.md)
#echo "DEBUG current_line_in_current_file="$current_line_in_current_file;

global_array_of_md_patterns=();
index_global_array=0;

current_line_in_current_file="$line";
return_an_array_of_md_patterns_from_a_line "$current_line_in_current_file";




# Lets print the array after the abocve charater after character Loop to see what it is inside:
for i in "${global_array_of_md_patterns[@]}"
	do


	   echo "i="$i;
	done







```



The only problem I have is that lines such as:
```
"Lorem ispus [button] lorem lalalal [link1](link1.md)"
```

Seam to fool my regex into recognising the whole line... But I do have a resiliient program that has many checks...  
So even that this functin does't do what it should, hopefully the program will recheck this particular link to the point this is not a problem..

Wow it works greate!!!  
I had a littel problem with a function... ..
I added a loop to that function but the BASH was exiting after one iteration...  
Latter I found that that function had the `return` keyword and well because of this was exiting from the functio, and of corse, exiting from the loop after first iteration because hitting this "return" keyword.  
Apart that the code works well.  
Now I will have a quick break and back up this version, and put the code that I have in another loop, this time this loop will open Directory by Directory and read all the files in the Direcotories recurlively. The idea is to call well my functional code for each file in the Directories.
I will need to optimise my code and add more examples at my Small Core of notes to test more.  
And I do want to add some Log Variables to the bash script that will tell me how many links wore found, how many links wore modified, how many files wore checked, which IDs don't exist,errors encontered, progress bar, or some sort of progress number, and so on ... this type of statistics...


So I was thinkig how to loop through a directory recursively, file by file.

And search for this line:
"By the way this video was useful teaches me how to loop and read a text file line by line using 3 Methods:"
For that day, and You will have the link to the YouTube video.



Well I managed to write this code:

```bash
for i in "$(find "$PWD" -type f -name "*.md")";
do	
	# CODE BLOCK 
    echo "$i";
done;
```

Bassically this code is able to recursively run through all my directories and print the absolute path of each markdown file.  
The command that does most of the work here is this one:

```bash
find "$PWD" -type f -name "*.md"
```

Which outputs a list of all the paths to my md files from current directory aka Present Working Directory (PWD). Which is perfect! 
Now all I need to do is to call all my code for each file and I am gold!  

I just realised that this loop is bad:
```bash
for i in "$(find "$PWD" -type f -name "*.md")";
do
	# CODE BLOCK
    echo "$i";
	echo " -----";
done;
```

You see because I put "" quotation marks around the find subshell it does not return path by bath for each "i" variable. But it just dumps a whole blob like this:

```
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file4_20220512124345 (copy).md
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file2_20220512124345 (3rd copy).md
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file3_20220512124345 (another copy).md
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file1_20220512124345.md
 -----

```


Problem is if I do remove the quotation marks:

```bash
for i in $(find "$PWD" -type f -name "*.md");
do
	# CODE BLOCK
    echo "$i";
	echo " -----";
done;
```

Then I have this output, which proves that it does break at space character ` ` now that is a problem. A big one. 

```
zen101@vbox:Small_CORE2$ ./test.sh 
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix
 -----
the
 -----
md
 -----
links
 -----
after
 -----
renaming/Fix
 -----
links
 -----
bash
 -----
script/fix-markdown-links-v00/Small_CORE2/Directory
 -----
with
 -----
a
 -----
very
 -----
long
 -----
name/Direcory2
 -----
with
 -----
long
 -----
LONG
 -----
VERY
 -----
LONG
 -----
NAME/i_am_a_file4_20220512124345
 -----
(copy).md
 -----
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix
 -----
the
 -----
md
 -----
links
 -----
after
 -----
renaming/Fix
 -----
links
 -----
bash
 -----
script/fix-markdown-links-v00/Small_CORE2/Directory
 -----
with
 -----
a
 -----
very
 -----
long
 -----
name/Direcory2
 -----
with
 -----
long
 -----
LONG
 -----
VERY
 -----
LONG
 -----
NAME/i_am_a_file2_20220512124345
 -----
(3rd
 -----
copy).md
 -----
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix
 -----
the
 -----
md
 -----
links
 -----
after
 -----
renaming/Fix
 -----
links
 -----
bash
 -----
script/fix-markdown-links-v00/Small_CORE2/Directory
 -----
with
 -----
a
 -----
very
 -----
long
 -----
name/Direcory2
 -----
with
 -----
long
 -----
LONG
 -----
VERY
 -----
LONG
 -----
NAME/i_am_a_file3_20220512124345
 -----
(another
 -----
copy).md
 -----
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix
 -----
the
 -----
md
 -----
links
 -----
after
 -----
renaming/Fix
 -----
links
 -----
bash
 -----
script/fix-markdown-links-v00/Small_CORE2/Directory
 -----
with
 -----
a
 -----
very
 -----
long
 -----
name/Direcory2
 -----
with
 -----
long
 -----
LONG
 -----
VERY
 -----
LONG
 -----
NAME/i_am_a_file1_20220512124345.md
```

How can I inhibit this behaviour? 
Shoud I use DFI variable and change the delimiter?  
Shal I use a while loop?  
Is it possible to use a more complex loop?  
Or I need to just modify something small?  

All great questions!! But I am tired and hungry, I want to eat and take a long break, I will see after my lunch what the heck should I do about this space fusssy BASH issue.  
I am very close to finish this program but not quite there...

--------------------------------



Ok I am back, lets do this!  

This loop seams to work great:
```bash
find "$PWD" -name "*.md" | while read fname; do
  echo "$fname";
  echo "---------"
done
```

The output is:

```
zen101@vbox:Small_CORE2$ ./test.sh 
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file4_20220512124345 (copy).md
---------
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file2_20220512124345 (3rd copy).md
---------
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file3_20220512124345 (another copy).md
---------
/home/zen101/MY_STUFF/Improve-my-CORE-Project/Fix the md links after renaming/Fix links bash script/fix-markdown-links-v00/Small_CORE2/Directory with a very long name/Direcory2 with long LONG VERY     LONG NAME/i_am_a_file1_20220512124345.md
---------
```

Which is exacly what I wanted.
I found the answer in this stackoverflow web page:  
https://stackoverflow.com/questions/9612090/how-to-loop-through-file-names-returned-by-find  

But it was not the top answer that I chose, because programmers and the guys there wore over flexing and using very very cryptic stuff, that I saw no reason to use if I don't really need it.  

So I chose this answer:

------------------------------------------------



## Question:
# [How to loop through file names returned by find?](https://stackoverflow.com/questions/9612090/how-to-loop-through-file-names-returned-by-find)

Asked 10 years, 2 months ago

Modified [5 months ago](https://stackoverflow.com/questions/9612090/how-to-loop-through-file-names-returned-by-find?lastactivity "2021-12-05 17:41:03Z")

Viewed 355k times

342

147

[](https://stackoverflow.com/posts/9612090/timeline)

```bash
x=$(find . -name "*.txt")
echo $x
```

if I run the above piece of code in Bash shell, what I get is a string containing several file names separated by blank, not a list.
Of course, I can further separate them by blank to get a list, but I'm sure there is a better way to do it.
So what is the best way to loop through the results of a `find` command?



----------------------------------------------------------------------------------------------

## Answer:
```bash
find . -name "*.txt"|while read fname; do
  echo "$fname"
done
```

Note: this method _and_ the (second) method shown by bmargulies are safe to use with white space in the file/folder names.

In order to also have the - somewhat exotic - case of newlines in the file/folder names covered, you will have to resort to the `-exec` predicate of `find` like this:

```bash
find . -name '*.txt' -exec echo "{}" \;
```

The `{}` is the placeholder for the found item and the `\;` is used to terminate the `-exec` predicate.

And for the sake of completeness let me add another variant - you gotta love the *nix ways for their versatility:

```bash
find . -name '*.txt' -print0|xargs -0 -n 1 echo
```

This would separate the printed items with a `\0` character that isn't allowed in any of the file systems in file or folder names, to my knowledge, and therefore should cover all bases. `xargs` picks them up one by one then ...





-------------------------------------------------------
## Answer:
What ever you do, _don't use a `for` loop_:

```bash
# Don't do this
for file in $(find . -name "*.txt")
do
    …code using "$file"
done
```

Three reasons:

-   For the for loop to even start, the `find` must run to completion.
-   If a file name has any whitespace (including space, tab or newline) in it, it will be treated as two separate names.
-   Although now unlikely, you can overrun your command line buffer. Imagine if your command line buffer holds 32KB, and your `for` loop returns 40KB of text. That last 8KB will be dropped right off your `for` loop and you'll never know it.

---

Always use a **`while read`** construct:

```bash
find . -name "*.txt" -print0 | while read -d $'\0' file
do
    …code using "$file"
done
```

The loop will execute while the `find` command is executing. Plus, this command will work even if a file name is returned with whitespace in it. And, you won't overflow your command line buffer.

The `-print0` will use the NULL as a file separator instead of a newline and the `-d $'\0'` will use NULL as the separator while reading.





-------------------------------------------------------------

Finally I decided to use this loop syntax, to loop through all the files in CORE OF NOTES recursiveley one by one:

```bash
find "$PWD" -type f -name "*.md" | while read fname; do
  echo "$fname";
  echo "---------"
done
```

I think it is perfect! I only read .md files and do not tuch no other files, because I don't need to.  
My program it is very robust and strong to deal with many types of scenarious


I think it works, I did one light test on my Small Core and behaves well.. I hope it does work. I will need to do more testings and add a nice interface and write some how to use and wher to use Documentation. But I think I finished with this!  maybe in 2hours 5 hours I am all set!   

And I should backup my Ubuntu..  

And backup the CORE OF NOTES as it is ..

So the interface that I could have can be:

Example1:

```
LOG CURRENT FILE PATH                 =
LOG CURRENT NUMBER OF DIRECTORIES PATH=
LOG CURRENT MD LINK FOUND             =
LOG CURRENT BROKEN OLD MD LINK FOUND  =
LOG CURRENT FIXED WITH NEW MD LINK    =
LOG CURRENT NUMBER OF MD LINKS ON LINE=
LOG CURRENT LINE TEXT CONTENT         =
----------------------------------------------------------------------------------------------------------------
NEXT LINE
----------------------------------------------------------------------------------------------------------------









( ▀ ͜͞ʖ▀) MARKDOWN-LINKS-FIXER BY CONSTANTIN LUCIU 

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
```





------------------------------

Ok this is unbalivable!  
I thought I understood global variables in bash, but it seams that they don't work, wtf!!!
The final log counters don't work, why?  

I need a break from all this, it is super fustrating that I am soo close that I almost taste it, and BUUUUUUUUUUM  sh!t hits the fan!  


I read here about making like a temporary file to put my variables, and then pulling that data out of file:  
https://stackoverflow.com/questions/10515964/counter-increment-in-bash-loop-not-working  

Hmm this happens because subshells and parent shell and children shell.   


Basically this is the question that I had and that is an answer that I could use:

--------------------------------

## Question:
# [Counter increment in Bash loop not working](https://stackoverflow.com/questions/10515964/counter-increment-in-bash-loop-not-working)

Asked 10 years ago

Modified [2 years, 3 months ago](https://stackoverflow.com/questions/10515964/counter-increment-in-bash-loop-not-working?lastactivity "2020-01-22 15:01:25Z")

Viewed 379k times

142

33

[](https://stackoverflow.com/posts/10515964/timeline)

I have the following simple script where I am running a loop and want to maintain a `COUNTER`. I am unable to figure out why the counter is not updating. Is it due to subshell thats getting created? How can I potentially fix this?

```bash
#!/bin/bash

WFY_PATH=/var/log/nginx
WFY_FILE=error.log
COUNTER=0
grep 'GET /log_' $WFY_PATH/$WFY_FILE | grep 'upstream timed out' | awk -F ', ' '{print $2,$4,$0}' | awk '{print "http://domain.com"$5"&ip="$2"&date="$7"&time="$8"&end=1"}' | awk -F '&end=1' '{print $1"&end=1"}' |
(
while read WFY_URL
do
    echo $WFY_URL #Some more action
    COUNTER=$((COUNTER+1))
done
)

echo $COUNTER # output = 0
```

[linux](https://stackoverflow.com/questions/tagged/linux "show questions tagged 'linux'") [bash](https://stackoverflow.com/questions/tagged/bash "show questions tagged 'bash'") [shell](https://stackoverflow.com/questions/tagged/shell "show questions tagged 'shell'") [scripting](https://stackoverflow.com/questions/tagged/scripting) [counter](https://stackoverflow.com/questions/tagged/counter)

[Share](https://stackoverflow.com/q/10515964 "Short permalink to this question")

[Improve this question](https://stackoverflow.com/posts/10515964/edit)

Follow

[edited Apr 10, 2015 at 14:48](https://stackoverflow.com/posts/10515964/revisions "show all edits to this post")

[

![user avatar](https://i.stack.imgur.com/lJc4V.jpg?s=64&g=1)

](https://stackoverflow.com/users/3621464/merose)

[MERose](https://stackoverflow.com/users/3621464/merose)

3,41177 gold badges4747 silver badges7373 bronze badges

asked May 9, 2012 at 12:20

[

![user avatar](https://www.gravatar.com/avatar/0437d37e2ea8cb929dcb9bcd9219b1ee?s=64&d=identicon&r=PG)

](https://stackoverflow.com/users/654971/sparsh-gupta)

[Sparsh Gupta](https://stackoverflow.com/users/654971/sparsh-gupta)

1,95344 gold badges1717 silver badges21


------------------------------------------------------------------------------------

## Answer:
First, you are not increasing the counter. Changing `COUNTER=$((COUNTER))` into `COUNTER=$((COUNTER + 1))` or `COUNTER=$[COUNTER + 1]` will increase it.

Second, it's trickier to back-propagate subshell variables to the callee as you surmise. Variables in a subshell are not available outside the subshell. These are variables local to the child process.

One way to solve it is using a temp file for storing the intermediate value:

```bash
TEMPFILE=/tmp/$$.tmp
echo 0 > $TEMPFILE

# Loop goes here
  # Fetch the value and increase it
  COUNTER=$[$(cat $TEMPFILE) + 1]

  # Store the new value
  echo $COUNTER > $TEMPFILE

# Loop done, script done, delete the file
unlink $TEMPFILE
```

[Share](https://stackoverflow.com/a/10516135 "Short permalink to this answer")

[Improve this answer](https://stackoverflow.com/posts/10516135/edit)

Follow

answered May 9, 2012 at 12:30

[

![user avatar](https://www.gravatar.com/avatar/532d256e26cd394079a77eb43d728e42?s=64&d=identicon&r=PG)

](https://stackoverflow.com/users/788134/bos)

[bos](https://stackoverflow.com/users/788134/bos)

6,20833 gold badges2727 silver badges44


----------------------------------------------------------------------------------

## Using a file as a place to store values from a GLOBAL VARIABLE



### Continuing with final touches for my bash script

Ok I will go and continue wrestling with BASH again...



Basically what I am struggling is that I have a variable a counter a iterator in bash that is incremented in a loop. But I can't print it or echo it after the loop. Well it prints 0 zero but it should not be zero. I read on internet yestarday that it has to do with Parent Shell and children subshells so the best approach would be to write the data of **the variable to a file** and then read it from a file...

This is the code snipet that it may help me to overcome this problem:

```bash
TEMPFILE=/tmp/$$.tmp
echo 0 > $TEMPFILE

# Loop goes here
  # Fetch the value and increase it
  COUNTER=$[$(cat $TEMPFILE) + 1]

  # Store the new value
  echo $COUNTER > $TEMPFILE

# Loop done, script done, delete the file
unlink $TEMPFILE
```




So with a bit of modifications I run the code:

```bash


tempfile="/tmp/$$.tmp";
echo 0 > $tempfile;

# Loop goes here
for i in {1..500};
do
	# CODE BLOCK
    echo "$i";

	# Fetch the value and increase it
	counter=$[$(cat $tempfile) + 1];

	# Store the new value
	echo $counter > $tempfile;

done;


# Loop done, script done, delete the file
#unlink $tempfile;

```

And commented out the `unlink $tempfile;` line because I did not want my file to be automatically delete it by BASH. Because that is what `unlink` command does, it deletes files.  

So yeah I runt his code in a loop, and then I checked the file which it is here at this location in my Linux OS:  
```
/tmp/$$.tmp
```

And then I navigated there and checked if there is such a file. Guess what?  

```
zen101@vbox:tmp$ ls -l
```

I found the temprorary file, it is this one:

```
-rw-r--r-- 1 zen101 zen        4 May 13 09:16  6963.tmp
```

Wow bash named it a random number and inside after I opened this file `6963.tmp` it is exactly what I expected:

```text
500












```



Which of course it is that number of 500, because I run the loop 500 times...  
So that means even if BASH drops variables between shels sometimes, well I can use temporary filles to store variable data.  

Hurrayyyyy  🥳 I am super happy that I got the hung of this problam 🥳  

Now I will just take a small break and then I will go and try to add this functioality to my sourcecode..

By the way, if you want your temp file to be deleted after the program finishes its execution, just un-comment this line in the code snipet above:  

```bash
# Loop done, script done, delete the file
unlink $tempfile;
```

And the "unlink" command will delete the temp file made and used..



Ok I run into a proble. So I had this boiler plate of code, which works fine when I have one counter and one file.

```bash


tempfile="/tmp/$$.tmp";
echo 0 > $tempfile;

# Loop goes here
for i in {1..500};
do
	# CODE BLOCK
    echo "$i";

	# Fetch the value and increase it
	counter=$[$(cat $tempfile) + 1];

	# Store the new value
	echo $counter > $tempfile;

done;


# Loop done, script done, delete the file
unlink $tempfile;

```



But if I extend this paradigm, and use multiple files and multiple counters...  
I run into a wird issue. It seams that BASH only opens one file, and makes all variables to point to that file. And when I try to delete the 3 files uith `unlink` I get 2 erros, which means, that the "unlink" commadn deleted the first file, and the next 2 unlink commands had nothing to delete in the `/temp` direcotry, because there was only one file made in the first place.

```bash


tempfile1="/tmp/$$.tmp";
tempfile2="/tmp/$$.tmp";
tempfile3="/tmp/$$.tmp";

echo 0 > $tempfile1;
echo 0 > $tempfile2;
echo 0 > $tempfile3;

# Loop goes here
for i in {1..500};
do
	# CODE BLOCK
    echo "$i";

	# Fetch the value and increase it
	counter1=$[$(cat $tempfile1) + 1];
	counter2=$[$(cat $tempfile2) + 10];
	counter3=$[$(cat $tempfile3) + 100];

	# Store the new value
	echo $counter1 > $tempfile1;
	echo $counter2 > $tempfile2;
	echo $counter3 > $tempfile3;


done;

echo "the file content is="$(cat $tempfile1);
echo "the file content is="$(cat $tempfile2);
echo "the file content is="$(cat $tempfile3);

# Loop done, script done, delete the file
unlink $tempfile1;
unlink $tempfile2;
unlink $tempfile3;







```

This is the error output:

```
..
..
..
.
488
489
490
491
492
493
494
495
496
497
498
499
500
the file content is=50000
the file content is=50000
the file content is=50000
unlink: cannot unlink '/tmp/51381.tmp': No such file or directory
unlink: cannot unlink '/tmp/51381.tmp': No such file or directory

```



So you see it is like overwrites what is in one file, it looks that there are no 3 files made separateley..  

Hmm what could it be, I will go and check on interent...

I was reading on internet, but I just realised, that I overwrite to the file, becasue I keep using the same name for the temp file.  So I tested something and it is working..

To make the code above working replace these lines:

```bash
tempfile1="/tmp/$$.tmp";
tempfile2="/tmp/$$.tmp";
tempfile3="/tmp/$$.tmp";
```

With this lines:

```bash
tempfile1="/tmp/temp1.tmp";
tempfile2="/tmp/temp2.tmp";
tempfile3="/tmp/temp3.tmp";
```

By doing so I make a new file with a new name. And my data will not be overwritten.  
Amaizing, I am very happy with the results. So I modified the code, and now it looks like this:

```bash


tempfile1="/tmp/temp1.tmp";
tempfile2="/tmp/temp2.tmp";
tempfile3="/tmp/temp3.tmp";

echo 0 > $tempfile1;
echo 0 > $tempfile2;
echo 0 > $tempfile3;

# Loop goes here
for i in {1..500};
do
	# CODE BLOCK
    echo "$i";

	# Fetch the value and increase it
	counter1=$[$(cat $tempfile1) + 1];
	counter2=$[$(cat $tempfile2) + 10];
	counter3=$[$(cat $tempfile3) + 100];

	# Store the new value
	echo $counter1 > $tempfile1;
	echo $counter2 > $tempfile2;
	echo $counter3 > $tempfile3;


done;

echo "the file content is="$(cat $tempfile1);
echo "the file content is="$(cat $tempfile2);
echo "the file content is="$(cat $tempfile3);

# Loop done, script done, delete the file
unlink $tempfile1;
unlink $tempfile2;
unlink $tempfile3;



```

And the Output is good:

```

.....
...
..
485
486
487
488
489
490
491
492
493
494
495
496
497
498
499
500
the file content is=500
the file content is=5000
the file content is=50000

```





This is perfect!  
Now I can go back to my source code and implement this fix!  



----------------------------------------------------------------------------------

## I run my MARKDOWN LINKS FIXER script for the first time fully 

Ok I run the command `.fix-markdown-links.sh` , well I run my script. It took around 40 min to go through all my core and check and search for my notes. But now everything looks good, apart some errors with workbench file... it doesn't seam to be able to replace that, and I don't know why but I am too tired to care.. 
Anyway this is the output of my first time runing this script:

```



                                                  
# ( ▀ ͜͞ʖ▀) MARKDOWN-LINKS-FIXER BY CONSTANTIN LUCIU
#                                                  
####################################################################
# LOG FINAL STATISTICS:
# LOG TOTAL NUMBER OF IDS THAT DO NOT EXIST IN MY CORE OF NOTES=2690
# LOG TOTAL NUMBER OF MD FILES CHECKED=853
# LOG TOTAL NUMBER OF LINES READ=109134
# LOG TOTAL NUMBER OF CODE BLOCKS AVOIDED=1809
# LOG TOTAL NUMBER OF MARKDOWN LINKS CHECKED=4465
# LOG TOTAL NUMBER OF BROKEN MARKDOWN LINKS FOUND=437
# LOG TOTAL NUMBER OF MARKDOWN LINKS FIXED=437
#                                                        
# LOG THE MOST MARKDOWN LINKS ON 1 SINGLE LINE OF TEXT=120
# LOG THE DEEPEST DIRECTORY PATH HAS THIS NUMBER OF DIRECTORIES=23
####################################################################
```



Ok I finally done this! 

I think it looks good, it works fine...  
Wonderful :) 





## THE END
