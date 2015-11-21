From: Andi Kleen <ak@linux.intel.com>
Subject: Re: event group without multiplexing
Date: Fri, 20 Nov 2015 16:58:36 -0800
Message-ID: <20151121005836.GA8438@tassilo.jf.intel.com>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com>
 <CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com>
 <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
 <1447350001.15375.95.camel@Rudolf-RHEL-7>
 <alpine.DEB.2.20.1511121248050.7597@vincent-weaver-1.umelst.maine.edu>
 <alpine.DEB.2.20.1511121257380.7597@vincent-weaver-1.umelst.maine.edu>
 <20151117003937.GF10150@tassilo.jf.intel.com>
 <CAJh9x3oq8fzEuQytCfGNZ1us8ZLLZgs=Fjr1qJBTeETSd-uA2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57932 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760843AbbKUA6h (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Nov 2015 19:58:37 -0500
Content-Disposition: inline
In-Reply-To: <CAJh9x3oq8fzEuQytCfGNZ1us8ZLLZgs=Fjr1qJBTeETSd-uA2g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <cyfmxc@gmail.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>

On Mon, Nov 16, 2015 at 10:03:28PM -0500, Yuanfang Chen wrote:
> Is this ok?

Sorry for the delay. The patch looks good to me. You may need
to resend to peterz@infradead.org linux-kernel@vger.kernel.org

Reviewed-by: Andi Kleen <ak@linux.intel.com>

> 
> 
> From 47d52ccfae56a8eb702fee6ccf327780265df2cf Mon Sep 17 00:00:00 2001
> From: Yuanfang Chen <cheny@udel.edu>
> Date: Mon, 16 Nov 2015 21:53:53 -0500
> Subject: [PATCH 1/1] perf/x86/intel: make L1D_PEND_MISS.FB_FULL not
>  constrained on haswell
> 
> Signed-off-by: Yuanfang Chen <cheny@udel.edu>
> ---
>  arch/x86/kernel/cpu/perf_event_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/perf_event_intel.c
> b/arch/x86/kernel/cpu/perf_event_intel.c
> index f63360b..e2a4300 100644
> --- a/arch/x86/kernel/cpu/perf_event_intel.c
> +++ b/arch/x86/kernel/cpu/perf_event_intel.c
> @@ -232,7 +232,7 @@ static struct event_constraint
> intel_hsw_event_constraints[] = {
>   FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
>   FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
>   FIXED_EVENT_CONSTRAINT(0x0300, 2), /* CPU_CLK_UNHALTED.REF */
> - INTEL_EVENT_CONSTRAINT(0x48, 0x4), /* L1D_PEND_MISS.* */
> + INTEL_UEVENT_CONSTRAINT(0x148, 0x4),  /* L1D_PEND_MISS.PENDING */
