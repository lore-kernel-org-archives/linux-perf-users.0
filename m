From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Some troubles with perf and measuring flops
Date: Wed, 5 Mar 2014 20:40:53 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1403052036580.22262@vincent-weaver-1.um.maine.edu>
References: <5317C76A.4050103@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:53271 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757706AbaCFBin (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Mar 2014 20:38:43 -0500
Received: by mail-qg0-f42.google.com with SMTP id q107so5298278qgd.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2014 17:38:43 -0800 (PST)
In-Reply-To: <5317C76A.4050103@inf.ethz.ch>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alen Stojanov <astojanov@inf.ethz.ch>
Cc: linux-perf-users@vger.kernel.org

On Thu, 6 Mar 2014, Alen Stojanov wrote:

> However, whenever I try to run matrices of bigger size, the reported flops are
> not even close to the flops that I am supposed to obtain (anticipated results:
> 600 * 600 * 600 * 2 = 432'000'000):
> 
> perf stat -e r538010 ./mmmtest 600
> 
>  Performance counter stats for './mmmtest 600':
> 
>      2,348,148,851 r538010
> 
>        0.955511968 seconds time elapsed
> 
...
> CPU: Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz, 8 cores
> Linux Kernel: 3.11.0-12-generic
> GCC Version: gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu8)
> Monitored events: FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE - Raw event: 0x538010
> (converted using libpfm4)
...
> Do you know why does this happens ? How can I instruct perf to obtain accurate
> results ?

one thing you might want to do is put :u on your event name so you are 
only measuring user space accesses not kernel too.

floating point events are notoriously unreliable on modern intel 
processors.

The event might also be counting speculative events or uops and it gets 
more complicated with AVX in the mix.  What does the intel documentation 
say for the event for your architecture?

Vince
