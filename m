Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3622A7FD;
	Fri, 20 Jun 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406683; cv=none; b=PYOPq2eE1vgtf0rCZtTNIXiUTnTlanZbMhQ/kkAe3SKV3aqXXOYhLHtqej/bKTAzau0yfhVlBTHFZhVihpOa7foYDyUJHNmhfAukhhqpiP4EEC0rPasd+605qmWjP7VhuyLfZub1BhDhMjuXCj0czRiFKyyXC+7nYkkoKKQUGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406683; c=relaxed/simple;
	bh=e6J/ci+AseVoDFrbJK0noq16VSi0qNOaftFeH1SKliQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFHWVXsLdR0PrgM6ZF2Omyw8QbKZxp/A3EawE9J1HrUDzT18QvlvPuCYSOd+cNuamvrPgiPXway6SZh1c1cBNMCJlT+hcZNpaegd6PwBvSttJ3QYLnEX0rH08RJn9HE2hRIy/dl2oP+gVqgWn/BGvtbZ8yhOsWHqI5CgwxyVeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZRtNG7zs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRtNG7zs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=POVtJUAKh/YpDAjJIegUwrxE9LaR562qjVUhPfBk15Q=; b=ZRtNG7zsfmb19myGlc2tuM2+N9
	f9uRHk8+jcyPRdletvotKgLi5pgiFoiLkFrbxr3yCOPCzuY1yFnoRVvn0/s5W9rzku0o+YuLhU8Ns
	fvq9IRC8xDa0ktxXSuHLVrfw2z6XRrcQ3+7VtD8HZJenf1oxCwTDYiWPaNRgOKJPAhZkCzhxm3UJt
	Za9Bg4mdhAvQKyvuYsCa4QP7IaVHSPNiHi5MHsXq+4s9ecSPlS+0pxwAI4IuyTC51zHWPMcaAlQYN
	dauEQ0rqHtHpc/6tDRnVjuqjuq/yLogpkYph3UDSmRjpy7z5Bm1jW+JOPvBRXK5a5DZBZsN6bAzTO
	NVwNLQFw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSWjd-00000004fg8-0kEZ;
	Fri, 20 Jun 2025 08:04:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF8B3308989; Fri, 20 Jun 2025 10:04:26 +0200 (CEST)
Date: Fri, 20 Jun 2025 10:04:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kernel@collabora.com,
	Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/headers: Document PERF_PMU_CAP capability flags
Message-ID: <20250620080426.GO1613376@noisy.programming.kicks-ass.net>
References: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
 <20250619145044.GL1613376@noisy.programming.kicks-ass.net>
 <2518748.tdWV9SEqCh@workhorse>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2518748.tdWV9SEqCh@workhorse>

On Thu, Jun 19, 2025 at 06:06:50PM +0200, Nicolas Frattaroli wrote:

> > >  #define PERF_PMU_CAP_NO_INTERRUPT	0x0001
> > 
> > This is not quite right; CAP_NO_INTERRUPT means it is not able to
> > generate samples.
> > 
> > While not being able to generate interrupts and not being able to
> > generate sample is more or less the same for CPU PMU drivers, this is
> > not true for uncore drivers. Even if an uncore driver has interrupt
> > capacility to help with counter overflow, it cannot generate samples.
> 
> I'll send a follow-up v2 to fix this, though just to make sure I
> understand this right, I have some questions for clarification.
> 
> Does "uncore" in this context mean PMU drivers for counters that are not
> tied to the CPU instruction flow, but are counting other things like
> interconnect statistics?

Correct.

> Also, am I correct in assuming "sample" in this context means the
> concept represented by struct perf_sample_data, i.e. what appears to be
> a snapshot of current process context, including registers and stack
> information? 

Right; perf_event_attr::sample_type, filled out with bits from
perf_event_sample_format.

> Which would then mean going by my understanding of uncore
> that basically every uncore driver should set this capability flag, as
> they're not performance counter registers on a CPU that are intimately
> tied to the ISAs execution state.

Correct again. There is interconnect, memory and even GPU drivers out
there these days.

> To further my understanding: does this mean that
> drivers/devfreq/event/rockchip-dfi.c (used for measuring memory
> bandwidth) should set PERF_PMU_CAP_NO_INTERRUPT, since it's not a CPU
> but a memory controller monitor?

Yup, that would indeed seem to be so.

> In a more general sense, if anyone has any written resources on writing
> PMU drivers, rather than perf from a userspace perspective, I'd be very
> happy to get some pointers in their direction.

I'm afraid not :/ The best we have is the comments in struct pmu.

