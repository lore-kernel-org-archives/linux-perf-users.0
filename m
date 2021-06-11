Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E45C48BE0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 22:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6730613CD
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 22:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKWDR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:03:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhFKWDR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 18:03:17 -0400
Received: from zn.tnic (p200300ec2f0aec00c039d52956c712fd.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ec00:c039:d529:56c7:12fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80F171EC01B7;
        Sat, 12 Jun 2021 00:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623448877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EEwR5/b08FCIuHBcZmeu6ocrkwRpJQ7CMwf2+fRzK8o=;
        b=GXNqJE8MkSjDShDvC9yDZluu+iiqX7qHocrZi39M8iu9Y3Hvvbna0BEKsTJxmnqjWjzXWy
        7B+XsSxLOFsPiXh7DU24EW46RT8m74XjyZ7OOkaxJbQxOQrLEi8/Lq2n9Ef2uTJMyyYjr2
        IbswmaC7ikaNbpCrgNyR6DmChWDT4FY=
Date:   Sat, 12 Jun 2021 00:01:10 +0200
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
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf/x86/intel: Do not deploy workaround when TSX is
 deprecated
Message-ID: <YMPdJkLJkQBJdIEL@zn.tnic>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <4926973a8b0b2ed78217add01b5c459a92f0d511.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
 <YMMVvq9ZZCu9zZom@zn.tnic>
 <20210611213443.ira5gc65jlafz7pu@gupta-dev2.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210611213443.ira5gc65jlafz7pu@gupta-dev2.localdomain>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 11, 2021 at 02:34:43PM -0700, Pawan Gupta wrote:
> > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > > index e28892270c58..b5953e1e59a2 100644
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -6016,10 +6016,24 @@ __init int intel_pmu_init(void)
> > >  		intel_pmu_pebs_data_source_skl(pmem);
> > > 
> > >  		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
> > > -			x86_pmu.flags |= PMU_FL_TFA;
> > > -			x86_pmu.get_event_constraints = tfa_get_event_constraints;
> > > -			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
> > > -			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
> > > +			u64 msr;
> > > +
> > > +			rdmsrl(MSR_TSX_FORCE_ABORT, msr);
> > > +			/* Systems that enumerate CPUID.RTM_ALWAYS_ABORT or
> > > +			 * support MSR_TSX_FORCE_ABORT[SDV_ENABLE_RTM] bit have
> > > +			 * TSX deprecated by default. TSX force abort hooks are
> > > +			 * not required on these systems.
> > 
> > So if they're not required, why aren't you simply disabling the force
> > abort "workaround" by clearing the feature flag?
> 
> Feature flag also enumerates MSR_TSX_FORCE_ABORT, which is still present
> after the microcode update. Patch 3/4 in this series clears the TSX
> CPUID bits using MSR_TSX_FORCE_ABORT. So we do need the feature flag
> X86_FEATURE_TSX_FORCE_ABORT.

So it seems to me then, the if test above should be changed to:

	if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT) && 
	   !boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT)) {
	   ...

and no need for the MSR read.

Please don't tell me there are configurations
where CPUID.RTM_ALWAYS_ABORT is clear but the
MSR_TSX_FORCE_ABORT[SDV_ENABLE_RTM] is there?!

This

"A new CPUID bit CPUID.RTM_ALWAYS_ABORT (CPUID 7.EDX[11]) is added to
indicate the status of always abort behavior."

tells me that the CPUID bit is always set by the microcode so we should
be ok.

If not, you should read that MSR early and do

	setup_force_cpu_cap(X86_FEATURE_RTM_ALWAYS_ABORT)

so that this "always abort" flag is always set when TSX transactions are
always aborted.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
