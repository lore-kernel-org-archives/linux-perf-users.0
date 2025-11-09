Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27861E51E0;
	Sun,  9 Nov 2025 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762688714; cv=none; b=RwE+kTLnXH8XQXFpviktiq68JUNSdyfhKY0aN1fgKRXkaqrPF7GvtFjF+WRuGOtqXz0FizIdWDexnLen9wDUDJIlb+g+loxt5Co+q+PlUcr49khJoip48BDDQekzI3FfAqsg12yx20WnPzmihC3ZGyAB3G0y709C221zrlZxE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762688714; c=relaxed/simple;
	bh=O0nIcV0c5wgu+szwXxCd+tGsNyUfJ4GDEdOEOuMwZOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6uxDTDwl5IkjoMP99KLFJXHTNtuTBs4rUFRbhHKcFov4vDijC2JzgyKDgn1NVYNMF2BLeP8BAnRfE9bvOrBQRVB1ueRleB+NkN12/0DbMIYAe81Mp4OWt5C/QyQ5cLkQBIh3NEZsuG8r1lojMXKLCwjDtyg0SQtVzHavBLkjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kxDK60de; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kxDK60de"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ia/BGyrmRgCd/x4/Ff6ZBieRFwhNMm3rnIx8XPcPLnk=; b=kxDK60deRXrRM8BtbCLup/i7wK
	XDcb6JVr7rcKhwUQWIsWRMLE5aZBMqSkTC7/x4zV+YzHxgCiI8lE+wqV5/Wxrx06B0lNFmwFR9X+0
	qssKyj60IrgL4zkhevzQHR5dwvfHefBGwowxGOGACzEOaOJDVSk/S7+NuS4sGtSPfXuxf7Jr+R/wt
	GXUfBOQ0Fd0C2WDx3JX5Mg7WHvEPDU/QqTaUXG+PBWMmGfgROehC1SDNwom5rwGUaSarxsp6rB7Qv
	NyN7iFY2HnoNuIjOt76M0Ruk01D8NZRuyxum64F9NFhNcT5mQvpb2sV8HgEtDfwVhaRx0dnt2DUzk
	R3yLr9nQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI2zF-00000009048-2IlU;
	Sun, 09 Nov 2025 10:49:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3101530023C; Sun, 09 Nov 2025 12:45:01 +0100 (CET)
Date: Sun, 9 Nov 2025 12:45:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Liangyan <liangyan.peng@bytedance.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, bigeasy@linutronix.de,
	zengxianjun@bytedance.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix pending work re-queued in
 __perf_event_overflow
Message-ID: <20251109114500.GC2545891@noisy.programming.kicks-ass.net>
References: <20251109103253.57081-1-liangyan.peng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109103253.57081-1-liangyan.peng@bytedance.com>

On Sun, Nov 09, 2025 at 06:32:53PM +0800, Liangyan wrote:
> A race condition occurs between task context and IRQ context when
> handling sigtrap tracepoint event overflows:
> 
> 1. In task context, an event is overflowed and its pending work is
>    queued to task->task_works
> 2. Before pending_work is set, the same event overflows in IRQ context
> 3. Both contexts queue the same perf pending work to task->task_works
> 
> This double queuing causes:
> - task_work_run() enters infinite loop calling perf_pending_task()
> - Potential warnings and use-after-free when event is freed in
> perf_pending_task()
> 
> Fix the race by disabling interrupts during queuing of perf pending work.



> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Reported-by: Xianjun Zeng <zengxianjun@bytedance.com>
> Signed-off-by: Liangyan <liangyan.peng@bytedance.com>
> ---
>  kernel/events/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cae921f4d137..6c35a129f185 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10427,12 +10427,14 @@ static int __perf_event_overflow(struct perf_event *event,
>  		bool valid_sample = sample_is_allowed(event, regs);
>  		unsigned int pending_id = 1;
>  		enum task_work_notify_mode notify_mode;
> +		unsigned long flags;
>  
>  		if (regs)
>  			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
>  
>  		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
>  
> +		local_irq_save(flags);

This could be written as:

		/*
		 * Comment that explains why we need to disable IRQs.
		 */
		guard(irqsave)();

>  		if (!event->pending_work &&
>  		    !task_work_add(current, &event->pending_task, notify_mode)) {
>  			event->pending_work = pending_id;
> @@ -10458,6 +10460,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  			 */
>  			WARN_ON_ONCE(event->pending_work != pending_id);
>  		}
> +		local_irq_restore(flags);
>  	}
>  
>  	READ_ONCE(event->overflow_handler)(event, data, regs);
> -- 
> 2.39.3 (Apple Git-145)
> 
