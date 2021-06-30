Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D34C11F65
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 11:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64236144A
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 11:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhF3LHs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3LHs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Jun 2021 07:07:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE2C061756;
        Wed, 30 Jun 2021 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D323D401TdCk6w7+sRla9GhM2/NvkKAQNpWP3TaT4EE=; b=ABerm+bQzI7rlXpwm6vCG1tJl6
        Eas/5ugMF7eFiDEMY1pewlzE36OAVa2/VzI9Dudf1yG5FcvmIa426d8/Vv7DYfZdEm1oJ6VwCwXDf
        f2VX/n2/M5C2GlQ/RNzYQS0E2ZHUErj6yGnW9OtETybgvh6T9oZsodd/U8du4yyJijuXka+Qr7NOS
        bRee3FByYg9CNa+MQIugir8PTZWyEEkIJXekpN97GLgw0/4JdZ3wIfjUzDEDYAsf+nFFitqAsi1Q7
        fLwkV8E/V5tjKD+UhqIwwmAtyfWTdLjf3kwRIQF6KrIjCC6FSSZcGNzIRBYylJPzSA/roQiUqsV1D
        EtbBupug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyY18-005FbH-3j; Wed, 30 Jun 2021 11:04:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB23D300242;
        Wed, 30 Jun 2021 13:04:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BAE72C306076; Wed, 30 Jun 2021 13:04:28 +0200 (CEST)
Date:   Wed, 30 Jun 2021 13:04:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/x86: Add new event for AUX output counter index
Message-ID: <YNxPvIC3gVdy1bp4@hirez.programming.kicks-ass.net>
References: <20210609142055.32226-1-adrian.hunter@intel.com>
 <20210609142055.32226-2-adrian.hunter@intel.com>
 <YNXW4+QqeO1KL4Xq@hirez.programming.kicks-ass.net>
 <cc79fce0-2c92-dd55-fd50-46b28644f4fc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc79fce0-2c92-dd55-fd50-46b28644f4fc@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 30, 2021 at 12:21:07PM +0300, Adrian Hunter wrote:
> On 25/06/21 4:15 pm, Peter Zijlstra wrote:
> > On Wed, Jun 09, 2021 at 05:20:53PM +0300, Adrian Hunter wrote:
> > 
> >> +static void intel_pmu_report_aux_output_id(struct perf_event *event)
> >> +{
> >> +	struct hw_perf_event *hwc = &event->hw;
> >> +
> >> +	/*
> >> +	 * So long as all PEBS-via-PT events for a recording session are
> >> +	 * scheduled together, then only changes to hwc->idx need be reported.
> >> +	 */
> >> +	if (hwc->idx != hwc->idx_reported) {
> >> +		hwc->idx_reported = hwc->idx;
> >> +		perf_report_aux_output_id(event, hwc->idx);
> >> +	}
> >> +}
> > 
> > AFAICT you want a callback in x86_assign_hw_event(), is that so?
> > 
> 
> Yes, or open-coded e.g.
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8f71dd72ef95..46dac45298d1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1207,6 +1207,11 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>  	return n;
>  }
>  
> +static inline bool report_aux_output_id(struct perf_event *event)
> +{
> +	return is_pebs_pt(event);
> +}
> +
>  static inline void x86_assign_hw_event(struct perf_event *event,
>  				struct cpu_hw_events *cpuc, int i)
>  {
> @@ -1217,6 +1222,9 @@ static inline void x86_assign_hw_event(struct perf_event *event,
>  	hwc->last_cpu = smp_processor_id();
>  	hwc->last_tag = ++cpuc->tags[i];
>  
> +	if (report_aux_output_id(event))
> +		perf_report_aux_output_id(event, idx);
> +
>  	switch (hwc->idx) {
>  	case INTEL_PMC_IDX_FIXED_BTS:
>  	case INTEL_PMC_IDX_FIXED_VLBR:

Right, bit yuck, but I suppose it works. The alternative is something
like:

	static_call_cond(x86_pmu_assign)(event, idx);

but I'm not sure that's worth it, but it avoids stuffing even more intel
specific bits into the core.


