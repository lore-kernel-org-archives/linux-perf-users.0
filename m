From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Interrupt caused by software events
Date: Fri, 11 Jul 2014 11:26:38 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1407111122070.21519@vincent-weaver-1.umelst.maine.edu>
References: <20140711142058.GA27580@gamayun>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36761 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbaGKPVh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Jul 2014 11:21:37 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so1149899qcy.31
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2014 08:21:36 -0700 (PDT)
In-Reply-To: <20140711142058.GA27580@gamayun>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org

On Fri, 11 Jul 2014, Martin Ichilevici de Oliveira wrote:

> /* Gets called whenever my program generates a cache-miss */
> void my_func()
> {
>     unsigned long addr = get_ip_that_generated_event();
>     printf("A cache-miss occurred at IP: %x!\n", addr);
> }
> 
> int main()
> {
>     struct perf_event_attr pe;
>     pe.type = PERF_TYPE_HARDWARE.
>     pe.config = PERF_COUNT_HW_CACHE_MISSES;
>     ...
>     register_handler(&pe, my_func);
>     // code to be monitored
>     unregister_handler();
>     return 0;
> }
> /*******************/
> 
> Every time an event occurs (a cache-miss in my example), my_func should
> get called. The get_ip_that_generated_event() function should return the
> Instruction Pointer that generated the event.

In general you can't do this.  Cache misses happen way too often, your 
program would not be able to keep up, and likely it would be causing cache 
misses itself.

Also you should read up on skid, it's very hard to track an event to an 
exact IP, although if your CPU has PEBS it's possible with certain 
limitations.

> My impression is that this could be done with a low overhead (other then
> that introduced by what I do in my_func), because 
> "perf record -e cache-misses ./a.out"
> can pinpoint with little overhead how many times the event was caused by
> each instruction. But maybe I'm just missing something.

No, what perf record is doing is sampling.  It's getting interrupted say 
every 100,000 cache misses and reporting the values, and hopefully the 
ones that trigger are statistically relevant enough to extract the full 
program behavior.

> I'm unsure how to configure the mmap buffer you mentioned, and I
> couldn't find any examples online. Could you please point me to some
> reference, or maybe provide a little example?

There are some examples in my perf_event_tests package.

See for example
	https://github.com/deater/perf_event_tests/blob/master/tests/x86_intel/pebs.c

although that example really isn't using PEBS yet, I'm currently working 
on that code, so beware I might be re-writing and moving around the code 
in that directory in the next few days.

Vince
