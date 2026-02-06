Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E1360732;
	Fri,  6 Feb 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374043; cv=none; b=qSazMv24/IDBM9tql8E1N1kSoS7wdpi6lj4JJQHRF0TJytnt5ZtYHPXVZE2ge91WNbGb7vIT36iJYJxUJSE3vTRvCstycacCM72uZldljmpxdmphE4IOUodBnf2GCGFK/gdsr8wBeOxLpQ+pfmbZQvjetO3qLhXLgBBBQo+HoZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374043; c=relaxed/simple;
	bh=cab6FQ2mhyuUcatDfegcxhNa/1H/qZjzVB+s8g26JN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm4DKOe02J9rzQ5XQW1MZsQc/6ED0MoVVOiL9zcKPjdzKDPtw7JIt3VViKaN0TFRR/aO6VVAWKJ/dxwRdEVX+pfdpiGWpe3AzIs1bd7FbvS1MvHX+oBJVaD1UA3wzX5YfwMLX1ILVFij27dby09KfS4v8tem+blIYCSV+W3futo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d8WzRMuP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8WzRMuP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5dP7svRle6SZlVj3cLr3sPHhuJoAU85mnf+ry832Kxs=; b=d8WzRMuPXaHqO/Cs8iRJgZ6adK
	EpVxsw46rVkc5KAB0lTfYGYLOZ53h4AxAmUGfoN6KCOjx9q9vlorbPWYl7Wiy0qUH7IXEXmUwOZmO
	kfEeuiX264Q8g3qju/NV3vqId2RHwY30iSWsdT4MpwQEMV2YS0k5C/KxHR5coAoGJczohwyfQq9gM
	qMwNgyZjFpVILvg/RX2Fm7VqkrShL2xQvY8HaVRp9de1sUkYKXYpaIPzIoa7XNGLtjR8VK/gH566w
	k3oTTdcR757cIkBorIAzc/XvFhoazci2ZdxKwgCcasSHxwNxb9OFinnIQXsh0kn6YN0fuSX9Aa6xD
	B988jRzA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voJ9r-00000003e3E-0Ho1;
	Fri, 06 Feb 2026 10:33:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0DC23030DB; Fri, 06 Feb 2026 11:33:49 +0100 (CET)
Date: Fri, 6 Feb 2026 11:33:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com>,
	acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KCSAN: data-race in perf_event_set_state /
 perf_mmap_rb
Message-ID: <20260206103349.GG1395416@noisy.programming.kicks-ass.net>
References: <69859a00.a00a0220.34fa92.0028.GAE@google.com>
 <CACT4Y+axrv7knEVcS_2BHoPgkrqfwKd0VmHVRk7eogjssfZ6jQ@mail.gmail.com>
 <20260206091838.GP1395266@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206091838.GP1395266@noisy.programming.kicks-ass.net>

On Fri, Feb 06, 2026 at 10:18:38AM +0100, Peter Zijlstra wrote:

> > Because `perf_mmap_rb()` does not hold the `perf_event_context` lock
> > (`ctx->lock`), which is the intended protection for these timing
> > fields, it races with the `event_sched_out()` path (which does hold
> > `ctx->lock`).
> > 
> > The race on `total_time_enabled` and `total_time_running` involves
> > non-atomic read-modify-write operations. If both threads read the same
> > old value of `total_time_enabled` before either writes back the
> > updated value, one of the updates (representing a chunk of time the
> > event was enabled) will be lost. Additionally, the race on
> > `event->tstamp` can lead to inconsistent state where the timestamp and
> > the total time counters are out of sync, causing further errors in
> > subsequent time calculations.
> 
> Yeah, fair enough. Let me go stare at that.

I ended up with the below. It boots and passes 'perf test' with lockdep
on. No further testing was done.

Can you throw this at the robot?

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5b5cb620499e..a5b724cb6b42 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1356,7 +1356,9 @@ static void put_ctx(struct perf_event_context *ctx)
  *	      perf_event_context::lock
  *	    mmap_lock
  *	      perf_event::mmap_mutex
+ *	        perf_buffer::event_lock
  *	        perf_buffer::aux_mutex
+ *	        perf_event_context::lock
  *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
@@ -1582,6 +1584,8 @@ static u64 perf_event_time(struct perf_event *event)
 	if (unlikely(!ctx))
 		return 0;
 
+	lockdep_assert_held(&ctx->lock);
+
 	if (is_cgroup_event(event))
 		return perf_cgroup_event_time(event);
 
@@ -6157,9 +6161,15 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
+	/*
+	 * Must disable PMU to stop the event from triggering during
+	 * perf_event_update_userpage().
+	 */
+	perf_pmu_disable(event->pmu);
 	(void)perf_event_read(event, false);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
+	perf_pmu_enable(event->pmu);
 }
 
 /* Assume it's not an event with inherit set. */
@@ -6504,15 +6514,9 @@ static int perf_event_index(struct perf_event *event)
 	return event->pmu->event_idx(event);
 }
 
-static void perf_event_init_userpage(struct perf_event *event)
+static void perf_event_init_userpage(struct perf_event *event, struct perf_buffer *rb)
 {
 	struct perf_event_mmap_page *userpg;
-	struct perf_buffer *rb;
-
-	rcu_read_lock();
-	rb = rcu_dereference(event->rb);
-	if (!rb)
-		goto unlock;
 
 	userpg = rb->user_page;
 
@@ -6521,9 +6525,6 @@ static void perf_event_init_userpage(struct perf_event *event)
 	userpg->size = offsetof(struct perf_event_mmap_page, __reserved);
 	userpg->data_offset = PAGE_SIZE;
 	userpg->data_size = perf_data_size(rb);
-
-unlock:
-	rcu_read_unlock();
 }
 
 void __weak arch_perf_update_userpage(
@@ -6536,17 +6537,11 @@ void __weak arch_perf_update_userpage(
  * the seqlock logic goes bad. We can not serialize this because the arch
  * code calls this from NMI context.
  */
-void perf_event_update_userpage(struct perf_event *event)
+static void __perf_event_update_userpage(struct perf_event *event, struct perf_buffer *rb)
 {
 	struct perf_event_mmap_page *userpg;
-	struct perf_buffer *rb;
 	u64 enabled, running, now;
 
-	rcu_read_lock();
-	rb = rcu_dereference(event->rb);
-	if (!rb)
-		goto unlock;
-
 	/*
 	 * compute total_time_enabled, total_time_running
 	 * based on snapshot values taken when the event
@@ -6582,7 +6577,16 @@ void perf_event_update_userpage(struct perf_event *event)
 	barrier();
 	++userpg->lock;
 	preempt_enable();
-unlock:
+}
+
+void perf_event_update_userpage(struct perf_event *event)
+{
+	struct perf_buffer *rb;
+
+	rcu_read_lock();
+	rb = rcu_dereference(event->rb);
+	if (rb)
+		__perf_event_update_userpage(event, rb);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);
@@ -6978,6 +6982,7 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
 static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			unsigned long nr_pages)
 {
+	struct perf_event_context *ctx = event->ctx;
 	long extra = 0, user_extra = nr_pages;
 	struct perf_buffer *rb;
 	int rb_flags = 0;
@@ -7032,11 +7037,19 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	rb->mmap_user = get_current_user();
 	rb->mmap_locked = extra;
 
-	ring_buffer_attach(event, rb);
+	scoped_guard (raw_spinlock_irq, &ctx->lock) {
+		ctx_time_update_event(ctx, event);
+		perf_event_update_time(event);
+	}
 
-	perf_event_update_time(event);
-	perf_event_init_userpage(event);
-	perf_event_update_userpage(event);
+	/*
+	 * Initialize before setting event->rb to ensure it cannot nest
+	 * if the event is already active.
+	 */
+	perf_event_init_userpage(event, rb);
+	__perf_event_update_userpage(event, rb);
+
+	ring_buffer_attach(event, rb);
 
 	perf_mmap_account(vma, user_extra, extra);
 	refcount_set(&event->mmap_count, 1);
