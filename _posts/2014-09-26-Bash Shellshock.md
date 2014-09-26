---
layout: post
title:  "Bash Shellshock"
tags: Vulnerabilities bash, CVE-2014-6271, CVE-2014-7169, shellshocked
date: 2014-09-26 10:41:25
author: Abil N George
category: blog
---
Bash or the Bourne again shell, is a UNIX like shell, which is perhaps one of the most installed utilities on
any Linux system. From its creation in 1980, Bash has evolved from a simple terminal based command interpreter 
to many other fancy uses.

In Linux, environment variables provide a way to influence the behavior of software on the system. 
They typically consists of a name which has a value assigned to it. The same is true of the Bash shell. 
It is common for a lot of programs to run Bash shell in the background. It is often used to provide a shell 
to a remote user (via ssh, telnet, for example), provide a parser for CGI scripts (Apache, etc) or 
even provide limited command execution support (git, etc)

Coming back to the topic, the vulnerability arises from the fact that you can create environment 
variables with specially-crafted values before calling the Bash shell. These variables can contain code, 
which gets executed as soon as the shell is invoked. The name of these crafted variables does not matter, 
only their contents. As a result, this vulnerability is exposed in many contexts, for example:

* ForceCommand is used in sshd configs to provide limited command execution capabilities for remote users. 
This flaw can be used to bypass that and provide arbitrary command execution. 

* Some Git and Subversion deployments use such restricted shells. Regular use of OpenSSH is not affected 
because users already have shell access.

* Apache server using mod_cgi or mod_cgid are affected if CGI scripts are either written in Bash, or spawn subshells. 
Such subshells are implicitly used by system/popen in C, by os.system/os.popen in Python, system/exec in PHP 
(when run in CGI mode), and open/system in Perl if a shell is used (which depends on the command string).

* PHP scripts executed with mod_php are not affected even if they spawn subshells.

* DHCP clients invoke shell scripts to configure the system, with values taken from a potentially malicious server. 
This would allow arbitrary commands to be run, typically as root, on the DHCP client machine.

* Various daemons and SUID/privileged programs may execute shell scripts with environment variable values 
set / influenced by the user, which would allow for arbitrary commands to be run.

* Any other application which is hooked onto a shell or runs a shell script as using Bash as the interpreter. 
Shell scripts which do not export variables are not vulnerable to this issue, even if they process untrusted content 
and store it in (unexported) shell variables and open subshells.

Like “real” programming languages, Bash has functions, though in a somewhat limited implementation, and it is possible
to put these Bash functions into environment variables. This flaw is triggered when extra code is added to the end 
of these function definitions (inside the enivronment variable). Something like:

{% highlight bash %}
$ env x='() { :;}; echo vulnerable' bash -c "echo this is a test"
 vulnerable
 this is a test
{% endhighlight %}
The patch used to fix this flaw, ensures that no code is allowed after the end of a Bash function. 
So if you run the above example with the patched version of Bash, you should get an output similar to:
{% endhighlight %}
 $ env x='() { :;}; echo vulnerable' bash -c "echo this is a test"
 bash: warning: x: ignoring function definition attempt
 bash: error importing function definition for `x'
 this is a test
{% endhighlight %}.

