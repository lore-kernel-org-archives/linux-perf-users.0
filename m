Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDA5C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Mar 2022 11:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiCQLeG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiCQLeG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Mar 2022 07:34:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94D81E3E23;
        Thu, 17 Mar 2022 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ey+fTvo2WaAXz/8S4ThmUaqCZBbCMIOrkL3sCa+NTTg=; b=DZZZ/qaiMvFxJJskTW+RRyyWsq
        TRlnPiyk/dtCK42Dv6mDxRNz4owhHryjydGyhYmrBORhvKeWfVLAuEzvIc1w3/zDq6KuPErCy7PhT
        idgCXcKlyPExYrnKXaNRGvazDEtawVsq/AAPsz7LmISSvuXHFrQ6buAEy4Ep/p7pmwrPQEbOh3aqV
        LDg7LD4oR8wbPWNsBLSFO7MwbQItFeMoON98KSSBiuM+TQXKmKVDkeq6HI/25kR88jrRngRc12d/g
        N0CnxxYjnJMkOVoF430KilTDGDRGpjpmQGzu0QqamoOi+pv/wf4E1d176253ikUAhexvyjmCDtfoa
        /rsijmBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUoMv-006uxP-Kc; Thu, 17 Mar 2022 11:32:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3967C3001EA;
        Thu, 17 Mar 2022 12:32:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B7AD2B3B2762; Thu, 17 Mar 2022 12:32:37 +0100 (CET)
Date:   Thu, 17 Mar 2022 12:32:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 4/7] perf/x86/amd/core: Detect available counters
Message-ID: <YjMcVVkG+kOZgtYB@hirez.programming.kicks-ass.net>
References: <cover.1647498015.git.sandipan.das@amd.com>
 <7393a62ef0489c4b86034c68ff8e11bc97456385.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7393a62ef0489c4b86034c68ff8e11bc97456385.1647498015.git.sandipan.das@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 17, 2022 at 11:58:33AM +0530, Sandipan Das wrote:
> If AMD Performance Monitoring Version 2 (PerfMonV2) is
> supported, use CPUID Fn80000022[EBX] to detect the number
> of Core PMCs. This offers more flexibility if the counts
> change across processor families.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/amd/core.c        | 5 +++++
>  arch/x86/include/asm/perf_event.h | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index a074af97faa9..05d79afe5173 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -980,9 +980,14 @@ static int __init amd_core_pmu_init(void)
>  
>  	/* Check for Performance Monitoring v2 support */
>  	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
> +		int ebx = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
> +
>  		/* Update PMU version for later usage */
>  		x86_pmu.version = 2;
>  
> +		/* Find the number of available Core PMCs */
> +		x86_pmu.num_counters = EXT_PERFMON_DEBUG_NUM_CORE_PMC(ebx);
> +
>  		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
>  	}

I prefer using unions like cpuid10_ebx. Such much easier to read than
all this shouting.
