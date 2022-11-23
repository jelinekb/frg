# frg
frg is a bash function that combines the abilty of fzf to rapidly search and select files by name, and ripgrep to search contents within files. The fzf and ripgrep search filters are independent of one another. This means that one, the other, or both filename and content filters can be applied. For example, pressing ESC will bypass the filename search filter such that 

# Two stage search:
(1) select (i.e., filter/limit) files to search (fzf), and
(2) search only within selected files (rg)

# Three search modes:
(1) normal: files are first selected using fzf, and then rg search results for only those files are displayed
(2) fzf select files: files can be selected and previewed in their entirety (i.e., essentially cat'ed into one preview)
(3) rg: pressing ESC on the first menu skips file selection/filtering causing rg to search all files within the directory

# Application




# fuzzy select files and search within the selected files (w/ preview)

# usage: frg




# Data format:
rg --line-number --no-heading --color=always --smart-case --no-messages
returns "<file>:<linenumber>:<matching line>" (appears to be one indexed)
ex.) README.md:3:Marker Fork for Python3
{1}: file (README.md)
{2}: line number (3)
{3}: matching line (Marker Fork for Python3)

# Installation
  
## Dependencies
(1) fzf
(2) ripgrep
(3) sublime-text (or another text editor to open selected files)

# Limitations
frg is limited to text files due
