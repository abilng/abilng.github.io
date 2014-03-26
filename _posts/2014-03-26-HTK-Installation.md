---
layout: post
title:  "HTK-Installation"
tags: HTK Linux Speech
date: 2014-03-26 17:41:25
category: blog
---

The Hidden Markov Model Toolkit (HTK) is a portable toolkit for building and manipulating hidden Markov models. HTK is primarily used for speech recognition research.


1.	HTK's licence requires you to [register](http://htk.eng.cam.ac.uk/register.shtml) before you can [download](http://htk.eng.cam.ac.uk/download.shtml) the toolkit.

2. Extract HTK-3.4.1.tar.gz
{% highlight bash %}
$ tar -xvzf HTK-3.4.1.tar.gz
{% endhighlight %}

3. Compile and Install

{% highlight bash %}
cd HTK-*/
{% endhighlight %}

*	If you have 32 bit system
		
{% highlight bash %}
 $ ./configure --prefix=/opt/htk
 $ make all
 $ sudo make install
{% endhighlight %}

* If you have 64 bit system.

> Install libc6-dev-i386 libx11-dev
 {% highlight bash %}
 $ sudo apt-get install libc6-dev-i386 libx11-dev
 {% endhighlight %}

> go to 32 bit terminal
 {% highlight bash %}
 $ linux32 bash
 $ ./configure --prefix=/opt/htk
 $ make all
 $ make install
{% endhighlight %}

4. Set '$PATH'
{% highlight bash %}
 $ echo 'export $PATH=$PATH:/opt/htk/' >> ~/.bashrc
{% endhighlight %}