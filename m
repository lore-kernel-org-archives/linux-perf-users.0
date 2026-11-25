Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595244;
	b=LiCJOCI7jj6WybxCiDGf8YhbJLBhdW3XSKJ8JkB+FrmuXjt0DYyvAACh3L5OyXvUjVth
	 7YpQjRgRk/mVWTRU6hu1/dwQlshxX16uzhfjgG83aKW/hTA9MI7DhizHMyz3d5SP2pdvJ
	 NNFePuDyhNLzbPD2YQ31owjSLPHqFd7hBZQZD1eXn6JOnw5pYJdO6r+aoGy5dWin9qRTN
	 9T0+u9j9rvR0nrnwX8aKPfAwGJkv3swfRF+qFRDxADN5gjhPvASjevbwrpCIDTVmrTK0d
	 kNfew1q0nhJqBveCdrxOhQrJ81LvcZHv+lNFQdq1jYRDZnw4C17a+kZ/VsNY/0cZ4OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=pteydfxRl+HzubC8k+/oUWaehVw+cLEHvYVfJ3DJcCk=;
	b=DnP+ubPv58mtosCMUznPqY0u5mgaUjgD+L8+zeZNq6cPCVRI/KbJO0xRMmmy9/txr+XO
	 rBP8LqzFuunI/tkanTxutoJZBt5eFY9uPyqV0y6pxNv+EnkN0bn4sl0RgsD8ZJr46uJ93
	 XhH+IYsFZv4Kjkc6UatoCEtoaK33cyvY9T6nraw3oKuuwSJGc9t7caB82lp6i/pyOUr0L
	 +nDWv0Y2eqsRo5NslfFRdVHya4T0chrVQ7bXOHuaUsfXstoUWGl/lVKrGEIaAN0pYjh6L
	 FJcFRed2rIT5h+NRYyP8yPHWQzOyYiyO+Msm9cJSBVTzpTFYNigpPaWYziYGYlV3fOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KViTnuty;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F563606A31E;
	Wed, 25 Nov 2026 08:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F563606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KViTnuty
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pteydfxRl+HzubC8k+/oUWaehVw+cLEHvYVfJ3DJcCk=; b=KViTnutyQo8mc6tYwc6EPGK/aT
	lJC35PwWmRmvDrW9nxbsA+DfJApseLbvOGj41HuHgTVlI+8DHfIyq84WWwbRCEZjUZq9p3mAsmI+j
	4C4JzSOiFXkAVakOPutY4Rm5EuNwPCrgJc12q9T0JC6RvMTQ5D5agD5ZY7ed1XOJuKMEjjJK42Nk4
	rE36qztHFASnzQh2OWF+a+OCUCr/ek6QUBMyjFLkYGjCbJsG4fY5+Dp+0jZjUXe02ReoeM8NylAs8
	awH/2AreOWhRzWr7YGgC2lOvoBWu0D80arN2UMBTTIQMMhN8s0ZunO7Af/ZLC2KJOtXns3PbCW76B
	4JbjQ3YA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8LQ-00000008VvZ-1qz9;
	Wed, 25 Nov 2026 08:27:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3DD3D300969; Wed, 25 Nov 2026 09:27:11 +0100 (CET)
Date: Wed, 25 Nov 2026 09:27:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261125082711.GV2668804@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
 <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
 <20261123080004.MKzgHQ3W@linutronix.de>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123080004.MKzgHQ3W@linutronix.de>

On Mon, Nov 23, 2026 at 09:00:04AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-20 18:49:42 [+0100], Peter Zijlstra wrote:
> > From: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > The sigtrap handling in __perf_event_overflow() checks
> > event->pending_work before calling task_work_add(), but only sets
> > pending_work after the task work has been queued.
> > 
> > This leaves a window where an NMI can interrupt task_work_add() and
> > re-enter __perf_event_overflow() for the same (software/tracepoint)
> > event. Since pending_work is still zero, the nested invocation can
> > enqueue the same pending_task again.
> > 
> > The re-entrant call path looks like this:
> > 
> >   __perf_event_overflow()
> >     task_work_add()
> >       <NMI>
> >         __perf_event_overflow()
> >           task_work_add()
> > 
> > The nested invocation may enqueue pending_task before the outer
> > invocation does. When the outer invocation resumes, it inserts the
> > same task work entry again, potentially creating a cycle in the task
> > work list.
> > 
> > As a result, perf_pending_task() may be executed repeatedly, leading
> > to unbalanced event reference counting.
> > 
> > Fix this by atomically claiming pending_work with cmpxchg_local()
> > before calling task_work_add(). This ensures that only one invocation
> > can enqueue the task work, even when another overflow occurs
> > re-entrantly from an NMI.
> > 
> > Notably: sigtrap events must be per-task, meaning that the there is no
> > concurrency, only re-entrancy.
> > 
> > [peterz: clarify and rewrite]
> > Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> > Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> This looks good. Shouldn't we insert also
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e870f12c3ad81..edadc34f065fc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7776,8 +7776,8 @@ static void perf_pending_task(struct callback_head *head)
>  	rctx = perf_swevent_get_recursion_context();
>  
>  	if (event->pending_work) {
> -		event->pending_work = 0;
>  		perf_sigtrap(event);
> +		WRITE_ONCE(event->pending_work, 0);
>  		local_dec(&event->ctx->nr_no_switch_fast);
>  	}
>  	put_event(event);
> 
> To ensure the ::pending_work is reset after perf_sigtrap() is done?

task_work_add() can be used while inside task_work; so I do not see why
this would matter.
