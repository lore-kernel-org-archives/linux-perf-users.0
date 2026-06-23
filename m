Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EA2DF15C;
	Tue, 23 Jun 2026 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206074; cv=none; b=sO7Vgnm2X0waNo6+VOg42+qK8CSuzQ/qjLpIntFMRnV6ocIhVCFLWn7wpzCD8pEyaAni49UDCmfODV7h3X1GC5TrIxASLQrB0tfjVefeydjXmiFK3WBqoqUkKaDGhs9vdBnKQ40vlO/zSU07jCb8J37n8TV+gMuGVh74+uQX4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206074; c=relaxed/simple;
	bh=jHJ3KLwxvZmB4HFdm0HSHIc+rpbQiljw5BUPOSCMTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWhoQyJQneAJ4fDNcWOzYGz0GTQH1OGk/WWs+EKqDmQWDwDge3CTCkET4rNbtzjTE4j8t2JciY6adBTO9AhF/32Huguhs3o853+9aLK1UlJT/yYcPjkv1XLLRhFrQaBCE++VqtIrGGKIogWUHiLGVlcqnpO/1V28OvJ88IzBKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SFSQxmpv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFSQxmpv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qrunmkJq/nMdEnRjBjzsPKNoNgj4VzUvmPqerlYp6uk=; b=SFSQxmpvaZ8tB5ktL1BBjkWVxi
	zw26ApeROhNfSh55xCkjtaO5YJo0SF1opRZeUUG/HNv/AAfzq02AtoCIe6jRuOhMyYD+a0PuyL6rD
	8/n5ihu9fYWEklNClgxfSnqlTUrCi95ZymEKHJJpCDpj7YCZ/Bx1yin4rC144HpANUCWe8jGFUl6C
	6LDWUW4YtAKRdU6l9rcOs+eGd3nMUvv2Sd/vbYCwqavJ7FXrotHJdUi9P0NO+Serxg3fYbBglrKuc
	rWL2MekI+8OHPQGpWSf20kcEpB42ArNFASTHvEBge6Rqw9xDRHMGjbrqIOj7AGmXF5+/n5cIBpE14
	jFWz6d5w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxD9-00000005scO-1t7V;
	Tue, 23 Jun 2026 09:14:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B303E30324A; Tue, 23 Jun 2026 11:14:26 +0200 (CEST)
Date: Tue, 23 Jun 2026 11:14:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@arm.com
Subject: [RFC][PATCH v2] perf: Fix perf_addr_filters_afjust()
Message-ID: <20260623091426.GF49529@noisy.programming.kicks-ass.net>
References: <20260622123245.GS48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622123245.GS48970@noisy.programming.kicks-ass.net>


 - adjust lock order; since perf_event_addr_filters_apply() takes mmap_lock
   inside child_mutex.

 - note that perf_event_mmap() is called by the thread doing the
   mmap()/mprotect()/.. operation, but not the other threads in the address
   space that might have inherited the same event.

 - have perf_addr_filters_adjust() iterate the child_list to find all other
   events for tasks that have the same mm.

 - since this can now adjust addr_filter_ranges[] for remote events, make sure
   to adjust things while holding ctx->lock; local_irq_disable() as implied by
   the ifh->lock is no longer suffient to serialize against event scheduling.

 - per the previous locking order; perf_event_mmap(), which is called holding
   mmap_lock, cannot take child_mutex, as such, make child_list RCU protected
   and iterate under RCU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
addressed sashiko feedback

 kernel/events/core.c |   72 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 19 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1454,10 +1454,11 @@ static void put_ctx(struct perf_event_co
  *	  perf_event_context::mutex
  *	    perf_event::child_mutex;
  *	      perf_event_context::lock
- *	    mmap_lock
- *	      perf_event::mmap_mutex
- *	        perf_buffer::aux_mutex
- *	      perf_addr_filters_head::lock
+ *	        perf_addr_filters_head::lock
+ *	      mmap_lock
+ *	        perf_event::mmap_mutex
+ *	          perf_buffer::aux_mutex
+ *	        perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
  *      pmus_lock
@@ -2429,7 +2430,7 @@ static void perf_child_detach(struct per
 	lockdep_assert_held(&parent_event->child_mutex);
 	 */
 
-	list_del_init(&event->child_list);
+	list_del_rcu(&event->child_list);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -9902,21 +9903,15 @@ static bool perf_addr_filter_vma_adjust(
 	return true;
 }
 
-static void __perf_addr_filters_adjust(struct perf_event *event, void *data)
+static int __perf_event_addr_filters_adjust(struct perf_event *event,
+					    struct vm_area_struct *vma)
 {
 	struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
-	struct vm_area_struct *vma = data;
-	struct perf_addr_filter *filter;
 	unsigned int restart = 0, count = 0;
-	unsigned long flags;
-
-	if (!has_addr_filter(event))
-		return;
+	struct perf_addr_filter *filter;
 
-	if (!vma->vm_file)
-		return;
+	guard(raw_spinlock)(&ifh->lock);
 
-	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
 		if (perf_addr_filter_vma_adjust(filter, vma,
 						&event->addr_filter_ranges[count]))
@@ -9927,12 +9922,52 @@ static void __perf_addr_filters_adjust(s
 
 	if (restart)
 		event->addr_filters_gen++;
-	raw_spin_unlock_irqrestore(&ifh->lock, flags);
 
+	return restart;
+}
+
+static void perf_event_addr_filters_adjust(struct perf_event *event,
+					   struct vm_area_struct *vma)
+{
+	struct perf_event_context *ctx;
+	struct task_struct *task;
+	int restart = 0;
+
+again:
+	ctx = READ_ONCE(event->ctx);
+	scoped_guard (raw_spinlock_irqsave, &ctx->lock) {
+		if (event->ctx != ctx)
+			goto again;
+
+		task = ctx->task;
+		if (!task || task == TASK_TOMBSTONE)
+			continue;
+
+		if (vma->vm_mm != task->mm)
+			continue;
+
+		restart = __perf_event_addr_filters_adjust(event, vma);
+	}
 	if (restart)
 		perf_event_stop(event, 1);
 }
 
+static void __perf_addr_filters_adjust(struct perf_event *event, void *data)
+{
+	struct perf_event *child, *parent = event->parent ?: event;
+	struct vm_area_struct *vma = data;
+
+	if (!has_addr_filter(event))
+		return;
+
+	if (!vma->vm_file)
+		return;
+
+	perf_event_addr_filters_adjust(parent, vma);
+	list_for_each_entry_rcu(child, &parent->child_list, child_list)
+		perf_event_addr_filters_adjust(child, vma);
+}
+
 /*
  * Adjust all task's events' filters to the new vma
  */
@@ -9947,11 +9982,10 @@ static void perf_addr_filters_adjust(str
 	if (!(vma->vm_flags & VM_EXEC))
 		return;
 
-	rcu_read_lock();
+	guard(rcu)();
 	ctx = rcu_dereference(current->perf_event_ctxp);
 	if (ctx)
 		perf_iterate_ctx(ctx, __perf_addr_filters_adjust, vma, true);
-	rcu_read_unlock();
 }
 
 void perf_event_mmap(struct vm_area_struct *vma)
@@ -14880,7 +14914,7 @@ inherit_event(struct perf_event *parent_
 	/*
 	 * Link this into the parent event's child list
 	 */
-	list_add_tail(&child_event->child_list, &parent_event->child_list);
+	list_add_tail_rcu(&child_event->child_list, &parent_event->child_list);
 	mutex_unlock(&parent_event->child_mutex);
 
 	return child_event;
