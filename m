Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6932C8B;
	Thu,  8 Jan 2026 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849588; cv=none; b=lUs0xBm6a4LYulGhp87ZUWopZMMZye6ekSkChAYgygDJcEGyh3vt91evRtW1mDwvDX20oT6M01od1ucSjHVTgeaH/5m76esYSwgmw8GaiLO5qd/LPhKoSNA1D658xuadnWEInb7M+qX3m9KhnhLFT9K50c6KMH85AJngj09nRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849588; c=relaxed/simple;
	bh=oFlUSQXNvSjAfIbd7BqItrZfIULGO8s7jgggyHQo7fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxDe//w8s9Ye77l2bA1ihNWYZVIXNYzWdMYHS2c2yZRf4knZpLHxQNlXFSRMBI7THtUKQftZC1rkWSIBVknJxWZysSn7ZB4VyILhTMuuGBa9WTpgijNfHcjbtambpCpBrfAHIxnC+O6oTPoZXs7smf+jdaMktnXmu7mEDnTfuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdqB7MwX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdqB7MwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767849586; x=1799385586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oFlUSQXNvSjAfIbd7BqItrZfIULGO8s7jgggyHQo7fE=;
  b=UdqB7MwXq8Toz9pnnoEE4uxoJ7RgETVwGZ0n5dlpSwALn6Nxqk/pYw7N
   HeQX04iASK48o9YioUfcwrAVbarV+bZVFLniWITctB41EmzIyFHaTPzut
   BsttZ/rTpCuSLZ1C55zhgdlYd/tjCPgop8N5BIkEJZrAVN3mpf5Ke/iKD
   YD30VRamBE/R0x7BDzVOI5qtOBaV/DzpZMK+zcKqEyGP6C5qGapUv8cO/
   xfNpylB8VfgYhzI0djJ/pjBhr1kESR14EOK1Z4Zb7oDxx8ctE5HleCTBz
   sxjgyFoWSPyoihhQnm/8Z+DunXF22EVytmssjG8i8LeMKcCohjBeTYKt/
   g==;
X-CSE-ConnectionGUID: 0o7Zbm88QgOwfnJ0LrJm7A==
X-CSE-MsgGUID: OyobaC+6TjCbex/dxaE/uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69137389"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69137389"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:19:46 -0800
X-CSE-ConnectionGUID: ee9zG6lNRk2o5nlpQfYMBw==
X-CSE-MsgGUID: 6lyrdcNaTfCMBnD6ihRkwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="233814035"
Received: from unknown (HELO [10.238.3.120]) ([10.238.3.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:19:43 -0800
Message-ID: <49da7dcf-f16a-47b7-96e8-8307d127e823@linux.intel.com>
Date: Thu, 8 Jan 2026 13:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Drop an unused parameter 'ctx'
To: Qing Wang <wangqing7171@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Yeoreum Yun <yeoreum.yun@arm.com>
References: <20260107064351.3682174-1-wangqing7171@gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260107064351.3682174-1-wangqing7171@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/7/2026 2:43 PM, Qing Wang wrote:
> There is an unused parameter 'ctx' in perf_event_exit_event(), so drop it.
>
> Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  kernel/events/core.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dad0d3d2e85f..d4da96b3ab34 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4584,7 +4584,6 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
>  
>  static void perf_remove_from_owner(struct perf_event *event);
>  static void perf_event_exit_event(struct perf_event *event,
> -				  struct perf_event_context *ctx,
>  				  struct task_struct *task,
>  				  bool revoke);
>  
> @@ -4613,7 +4612,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
>  
>  		modified = true;
>  
> -		perf_event_exit_event(event, ctx, ctx->task, false);
> +		perf_event_exit_event(event, ctx->task, false);
>  	}
>  
>  	raw_spin_lock_irqsave(&ctx->lock, flags);
> @@ -12511,12 +12510,12 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
>  EXPORT_SYMBOL_GPL(perf_pmu_register);
>  
>  static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
> -			       struct perf_event_context *ctx)
> +			       struct task_struct *task)
>  {
>  	/*
>  	 * De-schedule the event and mark it REVOKED.
>  	 */
> -	perf_event_exit_event(event, ctx, ctx->task, true);
> +	perf_event_exit_event(event, task, true);
>  
>  	/*
>  	 * All _free_event() bits that rely on event->pmu:
> @@ -12555,7 +12554,7 @@ static void pmu_detach_event(struct pmu *pmu, struct perf_event *event)
>  	struct perf_event_context *ctx;
>  
>  	ctx = perf_event_ctx_lock(event);
> -	__pmu_detach_event(pmu, event, ctx);
> +	__pmu_detach_event(pmu, event, ctx->task);
>  	perf_event_ctx_unlock(event, ctx);
>  
>  	scoped_guard (spinlock, &pmu->events_lock)
> @@ -14096,11 +14095,9 @@ static void sync_child_event(struct perf_event *child_event,
>  		     &parent_event->child_total_time_running);
>  }
>  
> -static void
> -perf_event_exit_event(struct perf_event *event,
> -		      struct perf_event_context *ctx,
> -		      struct task_struct *task,
> -		      bool revoke)
> +static void perf_event_exit_event(struct perf_event *event,
> +				  struct task_struct *task,
> +				  bool revoke)
>  {
>  	struct perf_event *parent_event = event->parent;
>  	unsigned long detach_flags = DETACH_EXIT;
> @@ -14217,7 +14214,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>  		perf_event_task(task, ctx, 0);
>  
>  	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
> -		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
> +		perf_event_exit_event(child_event, exit ? task : NULL, false);
>  
>  	mutex_unlock(&ctx->mutex);

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  
