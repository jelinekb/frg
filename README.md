# frg

# fuzzy select files and search within the selected files (w/ preview)
# usage: frg


# Two stage search:
(1) select (i.e., filter/limit) files to search (fzf), and
(2) search only within selected files (rg)

# Three search modes:
(1) normal: files are first selected using fzf, and then rg search results for only those files are displayed
(2) fzf select files: files can be selected and previewed in their entirety (i.e., essentially cat'ed into one preview)
(3) rg: pressing ESC on the first menu skips file selection/filtering causing rg to search all files within the directory

# Data format:
rg --line-number --no-heading --color=always --smart-case --no-messages
returns "<file>:<linenumber>:<matching line>" (appears to be one indexed)
ex.) README.md:3:Marker Fork for Python3
{1}: file (README.md)
{2}: line number (3)
{3}: matching line (Marker Fork for Python3)

# Installation
