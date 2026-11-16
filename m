Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822431;
	b=kmRkwhv57sxgUpRb+MEQ3zhSZ9V67OUd0jjMLUM3Tui4bp/nBB5scRJp00mEydMyJ0y/
	 GD5pD6AA1hz77uXxnFV1UNTJ7XowxY4J46h87SxogB8p43m2gctud9QBMBH5HJgaTKWLy
	 T6qVt+oVk+52JdCZOiYxaIJhZt1X62gUXFg5peaqpZQ/N6FdjEy+HviVmHhOaYn6pLHxw
	 sIYogUoencL1fWsjW1OxAalUWXJne+L/nKIo9QWT8zS23CbKOQihEbvEzt65Gvg0iEEQZ
	 2FOmqnh+JbPwLhl9cgmB3ZxWhsWwYYhxT43tClPmQC32tpALPFlXpK0O09bdK7DN2gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822431;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=fsPsMFn8hWSINzFyIgJpitEGrKFPlA0wibbGI4KQ4Xw=;
	b=06pCffeJnMt2c8M7mDrG4TybpO58zzuN4ouY97zIcK1ke4Xx7ygkDXDtSdNhOX4LDdDs
	 N5L1BAXwarDEGhzidwXLcJzH6TZKwrNhp16XbEfvedhs22yTYWpYh8i1rfBiH9KmZ2iFC
	 FiXOvuJNUGiHCHo9cIaBjDea4UUuG4eGbIb1sXY+rs3oPTbgV2mQFiUEOwvSO+l1rwYbA
	 YhQRuohoDMbWeFJaZkHvdEBrOAIzzIzjVYVKxX+bNDmFqL4xgFAvoRdx7fCclLLdNSJxF
	 wk+rA1rVkrYkMdPGlGqFUnXieL9YfHo5lqtHaHRKWSHklsKqY54PU/qgxHg9AZDNc2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hJLV6ZQi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=m3Mji7C+;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E9606A31C;
	Mon, 16 Nov 2026 09:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hJLV6ZQi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=m3Mji7C+
Date: Mon, 16 Nov 2026 10:47:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794822428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsPsMFn8hWSINzFyIgJpitEGrKFPlA0wibbGI4KQ4Xw=;
	b=hJLV6ZQiRHk/LYJPQMwf0Zeqs0xt5jqEx3eeUGUZkjI4t4H8JK5j0MdNYRUwZLSKR/XfP7
	45Nz2QtzA2QnCLha2IuEvBevBpzDXQxQy+Ny7NYRniBQzcosL0eT8a0CpfrTX1jk8JcVj2
	iYvMa/jKoUIpXcGr9q8HS1jEs91YLgt5DnjanGc9TCWxkjR3WIh5uWmdPPirN/OdftUIoq
	JYgn78lufZoqXagML0I0HSq4SqWN1mthQxy73mZSqSKLO+Om2o/xEa4JFXT+e0PTX8yljB
	+p/BcRm859F9qwDVnhqGBbsn3j3rq7CeRmYQDpLhX8JzDOCA7wH/LXbFDKE44g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794822428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsPsMFn8hWSINzFyIgJpitEGrKFPlA0wibbGI4KQ4Xw=;
	b=m3Mji7C+1Lc7pTYKmsbndx4QOXyzTON6cxHUNfSu6+pHN9LTWMrNZmaWmyb8kcQHuubRth
	uQTVvf3caGj6PPDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261116094706.GX5vD02a@linutronix.de>
References: <cover.1793870900.git.wutengda@huaweicloud.com>
 <ff842e802e9ecb74510a90964f8ad2c4825834b7.1793870900.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff842e802e9ecb74510a90964f8ad2c4825834b7.1793870900.git.wutengda@huaweicloud.com>

On 2026-11-05 09:30:43 [+0000], Tengda Wu wrote:
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
> 
> The re-entrant call path is:
> 
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
>           __perf_event_overflow()
>             task_work_add()
> 
> The nested invocation can enqueue pending_task before the
> outer invocation does. When the outer invocation resumes, it
> inserts the same task_work entry again, potentially creating
> a cycle in the task work list.
> 
> This causes perf_pending_task() to be executed repeatedly
> and leads to unbalanced event reference counting.
> 
> Use cmpxchg() to atomically claim pending_work before calling
> task_work_add(). This ensures that only one invocation can
> enqueue the pending_task, even when interrupted by an NMI.
> 
> If task_work_add() fails, clear the pending_work claim so that
> a subsequent overflow can retry.
> 
> Also use READ_ONCE() when checking pending_work in the
> exclude_kernel warning path to avoid an unsynchronized read.
> 
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  kernel/events/core.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 457d75ea7142..ee5c59158b89 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10925,16 +10925,17 @@ static int __perf_event_overflow(struct perf_event *event,
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
> -
> +		if (cmpxchg(&event->pending_work, 0, pending_id) == 0) {

would cmpxchg_acquire() here make sense?

> +			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> +				local_inc(&event->ctx->nr_no_switch_fast);
> +				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> +
> +				event->pending_addr = 0;
> +				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> +					event->pending_addr = data->addr;
> +			} else {
> +				cmpxchg(&event->pending_work, pending_id, 0);

if the task_work_add() fails then smp_store_release(, 0) since only the
executed task_work can release it back to 0. The cmpxchg seems not
needed.

> +			}
>  		} else if (event->attr.exclude_kernel && valid_sample) {
>  			/*
>  			 * Should not be able to return to user space without
> @@ -10948,7 +10949,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  			 *     To approximate progress (with false negatives),
>  			 *     check 32-bit hash of the current IP.
>  			 */
> -			WARN_ON_ONCE(event->pending_work != pending_id);
> +			WARN_ON_ONCE(READ_ONCE(event->pending_work) != pending_id);
smp_load_acquire()

perf_pending_task() could maybe get a xchg_release(, 0). This however is
wrong because it would reset perf_event::pending_work and make it
available for __perf_event_overflow() again. I think it should have a
load_acquire() first, and have the store_release() after perf_sigtrap().

Comments?

>  		}
>  	}
>  

Sebastian
