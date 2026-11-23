Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795399860;
	b=CzdkKq9sBOq15e1jErnk4yKShXgpJcCvvZv02z2DwLaZzEX/hqv6kEP2dYuK1PDU9ccm
	 jy5/Q6V+Kc/2+OQW/wNDrYFRllUDhSw904ouxEt1FkZeT8BWqlzCVlZRrBLdV7szvsuAR
	 qSvTPy3HbB8JET9MnjlgGxZBTD4luuMEAFeGGQKCEQXN7XbHFVf/nckqhErNJ/YdcFXfX
	 t9Qh811/JPtE540H85Q+nob/sjKxxb+SNOgCmFXnG8dEUZgLag3Ge51bRXqJ+OXfhHOlZ
	 b3/J7VJkhoFfEkVZnsVfVqOT7SP/+8Jqw9JyZWekHG0lUYDvbuEJAy2BiXAJPgI344A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795399860;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=C4d4/ZZI2QavfeDE1+YXdE9XsQGasUBBMAoeix++LBY=;
	b=VrMiZHq+eB2cEeLfqNV1fe3eGC+2sogf4Z+5FcEmX2AUL4PKvSxD/r6+4wbRkxBd6egH
	 r7/d9OODn6ei0Sfs9zZpnQpC7AdXh3kCVhtlXUv8NXNiljylTqE6IEXKPMfZ/6VK9/Dr9
	 k8BXQNBooZEk+Ajazj8kNr7bjaqi0R6FvT0Mz/Ga7ifbiISHxxJzjtXJ3hBgDNeXZJRi1
	 hBA/CAn+nPAVUXwQt+Fwjv9cieEEqq/cPuT7XjiRzaERFDtmgskp4Am5yg7CjDR2rYq5N
	 l+xtIrGkRDkFKkzjwqDGId+ZcZcsl94dlGQWH+LrGKxWjwVsztRvfBpiA3PVXAdT5uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30079606A31A;
	Mon, 23 Nov 2026 02:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30079606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jXqD853Nkz1c18B;
	Mon, 23 Nov 2026 10:10:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 65A1D4056D;
	Mon, 23 Nov 2026 10:10:49 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgD3e_GnoANrSTGAFQ--.62995S2;
	Mon, 23 Nov 2026 10:10:49 +0800 (CST)
Message-ID: <42094cd9-6b18-4877-b99d-9e72c8e6e613@huaweicloud.com>
Date: Mon, 23 Nov 2026 10:10:47 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
To: Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
 <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3e_GnoANrSTGAFQ--.62995S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWrWw17KrWDJr4rCr13CFg_yoWrAr4xpr
	W3Xrn0kay8XFnFqr13tw4DZr1rWw4vqws8Crs5A34SyF4Yvr92qa17K3WYva1rCrnrJay3
	Z3yjkrW7C34UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/21 1:49, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 06:28:31PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2026-11-20 17:26:04 [+0100], Peter Zijlstra wrote:
>>> Also, sending signals on software events seems utterly insane. But I
>>> don't support we can go limit that now :-(
>>
>> Tengda: Is this an actual valid use case that you have here or did an AI
>> figured out that this broken?
> 
> I *think* the below is sufficient.
> 
>  - sigtrap implies a per-task event; task_work is local to the current
>    task (+- the context switch thing from 2/2).
> 
>  - task_work_run() is written such that the work handler can do
>    task_work_add(), therefore the early clear in the handler doesn't
>    matter.
> 
> And while recursive software events are tedious, I think the below fix
> is simple enough to not worry about too much.
> 
> ---
> Subject: perf/core: Prevent duplicate sigtrap task work enqueue
> From: Tengda Wu <wutengda@huaweicloud.com>
> Date: Thu, 19 Nov 2026 09:51:00 +0000
> 
> From: Tengda Wu <wutengda@huaweicloud.com>
> 
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add() and
> re-enter __perf_event_overflow() for the same (software/tracepoint)
> event. Since pending_work is still zero, the nested invocation can
> enqueue the same pending_task again.
> 
> The re-entrant call path looks like this:
> 
>   __perf_event_overflow()
>     task_work_add()
>       <NMI>
>         __perf_event_overflow()
>           task_work_add()
> 
> The nested invocation may enqueue pending_task before the outer
> invocation does. When the outer invocation resumes, it inserts the
> same task work entry again, potentially creating a cycle in the task
> work list.
> 
> As a result, perf_pending_task() may be executed repeatedly, leading
> to unbalanced event reference counting.
> 
> Fix this by atomically claiming pending_work with cmpxchg_local()
> before calling task_work_add(). This ensures that only one invocation
> can enqueue the task work, even when another overflow occurs
> re-entrantly from an NMI.
> 
> Notably: sigtrap events must be per-task, meaning that the there is no
> concurrency, only re-entrancy.
> 
> [peterz: clarify and rewrite]
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10950,16 +10950,22 @@ static int __perf_event_overflow(struct
>  
>  		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
>  
> -		if (!event->pending_work &&
> -		    !task_work_add(current, &event->pending_task, notify_mode)) {
> -			event->pending_work = pending_id;
> -			local_inc(&event->ctx->nr_no_switch_fast);
> -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> -
> -			event->pending_addr = 0;
> -			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> -				event->pending_addr = data->addr;
> +		/*
> +		 * Software events can nest and attempt this recursively;
> +		 * claim the pending_work before task_work_add() recurses.
> +		 */
> +		if (cmpxchg_local(&event->pending_work, 0, 1) == 0) {
> +			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> +				event->pending_work = pending_id;
> +				local_inc(&event->ctx->nr_no_switch_fast);
> +				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
>  
> +				event->pending_addr = 0;
> +				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> +					event->pending_addr = data->addr;
> +			} else {
> +				event->pending_work = 0;
> +			}
>  		} else if (event->attr.exclude_kernel && valid_sample) {
>  			/*
>  			 * Should not be able to return to user space without

Hmm, this is basically similar to my original version, and I re-tested with this
and it's fine. LGTM.

Thanks,
Tengda

