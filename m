Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80C1C5488;
	Fri, 20 Dec 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704549; cv=none; b=jYWyNyZMEhndWHpS6m161js+hdu++ymX50fhbLSfoPPFbGSisbHSuS2z6TjwA03hVLfG7oyV6tLperB06xP5Nq8LE7UvsUZIPHzieZeHqPFme6Ov09UhN5afNsx+W7vtEA3EzvZMoPq4UQkA2IAgV+7W00/QKQ0rC/tt0FJaVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704549; c=relaxed/simple;
	bh=7BsQx7AX7gGARcFaivRV6iwIfj6SbF35TbJlwGC723A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH0Tzf/cTx+WG5iI0hOdk5yk1TO31CQ3jN2nqV5UHSkzLWA05ukpC6YBfc8ygEMs3KgG/ObwxUX8QbWK3ZQEFmN/3cTnS7m6XwWxFylZBVqnBIS9bVFE5W9LZSNVTmABON5cKl4bQP1tQTAE31+isbMxsMpih3TZDnVV6McSMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KUUz0M/A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KUUz0M/A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Xb9ZpZGMStvk988jjssqFVvY3C8NF2MNwADppx6OpE=; b=KUUz0M/Ahj5kd2GLPot1ENtbPx
	8u7oMU1K5T41ZwYUoQU1qBiuD5vDZnfQEX2kF2OmJsXrbHVwnExyjp1d2IP/mu3uCkksLYVpKDi4j
	gGJ8lX6bsLs3JHCX1F0qfN7/ACHp9CN7OfwzeUrrankgzh1l50CozbPJAOxzHbH5wm1taq91a2hgH
	gpBzjJ6zkHO84zoPZ/fXYHXrOXYNjELH2gEbZqaOH85v1FI2bYe8JsRJ5PJ850HSR8KAfLZ6ntxnt
	j857YOb4pQX2bmK+YVSfh5fSKXJHkyy9ls3jpHhs02vQzdfudXybINqoIpRaPdxai97636Z/RpCoY
	yNE73RCA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOdtW-00000005eJw-18Uh;
	Fri, 20 Dec 2024 14:22:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8CE833003FF; Fri, 20 Dec 2024 15:22:21 +0100 (CET)
Date: Fri, 20 Dec 2024 15:22:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V6 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20241220142221.GN11133@noisy.programming.kicks-ass.net>
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
 <20241218151643.1031659-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218151643.1031659-3-kan.liang@linux.intel.com>

On Wed, Dec 18, 2024 at 07:16:43AM -0800, kan.liang@linux.intel.com wrote:

> @@ -3109,6 +3116,27 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		if (!test_bit(bit, cpuc->active_mask))
>  			continue;
>  

> +		if (is_pebs_counter_event(event))
> +			x86_pmu.drain_pebs(regs, &data);
> +
>  		if (!intel_pmu_save_and_restart(event))
>  			continue;
>  
> @@ -4056,6 +4084,23 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
>  	}
>  
> +	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
> +	    (x86_pmu.intel_cap.pebs_format >= 6)) {

Right, so the event that has SAMPLE_READ on is 'event'

> +		struct perf_event *leader = event->group_leader;
> +		bool slots_leader = is_slots_event(leader);
> +
> +		if (slots_leader)
> +			leader = list_next_entry(leader, sibling_list);

Uh, what, why?

> +
> +		if (leader->attr.precise_ip) {
> +			event->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
> +			if (slots_leader) {
> +				leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
> +				event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
> +			}
> +		}

And this is more confusion. You want event to be a PEBS event, not the
leader, you don't care about the leader.


> +	}
> +
>  	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
>  	    (event->attr.type == PERF_TYPE_HW_CACHE))
>  		return 0;

> +static inline bool is_pebs_counter_event(struct perf_event *event)
> +{
> +	return event->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
> +}

For that drain_pebs() thing, you want all group members to have
PEBS_CNTR set.

That is, if PEBS>=6 and event is PEBS and event has SAMPLE_READ, then
mark the whole group with PEBS_CNTR

SAMPLE_READ doesn't particularly care who's the leader, the event that
has SAMPLE_READ will read the whole group. Heck they could all have
SAMPLE_READ and then all their samples will read each-other.
