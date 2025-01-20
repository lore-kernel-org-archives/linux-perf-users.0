Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C16188A0E;
	Mon, 20 Jan 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737406154; cv=none; b=Y0eESui0ct8oXzwf0hp0PrU0SOSNVrKQxh3ZwDeOGOSWbMbc1gfZh+UDJbdADbqGLTzN+g38PVL/ZrsWWV7X7Qx9Gp54oZUOTWLL95xt69E0MMssvLvAi/DRevoA4+1zyN3uGTmjvjegIc8SdXbSvVCvMdUQmFgFbAlEtM87k3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737406154; c=relaxed/simple;
	bh=ZdJfaa4byGlkJwMS8G0hdf/s2X0mie/tGANcgrjZuXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmeqMw+GvV41nR5UB8CnVGLKE7WKHrBmDbCpxcLWYybRrBfZIfY/cs0RyK6zHS62ydDEtS/osoUomQjiGYfF/n4y1n75KudZRNDyL7Ei7WxPbTk4k1evpyQMCj/i8ogE/S3PWUBwAUaukFmv+tn9fBGX0M3qlpQU1PmDmIvPMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnacWNt9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnacWNt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737406153; x=1768942153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZdJfaa4byGlkJwMS8G0hdf/s2X0mie/tGANcgrjZuXY=;
  b=dnacWNt996Nc+V90qp6a8NZKRn8OllAYhUhFBNPdGLAWp+4P20B+ibxm
   kulsoJmzvGQJ/S8FPFlHgd5oHXdMnECD8J9bP0G9rvJV9QtxTsVrfKHyx
   qwqr7pWnKMsiy9Z0GECLncZGgl5EIvLTfePkfm0ChdaIkt2mUKt1eM2ny
   MzUT0LJ8yb2m2EJ3q1adgPTW4yIi9nKOGNgultenIcp76c3pXKX4PpTN0
   cc1JOEkeQ3llyJv1+5DXc79hKSTSpStXOG+0sr4VbjdR+7s8nGROCKrEW
   vnzYFfxyz+6+dC+MDVWNPiBiTIDuFHVOkPU6JI5GS1wUkznwLff7k2Kd5
   g==;
X-CSE-ConnectionGUID: 2Ncvu1RxRoiI3gYOhGWYog==
X-CSE-MsgGUID: NIdv3wbqRSGGZQMlYuRTWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="55219125"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="55219125"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 12:49:12 -0800
X-CSE-ConnectionGUID: dXe5+PnGSeKKskfWoc9l3w==
X-CSE-MsgGUID: dwpm3eX5SHadCpCfq7Il/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107046125"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 12:49:12 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0217820B5713;
	Mon, 20 Jan 2025 12:49:10 -0800 (PST)
Message-ID: <fac5bb75-8bce-4181-8278-c971d35b8b3a@linux.intel.com>
Date: Mon, 20 Jan 2025 15:49:09 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix warning warning due to unordred
 pmu_ctx_list
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250120114344.632474-1-luogengkun@huaweicloud.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250120114344.632474-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A redundant "warning" is in the title.

On 2025-01-20 6:43 a.m., Luo Gengkun wrote:
> Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
> perf_event_swap_task_ctx_data. vmcore shows that two lists have the same
> perf_event_pmu_context, but not in the same order.
> 
> The problem is that when inheritance is performed, it traverses the ordered
> groups of events, and inserts the new perf_event_pmu_context into
> child_ctx->pmu_ctx_list which is unordered. So the order of pmu_ctx_list in
> the parent and child may be different.

I think the order of pmu_ctx_list for the parent should be impacted by
the time when an event/pmu is added.
While the order for a child should be impacted by the event order in the
pinned_groups and flexible_groups.

> 
> The follow testcase can trigger above warning:
> 
>  # perf record -e cycles --call-graph lbr -- taskset -c 3 ./a.out &
>  # perf stat -e cpu-clock,cs -p xxx // xxx is the pid of a.out
> 
> test.c
> 
> void main() {
>         int count = 0;
>         pid_t pid;
> 
>         printf("%d running\n", getpid());
>         sleep(30);
>         printf("running\n");
> 
>         pid = fork();
>         if (pid == -1) {
>                 printf("fork error\n");
>                 return;
>         }
>         if (pid == 0) {
>                 while (1) {
>                         count++;
>                 }
>         } else {
>                 while (1) {
>                         count++;
>                 }
>         }
> }
> 
> The testcase first open a lbr event, so it will alloc task_ctx_data, and
> then open tracepoint and software events, so the parent ctx will have 3
> different perf_event_pmu_contexts. When doing inherit, child ctx will
> insert the perf_event_pmu_context in another order then the warning will
> trigger.
> 
> To fix this problem, add pmu_ctx_insertion_sort to make sure the
> pmu_ctx_list is ordered.
> 
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>  kernel/events/core.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 95b01a51139d..1bdff3ef0ce2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4953,6 +4953,24 @@ find_get_context(struct task_struct *task, struct perf_event *event)
>  	return ERR_PTR(err);
>  }
>  
> +/*
> + * This function ensures that ctx->pmu_ctx_list is ordered, so that no warning
> + * is triggered due to prev_epc->pmu != next_epc->pmu.
> + */
> +static void pmu_ctx_insertion_sort(struct perf_event_pmu_context *new,
> +				   struct perf_event_context *ctx)
> +{
> +	struct perf_event_pmu_context *epc;
> +
> +	lockdep_assert_held(&ctx->lock);
> +
> +	list_for_each_entry(epc, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +		if (epc->pmu > new->pmu)
> +			break;
> +	}
> +	list_add(&new->pmu_ctx_entry, epc->pmu_ctx_entry.prev);
> +}
> +
>  static struct perf_event_pmu_context *
>  find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>  		     struct perf_event *event)
> @@ -4974,7 +4992,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>  		if (!epc->ctx) {
>  			atomic_set(&epc->refcount, 1);
>  			epc->embedded = 1;
> -			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
> +			pmu_ctx_insertion_sort(epc, ctx);

The CPU event and per-task event should have a different ctx.
The warning should only be triggered for the per-task event, right?
If so, I don't think a sort is required here.

>  			epc->ctx = ctx;
>  		} else {
>  			WARN_ON_ONCE(epc->ctx != ctx);
> @@ -5021,7 +5039,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>  	printk(KERN_INFO
>  		"lgk: ctx %p insert pmu ctx %p, pmu is %p!\n", ctx, epc, epc->pmu);

Seems your debug code. Please send a clean patch.

>  
> -	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
> +	pmu_ctx_insertion_sort(epc, ctx);

I think the pmu_ctx_list has already traversed to find a matched pmu
right before. The traverse in the pmu_ctx_insertion_sort() can be avoided.

Thanks,
Kan
>  	epc->ctx = ctx;
>  
>  found_epc:

