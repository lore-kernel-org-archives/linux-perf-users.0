From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Re: perf tracepoints for regular user?
Date: Thu, 21 Jan 2016 11:05:05 -0300
Message-ID: <20160121140505.GB2312@kernel.org>
References: <20160115210516.GA6329@localhost>
 <4927145.OUESRpdSEU@agathebauer>
 <20160119050244.GA13183@localhost>
 <20160119221858.GK27085@kernel.org>
 <trinity-4241dafc-74f5-4560-80af-3b9ba8eefece-1453290633763@3capp-webde-bs16>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38033 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759536AbcAUOFV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Jan 2016 09:05:21 -0500
Content-Disposition: inline
In-Reply-To: <trinity-4241dafc-74f5-4560-80af-3b9ba8eefece-1453290633763@3capp-webde-bs16>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin King <benjaminking@web.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Em Wed, Jan 20, 2016 at 12:50:33PM +0100, Benjamin King escreveu:
> Hi Arnaldo,
> 
> > > $ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
> > > mount: can't find /sys/kernel/debug/tracing in /etc/fstab
> > > $ mount|grep debug
> > > none on /sys/kernel/debug type debugfs (rw,mode=755,mode=755)
> > 
> > Ok, your kernel is old and doesn't have the tracefs:

Not having tracefs, if that is indeed the case, only means that the
remount isn't needed, as what is in tracefs is what, before its
existence, lived in a debugfs directory, /sys/kernel/debug/tracing, i.e.
remounting just /sys/kernel/debug/ would then be enough.

> > [acme@zoo ~]$ mount | egrep \(debug\|trace\)fs
> > debugfs on /sys/kernel/debug type debugfs (rw,relatime,seclabel,mode=755)
> > tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime,mode=755)
> > [...]
> > [acme@zoo ~]$ uname -r
> > 4.3.0+
 
> That's odd. According to kernelnewbies.org (Yes, I am that much of a
> kernel hacker :-) ), tracefs should be in since 4.1 and I'm on 4.2,
> but I can only find CONFIG_DEBUG_FS in my kernel configuration. There
> is no mentioning of a corresponding CONFIG_TRACE_FS there.
 
> I'll try to upgrade to a more recent kernel and stop bugging you guys until then.
