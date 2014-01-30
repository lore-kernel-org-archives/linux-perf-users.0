From: Mauro Andreolini <mauro.andreolini@gmail.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Thu, 30 Jan 2014 15:43:19 +0100
Message-ID: <1391092999.1111.3.camel@nb-andreolini.mat.unimo.it>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
	 <20140129111844.GA1869@krava.brq.redhat.com>
	 <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
	 <20140130114751.GB1161@krava.brq.redhat.com>
Reply-To: mauro.andreolini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:38234 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbaA3OnX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Jan 2014 09:43:23 -0500
Received: by mail-wg0-f47.google.com with SMTP id m15so6297687wgh.26
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2014 06:43:21 -0800 (PST)
In-Reply-To: <20140130114751.GB1161@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

> zero's are taken care by:
> http://marc.info/?t=138909914500003&r=1&w=2
> within following patchset:
> http://marc.info/?l=linux-kernel&m=138909914404574&w=2

> which implements libdw dwarf unwind.. you might
> actualy want to try it, it seems to be little faster
> than libunwind unwinder
Since I do not yet have elfutils 0.158 installed, I tried
to apply the single patch both to linux-3.12 and to the kernel you
pointed me at, and used perf with the libunwind unwinder. With the 3.12
kernel I get segfaults on perf report; with the 3.13 branch zeroes are
still present. Maybe I messed up.
I think I'll wait for the newest elfutils and give a shot ad the
libdw unwinder.

> > 
> > I also get an occasional screw in the dynamic linker code path:
> > 
> >      5.26%       ls  [kernel.kallsyms]  [k]
> > lock_release                       
> >                  |
> >                  --- lock_release
> >                      __mem_cgroup_try_charge
> >                      mem_cgroup_charge_common
> >                      mem_cgroup_newpage_charge
> >                      do_wp_page
> >                      handle_mm_fault
> >                      __do_page_fault
> >                      do_page_fault
> >                      do_async_page_fault
> >                      async_page_fault
> >                      __init_cpu_features
> >                      0x7fd2357470de   <---- HERE
> 
> not sure if that's just untranslatable part (.plt .got?)
> or an error.. need to be checked some day ;-)
OK. Thanks for your time.

Mauro
