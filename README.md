# frg
frg is a bash function that combines the abilty of fzf to rapidly search and select files by name, and ripgrep to search contents within files. The fzf and ripgrep search filters are independent of one another. This means that one, the other, or both filename and content filters can be applied. For example, pressing ESC will bypass the filename search filter such that the content of all files in the currect directly are searched using ripgrep.

# Two Search Stages:
(1) select (i.e., filter/limit) files to search (fzf), and  
(2) search only within selected files (rg)

# Three Search Modes:
(1) normal: files are first selected using fzf, and then rg search results for only those files are displayed  
(2) fzf select files: files can be selected and previewed in their entirety (i.e., essentially cat'ed into one preview)  
(3) rg: pressing ESC on the first menu skips file selection/filtering causing rg to search all files within the directory

# Application
Note-taking is one basic appliation of frg. I keep all of my data files within a large directory. Sometimes I know the file (or several files) which contain the text for which I am searching. In this case, the fzf filename search filter helps to keep the search results from getting overwhelmed with irrelevant files. It is particularly usefule for certain types of searches, for example, programming langauge constructs like "break", "continue", and "[", which are often common in typical documents.  Othertimes, I may have related files in a smaller directory and want to quickly preview them. Once the desired content is found, it can be opened to the exact line in an editor with a single press of Enter.


# usage: frg
(1) navigate to a desired directory, which will serve as the root directory for all searches within frg  
(2) run "frg"



# Data format:
rg --line-number --no-heading --color=always --smart-case --no-messages
returns "<file>:<linenumber>:<matching line>" (appears to be one indexed)
ex.) README.md:3:Marker Fork for Python3
{1}: file (README.md)
{2}: line number (3)
{3}: matching line (Marker Fork for Python3)

# Installation
## Temporary (cut & paste)
The frg() shell function can be copied and pasted into a terminal window. The frg funtion is run by entering "frg" at the command prompt. 
  
## .bashrc
The frg() shell function can be made permanent within the terminal by ```source``ing the frg.sh.
  
## .bashrc.d

  
## Dependencies
(1) fzf
(2) ripgrep
(3) sublime-text (or another text editor to open selected files)

# Limitations
frg is limited to text files due to dependency on ripgrep. frga is an extension to frg that used ripgrep-all to enable searching of common binary files (e.g., pdf, word, etc.) (coming soon)
