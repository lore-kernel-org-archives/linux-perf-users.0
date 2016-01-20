From: "Benjamin King" <benjaminking@web.de>
Subject: Aw: Re: perf tracepoints for regular user?
Date: Wed, 20 Jan 2016 12:50:33 +0100
Message-ID: <trinity-4241dafc-74f5-4560-80af-3b9ba8eefece-1453290633763@3capp-webde-bs16>
References: <20160115210516.GA6329@localhost>
 <4927145.OUESRpdSEU@agathebauer> <20160119050244.GA13183@localhost>,
 <20160119221858.GK27085@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:57857 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932371AbcATLui (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 Jan 2016 06:50:38 -0500
In-Reply-To: <20160119221858.GK27085@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Arnaldo,

> > $ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
> > mount: can't find /sys/kernel/debug/tracing in /etc/fstab
> > $ mount|grep debug
> > none on /sys/kernel/debug type debugfs (rw,mode=755,mode=755)
> 
> Ok, your kernel is old and doesn't have the tracefs:
> 
> 
> [acme@zoo ~]$ mount | egrep \(debug\|trace\)fs
> debugfs on /sys/kernel/debug type debugfs (rw,relatime,seclabel,mode=755)
> tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime,mode=755)
> [...]
> [acme@zoo ~]$ uname -r
> 4.3.0+

That's odd. According to kernelnewbies.org (Yes, I am that much of a kernel hacker :-) ), tracefs should be in since 4.1 and I'm on 4.2, but I can only find CONFIG_DEBUG_FS in my kernel configuration. There is no mentioning of a corresponding CONFIG_TRACE_FS there.

I'll try to upgrade to a more recent kernel and stop bugging you guys until then.

Cheers,
  Benjamin
