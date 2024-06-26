Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827E18C332;
	Wed, 26 Jun 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409632; cv=none; b=sWtTh+qtFL/oi77X9OvbD6XLsh3ScaSq1hEoxwJGrzIWadjw7s0q+CnuauJ4/Dbf0SXa0QdsVWtcxACQmLB+P+kjg8RBkQ1a48jhBIJPhY9swLa6noXG6g21UBU7bLf4ji6c/v5Kzie8RerWnrsUcdlWibk4VPiJInAtZaHCi3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409632; c=relaxed/simple;
	bh=LzCekQcIoqruWg0rYojXSnFhC5ZmixAWJ/RcdTynxwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMU7dvbAuGMUBpS2jJr8JUd/J1kRUqGSW9761EUBcngxvQPvr4Mak7lZNzFq6M1DBdGKTCucNeKVGCix0y2jYcuwyd3Ey6ieRrRUUQn5U6e7NPwRzSXXjojpaKd3FBxKyqLAyTk7VI+ItInMx0+0LLGdgwWkm/YP63WiAMdp9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+cbKdaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+cbKdaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D5DC32789;
	Wed, 26 Jun 2024 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409632;
	bh=LzCekQcIoqruWg0rYojXSnFhC5ZmixAWJ/RcdTynxwE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=h+cbKdaj87xqGJRf6aGqu7Veq6bWYSw+tpcCpJe1WWWx1QFazkbvD3sWZmgDFp35A
	 A8jVUlMyr8xdIhefZvVKFpvqCBbVpECRYUYwYIzeTQLavfyhe6xCY/jMqgCOch/Kcw
	 2949FDXwnV4sn4EIssDnbRu4GvyKoF9w9q3Z9mhXbSd3f40hk0klL3vDS+oMoQffGU
	 1F6WY8HsfD4yiw4DQwpjeg80cbLPFqEYmdRcYlP4UG0g4TKo0FESMGLc5h3nIQnei9
	 yuokhFtLRxWDxQH2B/CgENQOQu0rgmADpzo87xE6pdlh/pSE7OJFcnfBxPyQ7v0ZSz
	 ks/NucI+s47Pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B212DCE0E79; Wed, 26 Jun 2024 06:47:10 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:47:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <cc187abf-fbcc-4d4d-8764-faa9d1ceadd1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240524141021.3889002-1-leitao@debian.org>
 <20240625115734.GX31592@noisy.programming.kicks-ass.net>
 <e17a924d-9699-465f-8bef-cde4411e2146@paulmck-laptop>
 <20240626085153.GA31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626085153.GA31592@noisy.programming.kicks-ass.net>

On Wed, Jun 26, 2024 at 10:51:53AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2024 at 07:47:06AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 25, 2024 at 01:57:34PM +0200, Peter Zijlstra wrote:
> > > On Fri, May 24, 2024 at 07:10:20AM -0700, Breno Leitao wrote:
> > > > Warning at every leaking bits can cause a flood of message, triggering
> > > > vairous stall-warning mechanisms to fire, including CSD locks, which
> > > > makes the machine to be unusable.
> > > > 
> > > > Track the bits that are being leaked, and only warn when a new bit is
> > > > set.
> > > > 
> > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > ---
> > > >  arch/x86/events/amd/core.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > > > index 1fc4ce44e743..df0ba2382d13 100644
> > > > --- a/arch/x86/events/amd/core.c
> > > > +++ b/arch/x86/events/amd/core.c
> > > > @@ -941,11 +941,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
> > > >  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
> > > >  {
> > > >  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > > +	static atomic64_t status_warned = ATOMIC64_INIT(0);
> > > > +	u64 reserved, status, mask, new_bits;
> > > >  	struct perf_sample_data data;
> > > >  	struct hw_perf_event *hwc;
> > > >  	struct perf_event *event;
> > > >  	int handled = 0, idx;
> > > > -	u64 reserved, status, mask;
> > > >  	bool pmu_enabled;
> > > >  
> > > >  	/*
> > > > @@ -1010,7 +1011,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
> > > >  	 * the corresponding PMCs are expected to be inactive according to the
> > > >  	 * active_mask
> > > >  	 */
> > > > -	WARN_ON(status > 0);
> > > > +	if (status > 0) {
> > > > +		new_bits = atomic64_fetch_or(status, &status_warned) ^ atomic64_read(&status_warned);
> > > > +		// A new bit was set for the very first time.
> > > > +		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
> > > > +	}
> > > 
> > > Why not just a WARN_ON_ONCE() instead? This really shouldn't be
> > > happening in the first place.
> > 
> > We did consider that, but seeing the full set of bits that shouldn't
> > have been happening in the first place helps with debuggging.
> > 
> > But is there a better way to accumulate and print the full set of
> > unexpected bits?
> 
> Dunno, I was just wondering if the whole thing wasn't massive overkill.
> The changelog wasn't really explaining much here.

For me, the two additional executable lines of code seems to be a small
price to pay to be able to see all the bits, not just the first one that
happened to be set.

							Thanx, Paul
