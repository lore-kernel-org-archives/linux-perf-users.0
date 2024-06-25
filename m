Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A816B720;
	Tue, 25 Jun 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326828; cv=none; b=kr+JRGMmemshqj7/3Zh12/2PQ0iNVLSFGJkQACLKm/pkAiy2YlWapd9c/o4uYPRHL+HPhXdmtp7ZV40WtHcyVroGd2i5fEnn9bSJyMNt63NCFhDG9mW0AxR28PzGRlXo5hwMjBwZesFs9Do6a9YwQ5Gxzzn2NRpZVqUTLEmkhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326828; c=relaxed/simple;
	bh=7INvdVScmw601ooabE8KK31RUvWRf0vcMmCdvEuMPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8tgOdten38JcSvTz+2a05L0cKB+78D3DRSM2bGX5e5en8R8eXP+KrmSg8rB99cnSViqqxXB4YSejJ9+CDSy8QhGFkfWLYm+CIFe4lBrY7LDAdnAamrb6pzgs2QF26Xz/3y1ux3oLPmpAC8AHCnY+EpoWJsiMpHfqDC+eGzL4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdM3o8Ze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdM3o8Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951E6C32781;
	Tue, 25 Jun 2024 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326827;
	bh=7INvdVScmw601ooabE8KK31RUvWRf0vcMmCdvEuMPpw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gdM3o8ZeKJSxMUQapTfXcG2O1lUUSBXsiZsI/f20yD1h+gjQGW+IeOZ4eMt80fyuF
	 MgTVrjG41Kx4Sq0vV6st6omHRZJXZhnrDH72WM7wiN9GsyGvFTGCxv26GkJZtL3Y5s
	 UC4xZdkCr3XjcGk4FnV83FbpY+NxqMFSI8NVQKpwK4PnqLLd6Yol7084UA08jhJW2u
	 hxYTk6nC58fcmSXBcgfYanHUzJ4FO+TSvxtKXleKARKUUgb8XklttGfzwZ+XsidtVf
	 rgRE37n+TOAkg9diwmyjQi7SGVNgKEjaVl76EEpPhgN1fOYHKEwDmZo/wrZIUzP9iU
	 OnbITka7pRdVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97385CE04A8; Tue, 25 Jun 2024 07:47:06 -0700 (PDT)
Date: Tue, 25 Jun 2024 07:47:06 -0700
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
Message-ID: <e17a924d-9699-465f-8bef-cde4411e2146@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240524141021.3889002-1-leitao@debian.org>
 <20240625115734.GX31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625115734.GX31592@noisy.programming.kicks-ass.net>

On Tue, Jun 25, 2024 at 01:57:34PM +0200, Peter Zijlstra wrote:
> On Fri, May 24, 2024 at 07:10:20AM -0700, Breno Leitao wrote:
> > Warning at every leaking bits can cause a flood of message, triggering
> > vairous stall-warning mechanisms to fire, including CSD locks, which
> > makes the machine to be unusable.
> > 
> > Track the bits that are being leaked, and only warn when a new bit is
> > set.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  arch/x86/events/amd/core.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > index 1fc4ce44e743..df0ba2382d13 100644
> > --- a/arch/x86/events/amd/core.c
> > +++ b/arch/x86/events/amd/core.c
> > @@ -941,11 +941,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
> >  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
> >  {
> >  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > +	static atomic64_t status_warned = ATOMIC64_INIT(0);
> > +	u64 reserved, status, mask, new_bits;
> >  	struct perf_sample_data data;
> >  	struct hw_perf_event *hwc;
> >  	struct perf_event *event;
> >  	int handled = 0, idx;
> > -	u64 reserved, status, mask;
> >  	bool pmu_enabled;
> >  
> >  	/*
> > @@ -1010,7 +1011,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
> >  	 * the corresponding PMCs are expected to be inactive according to the
> >  	 * active_mask
> >  	 */
> > -	WARN_ON(status > 0);
> > +	if (status > 0) {
> > +		new_bits = atomic64_fetch_or(status, &status_warned) ^ atomic64_read(&status_warned);
> > +		// A new bit was set for the very first time.
> > +		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
> > +	}
> 
> Why not just a WARN_ON_ONCE() instead? This really shouldn't be
> happening in the first place.

We did consider that, but seeing the full set of bits that shouldn't
have been happening in the first place helps with debuggging.

But is there a better way to accumulate and print the full set of
unexpected bits?

							Thanx, Paul
