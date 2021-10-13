Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E1C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535CC6109F
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhJMR15 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:27:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhJMR15 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:27:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA6C01063;
        Wed, 13 Oct 2021 10:25:52 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6E43F694;
        Wed, 13 Oct 2021 10:25:47 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:25:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 1/5] x86: perf: Move RDPMC event flag to a common
 definition
Message-ID: <20211013172529.GA5400@C02TD0UTHF1T.local>
References: <20210914204800.3945732-1-robh@kernel.org>
 <20210914204800.3945732-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914204800.3945732-2-robh@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Rob,

On Tue, Sep 14, 2021 at 03:47:56PM -0500, Rob Herring wrote:
> In preparation to enable user counter access on arm64 and to move some
> of the user access handling to perf core, create a common event flag for
> user counter access and convert x86 to use it.
> 
> Since the architecture specific flags start at the LSB, starting at the
> MSB for common flags.

Minor comments below (definition rename, and a comment block), but with
those:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Peter, are you happy with this from the x86 side?

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-perf-users@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/x86/events/core.c       | 10 +++++-----
>  arch/x86/events/perf_event.h |  2 +-
>  include/linux/perf_event.h   |  2 ++
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 2a57dbed4894..2bd50fc061e1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2469,7 +2469,7 @@ static int x86_pmu_event_init(struct perf_event *event)
>  
>  	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
>  	    !(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
> -		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
> +		event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
>  
>  	return err;
>  }
> @@ -2503,7 +2503,7 @@ void perf_clear_dirty_counters(void)
>  
>  static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  {
> -	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
> +	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
>  		return;
>  
>  	/*
> @@ -2524,7 +2524,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>  
>  static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
>  {
> -	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
> +	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
>  		return;
>  
>  	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
> @@ -2535,7 +2535,7 @@ static int x86_pmu_event_idx(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  
> -	if (!(hwc->flags & PERF_X86_EVENT_RDPMC_ALLOWED))
> +	if (!(hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>  		return 0;
>  
>  	if (is_metric_idx(hwc->idx))
> @@ -2718,7 +2718,7 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time = 0;
>  	userpg->cap_user_time_zero = 0;
>  	userpg->cap_user_rdpmc =
> -		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
> +		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
>  	userpg->pmc_width = x86_pmu.cntval_bits;
>  
>  	if (!using_native_sched_clock() || !sched_clock_stable())
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index e3ac05c97b5e..49f68b15745f 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -73,7 +73,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
>  #define PERF_X86_EVENT_PEBS_NA_HSW	0x0010 /* haswell style datala, unknown */
>  #define PERF_X86_EVENT_EXCL		0x0020 /* HT exclusivity on counter */
>  #define PERF_X86_EVENT_DYNAMIC		0x0040 /* dynamic alloc'd constraint */
> -#define PERF_X86_EVENT_RDPMC_ALLOWED	0x0080 /* grant rdpmc permission */
> +
>  #define PERF_X86_EVENT_EXCL_ACCT	0x0100 /* accounted EXCL event */
>  #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
>  #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fe156a8170aa..12debf008d39 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -142,6 +142,8 @@ struct hw_perf_event {
>  			int		event_base_rdpmc;
>  			int		idx;
>  			int		last_cpu;
> +
> +#define PERF_EVENT_FLAG_USER_READ_CNT	0x80000000

I realise this matches the style of PERF_HES_* and PERF_EF_*. but could
we please arrange this like the PERF_PMU_CAP_* definitions, and move
this immediately before the struct hw_perf_event defintion, with a
comment block, e.g.

/*
 * hw_perf_event::flag values
 *
 * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
 * usage.
 */
#define PERF_EVENT_FLAG_ARCH			0x0000ffff
#define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000

Thanks,
Mark.
