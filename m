Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E54C48BD1
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E7F613BA
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 07:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFKHyi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFKHyh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 03:54:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB8C061574;
        Fri, 11 Jun 2021 00:52:39 -0700 (PDT)
Received: from zn.tnic (p2e584d18.dip0.t-ipconnect.de [46.88.77.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E5BC1EC0528;
        Fri, 11 Jun 2021 09:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623397958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vSnV81dscIMGE/gY3bycp5V2Li1nZZO4DLoJmbCgDdU=;
        b=AbK4ea+m7e4UCR6DzGiNOdLe+w4q57MTzkANx0f9Tbw4U1WFKniqOpYkJchGZonW7PDJMQ
        bbaRyVApCBSkMFS3+gvB9xpCaumT+PPTHLtHtXuAmGLeyaxryuZaFEk/7cBgfVpdzJ/SwB
        wimHMZ3x1yAB9cBJZthq9BEjVz4CHSA=
Date:   Fri, 11 Jun 2021 09:50:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Victor Ding <victording@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf/x86/intel: Do not deploy workaround when TSX is
 deprecated
Message-ID: <YMMVvq9ZZCu9zZom@zn.tnic>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <4926973a8b0b2ed78217add01b5c459a92f0d511.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4926973a8b0b2ed78217add01b5c459a92f0d511.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 09, 2021 at 02:12:38PM -0700, Pawan Gupta wrote:
> Earlier workaround added by commit 400816f60c54 ("perf/x86/intel:
> Implement support for TSX Force Abort") for perf counter interactions
> [1] are not required on some client systems which received a microcode
> update that deprecates TSX.
> 
> Bypass the perf workaround when such microcode is enumerated.
> 
> [1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
>     http://cdrdv2.intel.com/v1/dl/getContent/604224
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
> ---
>  arch/x86/events/intel/core.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e28892270c58..b5953e1e59a2 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6016,10 +6016,24 @@ __init int intel_pmu_init(void)
>  		intel_pmu_pebs_data_source_skl(pmem);
>  
>  		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
> -			x86_pmu.flags |= PMU_FL_TFA;
> -			x86_pmu.get_event_constraints = tfa_get_event_constraints;
> -			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
> -			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
> +			u64 msr;
> +
> +			rdmsrl(MSR_TSX_FORCE_ABORT, msr);
> +			/* Systems that enumerate CPUID.RTM_ALWAYS_ABORT or
> +			 * support MSR_TSX_FORCE_ABORT[SDV_ENABLE_RTM] bit have
> +			 * TSX deprecated by default. TSX force abort hooks are
> +			 * not required on these systems.

So if they're not required, why aren't you simply disabling the force
abort "workaround" by clearing the feature flag?

	if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
		if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT))
			setup_clear_cpu_cap(X86_FEATURE_TSX_FORCE_ABORT);
	}

so that it doesn't get enabled in the first place?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
