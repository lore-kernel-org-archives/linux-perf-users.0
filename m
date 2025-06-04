Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2D7146D6A;
	Wed,  4 Jun 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052007; cv=none; b=XzJTSe2N/lh+wk5GfxcPdOep26NtLyhINDpwxwGtX/wUXNFR6ifz0yTjqLF7A/vhHr7UPBnNJEobdkO4UvCnXsF/m6kHcWq8vH/wKHcaK9k2s6keVAwd3o+rQcDvEeG8P2iQjghWGx1J45XW5nqVdGi6H7Q/qJsVa5u5jnx5nBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052007; c=relaxed/simple;
	bh=4uKaNsdRWPKAwZnIohgZ6Xw81iYiK0D1BgnFAv3sacI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOn+cb8+tcyjB2mGRLD/4DWlFF+HOdD2Vvalh1UK89KcdZ24+tAzKiVEqiHLFAdfsObxOv41p8/nshe+RLECKWscaX023Qky/tni6TJ7RhJ/iv7dl71hZdIzxkB6/pvz3mPgb1M4WEkD3AeIm6U0eio9+kImENul7dpd7gCgI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7981758;
	Wed,  4 Jun 2025 08:46:26 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89F773F59E;
	Wed,  4 Jun 2025 08:46:43 -0700 (PDT)
Date: Wed, 4 Jun 2025 16:46:39 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604154639.GE8020@e132581.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
 <20250604141640.GL38114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604141640.GL38114@noisy.programming.kicks-ass.net>

On Wed, Jun 04, 2025 at 04:16:40PM +0200, Peter Zijlstra wrote:

[...]

> It might be prudent to do something like so:

Thanks for the patch.

> +static void __event_disable(struct perf_event *event,
> +			    struct perf_event_context *ctx,
> +			    enum perf_event_state state)
> +{
> +	if (event == event->group_leader)
> +		group_sched_out(event, ctx);

I am a bit struggle for this code line. It disables all events in a
group, but only clear cgroup pointer for group leader but miss to clear
for sibling events.

If the cgroup pointer is only used for group leader, maybe we only
maintain (set and clear) the cgroup pointer for the leader?

Thanks,
Leo

> +	else
> +		event_sched_out(event, ctx);
> +
> +	perf_event_set_state(event, state);
> +	perf_cgroup_event_disable(event, ctx);
> +}
> +
>  /*
>   * Cross CPU call to disable a performance event
>   */
> @@ -2575,15 +2583,7 @@ static void __perf_event_disable(struct perf_event *event,
>  
>  	perf_pmu_disable(event->pmu_ctx->pmu);
>  	ctx_time_update_event(ctx, event);
> -
> -	if (event == event->group_leader)
> -		group_sched_out(event, ctx);
> -	else
> -		event_sched_out(event, ctx);
> -
> -	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> -	perf_cgroup_event_disable(event, ctx);
> -
> +	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
>  	perf_pmu_enable(event->pmu_ctx->pmu);
>  }
>  
