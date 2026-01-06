Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC0212549;
	Tue,  6 Jan 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738882; cv=none; b=AeEIjrw91pjSA1WRKoXGAFXJ10Jv+2BDMhWGzk8DU4c3D/T4EsmNPmvhy9I6Tfq/AEjDL7yaW5Mp1+yD3g5SBi++tWVbVSdGyAg1vBr0vxx0nEBh8BxzaJw+VDYAR/BkQklS/ZzOLeep/sjGpkw8ip71oZAzQSOzDxAmEj0pbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738882; c=relaxed/simple;
	bh=Bez7zgz2PtbURZtG34Qpw8NGRAzWkKw0cpzXrj9gWog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjXpQuSRKMGBoFdM/C8k/hKPrBOHAzN8ehiiLJah/GTCkLLBA7aWYORrBbPWqPDtlD6UJHStPQMLw/yulTX8cm4ZS8EXunu1d4jJsmPMKZ+BGCtGkXf9HG4wUqaxv/sX6GbAAnV5+rSXUkRspAcPzmGeSj77gzcILT+a/7t/6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT52Vzat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT52Vzat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C72C116C6;
	Tue,  6 Jan 2026 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767738882;
	bh=Bez7zgz2PtbURZtG34Qpw8NGRAzWkKw0cpzXrj9gWog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tT52Vzaty3yfaeC7r25SVY/rmDPrZ0uDQYveGCSRdA3qsOK/CnY6tFfGevgl4HGA5
	 WwpVleNWh9uhD5aZeWtpV7kW9VkDqCSwm+Bl1sJE4hDpzA9EaN7GZNpjeMzKu+jUaH
	 gWNENs7WqqDfXjjSwuMcMQkM6+AByjPvXY38P0y0l0RGeuPFB1OYUAPGIc32PFApIe
	 W158BoTf1qTOugIksu/+PLyMZVg1+SHHiZzgAGC4yJpG8zGg/cQYex26EC1yczo53t
	 zOMiibCn8pd+gVg923v1eSXYLWybZqP3NOojYGACBQ1RrTa81hmWeQpOQ4ql1c/Op2
	 AlOagoYpv9GWg==
Date: Tue, 6 Jan 2026 14:34:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] perf/core: Task stuck on global_ctx_data_rwsem
Message-ID: <aV2OACqA5OpmoeF0@google.com>
References: <aUnVfxDtLNUDJM_v@google.com>
 <aUnWFc_mILUDFavi@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUnWFc_mILUDFavi@google.com>

Hello,

On Mon, Dec 22, 2025 at 03:36:53PM -0800, Namhyung Kim wrote:
> On Mon, Dec 22, 2025 at 03:34:23PM -0800, Namhyung Kim wrote:
> > Hello,
> > 
> > I got a report that a task is stuck in perf_event_exit_task() waiting
> > for global_ctx_data_rwsem.  On large systems, it'd have performance
> > issues when it grabs the lock to iterate all threads in the system to
> > allocate the context data.  And it'd block task exit path which is
> > problematic especially under memory pressure.
> > 
> >   perf_event_open
> >     perf_event_alloc
> >       attach_perf_ctx_data
> >         attach_global_ctx_data
> >           percpu_down_write (global_ctx_data_rwsem)
> >             for_each_process_thread
> >               alloc_task_ctx_data
> >                                                do_exit
> >                                                  perf_event_exit_task
> >                                                    percpu_down_read (global_ctx_data_rwsem)
> > 
> > I think attach_global_ctx_data() should skip tasks with PF_EXITING and
> > it'd be nice if perf_event_exit_task() could release the ctx_data
> > unconditionally.  But I'm not sure how to synchronize them properly.
> > 
> > Any thoughts?

I'm curious if this makes any sense..  I feel like it needs to check the
flag again before allocation.

Thanks,
Namhyung


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 376fb07d869b8b50..2a8847e95d7eb698 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5469,6 +5469,8 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 	/* Allocate everything */
 	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
+			if (p->flags & PF_EXITING)
+				continue;
 			cd = rcu_dereference(p->perf_ctx_data);
 			if (cd && !cd->global) {
 				cd->global = 1;
@@ -14563,7 +14565,6 @@ void perf_event_exit_task(struct task_struct *task)
 	/*
 	 * Detach the perf_ctx_data for the system-wide event.
 	 */
-	guard(percpu_read)(&global_ctx_data_rwsem);
 	detach_task_ctx_data(task);
 }
 
