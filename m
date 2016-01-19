From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf tracepoints for regular user?
Date: Tue, 19 Jan 2016 19:18:58 -0300
Message-ID: <20160119221858.GK27085@kernel.org>
References: <20160115210516.GA6329@localhost>
 <4927145.OUESRpdSEU@agathebauer>
 <20160119050244.GA13183@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39559 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbcASWTB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Jan 2016 17:19:01 -0500
Content-Disposition: inline
In-Reply-To: <20160119050244.GA13183@localhost>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin King <benjaminking@web.de>
Cc: Milian Wolff <milian.wolff@kdab.com>, Linux perf users <linux-perf-users@vger.kernel.org>

Em Tue, Jan 19, 2016 at 06:02:44AM +0100, Benjamin King escreveu:
> Hi Milian,
> 
> On Sun, Jan 17, 2016 at 10:20:00PM +0100, Milian Wolff wrote:
> >On Freitag, 15. Januar 2016 22:05:16 CET Benjamin King wrote:
> >>I am trying to use 'perf stat -e uprobes:xyz' on a tracepoint that I have
> >>previously set, but with no success.
> >Try these commands:
> >
> >$ sudo mount -o remount,mode=755 /sys/kernel/debug
> >$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
> >$ echo \"-1\" | sudo tee /proc/sys/kernel/perf_event_paranoid
> 
> Hm, that does not work for me. I can do the first remount, but not the
> second:
> -----
> $ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
> mount: can't find /sys/kernel/debug/tracing in /etc/fstab
> $ mount|grep debug
> none on /sys/kernel/debug type debugfs (rw,mode=755,mode=755)
> -----

Ok, your kernel is old and doesn't have the tracefs:
 

[acme@zoo ~]$ mount | egrep \(debug\|trace\)fs
debugfs on /sys/kernel/debug type debugfs (rw,relatime,seclabel,mode=755)
tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime,mode=755)
[acme@zoo ~]$ 


> And then, I still can not see tracepoints as a regular user:
> -----
> $ perf list tracepoint
> 
> List of pre-defined events (to be used in -e):
> 
> $ -----
> 
> If this works for you, then maybe it's my version? I'm on 4.2.3

[acme@zoo ~]$ uname -r
4.3.0+


But on another machine, oops, I thought it was older, in fact it is newer :-\

[root@jouet images]# uname -r
4.3.3-300.fc23.x86_64
[root@jouet images]# mount | egrep \(trace\|debug\)fs
debugfs on /sys/kernel/debug type debugfs (rw,relatime,seclabel)
tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime)
[root@jouet images]#
