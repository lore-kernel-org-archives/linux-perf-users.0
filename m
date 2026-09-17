Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE69499F39;
	Thu, 17 Sep 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634446; cv=none; b=NR/9HTOdXvxq3x/bFTBTJa05UGPxwd9HT5LrjQ5270D6P2fHnI8UVbcUqf/FrBIcKFQ71QbpTzTz8yVXH8YzhzvUhAdrrA7rVy3jhdvFO7FIED4wKTjUoKBfEJ0dPKShqImAx+KiGekahIci3L1JTO29CvBrZ51mG4viYig7Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634446; c=relaxed/simple;
	bh=g9vUrJLuX3tLOjcXyLXs6n1+JPwnhVUSH+YPtjy7ov4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkvwA5m19inY+tnkl9O7f0yAEtxouL8i8i7fZXBw2To2gH8rW9pwgsXcBanMecz9hEY/VcfnEnnNh+lb3usmN4tNFmwQG9ruS18AQk1GvyDsCvvuWtPb957YzANXj0ZFlxJDVjDPjEAfeEC7KZ9GCRFOSzs7ha7cs/ZgbQcek1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dg98uTER; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dg98uTER"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qwIkKtla+hik8QJ+k0zna/z2zi7HBqTzDCA2HFbIpMQ=; b=Dg98uTERFewuwnioPh2Y+qERc4
	PhTNjESKDUUMla3VAZE/6JG7ooVUvjomP9FI1BUyK1Iy3XgkxUDVCAnOHRW/2GMdG9KxpjdVHhAfo
	KT7UNx99v/iR/5OUz0Vy1pYrMlLcxICo+RbHx9ej/nYvYcOB4Qp3GhTgxNfMguXqD16Kg4DQc9GMy
	WZfD2dc2el61qDMcZY+HEX6ceZ4G+NrggQKejK3jasUGwxOeGC7zWR1LbSLuxAuX/WxjCw1sPGKuT
	CpGDqoStJd9/emhAepKlUIH4+Tl2vaL6jWJjN9hcSqaL1E+64awoa/+JAuzd/B90Rj4FvhH3x02Dl
	Ty4dOXUQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x77es-00000008gVP-18ta;
	Thu, 17 Sep 2026 08:39:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A74AF300583; Thu, 17 Sep 2026 10:39:51 +0200 (CEST)
Date: Thu, 17 Sep 2026 10:39:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 2/2] perf: Add checks to prevent null ptr access
Message-ID: <20260917083951.GC2009045@noisy.programming.kicks-ass.net>
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
 <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904181625.1394082-2-vinay.belgaumkar@intel.com>

On Fri, Sep 04, 2026 at 11:16:25AM -0700, Vinay Belgaumkar wrote:
> Sashiko recommended some additional checks to prevent null pointer
> access. Check for revoked states inside perf_event_read_local(), as
> the pmu event may have already been freed at this point. Add a null
> check inside __perf_event_read_cpu() as well before accessing the pmu
> ptr.
> 
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> ---
>  kernel/events/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7777e82aad5e..059f82f0cadd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
>  
>  static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>  {
> +	struct pmu *pmu = READ_ONCE(event->pmu);
>  	int local_cpu = smp_processor_id();
>  	u16 local_pkg, event_pkg;
>  
>  	if ((unsigned)event_cpu >= nr_cpu_ids)
>  		return event_cpu;
>  
> +	if (!pmu)
> +		return -ENODEV;
> +
>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
> -		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
> +										event_cpu);
>  
>  		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
>  			return local_cpu;
> @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  		goto out;
>  	}
>  
> +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Get the event CPU numbers, and adjust them to local if the event is
>  	 * a per-package event that can be read locally

I don't think any of this is right.

When unregistered, the event is de-scheduled, this means event->oncpu
will be -1, therefore __perf_event_read_cpu() will already exit early.

And perf_event_read_local() will then already do the right thing, by
returning the old value.

So AFAICT, there is nothing to fix here.
