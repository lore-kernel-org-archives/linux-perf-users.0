Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFA3DAAD6;
	Mon, 10 Aug 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366905; cv=none; b=N451q4ua/e9wZrWMXhtILcb0oGj6wiQx2/bVX9Dtp3n1gno38z+2zPkiWaSeAeVshDt/ziMmO5g8K8SWVGmMiqqaX4RIvSLajkM00cr9U9l9wEMeKwxPpwud4OodrLNMfKqGnkR2jPxFfsF7a/zSJbxZgnwMCHGXrMrKh7RA0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366905; c=relaxed/simple;
	bh=UnHydR6zZf1KWO8OmKlj6x46dUgdjq1lBpW4WxsQ+w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7VlpPN5rCguOENy5fQt2DNKYE3b9/zw/sBP8BZgLQAnrPRxuxGYP65s5xJSIp6TurSwpqffEZKBhjEChXF/h78Pjx1yCFnAGIsWyjsri0lupQ6dAYFutSeAWkEKu+mHe8jOjwr8VPu7iPrRs4iMJWeFMP2q52u07b+bKbLvrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nvi1vcl7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nvi1vcl7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O5Qivzyu/75HYM6+Fri8ycx805JnQC/OdXnliatUHdE=; b=Nvi1vcl7KXdkRofTNzeAqlAnD3
	Mw8DdnzoIvEwUG1g5ewTGqlvhxv+yoEhhbOAOHgqWxIRB+LRGSLV65y/iKHavW3UbjTSZCVeKx/NJ
	o8Raby4G9vfNl/GysVOI0rhA7uMKHOTxD9ZLSdzjEUInWb1+fhtnw45bjxf716KkK9nkYRHW9YxlX
	h/E8rmFY/hDhU8YYmL/U7QXGdiwu3M4wSBZzm+uWG2sb6pY2iZdJzvppkjNbptSFT0JM5KlQG52U+
	K3fZPp+3pmoCdYkoYuqM47nqKkPyDLg8M0Z8QdJoNzFSP4V1dinEJRjS9+mSBDDLm3wU8CJM5PHqU
	CCFn34QA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtPdH-0000000Dns0-1PEf;
	Mon, 10 Aug 2026 13:01:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF2B7300244; Mon, 10 Aug 2026 15:01:30 +0200 (CEST)
Date: Mon, 10 Aug 2026 15:01:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
Message-ID: <20260810130130.GX776954@noisy.programming.kicks-ass.net>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>

On Fri, Jul 17, 2026 at 04:03:42PM +0800, Dapeng Mi wrote:
> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
> not run concurrently. If it is reentered, one instance may observe stale
> buffer state and potentially access out-of-bound memory.
> 
> Most invocations happen in NMI context, which naturally prevents reentry.
> However, drain_pebs() is also reachable from process context via
> intel_pmu_drain_pebs_buffer().
> 
> In those paths, the PMU is often already disabled, but not guaranteed.
> For example, __intel_pmu_pebs_disable() only disables the target counter,
> so other active counters can still raise a PMI and interrupt an in-flight
> drain_pebs().
> 
> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
> use them in intel_pmu_drain_pebs_buffer() to disable the full PMU
> around the drain_pebs() call, preventing reentry.
> 

It is not at all clear to me where the exact recursion happens. (The
word you're looking for was recursion, not concurrent).
