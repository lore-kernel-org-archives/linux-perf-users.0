Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF7188006;
	Tue, 21 Jan 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475982; cv=none; b=NMXXiHdXH9d9XwKq1KOxzJ0FAHdFlJeXFct8LyBFzc54hAG6rpsDpEaTxHkZL52bIZckR2tK5j4cA5SQvyVWP4/DCGwby8tpnmhIdf8r40xuB9PG7UcXvyPBsvo0CNlmg72qXZM4oVuXR2BbhBKcS3vMqOvX+NR6TKh6w3EMLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475982; c=relaxed/simple;
	bh=zD2ekEshlfDlnJ+vzvlb6p+YD0VSwTReux2r7806EyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJ/5oDQIRf8Cvwk716/qIuHKI0r5JYsPlTOBHn1LuPbqLiNZX0V1WuWgFYTK5YnQUwa2JIwOLMJkt7Nn+yxRN2Q2jZWKgMkqe87TAYY1aW2CFPzl3RAUqec6ZOOhExLN2F72jFec9wDSBf4rafe/G2g4YgqRI9cNHIeAe1qU4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPVivUgk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPVivUgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737475981; x=1769011981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zD2ekEshlfDlnJ+vzvlb6p+YD0VSwTReux2r7806EyM=;
  b=lPVivUgkfMNw4KdUGKc5GgHgHWBl4kU+sqf2TBJILIurGVN7XcA+8Dj8
   VC7zBHai6ZRYNRuUKAscg6f43/l3+FDAEmt4Hfce/lNz5Rw9cpDsHx/28
   qrTFKTvM5nPD+tS/hVFQ7lT0x6kiQ4AvT5H3PeVUfquKSCZkkXjfIk+x/
   IO6fMCA7rpDJfFBH860D+mhM9xZWGVuPgvj4+GERvzwZjUnVfA6IclQXv
   pDMn7aqdoyiuqW1T4ixnyGDEZrdH93ZXqgZvNMFsVdqEu2BGae+IF/9w8
   hTLIRPGT6t8cYsWX4U7/2fd2BIIanSFh4M8VHLndJABTQpoQo2n9AAFI8
   g==;
X-CSE-ConnectionGUID: W3i3l65wS76hnfE7QVhkUg==
X-CSE-MsgGUID: tBm8Giq9TsuWnp+dVTRamg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37772363"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="37772363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 08:13:00 -0800
X-CSE-ConnectionGUID: 52ms/hyVRpyf0rrh8PMrxw==
X-CSE-MsgGUID: hhjACR7lRLiq/WWlqvBtFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111476220"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 08:12:59 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 51F1D20B5713;
	Tue, 21 Jan 2025 08:12:57 -0800 (PST)
Message-ID: <aa086dd7-10aa-4746-889d-b13c793da5ec@linux.intel.com>
Date: Tue, 21 Jan 2025 11:12:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Fix warning due to unordred pmu_ctx_list
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121130802.1813928-1-luogengkun@huaweicloud.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250121130802.1813928-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-21 8:08 a.m., Luo Gengkun wrote:
> Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
> perf_event_swap_task_ctx_data. vmcore shows that two lists have the same
> perf_event_pmu_context, but not in the same order.
> 
> The problem is that the order of pmu_ctx_list for the parent is impacted by
> the time when an event/pmu is added. While the order for a child is
> impacted bt the event order in the pinned_groups and flexible_groups. So

%s/bt/by/

> the order of pmu_ctx_list in the parent and child may be different.
> 
> To fix this problem, insert the perf_event_pmu_context to proper place
> after iteration of pmu_ctx_list.
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
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
> Changes in v2:
> 1. update commit message.
> 2. only sort the pmu_ctx_list of ctx which ctx->task != NULL.
> Link to v1: https://lore.kernel.org/all/20250120114344.632474-1-luogengkun@huaweicloud.com/
> 
> ---
>  kernel/events/core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..096f92b9a971 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4950,7 +4950,7 @@ static struct perf_event_pmu_context *
>  find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>  		     struct perf_event *event)
>  {
> -	struct perf_event_pmu_context *new = NULL, *epc;
> +	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
>  	void *task_ctx_data = NULL;
>  
>  	if (!ctx->task) {
> @@ -5007,12 +5007,19 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
>  			atomic_inc(&epc->refcount);
>  			goto found_epc;
>  		}
> +		// Make sure the pmu_ctx_list is sorted by pmu

/* Make sure the pmu_ctx_list is sorted by pmu */

> +		if (!pos && epc->pmu->type > pmu->type)
> +			pos = epc;
>  	}
>  
>  	epc = new;
>  	new = NULL;
>  
> -	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
> +	if (!pos)
> +		list_add_tail(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
> +	else
> +		list_add(&epc->pmu_ctx_entry, pos->pmu_ctx_entry.prev);
> +
>  	epc->ctx = ctx;
>  
>  found_epc:

Other than the above two issues, the patch looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
