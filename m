Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D81C84A4;
	Tue, 25 Feb 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481219; cv=none; b=bNs34YOCDGGM91E2X59iC5yFIirIBM7wtHCMyc4uQcGOmfYVVb7EYxXd+hiKDAymHtMdhg+ii6tf7r/UhBo8UNqrK3GxiZ9RRNY9I9XROvqPP5D8zOTdf1cxyuU4TZkUITOWq1VB8HA5jiyeDDGdRrcc/VYJ+faCkAVhuo9sM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481219; c=relaxed/simple;
	bh=OIAYG0DTu1dbYqV7zeemEwB6CnpNfpQ2N8t5mKh6jvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+htZa+RsGBQHI7tEKk56BRl9Yxw0Sjpc3qH1xPhFCDv2BdJ5/Wi94Gt64HmhrEFuX1r5lZK4yUPeF84ZxeBA/Wer0em/LCRolIb0QvPigONKfPY65q3ThomdtgWSWlUDVv1YQu5TSwtuZvm1W7ekpn0SScHjqIvzqPG84Hel+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jgkdqvb7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jgkdqvb7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X2opscf7XUW1j6O0X55tJb+3c775cxiqTofDgsyFe/Y=; b=Jgkdqvb7s4a0Rh/GZwdTMHhQJW
	cR484LNq2IM+vKyXTxn5adBmJ/FoStGMvW+6lzoHsV0W3PDSNNMC5T9mnbjdJaWyUWj4Mr90q78wN
	uL8B9BaGCH6VuzHgpNNYT5qHpQ5Q8533RdUuktVOQUQ6wCDKJtLPviE6Mpm8nfs/kt0Tn9vTrHk15
	WiS+B9VkIu+LARgpjcCE7ja8vLyy/3yNSjERu7AUSKqGpf/VCAu8RqbWrYQywSpVlz5Pwq1APq+T1
	bOxwZnvxgEF7f4rypYStpdcGm4wUE25wZ8UaKUrQeMoJMbri9dSujE4B+69HblRoLmR1RVvdr/fPV
	jRb6QZqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmsfc-0000000B1Or-1tYN;
	Tue, 25 Feb 2025 11:00:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E448300472; Tue, 25 Feb 2025 12:00:12 +0100 (CET)
Date: Tue, 25 Feb 2025 12:00:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
Message-ID: <20250225110012.GK31462@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
 <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225103927.GJ11590@noisy.programming.kicks-ass.net>

On Tue, Feb 25, 2025 at 11:39:27AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:04PM +0000, Dapeng Mi wrote:
> > A significant difference with adaptive PEBS is that arch-PEBS record
> > supports fragments which means an arch-PEBS record could be split into
> > several independent fragments which have its own arch-PEBS header in
> > each fragment.
> > 
> > This patch defines architectural PEBS record layout structures and add
> > helpers to process arch-PEBS records or fragments. Only legacy PEBS
> > groups like basic, GPR, XMM and LBR groups are supported in this patch,
> > the new added YMM/ZMM/OPMASK vector registers capturing would be
> > supported in subsequent patches.
> > 
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  arch/x86/events/intel/core.c      |   9 ++
> >  arch/x86/events/intel/ds.c        | 219 ++++++++++++++++++++++++++++++
> >  arch/x86/include/asm/msr-index.h  |   6 +
> >  arch/x86/include/asm/perf_event.h | 100 ++++++++++++++
> >  4 files changed, 334 insertions(+)
> > 
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 37540eb80029..184f69afde08 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3124,6 +3124,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
> >  			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> >  	}
> >  
> > +	/*
> > +	 * Arch PEBS sets bit 54 in the global status register
> > +	 */
> > +	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
> > +				 (unsigned long *)&status)) {
> 
> Will arch_pebs hardware ever toggle bit 62?

This had me looking at the bit 62 handling, and I noticed the thing from
commit 8077eca079a2 ("perf/x86/pebs: Add workaround for broken OVFL
status on HSW+").

Did that ever get fixed in later chips; notably I'm assuming ARCH PEBS
does not suffer this?

Also, should that workaround have been extended to also include
GLOBAL_STATUS_PERF_METRICS_OVF in that mask, or was that defect fixed
for every chip capable of metrics stuff?

In any case, I think we want a patch clarifying the situation with a
comment.


> > +		handled++;
> > +		x86_pmu.drain_pebs(regs, &data);
> 
> 		static_call(x86_pmu_drain_pebs)(regs, &data);
> 
> > +	}
> 
