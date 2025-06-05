Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223928E3F;
	Thu,  5 Jun 2025 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749095716; cv=none; b=RX+/8kmO0oYUSgxi4v/FVQkZqGiy3foccuI/iuI56LBhsing8q41abjprg4FIxEGpRplrStcBSAs6cHXGiAIXcZwXZ9BXYmXVeUgBzkTAVM4YohJhQEclbrXZFjQsL6JUVQ8PtwXq4Fy6gNwN6A5GCZygBZv7xPmoJVLdQPYEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749095716; c=relaxed/simple;
	bh=2ob9mLxLPx3nnUzKezqzg9HY+9Zpiv+L6w0YwZrNN/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X93Ad+n/IUOK5MmTQiCrhJvrHKzSVh49qUcII53e6uZ7gqMAvLFTidUmFA1JpJmcD5KCls0KqH0bjQBSef3FxfP1OVadOgWSMWr8s4S3IF5cs5prZA91NVDdAoqb8lRc/MhlW+VPZ1Nw3k5V3zBswbMnCTTYF9O9iSCxgNOOcgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bCVvs71GLzYQv7Y;
	Thu,  5 Jun 2025 11:55:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 06C351A1530;
	Thu,  5 Jun 2025 11:55:05 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgAni18XFUFo7SMxOg--.62183S3;
	Thu, 05 Jun 2025 11:55:04 +0800 (CST)
Message-ID: <83d9c5e8-9c72-4ab8-a3ac-638e49691694@huaweicloud.com>
Date: Thu, 5 Jun 2025 11:55:03 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf/core: Fix WARN_ON_ONCE(cpuctx->ctx.nr_cgroups
 == 0) in perf_cgroup_switch
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 davidcc@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250604033924.3914647-1-luogengkun@huaweicloud.com>
 <20250604033924.3914647-3-luogengkun@huaweicloud.com>
 <20250604100052.GH38114@noisy.programming.kicks-ass.net>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <20250604100052.GH38114@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAni18XFUFo7SMxOg--.62183S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryfGrW5Cr45ZryfCF4xtFb_yoW5urW7pF
	srCF4a9398XFyUXa17tw1vva4Svw4SgaykWw15Kw43CrWUXrn8GF47Ga15AFn8Z3Z7AFWf
	t390kr13A348ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/6/4 18:00, Peter Zijlstra wrote:
> On Wed, Jun 04, 2025 at 03:39:24AM +0000, Luo Gengkun wrote:
>> There may be concurrency between perf_cgroup_switch and
>> perf_cgroup_event_disable. Consider the following scenario: after a new
>> perf cgroup event is created on CPU0, the new event may not trigger
>> a reprogramming, causing ctx->is_active to be 0. In this case, when CPU1
>> disables this perf event, it executes __perf_remove_from_context->
>> list _del_event->perf_cgroup_event_disable on CPU1, which causes a race
>> with perf_cgroup_switch running on CPU0.
>>
>> The following describes the details of this concurrency scenario:
>>
>> CPU0						CPU1
>>
>> perf_cgroup_switch:
>>     ...
>>     # cpuctx->cgrp is not NULL here
>>     if (READ_ONCE(cpuctx->cgrp) == NULL)
>>     	return;
>>
>> 						perf_remove_from_context:
>> 						   ...
>> 						   raw_spin_lock_irq(&ctx->lock);
>> 						   ...
>> 						   # ctx->is_active == 0 because reprogramm is not
>> 						   # tigger, so CPU1 can do __perf_remove_from_context
>> 						   # for CPU0
>> 						   __perf_remove_from_context:
>> 						         perf_cgroup_event_disable:
>> 							    ...
>> 							    if (--ctx->nr_cgroups)
>> 							    ...
>>
>>     # this warning will happened because CPU1 changed
>>     # ctx.nr_cgroups to 0.
>>     WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>>
>> To fix this problem, expand the lock-holding critical section in
>> perf_cgroup_switch.
>>
>> Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> ---
> Right, so how about we simply re-check the condition once we take the
> lock?
>
> Also, take the opportunity to convert to guard instead of adding goto
> unlock.
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -207,6 +207,19 @@ static void perf_ctx_unlock(struct perf_
>   	__perf_ctx_unlock(&cpuctx->ctx);
>   }
>   
> +typedef struct {
> +	struct perf_cpu_context *cpuctx;
> +	struct perf_event_context *ctx;
> +} class_perf_ctx_lock_t;
> +
> +static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
> +{ perf_ctx_unlock(_T->cpuctx, _T->ctx); }
> +
> +static inline class_perf_ctx_lock_t
> +class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
> +				struct perf_event_context *ctx)
> +{ perf_ctx_lock(cpuctx, ctx); return (class_perf_ctx_lock_t){ cpuctx, ctx }; }
> +
>   #define TASK_TOMBSTONE ((void *)-1L)
>   
>   static bool is_kernel_event(struct perf_event *event)
> @@ -944,7 +957,13 @@ static void perf_cgroup_switch(struct ta
>   	if (READ_ONCE(cpuctx->cgrp) == cgrp)
>   		return;
>   
> -	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
> +	/*
> +	 * Re-check, could've raced vs perf_remove_from_context().
> +	 */
> +	if (READ_ONCE(cpuctx->cgrp) == NULL)
> +		return;
> +
>   	perf_ctx_disable(&cpuctx->ctx, true);
>   
>   	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
> @@ -962,7 +981,6 @@ static void perf_cgroup_switch(struct ta
>   	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
>   
>   	perf_ctx_enable(&cpuctx->ctx, true);
> -	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>   }
>   
>   static int perf_cgroup_ensure_storage(struct perf_event *event,

Thank for your review, I will make changes based on your suggestions.

