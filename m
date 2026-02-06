Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F47360741;
	Fri,  6 Feb 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391758; cv=none; b=qne03Z6sNv2vBe9Jn2k7NRWQw0SkcvHe8NgQXdX3ZQuRTnd4OXWQx0yJ9geNgw0FVsQmY58n7QCyCEwGecxLy+m5Vy+WzK1zOYUVUsqVbDBx2+PKrLolyC3K3BJRuOwyiAdaSe/1HDJ3vSe5iO/Wb3NjwJL2/UnzJybZSFcoZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391758; c=relaxed/simple;
	bh=yUzIrpvMeYI3/PLFi9ScRCQ6jhw63+cJtYKXbIdtUAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umk54vALAHM/gKwNdrNpmaI+lmGoYo+YIOlI0U4HWPnZY9bhHXFIvEVpnTDZaUjDs22UQSvG01jSxiBwJpCa+RpHrR7Y/uksP3nZcKxTNmZ7Hs4puNvjU9nyvQ3kx9PwNPVB4oXfj6PNtMmQRU8cKU6hcGJbD5bMW3m5VjRQNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aIlxlfl+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIlxlfl+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5cZuU9qlpE88NTRVJqte5E3EyGqgESdXK8ngp/IrWoY=; b=aIlxlfl+fXUyF1NIvrbvkkvI86
	QaUTewXgSA5LZqZcZf4t1TQKPt2BxTe4j1uVa7fldkgooZr5YFa4id7oS4rTrsYq46iCexYAGIOpB
	hiIvOkdlti6b8GaMVCdHzfT7F5oAS6EVIgKW//QTGstpl1towzbHFyjRY0cf3q4nS+xGzlWJXqukX
	tWGZxwPzgdqcouJqmOeft2ZFMy/6j4LIwMj7wYdzlVQMS9ArBkfRh+SnX1I0qruY+IGd6bJe3BQo5
	eh5uHiYFs43cPMmhz0FW8jFvM8sHPV/ozAQVKNpCk1VnA+LwlH6h9jN4g7rgJPGqp4PPN7UIamRfY
	udY/phOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNld-000000044aG-1MQD;
	Fri, 06 Feb 2026 15:29:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE522301142; Fri, 06 Feb 2026 16:29:07 +0100 (CET)
Date: Fri, 6 Feb 2026 16:29:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@linaro.org>
Cc: Thaumy Cheng <thaumy.love@gmail.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task
 exit
Message-ID: <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
References: <20251024170543.11201-1-thaumy.love@gmail.com>
 <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>

On Fri, Feb 06, 2026 at 11:21:19AM +0000, James Clark wrote:

> I've been looking into a regression caused by this commit and didn't manage
> to come up with a fix. But shouldn't this be something more like:
> 
>   if (attach_state & PERF_ATTACH_CHILD && event_filter_match(event))
>       sync_child_event(event, task);
> 
> As in, you only want to call sync_child_event() and write stuff to the ring
> buffer for the CPU that is currently running this exit handler? Although
> this change affects the 'total_time_enabled' tracking as well, but I'm not
> 100% sure if we're not double counting it anyway.
> 
> From perf_event_exit_task_context(), perf_event_exit_event() is called on
> all events, which includes events on other CPUs:
> 
>   list_for_each_entry_safe(child_event, next, &ctx->event_list, ...)
>     perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
> 
> Then we write into those other CPU's ring buffers, which don't support
> concurrency.
> 
> The reason I found this is because we have a tracing test that spawns some
> threads and then looks for PERF_RECORD_AUX events. When there are concurrent
> writes into the ring buffers, rb->nest tracking gets messed up leaving the
> count positive even after all nested writers have finished. Then all future
> writes don't copy the data_head pointer to the user page (because it thinks
> someone else is writing), so Perf doesn't copy out any data anymore leaving
> records missing.
> 
> An easy reproducer is to put a warning that the ring buffer being written to
> is the correct one:
> 
>   @@ -41,10 +41,11 @@ static void perf_output_get_handle(struct
>   perf_output_handle *handle)
>   {
>  	struct perf_buffer *rb = handle->rb;
> 
>  	preempt_disable();
> 
>   +	WARN_ON(handle->event->cpu != smp_processor_id());
> 
> 
> And then record:
> 
>   perf record -s -- stress -c 8 -t 1
> 
> Which results in:
> 
>   perf_output_begin+0x320/0x480 (P)
>   perf_event_exit_event+0x178/0x2c0
>   perf_event_exit_task_context+0x214/0x2f0
>   perf_event_exit_task+0xb0/0x3b0
>   do_exit+0x1bc/0x808
>   __arm64_sys_exit+0x28/0x30
>   invoke_syscall+0x4c/0xe8
>   el0_svc_common+0x9c/0xf0
>   do_el0_svc+0x28/0x40
>   el0_svc+0x50/0x240
>   el0t_64_sync_handler+0x78/0x130
>   el0t_64_sync+0x198/0x1a0
> 
> I suppose there is a chance that this is only an issue when also doing
> perf_aux_output_begin()/perf_aux_output_end() from start/stop because that's
> where I saw the real race? Maybe without that, accessing the rb from another
> CPU is ok because there is some locking, but I think this might be a more
> general issue.

I *think* something like so.

Before the patch in question this would never happen, because of calling
things too late and always hitting that TASK_TOMBSTONE.

But irrespective of emitting that event, we do want to propagate the
count and runtime numbers.


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5b5cb620499e..f566ad55b4fb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14086,7 +14086,7 @@ static void sync_child_event(struct perf_event *child_event,
 	u64 child_val;
 
 	if (child_event->attr.inherit_stat) {
-		if (task && task != TASK_TOMBSTONE)
+		if (task && task != TASK_TOMBSTONE && event_filter_match(child_event))
 			perf_event_read_event(child_event, task);
 	}
 
