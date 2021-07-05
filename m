Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F4C07E98
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 07:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95291613CB
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 07:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGEH04 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEH0z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 03:26:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E35C061574;
        Mon,  5 Jul 2021 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4TRaWRlSaYwqKlv2XNWBZV4iLCdRyV4Sdpw7BqXo1k=; b=Mt/xdxwJmlveT1KV/aLVl+gDEK
        gQOVhj9Q2OxT37O7HkcVjXZd5a/eJ8H09jiEIxz84b/TjOSuvi6/olQMPQoUWNavJDGVtcsHMOXaQ
        A4AH5wgW2hxd9txVdyy84L6ThrzfWgpRH6PsUjIA2dymtnFOxdztjDGzGtRSAILP1SHyeSs6l3tfv
        Ss9Tew1HK4LXJ7jqBoTLJs/C//bZ+gLKEcBwBZPR49Gwh9c//p2JKc4suQnFppt2su+BDUyOxZqCa
        OqX+4Rk+XuqgQufL+32yamqYeYJ6MFMdYgpG9FbGopyE4NZmFrEA0O8rFp8HX61sfEQWfQDDoHoYx
        NnI7i8Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0IxW-00EdfM-R9; Mon, 05 Jul 2021 07:24:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DD47300209;
        Mon,  5 Jul 2021 09:24:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C95B02B8EDE50; Mon,  5 Jul 2021 09:24:00 +0200 (CEST)
Date:   Mon, 5 Jul 2021 09:24:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] perf/x86: Add new event for AUX output counter
 index
Message-ID: <YOKzkPQ5gAeLUTnY@hirez.programming.kicks-ass.net>
References: <20210701131732.31602-1-adrian.hunter@intel.com>
 <20210701131732.31602-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701131732.31602-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 01, 2021 at 04:17:30PM +0300, Adrian Hunter wrote:
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e28892270c58..7a7c3b18acec 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2400,6 +2400,12 @@ static void intel_pmu_disable_event(struct perf_event *event)
>  		intel_pmu_pebs_disable(event);
>  }
>  
> +static void intel_pmu_assign_event(struct perf_event *event, int idx)
> +{
> +	if (is_pebs_pt(event))
> +		perf_report_aux_output_id(event, idx);
> +}
> +
>  static void intel_pmu_del_event(struct perf_event *event)
>  {
>  	if (needs_branch_stack(event))
> @@ -4596,6 +4602,7 @@ static __initconst const struct x86_pmu intel_pmu = {
>  	.enable_all		= intel_pmu_enable_all,
>  	.enable			= intel_pmu_enable_event,
>  	.disable		= intel_pmu_disable_event,
> +	.assign			= intel_pmu_assign_event,
>  	.add			= intel_pmu_add_event,
>  	.del			= intel_pmu_del_event,
>  	.read			= intel_pmu_read_event,

How about we only set that method (or clear it again) when
intel_cap.pebs_output_pt_available ?

Other than that, this looks good to me.
