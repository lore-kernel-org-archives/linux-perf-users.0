Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CEEEC3;
	Wed, 26 Jun 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391935; cv=none; b=ZrScXw+Ojhy2T/hJ2g0r+uGd6MNvSLJJUrrqzBH6zw8oQ6UFQv0MKfQVD7PIorjI/z87IXsUvqRn9FTymCTjiefR9Ap3OMjAiObcV9RPATq3bo/oT0w4C2zdUu6y02WEnwhxRU81RIoFbDZkTfBfVFofBOOCZ+yJ41zCdgSj+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391935; c=relaxed/simple;
	bh=W+et+/i11UQV7nUnezH36nJD1fVb9XzUixVf9FtAuUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxbUent0Ids/9qQ+v2VyWXTnChnmUGKZhZBujhr/69m9IL6b/0smbdC6ifJBlWkl7Id6accpjD1vk3DJUsJ4Ndha3QuSR9L8JNMo07waNf8nSoFMh/YWPjbEz4aOjoc7uUVL+c+NHY8jTLj3qHFLap3n9I36kBarX9uj0wQTLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j8vmlg5u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j8vmlg5u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YGAkf56VTaRIppmQXPuMc3RCXQhD14Bzdij4sagNTCU=; b=j8vmlg5uUvnOBOOiHOIca5rCvM
	wq6U5pyW/EbJg9WRz9/LKkc4n1Qrs8kG+0XIMosnPr8PZ5SnFCvU7t9oPlrEATps+vi5NqOTjixk2
	omyXQH8k+Xpn5qTup/5dErVd3RoP2lI6dpRv1o4kVkfeejj2naSjaaMMoGPE/9gyR5BSdqhEHyXyc
	d1XsAsmqJaOtvScjHtjpVlLp7fSNnRRfO4qvmzp67rrk0iJlclTVgnE4aCj54h2jC6tmPZHuyYA9y
	A5w8GlRBuqc4GgPuEk+/GIHlOqDhmQMtDQmL5ufevcPRrsNuBRbR7sUhcuegkBib1p+j+3D2QRb8f
	enQTd1bQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMONe-0000000C5UH-0ivl;
	Wed, 26 Jun 2024 08:51:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98C5B30057C; Wed, 26 Jun 2024 10:51:53 +0200 (CEST)
Date: Wed, 26 Jun 2024 10:51:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, sandipan.das@amd.com,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Warn only on new bits set
Message-ID: <20240626085153.GA31592@noisy.programming.kicks-ass.net>
References: <20240524141021.3889002-1-leitao@debian.org>
 <20240625115734.GX31592@noisy.programming.kicks-ass.net>
 <e17a924d-9699-465f-8bef-cde4411e2146@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17a924d-9699-465f-8bef-cde4411e2146@paulmck-laptop>

On Tue, Jun 25, 2024 at 07:47:06AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 25, 2024 at 01:57:34PM +0200, Peter Zijlstra wrote:
> > On Fri, May 24, 2024 at 07:10:20AM -0700, Breno Leitao wrote:
> > > Warning at every leaking bits can cause a flood of message, triggering
> > > vairous stall-warning mechanisms to fire, including CSD locks, which
> > > makes the machine to be unusable.
> > > 
> > > Track the bits that are being leaked, and only warn when a new bit is
> > > set.
> > > 
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  arch/x86/events/amd/core.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > > index 1fc4ce44e743..df0ba2382d13 100644
> > > --- a/arch/x86/events/amd/core.c
> > > +++ b/arch/x86/events/amd/core.c
> > > @@ -941,11 +941,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
> > >  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
> > >  {
> > >  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > +	static atomic64_t status_warned = ATOMIC64_INIT(0);
> > > +	u64 reserved, status, mask, new_bits;
> > >  	struct perf_sample_data data;
> > >  	struct hw_perf_event *hwc;
> > >  	struct perf_event *event;
> > >  	int handled = 0, idx;
> > > -	u64 reserved, status, mask;
> > >  	bool pmu_enabled;
> > >  
> > >  	/*
> > > @@ -1010,7 +1011,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
> > >  	 * the corresponding PMCs are expected to be inactive according to the
> > >  	 * active_mask
> > >  	 */
> > > -	WARN_ON(status > 0);
> > > +	if (status > 0) {
> > > +		new_bits = atomic64_fetch_or(status, &status_warned) ^ atomic64_read(&status_warned);
> > > +		// A new bit was set for the very first time.
> > > +		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
> > > +	}
> > 
> > Why not just a WARN_ON_ONCE() instead? This really shouldn't be
> > happening in the first place.
> 
> We did consider that, but seeing the full set of bits that shouldn't
> have been happening in the first place helps with debuggging.
> 
> But is there a better way to accumulate and print the full set of
> unexpected bits?

Dunno, I was just wondering if the whole thing wasn't massive overkill.
The changelog wasn't really explaining much here.
