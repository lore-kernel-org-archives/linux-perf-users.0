Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C941A4E7B;
	Mon,  2 Sep 2024 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725313631; cv=none; b=Me2T2dxIeMWROiMp4MYmkVwcGPFJ3rc/WRxW6vODR4LgbnIP+ieSjzhKErgFuseMNpQm94R6889gmVpvga0P0ZjomIEh4iAV922d9w69qk3Gc0+aCXW74Gtbhuk2Sq02CvSYaEvTBHSoFK0Vqtklq725LaQz6UzJbqZSBLG1COQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725313631; c=relaxed/simple;
	bh=zetEN9If2cwKZdgnu7DkOrqaePIj2Flu8Zx7189rQAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqH7IEzojnaxnOm6Lfpk7epkMb8zdUTunWExKmTr2s7WkraN04SZJf8btPOtVFMqCm2gU4FYUeAUcpgEDJG4xIcHgrbaSTDvfJCC3BVntsZPCuPMLXhYLmVeUYPkapn3AQHgfPykQejgpCylVM0w+FgMgQ8kw5QlivmwX0uzMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCCXpoV1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCCXpoV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE39DC4CEC2;
	Mon,  2 Sep 2024 21:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725313631;
	bh=zetEN9If2cwKZdgnu7DkOrqaePIj2Flu8Zx7189rQAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCCXpoV1KqNEiiPH7XbTlc5mn9tgWEKN5FPaEx0knKKP61mznOVnSTMHDRn8A6F1w
	 3DZOsxkj0n1vMhzIzLDFeCGZVsJrkcwqwBMgCxYVWcI5QfYCrvbyfMJ4sYOjOy+BA3
	 VG6lcQECBegu0vZcDbHa6YfyCWALMac+zvPqD+8uCrcHg62i5VNCqjqyxfbnzpbQH5
	 n/WNRNmDsHfAorsO79itYYctA59IHgU+wliNC81zZDTldp35L3Yjo8oJdqQIH3FWPp
	 ZXdipdl2AkeVleKSS4AeERS/jm2jxWyM778BBwh0VGOwHOuyYFzorqxJ9zNCpbhQEE
	 /t3UnFe5Flgaw==
Date: Mon, 2 Sep 2024 23:47:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [bug report] perf: Fix event leak upon exec and file release
Message-ID: <ZtYyXG4fYbUdoBpk@pavilion.home>
References: <5cc313bc-c44d-4f6c-80ee-5a9fe9356f43@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cc313bc-c44d-4f6c-80ee-5a9fe9356f43@stanley.mountain>

Le Fri, Aug 23, 2024 at 04:43:33PM +0300, Dan Carpenter a écrit :
> Hello Frederic Weisbecker,
> 
> Commit 3a5465418f5f ("perf: Fix event leak upon exec and file
> release") from Jun 21, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	kernel/events/core.c:5301 perf_pending_task_sync()
> 	warn: sleeping in atomic context
> 
> kernel/events/core.c
>     5280 static void perf_pending_task_sync(struct perf_event *event)
>     5281 {
>     5282         struct callback_head *head = &event->pending_task;
>     5283 
>     5284         if (!event->pending_work)
>     5285                 return;
>     5286         /*
>     5287          * If the task is queued to the current task's queue, we
>     5288          * obviously can't wait for it to complete. Simply cancel it.
>     5289          */
>     5290         if (task_work_cancel(current, head)) {
>     5291                 event->pending_work = 0;
>     5292                 local_dec(&event->ctx->nr_no_switch_fast);
>     5293                 return;
>     5294         }
>     5295 
>     5296         /*
>     5297          * All accesses related to the event are within the same RCU section in
>     5298          * perf_pending_task(). The RCU grace period before the event is freed
>     5299          * will make sure all those accesses are complete by then.
>     5300          */
> --> 5301         rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
>                          ^^^^^^^^^^
> The commit adds a sleep
> 
>     5302 }
> 
> Smatch is complaining about four call trees which are holding a spinlock.
> 
> One:
> pl330_free_chan_resources() <- disables preempt
> -> pl330_release_channel()
>    -> _free_event()
>       -> perf_pending_task_sync()
> 
> Two and three:
> perf_remove_from_context() <- disables preempt
> __perf_event_exit_context() <- disables preempt
> -> __perf_remove_from_context()
>    -> perf_group_detach()
>       -> perf_put_aux_event()
>          -> put_event()
>             -> _free_event()
>                -> perf_pending_task_sync()
> 
> Four:
> perf_free_event() <- disables preempt
> -> perf_group_detach()
>    -> perf_put_aux_event()
>       -> put_event()
>          -> _free_event()
>             -> perf_pending_task_sync()
> 
> 
> This check tends to have more false positive when the call tree is long.  For
> example, maybe event->pending_work is always zero or something.  I've looked it
> over, but I'm a newbie to this code.

Ah right.

So one possible fix is to possibly let the task work do the last reference
decrement. This would mean that freeing children events can't be always assumed
by the parent.

The below (only built tested) would do it?

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 701549967c18..181e122c94e2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -789,7 +789,6 @@ struct perf_event {
 	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
-	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c6a720f41225..047cc8f32a2c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5277,35 +5277,12 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
-static void perf_pending_task_sync(struct perf_event *event)
-{
-	struct callback_head *head = &event->pending_task;
-
-	if (!event->pending_work)
-		return;
-	/*
-	 * If the task is queued to the current task's queue, we
-	 * obviously can't wait for it to complete. Simply cancel it.
-	 */
-	if (task_work_cancel(current, head)) {
-		event->pending_work = 0;
-		local_dec(&event->ctx->nr_no_switch_fast);
-		return;
-	}
-
-	/*
-	 * All accesses related to the event are within the same RCU section in
-	 * perf_pending_task(). The RCU grace period before the event is freed
-	 * will make sure all those accesses are complete by then.
-	 */
-	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
-}
-
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
-	perf_pending_task_sync(event);
+
+	WARN_ON_ONCE(event->pending_work);
 
 	unaccount_event(event);
 
@@ -5326,6 +5303,10 @@ static void _free_event(struct perf_event *event)
 	if (is_cgroup_event(event))
 		perf_detach_cgroup(event);
 
+	/*
+	 * Parent might have been freed, only use that possibly stale
+	 * reference to check if the event is a child.
+	 */
 	if (!event->parent) {
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
 			put_callchain_buffers();
@@ -5547,7 +5528,8 @@ int perf_event_release_kernel(struct perf_event *event)
 		void *var = &child->ctx->refcount;
 
 		list_del(&child->child_list);
-		free_event(child);
+		/* On non-failed fork case, child might have a pending perf_pending_task() */
+		put_event(child);
 
 		/*
 		 * Wake any perf_event_free_task() waiting for this event to be
@@ -6938,12 +6920,6 @@ static void perf_pending_task(struct callback_head *head)
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
-	/*
-	 * All accesses to the event must belong to the same implicit RCU read-side
-	 * critical section as the ->pending_work reset. See comment in
-	 * perf_pending_task_sync().
-	 */
-	rcu_read_lock();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -6954,9 +6930,8 @@ static void perf_pending_task(struct callback_head *head)
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_no_switch_fast);
-		rcuwait_wake_up(&event->pending_work_wait);
+		put_event(event);
 	}
-	rcu_read_unlock();
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
@@ -9831,6 +9806,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_no_switch_fast);
+			atomic_long_inc(&event->refcount);
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
@@ -12074,7 +12050,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
-	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
@@ -13227,7 +13202,8 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
-		free_event(event);
+		/* Child might have a perf_pending_task(), free_event() can't be called directly */
+		put_event(event);
 		put_event(parent_event);
 		return;
 	}



> 
> regards,
> dan carpenter
