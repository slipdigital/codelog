# status
This project is currently work in progress. I will try and get version 1 released within a fairly short cycle, on order to get the end result and
 work on bells and whistles as feedback and PR's come in.

# Overview
CodeLog is a tool to help timekeeping on projects in a scenario where you are interacting / making 
changes to multiple projects and its difficult to keep track of the time spent. 

V1 will be designed to meet these simple needs, scan the git repos and tell you what you have been doing over a period of time.

# Install 
gem install codelog

rake console 

CodeLog::Setup.scan('~/path/to/parent/folder/of/code', 2)

Codelog will scan the specified path, find Git repos and look at the logs, and report what you have been up to. 

# Notes

Codelog will keep a record of the repositories it find, so the scan operation 
does not need to be done each time, once setup it will simply report on activity and check for new 
repos in the paths you specified. 




