Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D63A1A5D;
	Tue, 11 Aug 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438265; cv=none; b=tpnJAIvnL4pK8Mi6fl2fYnHPpftviFuKuHrItuAY5wNEBQZQpLIgngVwN4B7R7TVQ7LNS8NapSSHdosWSAVMjOLboSpbYgWLjPyGdVGV+etakZKuLrpd5oUNICEsUTJoHdTXIuIztQDcZXsMsnu5YiSe45rf6PF5EO92YVtCyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438265; c=relaxed/simple;
	bh=yt33yFRJ4lU2PMob9tCirObkYylIyDKl1LbVWekeMgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0XailyugKW9h0S0sn8vN3s/k58dWGtNeJzt6AMaJQGAds72D/Hq0dfiIkRHDMxkVj5uoM+f/v/hsG+uMp0P9rGtrES0pmIWGOJhWS/uE/eKFGQ3t7KSujg6Fcs7/bRlNBU6L2tDWFFG4hLJdLvbln++O41p0PA7amYQoGovQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3UtyCBe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3UtyCBe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M4vFYt3QyuNRz+IDez3EN21UOjcjOJ0c3jM5PJJPZsA=; b=i3UtyCBeK/Xz+Qqcq/DEgh9I0l
	DzEQ2cZlLFkWs4K23+1Ik9RYpNFzLOGRsqhORoFinGcnf44vPGwrA5+vJpYUxtWAC/nCl04LCSvSl
	XG55O2YqFXFBljMH01++ujEmT7idBWmEZmQvmtC1Ll1vXfO8I7en08plp72BevhfiUfCazm3KS+qA
	RqyxxJ/MaKcRMLR0UqXl0jkfQh0uPHDouIgXAwJYWlS0nBXXKWr5f09bwfAzD1M//qua2zNTrO0jv
	hItJJ85LB+rtbGRQvLeZX2ZIEo+gFFnu8y9bBpwRe+o8yOT58htKXooGChVNFToCEdk2TnFLZh7HN
	EWnTZgqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wthlJ-0000000EWde-3kTV;
	Tue, 11 Aug 2026 08:23:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 820DF301127; Tue, 11 Aug 2026 10:22:56 +0200 (CEST)
Date: Tue, 11 Aug 2026 10:22:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v3 8/8] perf/x86/intel: Prevent drain_pebs() reentry
Message-ID: <20260811082256.GT48970@noisy.programming.kicks-ass.net>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
 <20260810130130.GX776954@noisy.programming.kicks-ass.net>
 <da08527f-642b-4f77-89a6-43f42e12d114@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da08527f-642b-4f77-89a6-43f42e12d114@linux.intel.com>

On Tue, Aug 11, 2026 at 09:39:23AM +0800, Mi, Dapeng wrote:
> 
> On 8/10/2026 9:01 PM, Peter Zijlstra wrote:
> > On Fri, Jul 17, 2026 at 04:03:42PM +0800, Dapeng Mi wrote:
> >> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
> >> not run concurrently. If it is reentered, one instance may observe stale
> >> buffer state and potentially access out-of-bound memory.
> >>
> >> Most invocations happen in NMI context, which naturally prevents reentry.
> >> However, drain_pebs() is also reachable from process context via
> >> intel_pmu_drain_pebs_buffer().
> >>
> >> In those paths, the PMU is often already disabled, but not guaranteed.
> >> For example, __intel_pmu_pebs_disable() only disables the target counter,
> >> so other active counters can still raise a PMI and interrupt an in-flight
> >> drain_pebs().
> >>
> >> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
> >> use them in intel_pmu_drain_pebs_buffer() to disable the full PMU
> >> around the drain_pebs() call, preventing reentry.
> >>
> > It is not at all clear to me where the exact recursion happens. (The
> > word you're looking for was recursion, not concurrent).
> 
> Yes, the word "concurrently" is not accurate, reentry is the more accurate
> word.
> 
> Currently drain_pebs() would be called in two places, one is the in the PMI
> handler, like handle_pmi_common(). The other place is
> intel_pmu_drain_pebs_buffer() which is from process context.
> 
> So when intel_pmu_drain_pebs_buffer() is calling drain_pebs(), if there is
> an active PEBS event triggering PMI, it would interrupt current in-flight
> drain_pebs() and lead to drain_pebs() reentry.

What is the actual callchain here?

Because the one I'm thinking off is:

  perf_ctx_disable();
  perf_ctx_sched_task_cb()
    x86_pmu_sched_task()
      intel_pmu_sched_task()
	intel_pmu_pebs_sched_task()
	  intel_pmu_drain_pebs_buffer();
  perf_ctx_enable();

And that one has the full pmu disabled, because of context switch etc.
And then there is one in perf_read():

  pmu->read()
    intel_pmu_read_event()
      pmu_enabled = cpuc->enabled;
      cpuc->enabled = 0;
      if (pmu_enabled)
        intel_pmu_disable_all();
      intel_pmu_drain_pebs_buffer();
      cpuc->enabled = pmu_enabled;
      if (pmu_enabled)
        intel_pmu_enable_all();

So what specific callchain is going sideways?
