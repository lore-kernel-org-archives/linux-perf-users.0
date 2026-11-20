Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196988;
	b=oO1OQQHZo8SLRTcL7AQ+jGa2Ej+nt4IytkEg/FXgz6aDdf/h3Kxdjoch0laVfL10i3o0
	 WTkmxgN7iXiqnQqjGcXwDY/CRMvqNy9ULTy95asQ+1fgF/7e90UyscJgma7ZVvcCcJ5s7
	 YMtYqLRgAEVn/Wzi42H6eL+bdEoE1JGa+HUPce302AmwiwLNxgOi563ww5+Xtss0lnzFj
	 TmWFFBwz8lVuEuY/NkodtgN6S+GXYuxsHzokAAby4TgLVlG+ZbbCM5vZGAjf1HHTDGXyP
	 SQtF9EuprDRLjfA6VsPcKUx/e+XcV2c8ZSD7wb+Np80/GTzzuFt5KYWExI+xzV6kOKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196988;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=X9sTiAwexVAObjjO0yopQUmoE9pS2g/a0zw7hrGwxqQ=;
	b=lKgFnMKqCc6zFTEsBuP3+Ti6aE7wrVxy2wd3bgXi23Q70luR1TNNtSrbGp8AInpRDiQr
	 KuBBNaCv2vi+ZuIjEhfDw7PVvRK8Fddfn7BFFwv8t8yig+lO5hxVh8DCNJjC0m5aaxE4G
	 js+3DfzecKJ1pbmzc6BPEYeyDFg5WxqaOArcm7Wi51b3EelrKG7M9wjRQ3vjLb08TBpzA
	 M5GmxJO4QiE4d0QnLWlUApxGcYpfid+vw06ldO95Qj1929rnx8XLluKmPkz0QrMOq6j5t
	 8UIZo1fmCqEYy9xzNWsv0wZXXJ8CGMC8t27yWBcUm/GN5a8XDM6REhPxE+sbMk3EIeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fBrceXMZ;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B860A2602;
	Fri, 20 Nov 2026 17:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A40B860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fBrceXMZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X9sTiAwexVAObjjO0yopQUmoE9pS2g/a0zw7hrGwxqQ=; b=fBrceXMZxLu9dkavRu91bKqobn
	c4SljQl4pMq13dyCPr9lx7lxXwJm/QXcSoOKnzElYV9n6QSbxnbtOGlnm6sWhbOaUNGpFYk6ZoezL
	2Xaz6drKtpYt7jZwTcMekvYp9TSyGVxtvH1zZmtm7cXe6bKWvmuZ/IO/N6YbhLbWv9Kt3lSc54MRG
	MCr9JDpBJ5et6AuT2sS/IXj4JnhDzBJsOPApp2VImVdRyDiXAQD+5uHGLGTcATvIM6laMevevRAOD
	GNMb3IXTv55HWVqpnSslFr3E5TffDwsRjaH6aStkcOTopQ6CUc+MRMHeUdYbM1CJxoGdgr5kf1gT3
	Ic3/M85g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSk3-00000009AP0-0w0l;
	Fri, 20 Nov 2026 17:49:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BAC36301185; Fri, 20 Nov 2026 18:49:42 +0100 (CET)
Date: Fri, 20 Nov 2026 18:49:42 +0100
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
Message-ID: <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
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
In-Reply-To: <20261120172831.5XwELZY5@linutronix.de>

On Fri, Nov 20, 2026 at 06:28:31PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-20 17:26:04 [+0100], Peter Zijlstra wrote:
> > Also, sending signals on software events seems utterly insane. But I
> > don't support we can go limit that now :-(
> 
> Tengda: Is this an actual valid use case that you have here or did an AI
> figured out that this broken?

I *think* the below is sufficient.

 - sigtrap implies a per-task event; task_work is local to the current
   task (+- the context switch thing from 2/2).

 - task_work_run() is written such that the work handler can do
   task_work_add(), therefore the early clear in the handler doesn't
   matter.

And while recursive software events are tedious, I think the below fix
is simple enough to not worry about too much.

---
Subject: perf/core: Prevent duplicate sigtrap task work enqueue
From: Tengda Wu <wutengda@huaweicloud.com>
Date: Thu, 19 Nov 2026 09:51:00 +0000

From: Tengda Wu <wutengda@huaweicloud.com>

The sigtrap handling in __perf_event_overflow() checks
event->pending_work before calling task_work_add(), but only sets
pending_work after the task work has been queued.

This leaves a window where an NMI can interrupt task_work_add() and
re-enter __perf_event_overflow() for the same (software/tracepoint)
event. Since pending_work is still zero, the nested invocation can
enqueue the same pending_task again.

The re-entrant call path looks like this:

  __perf_event_overflow()
    task_work_add()
      <NMI>
        __perf_event_overflow()
          task_work_add()

The nested invocation may enqueue pending_task before the outer
invocation does. When the outer invocation resumes, it inserts the
same task work entry again, potentially creating a cycle in the task
work list.

As a result, perf_pending_task() may be executed repeatedly, leading
to unbalanced event reference counting.

Fix this by atomically claiming pending_work with cmpxchg_local()
before calling task_work_add(). This ensures that only one invocation
can enqueue the task work, even when another overflow occurs
re-entrantly from an NMI.

Notably: sigtrap events must be per-task, meaning that the there is no
concurrency, only re-entrancy.

[peterz: clarify and rewrite]
Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10950,16 +10950,22 @@ static int __perf_event_overflow(struct
 
 		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
 
-		if (!event->pending_work &&
-		    !task_work_add(current, &event->pending_task, notify_mode)) {
-			event->pending_work = pending_id;
-			local_inc(&event->ctx->nr_no_switch_fast);
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-
-			event->pending_addr = 0;
-			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
-				event->pending_addr = data->addr;
+		/*
+		 * Software events can nest and attempt this recursively;
+		 * claim the pending_work before task_work_add() recurses.
+		 */
+		if (cmpxchg_local(&event->pending_work, 0, 1) == 0) {
+			if (!task_work_add(current, &event->pending_task, notify_mode)) {
+				event->pending_work = pending_id;
+				local_inc(&event->ctx->nr_no_switch_fast);
+				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 
+				event->pending_addr = 0;
+				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
+					event->pending_addr = data->addr;
+			} else {
+				event->pending_work = 0;
+			}
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
