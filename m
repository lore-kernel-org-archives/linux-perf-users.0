Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13071C4A20;
	Thu,  5 Jun 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121713; cv=none; b=hilgr9vfM5kbE0VI7hfN1zOUGC6hpoJHArn0zbKOFK28Z9MjRemrux8JL3r3vjuBtqTdcvvVx2w64rkT5XDl1+S6kAP43oN9cbdMLKhfwkZ0aimu974qrY955F5GoqJFsvbQMRjSq6jo/5MF1mdCCbGIvAl65l7IXBjG0DzICOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121713; c=relaxed/simple;
	bh=HMRu+i1hsgiHiaaZYlY71LYjWVULN4Wiwey34tQDl6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+BMlR5HyuyihQGZAkhczar1+uMTIhqRsqQdsBIy4EChiPoHbrH06hcHe+TBhaabjNOOpiQI3/lcI1I6r6FxLzXXX0HqBg4d6/fUllytx8MNnfrSvJ1Lh+AOYjjMmu3ED4+m1H4I1XTeJIzA+9S1490bpG9IPkdMrey1tz3APKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i6jfUp6K; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6jfUp6K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nzcwZQikZQA4ZQSmzmP28ryvumzddlmv0QFfHqKkX0Y=; b=i6jfUp6KuU2q9F5MtYoLfKE9VV
	fLpAG94zGRz6tk0lkdvyxisLFjwL2lTI9vM9btp51VYjNIio2611hFZB9FJwX0GN89jPuZ75xCnJt
	hwURE0ciIeD0cwyfF4R3rOBEg76Vkw7R+PZvuv7o0D8gPsVSgYhTUaMLxfTitDlot9k3+a1cqJuHN
	R0jMzFzXlFFWtymdrBJuJJIaNPsP+E2jW7ycBcksrWZQz9M5i1nqRc2Zv3Hx6YlfJ/8iCvR1INWxP
	/aIrEdLQ+W/LGnJuIkHAz/HvnqWFvIwERRaKRa8DlJcYWLZdyPQBIIjoSRL5eOKYNyVn1oIANB2tx
	Yuu8Fn6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN8SG-000000019SB-0Nah;
	Thu, 05 Jun 2025 11:08:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1DDDE3005AF; Thu,  5 Jun 2025 13:08:15 +0200 (CEST)
Date: Thu, 5 Jun 2025 13:08:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Baisheng Gao <baisheng.gao@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com
Subject: Re: [PATCH] perf/core: Handling the race between exit_mmap and perf
 sample
Message-ID: <20250605110815.GQ39944@noisy.programming.kicks-ass.net>
References: <20250424025429.10942-1-baisheng.gao@unisoc.com>
 <aEBSt2LN7YhxYX7N@J2N7QTR9R3>
 <20250604142437.GM38114@noisy.programming.kicks-ass.net>
 <aEBeRfScZKD-7h5u@J2N7QTR9R3>
 <20250604153219.GJ39944@noisy.programming.kicks-ass.net>
 <aEBvd8fIdjlTV53j@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEBvd8fIdjlTV53j@J2N7QTR9R3>

On Wed, Jun 04, 2025 at 05:08:23PM +0100, Mark Rutland wrote:
> That looks good to me!

I now haz the below patch.

---
Subject: perf: Fix sample vs do_exit()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jun 5 12:31:45 CEST 2025

Baisheng Gao reported an ARM64 crash, which Mark decoded as being a
synchronous external abort -- most likely due to trying to access
MMIO in bad ways.

The crash further shows perf trying to do a user stack sample while in
exit_mmap()'s tlb_finish_mmu() -- i.e. while tearing down the address
space it is trying to access.

It turns out that we stop perf after we tear down the userspace mm; a
receipie for disaster, since perf likes to access userspace for
various reasons.

Flip this order by moving up where we stop perf in do_exit().

Additionally, harden PERF_SAMPLE_CALLCHAIN and PERF_SAMPLE_STACK_USER
to abort when the current task does not have an mm (exit_mm() makes
sure to set current->mm = NULL; before commencing with the actual
teardown). Such that CPU wide events don't trip on this same problem.

Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
Reported-by: Baisheng Gao <baisheng.gao@unisoc.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    7 +++++++
 kernel/exit.c        |   17 +++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7439,6 +7439,10 @@ perf_sample_ustack_size(u16 stack_size,
 	if (!regs)
 		return 0;
 
+	/* No mm, no stack, no dump. */
+	if (!current->mm)
+		return 0;
+
 	/*
 	 * Check if we fit in with the requested stack size into the:
 	 * - TASK_SIZE
@@ -8150,6 +8154,9 @@ perf_callchain(struct perf_event *event,
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
+	if (!current->mm)
+		user = false;
+
 	if (!kernel && !user)
 		return &__empty_callchain;
 
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -944,6 +944,15 @@ void __noreturn do_exit(long code)
 	taskstats_exit(tsk, group_dead);
 	trace_sched_process_exit(tsk, group_dead);
 
+	/*
+	 * Since sampling can touch ->mm, make sure to stop everything before we
+	 * tear it down.
+	 *
+	 * Also flushes inherited counters to the parent - before the parent
+	 * gets woken up by child-exit notifications.
+	 */
+	perf_event_exit_task(tsk);
+
 	exit_mm();
 
 	if (group_dead)
@@ -959,14 +968,6 @@ void __noreturn do_exit(long code)
 	exit_task_work(tsk);
 	exit_thread(tsk);
 
-	/*
-	 * Flush inherited counters to the parent - before the parent
-	 * gets woken up by child-exit notifications.
-	 *
-	 * because of cgroup mode, must be called before cgroup_exit()
-	 */
-	perf_event_exit_task(tsk);
-
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
 
