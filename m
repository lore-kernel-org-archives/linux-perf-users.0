From: David Ahern <dsahern@gmail.com>
Subject: Re: perf trace timestamps
Date: Fri, 16 Nov 2012 07:39:40 -0700
Message-ID: <50A6502C.9030900@gmail.com>
References: <loom.20121116T140608-755@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:60802 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab2KPOjq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 16 Nov 2012 09:39:46 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1171234dak.19
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Nov 2012 06:39:45 -0800 (PST)
In-Reply-To: <loom.20121116T140608-755@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Saumil Merchant <msaumil@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 11/16/12 6:07 AM, Saumil Merchant wrote:
> Hi,
> I am trying to understand the origin of the timestamps in the trace output.
> Here is an example trace of a sample C code.
>
> /> perf sched record -a ./a.out
> /> perf script
>
> [ ... ]
> a.out 29311 [000] 1746678.549886: sched_stat_runtime: comm=a.out pid=29311
> runtime=310028 [ns] vruntime=159246710291986646 [ns]
> a.out 29311 [000] 1746678.550885: sched_stat_runtime: comm=a.out pid=29311
> runtime=998470 [ns] vruntime=159246710292985116 [ns]
> a.out 29311 [000] 1746678.550895: sched_stat_runtime: comm=a.out pid=29311
> runtime=11039 [ns] vruntime=159246710292996155 [ns]
> [ ... ]
>
> My original impression was that this timestamp (eg, 1746678.550895) would align
> with time reported clk_gettime(MONOTONIC,...) function, but it does not. My C
> function above prints out timestamps from clk_gettime(MONOTONIC,..)  function
> and there is a delta of >15 mins.
>
> Here is the printout on console:
> CLKTIME (MONOTONIC):  1748132.102228068

At one time many, many releases ago perf timestamps did align with the 
monotonic clock. I have tried (unsuccessfully) to get an option into 
perf to correlate perf events with time-of-day stamps.

>
> This delta has been varying from 5 mins to 15+ mins.  My objective is to
> correlate events in a kernel trace with the execution of our user program.  My
> understanding is that both perf and clk_gettime functions on newer x86 systems
> use TSC as the clock source and hence I was confused why they do not align.
>
> Can someone please help?

See John's explanations in this thread:
https://lkml.org/lkml/2012/10/16/173

David
