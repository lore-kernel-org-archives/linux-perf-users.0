From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] perf/x86/intel: make L1D_PEND_MISS.FB_FULL not
 constrained on haswell
Date: Tue, 24 Nov 2015 11:06:08 +0100
Message-ID: <20151124100608.GQ17308@twins.programming.kicks-ass.net>
References: <CAJh9x3r50kGhcryDWdHi++dCtSpJ_1+3eCeGwaQmCORo4uCnAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJh9x3r50kGhcryDWdHi++dCtSpJ_1+3eCeGwaQmCORo4uCnAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuanfang Chen <cyfmxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Nov 23, 2015 at 08:42:08PM -0500, Yuanfang Chen wrote:
> From 47d52ccfae56a8eb702fee6ccf327780265df2cf Mon Sep 17 00:00:00 2001
> From: Yuanfang Chen <cheny@udel.edu>
> Date: Mon, 16 Nov 2015 21:53:53 -0500
> Subject: [PATCH 1/1] perf/x86/intel: make L1D_PEND_MISS.FB_FULL not
>  constrained on haswell
> 
> Signed-off-by: Yuanfang Chen <cheny@udel.edu>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
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

Your patch is line-wrapped, please read Documentation/email-clients.txt
on hints on how to configure your MUA. Then try again.
