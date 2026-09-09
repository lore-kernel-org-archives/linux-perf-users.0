Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56068560AAC;
	Wed,  9 Sep 2026 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959022; cv=none; b=qxupDMVLNFSJ+OQuiErnQMXbmh8iPn3gxvxzKvX9hWk2YENitCpOqnI7LljMkto1uBbIfzHDA9Z3eCHqX/qxTVVgj7Rpeut8cBC3zpKCS2IgbfthDaxEjdoiaigOopuDjM0b5pAFy+TpLyo9v2ehEu/nlh4hBwNSarZek7OgCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959022; c=relaxed/simple;
	bh=t86Spt9KFcl2TzEzJzxtu/2xxYDnWcNjODuDQ7Y/ITE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7X07YsTqhYjCczlquMuNd4y5fyYwIZRmXVaJujzuIP6aFpYHiZy0ASSaPEh8L5idqiDiO2b5mK/JtxzeYd0Ava8nWW0eRJdRXuIuk1IG4epkAT5QXVKze/5uVsulRAPMXKVFZv7vTKCbdZnLv8LPiBSTSYtTHlX0xMz1xEA2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJ/pTzPF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJ/pTzPF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wcvdJJuSkgWWNrB85+JaAFpaF8ME7CjkkxvzlpSylwg=; b=XJ/pTzPF9tcI51j8+UQk3Y6rdG
	4J+84y+SRkHPJr+r3sf35VRl6QasShVU9LHSwpUXZsV9fmw3ipv/YS0/KXNSOpTTsl93FBWaJFoKN
	3vDQJd6+04CH2dmXeMIuRU4BmObqY18RYMf5ozf0ssNOjeVEbnGMM+W8ybbKE9H5kq9irhddt9D+Y
	FMA6u9eFZqDk9PQs0iwVMW51oxlTOyVZY97ubGKQNUkiYszXjjo2fUSjgbb5meptS/RQSrZ0DLZ6F
	i0ndQP8UWmVSg5Uq5gsczEWNSc4sOBxSesf4sVBim1b9PFvjjIen2xj9CmzQny0ZKvRjrt3BzTMoD
	bUUt+C5w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Hxc-00000005Zr8-0QVP;
	Wed, 09 Sep 2026 13:03:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A2C9B300A9A; Wed, 09 Sep 2026 15:03:31 +0200 (CEST)
Date: Wed, 9 Sep 2026 15:03:31 +0200
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
Subject: Re: [Patch v2] perf/x86/intel: Prevent drain_pebs() reentry
Message-ID: <20260909130331.GT4121339@noisy.programming.kicks-ass.net>
References: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
 <d6ccff7d-df31-4308-b60b-8ec5f630415e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ccff7d-df31-4308-b60b-8ec5f630415e@linux.intel.com>

On Wed, Sep 09, 2026 at 07:09:11PM +0800, Mi, Dapeng wrote:
> Hi Peter,
> 
> Could you please review and queue this patch if it's good enough? This
> version addresses your comments. Thanks.
> 
> 
> On 8/13/2026 2:43 PM, Dapeng Mi wrote:
> > The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
> > not be reentered. If so, one instance may observe stale buffer state and
> > potentially access out-of-bound memory.
> >
> > Most invocations happen in NMI context, which naturally prevents reentry.
> > However, drain_pebs() is also reachable from process context via
> > intel_pmu_drain_pebs_buffer().
> >
> > In those paths, the PMU is often already disabled, but not guaranteed.
> > For example, __intel_pmu_pebs_disable() only disables the target counter,
> > so other active counters can still raise a PMI and interrupt an in-flight
> > drain_pebs(). Here is an example,
> >
> > __perf_addr_filters_adjust()
> >   perf_event_stop()
> >     __perf_event_stop()
> >       x86_pmu_stop() (event->pmu->stop)
> >         intel_pmu_disable_event()
> >           intel_pmu_pebs_disable()
> >             __intel_pmu_pebs_disable()
> >               intel_pmu_drain_large_pebs()
> >                 intel_pmu_drain_pebs_buffer()
> >
> > Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
> > use them in intel_pmu_drain_large_pebs() to disable the full PMU
> > around the intel_pmu_drain_pebs_buffer() call, preventing reentry.
> >
> > Also add a warning in intel_pmu_drain_pebs_buffer() when the full PMU is
> > not disabled.
> >
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Ah yes. Can you get me a Fixes tag to go with this?
