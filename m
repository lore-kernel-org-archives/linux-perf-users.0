Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123C23373D;
	Wed,  7 Jan 2026 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824915; cv=none; b=kcXkoL5BJY+r5BqAJnEq7FmH0YzDWYw8+lvtHWkjdZFG8/PS+Cde/kRQrW385vREoU+affrtzLBGL/hSf3QqLhBTw+otEyC3TGzMV7TAI1WPrM9rYF4r/85k5s8oI667vtHD6XEkpAoijxyyIKMDoMHYPMVmF+iiliwI0ArU5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824915; c=relaxed/simple;
	bh=PimGvbG5d0u5yDrL3sfsK25xon0Xmx3qpJd4Hy4Z0UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTcyaFonakF3hwmzTL1ttBp9ugli5HVsBkvEg1Gb8Nt6jDtyKDEzFrY4GWIl111qFO8mjFm/Vxn2hEwhUpE38C8LMKjhphQVJdWiBfd/r9HfdHXsmC6nqWc08pndoGgLWbHWnJxe4Jb7iuO8bTqzxTmLpAQKyqnGpOuZBTctBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mfCFsY55; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mfCFsY55"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JCLex8bTXbqt0z3LTkMl1q3RkJu8DhZlqqkvOAey+YM=; b=mfCFsY55PI8b2+r72ZN205jyto
	wR2WSw1t6l2d+aeHpkmFOXW5YkPHzLcCFVkZ4cwy8g9QzW1GHWZ3LBNWLoHZHZOJbmZa5fj4uitV4
	39MOE5HYMAs0L5/jMtQd/aFsyHFFgqiYs2C/j0qfIQEM/EJcV6o9d4W/QDt9ymBe8Usetw8k2q9e4
	/lseB06zLuCf5JZ23/KnBSOFRFfgJ1DJ9CbFG81OXAGs2ND8vBihj0Jzugg7dctu+EJuQRHiuq6Ji
	QU+TLMEPzn5skKf4FH32F37J788lZESI/oUlh5Wdw/e83tkDDqMR58EnhgdP21GcCJC+PoAqggayf
	rug/xK6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdc0v-0000000E1mN-1Uow;
	Wed, 07 Jan 2026 22:28:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 193DB30057E; Wed, 07 Jan 2026 23:28:24 +0100 (CET)
Date: Wed, 7 Jan 2026 23:28:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] perf/core: Task stuck on global_ctx_data_rwsem
Message-ID: <20260107222823.GC694817@noisy.programming.kicks-ass.net>
References: <aUnVfxDtLNUDJM_v@google.com>
 <aUnWFc_mILUDFavi@google.com>
 <aV2OACqA5OpmoeF0@google.com>
 <20260107091652.GB3707891@noisy.programming.kicks-ass.net>
 <aV6toexK5LMc1MNY@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV6toexK5LMc1MNY@google.com>

On Wed, Jan 07, 2026 at 11:01:53AM -0800, Namhyung Kim wrote:

> > But yes, I suppose this can do. The question is however, how do you get
> > into this predicament to begin with? Are you creating and destroying a
> > lot of global LBR events or something?
> 
> I think it's just because there are too many tasks in the system like
> O(100K).  And any thread going to exit needs to wait for
> attach_global_ctx_data() to finish the iteration over every task.

OMG, so many tasks ...

> > Would it make sense to delay detach_global_ctx_data() for a second or
> > so? That is, what is your event creation pattern?
> 
> I don't think it has a special pattern, but I'm curious how we can
> handle a race like below.
> 
>   attach_global_ctx_data
>     check p->flags & PF_EXITING
>                                               do_exit
>     (preemption)                                set PF_EXITING
>                                                 detach_task_ctx_data()
>     check p->perf_ctx_data
>     attach_task_ctx_data()   ---> memory leak

Oh right. Something like so perhaps?

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3c2a491200c6..e5e716420eb3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5421,9 +5421,19 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
 		return -ENOMEM;
 
 	for (;;) {
-		if (try_cmpxchg((struct perf_ctx_data **)&task->perf_ctx_data, &old, cd)) {
+		if (try_cmpxchg(&task->perf_ctx_data, &old, cd)) {
 			if (old)
 				perf_free_ctx_data_rcu(old);
+			/*
+			 * try_cmpxchg() pairs with try_cmpxchg() from
+			 * detach_task_ctx_data() such that
+			 * if we race with perf_event_exit_task(), we must
+			 * observe PF_EXITING.
+			 */
+			if (task->flags & PF_EXITING) {
+				task->perf_ctx_data = NULL;
+				perf_free_ctx_data_rcu(cd);
+			}
 			return 0;
 		}
 
@@ -5469,6 +5479,8 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 	/* Allocate everything */
 	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
+			if (p->flags & PF_EXITING)
+				continue;
 			cd = rcu_dereference(p->perf_ctx_data);
 			if (cd && !cd->global) {
 				cd->global = 1;
@@ -14568,8 +14580,11 @@ void perf_event_exit_task(struct task_struct *task)
 
 	/*
 	 * Detach the perf_ctx_data for the system-wide event.
+	 *
+	 * Done without holding global_ctx_data_rwsem; typically
+	 * attach_global_ctx_data() will skip over this task, but otherwise
+	 * attach_task_ctx_data() will observe PF_EXITING.
 	 */
-	guard(percpu_read)(&global_ctx_data_rwsem);
 	detach_task_ctx_data(task);
 }
 
