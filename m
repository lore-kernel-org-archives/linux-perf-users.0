From: Dennis Gnad <dennis.gnad@kit.edu>
Subject: Re: Understanding timestamps in perf.data
Date: Thu, 3 Sep 2015 09:19:24 +0200
Message-ID: <55E7F47C.2000403@kit.edu>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com>
 <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com>
 <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from scc-mailout-kit-01-web.scc.kit.edu ([129.13.231.93]:53657 "EHLO
	scc-mailout-kit-01-web.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703AbbICHTh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Sep 2015 03:19:37 -0400
In-Reply-To: <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>, David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 02.09.2015 19:00, Vince Weaver wrote:
> They might not be relevant for profiling, but some people use the perf
> counters for other tasks.
>
> For example, when measuring phase plot behavior for a system, it would be
> great if you'd be able to say I want a snapshot sample of the cycle and
> instruction counters every 10ms, and then you can plot the CPI behavior of
> the system.

Yeah, actually I wasn't asking about profiling, sorry if this was 
misunderstood for some reason. I am looking into something you could 
call 'workload characterization' and really need the absolute 
performance counter values, as they could for example correlate with the 
resulting temperature or energy-optimal frequency of the cpu/system, 
depending on its specific workload.

> as far as I can tell you can't really do this with perf (the -I option
> only lets you get down to 100ms).

Which -I option do you mean? At least it's not available for my perf 
record (kernel 3.16).

> I ended up trying to write a custom program to do this, but it turns out
> the perf sampling interface has really high overhead when doing this, and
> the interrupt throttle kicks in which makes it useless.

Are you talking about the kernel interface or some interface of the perf 
tool? I think I need a minimum of 100Hz or 1000Hz, but it wouldn't be a 
problem if this is just collected in some kernel shared memory and in 
the end copied to userspace, or at a lower frequency.

> It's a shame, as the old "pfmon" tool that came with perfmon2 could do
> this kind of measurement very easily.
>
> Vince
>

This can not be used with current kernels, I guess? I tried "oprofile" 
before, which can show absolute counts, but instead doesn't support any 
timestamps.

So, it seems there is nothing available that can do what I need. Maybe 
some of you can still recommend where I could start looking next or go 
into more detail? Kernel, perf, oprofile, libpapi are the things that 
come to my mind. If the kernel interface is really the bottleneck, it 
probably has to be there.

Thanks for your help so far,
Dennis
