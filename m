Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB9306754;
	Wed, 14 Oct 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973635; cv=none; b=RkSPgie0bhCAzVpJHbWLbw5XWUPHWyAl104nRl64y4elY45ThWRvXubNyrqoXvZA12mpEPjMypEJDHCCU83PwbmULY2U/8t9Fxncr8uBloi8DEEgwxFOhyJszXauSyPfjeSPKuzs/uze2Ac7AkQBjNRwxvqoDxmS6cuYNzQ13lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973635; c=relaxed/simple;
	bh=nykJQ8j2cEr0lbtlx/Lf5da8R7oxKIOmkVaiFHnF7P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPziBEhEqZBHRXZocz9hPlFM5fP7MLFrFhPEFMRZx8J5JrgDFDj6nJ5dPms+RA8tjo34V6kn/qgTN+5qe/wMfnFJSkp9qHgsUVfqpcloFtGKXkgcOaa5DnMjdztBCFFm5kG8JC0PxKfBBZu8PEzlOKA0S9GmVfTIpw+gGYMYi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VIHanN21; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VIHanN21"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nBmmlrjRf6kiAPDnWG0bIPmLpvBk+xT5O40dRmfvp1g=; b=VIHanN21Peaph5zThAGFzLv7J6
	adaWTxv+LFZ9iHD6K+I1uqxMiDOfTdwt4dwa1WSORjDUPT6o9h5ZoTfCJHuRlCWja+zQ+Mp9sF+IP
	PwPiI34+E4crA25WYxEJdQCZ/5T0gS9NT812fSr7o4JveXv3BAZR6WqTWgGOqiRShDDgCCqZogEOq
	oVkPngrFalNvy7telg+TitooXXFcL/p0pOirl3C9MWiwSNiL6Ca7hEzkJBpu+rCWbKSjWQLJtCNLW
	rv4CbD53FaewVRf2ETA7Hg2242/Af7hoaTDHyNavba0kiwsJH9UTPcnhDgfRBh3mla/goInICx5xz
	4qrvk0Ig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwCL-00000002tBD-2GdW;
	Wed, 14 Oct 2026 10:27:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A95CA30063F; Wed, 14 Oct 2026 12:27:00 +0200 (CEST)
Date: Wed, 14 Oct 2026 12:27:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Haris Okanovic <harisokn@amazon.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf/core: Add PERF_PMU_SCOPE_DEVICE
Message-ID: <20261014102700.GC4121339@noisy.programming.kicks-ass.net>
References: <20261013185603.1347265-1-harisokn@amazon.com>
 <20261013185603.1347265-3-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013185603.1347265-3-harisokn@amazon.com>

On Tue, Oct 13, 2026 at 01:56:01PM -0500, Haris Okanovic wrote:
> Add a "device" pmu::scope for PMUs counted on a single CPU drawn
> from a driver-supplied set instead of a fixed topology.
> 
> This mechanism is implemented by new callbacks: filter_allowed_cpus()
> is invoked to constrain the running CPU set to an allowed set for a
> particular device; migrate_cpu() is used to perform any device specific
> migration steps. Both are optional, e.g. for devices that can run on
> any CPU or have no additional migration steps.
> 
> Placement initially happens in perf_pmu_register() before the PMU
> becomes visible, and is subsequently re-evaluated on hotplug events.
> A new CPU selection is made by cpumask_any_distribute() to spread out
> load from multiple devices, but only when the previous CPU selection is
> offline or no longer allowed by filter_allowed_cpus().
> 
> PMU events of these devices follow the chosen CPU. They are initially
> bound to a CPU in perf_try_init_event() then reassigned by
> perf_pmu_migrate_context() when a new CPU is selected.

> 
> The initial CPU assignment can race with migration, leaving a stranded
> event. A sequence counter is added to close this gap without additional
> locks. A count in struct pmu increments on each migration and is copied
> to struct perf_event on init. The copied count is checked again before
> the event is installed, under the same context mutex, which causes
> perf_event_open() and perf_event_create_kernel_counter() to return -EBUSY
> during migration periods.

I'm not entirely sure on this. How is this race different from changing
CPU on hotplug? 
