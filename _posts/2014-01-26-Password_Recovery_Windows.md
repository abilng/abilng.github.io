---
layout: post
title:  "Password Recovery: Windows 7"
date: 2014-01-26 18:01:38
tags: windows passwd
author: Abil N George 
category: blog
---

One can reset Windows password by a simple command line utility.Here are the step by step instruction on how to do this.

start cmd (run as admin administrator).
Enter command net user. This will list all users in system.

{% highlight bat %}
net user
{% endhighlight %}
Now we can reset password of required user by:
{% highlight bat %}
net user username password
{% endhighlight %}

The problem is if we don't know current admin password, we cant run cmd as administrator. We can use a backdoor to run cmd as admin without password.

There are  programs like _Utilman.exe_ (Ease of Access Center - Windows Key + U ) ,sethc.exe(Sticky Keys) in windows which are available in login screen of windows 7.If replace these programs (in _C:\windows\system32_\) by _C:\windows\system32\cmd.exe_, we can run cmd from login screen itself.

To rename these file we need a  Windows 7 DVD or Live linux CD.

### Using Windows 7 DVD:

* To begin, boot from your Windows 7 DVD and when you reach the first screen asking about the language, currency and keyboard format, Click Next.
* On the next page, down in the lower left hand side, click on the “Repair your computer” link.
* Select the “Use recovery tools that can help fix problems starting Windows. Select an operating system to repair” option, choose an operating system from the list and Click Next.
* You will now have an option to “Choose a recovery tool”. Select Command Prompt.
* You should now have a Command Prompt Window open. Type in the following commands:
{% highlight bat %}
C:\
cd windows\system32
ren utilman.exe utilman.exe.bak
copy cmd.exe utilman.exe
{% endhighlight %}
* Remove the DVD and reboot the system. Once the computer boots up normally, press the key combination Windows Key + U and you should get a Command Prompt. If the Command Prompt doesn't appear, press Alt+Tab as the Command Prompt may appear behind the Login screen.
* Now Reset your password using "net user".

### Using Live linux CD:

Renaming files is more easy using Linux Live CD,Since most of them provide GUI.

* Using file browser,go to Windows (C:\) partition 
* rename _/windows/system32/sethc.exe_ to   _/windows/system32/sethc.exe.bak_, then make a copy of _cmd.exe_ as  _sethc.exe_.
* Remove the CD and reboot the system. 
* Once the computer boots up normally, press the shift key  five times and you should get a Command Prompt.Now Reset your password with "net user".