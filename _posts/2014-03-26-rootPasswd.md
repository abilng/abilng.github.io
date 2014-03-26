---
layout: post
title:  "Root Password Reset: Linux"
date: 2014-02-15 18:09:14
tags: linux passwd grub 
category: blog
---

Sometime you can't remember root password. On Linux, recovering root password can be done by booting Linux under a specific mode: single user mode.This can be done using GRUB.

Follow these steps to reset the password when using GRUB:

* While booting the system, in GRUB menu, highlight the line for Linux and press e (for edit).
This will take you to another screen where you can edit grub entry.
* Go to line which begins with kernel  append  single to the end of that line . And then append _init=/bin/bash_ .So that now the line end with 
> ...ro single init=/bin/bash

* Once the system finishes booting, you will be logged in as root. But root file-system is mounted as read only mode.So we should remount it as r+w mode. This can be done by
{% highlight bash %}
mount -o remount,rw /
{% endhighlight %}

* now set new password using __passwd__.
* Again remount root file-system as read only (this is only for safety of file system).

{% highlight ruby %}
mount -o remount,ro /
{% endhighlight %}


Note:

if __GRUB__ is locked by password ,one should use a live CD/USB and then change root (_chroot_) and edit grub file and comment  _password --md5_  ....... Then reboot.