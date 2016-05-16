From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace: Problems initializing symbol libraries!
Date: Mon, 16 May 2016 10:15:12 -0300
Message-ID: <20160516131512.GA5475@kernel.org>
References: <2323271.hRPH2PSKxc@milian-kdab2>
 <20160512181044.GK20258@kernel.org>
 <1849423.FYp0BrzLMo@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32868 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbcEPNPh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 May 2016 09:15:37 -0400
Content-Disposition: inline
In-Reply-To: <1849423.FYp0BrzLMo@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, May 16, 2016 at 01:31:48PM +0200, Milian Wolff escreveu:
> On Donnerstag, 12. Mai 2016 15:10:44 CEST Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 12, 2016 at 02:05:35PM +0200, Milian Wolff escreveu:
> > > I'm getting the following error when trying to run `perf trace` built from
> > > acme's perf/core branch on an Ubuntu 16.04 machine:
> > > 
> > > $ perf trace
> > > Problems initializing symbol libraries!
> > > 
> > > strace shows this at the end:
> > > 
> > > ...
> > > lstat("/proc", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> > > lstat("/proc/kallsyms", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> > > write(2, "Problems initializing symbol lib"..., 40Problems initializing
> > > symbol libraries!
> > > ) = 40
> > > exit_group(244)
> > > 
> > > Is something wrong with my /proc/kallsyms? Can someone tell me what the
> > > problems are that are being encountered?
> > 
> > Does it work as root?
> 
> It does work as root. Note that on my other machines, I can run these commands 
> to make it work as a non-root user:
> 
> sudo mount -o remount,mode=755 /sys/kernel/debug
> sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
> echo "-1" | sudo tee /proc/sys/kernel/perf_event_paranoid
> 
> This does not work on Ubuntu 16.04 anymore.

Ok, downloading 16.04 workstation to install on a guinea pig as I can't
possibly repro this on a docker image, the issue most likely is with the
kernel.
 
> > What is the value of /proc/sys/kernel/kptr_restrict?
> > 
> 
> This file does not exist.
> 
> > Need to improve that message :-\
> 
> Yes please :)

Will try, as soon as I install u16.04 on bare metal.

- Arnaldo
