From: Andi Kleen <andi@firstfloor.org>
Subject: Re: LBR unwinding for user defined dynamic trace point
Date: Thu, 7 Apr 2016 08:55:22 -0700
Message-ID: <20160407155522.GE9407@two.firstfloor.org>
References: <2495974.rH49Pff4SO@milian-kdab2>
 <3862406.HVDrYIDCMl@milian-kdab2>
 <20150916185614.GF1747@two.firstfloor.org>
 <2173915.EElRzu5JW2@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:53582 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbcDGPz0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 7 Apr 2016 11:55:26 -0400
Content-Disposition: inline
In-Reply-To: <2173915.EElRzu5JW2@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

> Could you tell me what would be required to get LBR callgraphs supported for 
> trace points? I noticed that it also does not work with static tracepoints or 
> software events:

The perf trace point handler code would need to know how to read the LBR
registers and dump them into the trace stream. Right now that's only
implemented for the PMU overflow code. In principle it is not very
complicated, see
arch/x86/kernel/cpu/perf_event_intel_lbr.c:intel_pmu_lbr_read()
Basically would need to call that, but save the information
somewhere else (not the cpuc), and then dump it into the trace buffer.

For kernel LBRs it would also need to stop/restart them to avoid
pollution, but for the case you're likely interested in (LBR with ring 3
filter for user programs), that's not needed.

> Due to the reasons and advantages you point out in your article for LBR 
> callgraphs, I'd love to see it supported for the above use-cases as well, if 
> possible. If you can guide me, and it does not require me to patch the kernel 
> itself, then I'm also willing to come up with a patch for perf.

It requires patching the kernel.

-Andi
