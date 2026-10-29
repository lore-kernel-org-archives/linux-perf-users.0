Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269173;
	b=XaIw/Q1a3y2BLkCDhOKNOe+0H+MhVaqzaC1aKcvrX6ufQasVAkWACgLJoDqDfLnPU0fK
	 L1Ht36+AEqodmAmYhI5laOY9Vp2QShbL1Gwo4JItDMynKuBWB74cGuU8/0CyRXD8X60Ou
	 qjx+KVugQDJ9mTreE1v5p1SzntxU/RGo0j7dZTZ7j4ePcDAN7//+9xu9qqQQbLUrVcc1H
	 2HCgiS16y0N0l6fdFV7O1rff7SGVjeniePK08YDJ2gJy2X6mUkFNN6C0pmA+H3QmADfh2
	 gqHXgIxRvJ0rDSJBKIqPqYdW8k7rbfwX8iZtsCzfIUNzAv+yEiUlOWZU6bBbApx3Z1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269173;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=vtaqbfBX5vfrkQb9nMFdRAxYBFnpk3c4orXF29WeP8I=;
	b=2YRuCpfDcSzUB0u6y2+9jVLD6v3KDbDdEG/rDMCIAsaWxftn0+432Zu4H9IQunMdkiCj
	 Y+ALlCia9QqTZLtmb4XfifB1vdU5zZTF4xiL4ln+7CCbpa9ARTgiJu3/xd051X9n2du1/
	 yf0QEy2KyqQm0TEJkvYomofXEeb5qAztsrmKuI/LDRDHZrkixo2BqZVKpVGQZ2IhENwbQ
	 RPf06fHrwRn0aPSRDjvvWoxYwD+FGVAc4Inb5Ms5yp+22HpSPmQZw5bcsVtqgY+W8gQ/R
	 zRaBPrDZfzzEkk8TEiSYT1g9bGLhOab6X6CPUnalbagWxsy5I8ZC0HyYSMMaPxrl5qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nCws2b9a;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98509606B782;
	Thu, 29 Oct 2026 10:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98509606B782
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nCws2b9a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vtaqbfBX5vfrkQb9nMFdRAxYBFnpk3c4orXF29WeP8I=; b=nCws2b9aBxAO9qlUADishe8Fow
	tLBV9d9y3aNbLuedV1Ok5lmUKi8gJSQDjhawzx3IDOMGadYmEJFkfc8uJ3oBAFNnHCmOXkijyTF7H
	j0+AWSF2XRL2Fb7X/TzSI8UbytP11pmoJdMp+CWqLdgvPqKTRGz2Z0yJ75dZpw/+XEOew/wO0v0sH
	Dx5zbPocpnGbs4aLaUT/Hg83sMLeYog12NT06PKbeBtAN1b+HR+EfuNFASb+k328BRZmNrinYbmuB
	ChOGTBFq47+YU9gPz4SV+wQkhBWnFncr2HM1f43uEYbC8fBFi9L9ZH5AieqP6GAjE+8dVIrE2cFhV
	OpeMjewg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNEG-0000000EJz0-1vue;
	Thu, 29 Oct 2026 10:19:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 90DEE300312; Thu, 29 Oct 2026 11:19:27 +0100 (CET)
Date: Thu, 29 Oct 2026 11:19:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 01/18] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds
 MAX_LBR_ENTRIES
Message-ID: <20261029101927.GB1813469@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>
 <20261029093845.GI1779021@noisy.programming.kicks-ass.net>
 <041e5185-ff2d-4423-af5d-aed6628973c5@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <041e5185-ff2d-4423-af5d-aed6628973c5@linux.intel.com>

On Thu, Oct 29, 2026 at 05:56:15PM +0800, Mi, Dapeng wrote:
> 
> On 10/29/2026 5:38 PM, Peter Zijlstra wrote:
> > On Thu, Oct 29, 2026 at 12:38:57PM +0800, Dapeng Mi wrote:
> >> Add a sanity check for x86_pmu.lbr_nr. If the hardware reports more LBR
> >> entries than MAX_LBR_ENTRIES, disable LBR to avoid out-of-bounds access
> >> in the cached LBR stack handling path.
> > Cute, can this actually happen?
> 
> Currently it won't happen on real hardware since the maximum LBR stack
> depth what hardware supports is 32. But it's better have this sanity check
> assume the LBR stack depth could be extended to 64 or larger.
> 
> 
> >
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  arch/x86/events/amd/lbr.c    | 8 +++++++-
> >>  arch/x86/events/intel/core.c | 7 +++++++
> >>  2 files changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> >> index a55646fcb846..96c5b5e56053 100644
> >> --- a/arch/x86/events/amd/lbr.c
> >> +++ b/arch/x86/events/amd/lbr.c
> >> @@ -433,7 +433,13 @@ __init int amd_pmu_lbr_init(void)
> >>  	ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
> >>  	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
> >>  
> >> -	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> >> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
> >> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
> >> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> >> +		x86_pmu.lbr_nr = 0;
> >> +	} else {
> >> +		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> >> +	}
> >>  
> >>  	return 0;
> >>  }
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> >> index 0a34d674df59..10c694db85ea 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -9023,6 +9023,13 @@ __init int intel_pmu_init(void)
> >>  	 */
> >>  	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
> >>  		x86_pmu.lbr_nr = 0;
> >> +
> >> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
> >> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
> >> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> >> +		x86_pmu.lbr_nr = 0;
> >> +	}
> >> +
> >>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> >>  		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
> >>  		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
> > Would it make sense to have but one copy of this check in
> > init_hw_perf_events(), after calling into the micro-arch code?
> 
> Yes, that's what the previous version does, but Sashiko complains it's too
> late.
> 
> "
> 
> Does zeroing x86_pmu.lbr_nr here in init_hw_perf_events() happen too late,
> after intel_pmu_init() and amd_pmu_init() have already configured hardware
> and driver state using the unvalidated x86_pmu.lbr_nr value?
> 
> "
> 
> https://lore.kernel.org/all/sashiko-outbox-179814@kernel.org/
> 
> It makes sense in some ways, so move the sanity check into the vendor init
> in this version. 

Urgh. But there are no events yet that early, none of that can actually
happen.

If we're really worried about this, change the micro-arch init to spawn
in disabled state and we call x86_pmu_enable_all() at the end.

Also, this is before x86_pmu_static_call_update(), nothing really
'works' yet anyway.
