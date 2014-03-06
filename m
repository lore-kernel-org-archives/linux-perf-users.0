From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Some troubles with perf and measuring flops
Date: Thu, 6 Mar 2014 13:25:46 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1403061323200.22334@vincent-weaver-1.um.maine.edu>
References: <5317C76A.4050103@inf.ethz.ch> <alpine.DEB.2.10.1403052036580.22262@vincent-weaver-1.um.maine.edu> <5317D4FF.1030302@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:37822 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaCFSX1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Mar 2014 13:23:27 -0500
Received: by mail-yh0-f47.google.com with SMTP id c41so3057515yho.6
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2014 10:23:26 -0800 (PST)
In-Reply-To: <5317D4FF.1030302@inf.ethz.ch>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alen Stojanov <astojanov@inf.ethz.ch>
Cc: linux-perf-users@vger.kernel.org

On Thu, 6 Mar 2014, Alen Stojanov wrote:

> > more complicated with AVX in the mix.  What does the intel documentation
> > say for the event for your architecture?
> I agree on this. However, if you would look at the .s file, you can see that
> it does not have any AVX instructions inside. 

I'm pretty sure vmovsd and vmuld are AVX instructions.

> And if I would monitor any other
> event on the CPU that counts any flop operations, I get 0s. It seems that the
> FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE is the only one that occurs. I don't think
> that FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE counts speculative events.

are you sure?

See http://icl.cs.utk.edu/projects/papi/wiki/PAPITopics:SandyFlops
about FP events on SNB and IVB at least.

Vince
