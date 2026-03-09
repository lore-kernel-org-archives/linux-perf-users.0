Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287335958;
	Mon,  9 Mar 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063458; cv=none; b=McwZmQdtN22i/4Ssh5H6QHQbP+FThK7Y2LweUkszT+LKJHtIwoSEmta4nJEiD+ignmSobdJ0+8xMJiBbcfNlrbPXdZq3z8emBkVC2ppey62zgYoqGyPZCl5PwlaHH866RWTnN9ZHZ16XtdsVNySvi19iqLAox8G9ZTbbS0Sgri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063458; c=relaxed/simple;
	bh=181AFqySLRnIhAAf1iKIUCgnCzuCJ96AMmOKu3+9vMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4R3rt1xdSyxaxRU8dmQyhFwxrT3yaw8HB3/1oPvwEoptDITrFRdFaMqCThNKXtpz6vGmGT/oE9ld1k1hvtHtN4wkhyPHLbFbC9iyZrNBB21b+8nQtNHLzr8EuxVKhfwJseLs0VEQFTJcxY/NSqQkaVQcyW9t/WCy7Q0Ln4h1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RXjOZ1fq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXjOZ1fq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ufcok373yNwLXFp2rCpzw/LKuLx7dgd3kF5Pw+wIfuc=; b=RXjOZ1fqtElXmacMpnBP+CnJmL
	vaAbc6Hn9216BvnHB1sVwISwKodkgwMSvKo6gfBO2DHeKUNT/3ACcdr2SwOjxWOw1egBj1DFTmXhF
	lleqO+T5L5ph9zdBgd/BFBt6o6Wwx1jVU7z1RGWX1O0JX4HxvCj26HkXCe6sCZnoVksq+fqqtimjz
	byzKg7eLaOVDO/u+llc2MYi7xmx70wrqWx2PdLYQ78vgYwjZ4YpOwk+w9Mb9S9tDFOccgJZi8T4xk
	G/i7xs04ImbsZZE4+ZiZp6yMj92870HqCtYch2iS78r175xlo1li58p3JEVeKyQ8WQEKnD9bnTh4G
	/bkZGuIw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzanV-0000000CGEP-0QTt;
	Mon, 09 Mar 2026 13:37:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91CEC300FB6; Mon, 09 Mar 2026 14:37:13 +0100 (CET)
Date: Mon, 9 Mar 2026 14:37:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oliver Rosenberg <olrose55@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf_events: fix array-index-out-of-bounds in x86_pmu_del
Message-ID: <20260309133713.GB606826@noisy.programming.kicks-ass.net>
References: <20260309014215.3871484-1-olrose55@gmail.com>
 <20260309120543.GA606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309120543.GA606826@noisy.programming.kicks-ass.net>

On Mon, Mar 09, 2026 at 01:05:43PM +0100, Peter Zijlstra wrote:
> Now, let me go audit the code to see if this same problem exists in more
> shapes...

I've ended up with the below.

---
Subject: perf: Make sure to use pmu_ctx->pmu for groups
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Mar 9 13:55:46 CET 2026

Oliver reported that x86_pmu_del() ended up doing an out-of-bound memory access
when group_sched_in() fails and needs to roll back.

This *should* be handled by the transaction callbacks, but he found that when
the group leader is a software event, the transaction handlers of the wrong PMU
are used. Despite the move_group case in perf_event_open() and group_sched_in()
using pmu_ctx->pmu.

Turns out, inherit uses event->pmu to clone the events, effectively undoing the
move_group case for all inherited contexts. Fix this by also making inherit use
pmu_ctx->pmu, ensuring all inherited counters end up in the same pmu context.

Similarly, __perf_event_read() should use equally use pmu_ctx->pmu for the
group case.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Reported-by: Oliver Rosenberg <olrose55@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4813,7 +4813,7 @@ static void __perf_event_read(void *info
 	struct perf_event *sub, *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
-	struct pmu *pmu = event->pmu;
+	struct pmu *pmu;
 
 	/*
 	 * If this is a task context, we need to check whether it is
@@ -4825,7 +4825,7 @@ static void __perf_event_read(void *info
 	if (ctx->task && cpuctx->task_ctx != ctx)
 		return;
 
-	raw_spin_lock(&ctx->lock);
+	guard(raw_spinlock)(&ctx->lock);
 	ctx_time_update_event(ctx, event);
 
 	perf_event_update_time(event);
@@ -4833,14 +4833,15 @@ static void __perf_event_read(void *info
 		perf_event_update_sibling_time(event);
 
 	if (event->state != PERF_EVENT_STATE_ACTIVE)
-		goto unlock;
+		return;
 
 	if (!data->group) {
 		pmu->read(event);
 		data->ret = 0;
-		goto unlock;
+		return;
 	}
 
+	pmu = event->pmu_ctx->pmu;
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
 
 	pmu->read(event);
@@ -4849,9 +4850,6 @@ static void __perf_event_read(void *info
 		perf_pmu_read(sub);
 
 	data->ret = pmu->commit_txn(pmu);
-
-unlock:
-	raw_spin_unlock(&ctx->lock);
 }
 
 static inline u64 perf_event_count(struct perf_event *event, bool self)
@@ -14743,7 +14741,7 @@ inherit_event(struct perf_event *parent_
 	get_ctx(child_ctx);
 	child_event->ctx = child_ctx;
 
-	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
+	pmu_ctx = find_get_pmu_context(parent_event->pmu_ctx->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
 		return ERR_CAST(pmu_ctx);
