Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA432746C;
	Sun, 17 Aug 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755437276; cv=none; b=Uk26WfjJiL2vLYoZwbaDHH+ZTIVGRKRsHwweoqFsRyZ3H3SkwENoVXaNdmb/vcYICpVWfsNnxguLbQE3jPHVsUyi7va+rdX+VVEtJCFud9Ikh9ZUxdB/fp+n8oaMex7yuhhRjOyYlcaNPW6kTcHkjshF/at6649Ep5Yfi/Q4fzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755437276; c=relaxed/simple;
	bh=nMC27mrpaNOcDuH9P5jD1XWV7p+Xb7aKREuFgN60KjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGksgBZHEppPjIWBz9ygpzVVoarSTE5OlbhZxjKPZ1eNmFgF3x4p16dfc7kVgtQY8xQ0oQUdpVpTS8ToWaSDnefzVcPISLjPGmAOA70ZzNPyN1LzpTY8XGmPL17suxKbeMTltvwDvabZySFky5dXtVYK7AxhwoNFUx8FYiMFSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=focXRr4V; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="focXRr4V"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-244582a738dso20985415ad.2;
        Sun, 17 Aug 2025 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755437274; x=1756042074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PH7UZNl6bH8vkla01SSa3J+pLgFY0n3tQWxYX+3FFq8=;
        b=focXRr4VOMBR63P1tZoAv+JpwGYbBKp3o2jkZpjswfpFtpjXZ6cGvQBMtkkdrH6/Wy
         JDmop1YpJUkiD6C+VK+to3+68hcez+nq0pRNhI+lqv68hhM8SjqbN/bb9HjDA/DYplff
         6KmclcIiPHmqLof4K0Wc06nW/HiXjBtDumviS9giJiAVLOTYH3zURwb9ZUMgdLfM8GEu
         XCDYJKjeVp2azOk/pMZycWPy9tX+qszFkM097JKGp/uexE/oWW6l1w/9aTZb0Dc2ldMM
         gKO9ipPDQHUHfaAmXhwwnMwNhQ1TZjT3nh/nSXUgZlPDJbP0m9BljN75uQB/nujGkH5Q
         IIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755437274; x=1756042074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PH7UZNl6bH8vkla01SSa3J+pLgFY0n3tQWxYX+3FFq8=;
        b=X6rODYk5x6rxHh6zmJOg2/jVCSKLqSsbccCng7IypnGW7nsmaWs7zjgX4U3LTfcW8M
         uEb50JSJFNIYzeHDxbqMi/34LfjgdmPKbQ4Aamr83MknmnF/zVE1TM9HH3XXwVlzsx/G
         l0NAhbpcQP7LTZxIJyGcZXPAGMCBBP0KOjjJGL7EFwbs7Q0s8GVr8SmYW6kSasjPl+BU
         vdkvt2I4iuOG3g9qouEm4j5UdfkYLw9CP7eu0xrzocc4ZA29UNn9TjXXxRoxI1s2EAYQ
         L8XGQMMHVzkIuyqdBfnEyOLQwlgXLTCXnbm9A4MFCX8y1sEfjHSa7QeAT27cyRamPpkl
         F+MA==
X-Forwarded-Encrypted: i=1; AJvYcCWlcV8HsjNTAetKVODJsHel2DBDVTpohvsdWvKkLIsuw0YNkRxJNT4UqXoGXjJ7zwmjUCv4Q3jIGTHJMhk=@vger.kernel.org, AJvYcCXyDbtMOvs1h2y3aJlpd4NW+/iGVXQA4nliE52eDMrH6W2tLlnJrLXGihySdFFxOj606y07Ezf4QuBYa86EOuu3dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5i5x3ZUe0afnJ7SD+Yp5VY/hLglcl9Qq4qz5KZAnYf0sNcc87
	Be8O5JzLevQSC0NzqkvfnIvj2hUu5OQP7ihlYtnLT4q4zh9Sh+M8ovQ4
X-Gm-Gg: ASbGnctCJSESRQ8Dsr0pKjkSBO3fq9kfNhGktFIxFsqdKqaeC3lYu8jF729fwQ296j4
	WFxJKpxQN2QHSViQDCRoeoKnTuFcl0zp+iMZ8T0qkDuW6wt4ro2UrbYXK+4yWTOtinURaBxPvqF
	57D7Re+T70gLDSOEUcdP8T+BE50YaTY7KfG5/OwABWUzJNnUcneVNzrQG+2qN47HLsEj03fN+Jm
	GLc7BDaOAW2kJllecdOA0mpMOOpDU5OmBPcOxhivzfxhUldX/IYREsi6ZDoeYIbEhfPI+8/kDg9
	EPsepSyPfT9yIaggE8EOwsKtKcYeHieS6XjvpW7oqeo5Sfr2nRW6uxf+Wuy3fCAfSaiNj72f4WE
	o7mJ+V8IVLVz+CNKxKkQI1umxnjEC
X-Google-Smtp-Source: AGHT+IEJEYhKVgh5oRSvpvHJEJqhJTpyCDYsA7m0naGH1w4dtAkQpzI+r/E9RaAQRaXe0WFPrMOIIw==
X-Received: by 2002:a17:902:e5d2:b0:235:779:edfa with SMTP id d9443c01a7336-2446d8811dfmr149725925ad.32.1755437273504;
        Sun, 17 Aug 2025 06:27:53 -0700 (PDT)
Received: from nixos ([115.193.162.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d554619sm55525975ad.141.2025.08.17.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:27:53 -0700 (PDT)
From: thaumy.love@gmail.com
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thaumy Cheng <thaumy.love@gmail.com>
Subject: [PATCH v2] perf/core: Fix missing read event generation on task exit
Date: Sun, 17 Aug 2025 21:27:42 +0800
Message-ID: <20250817132742.85154-1-thaumy.love@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thaumy Cheng <thaumy.love@gmail.com>

For events with inherit_stat enabled, a "read" event will be generated
to collect per task event counts on task exit.

The call chain is as follows:

do_exit
  -> perf_event_exit_task
    -> perf_event_exit_task_context
      -> perf_event_exit_event
        -> perf_remove_from_context
          -> perf_child_detach
            -> sync_child_event
              -> perf_event_read_event

However, the child event context detaches the task too early in
perf_event_exit_task_context, which causes sync_child_event to never
generate the read event in this case, since child_event->ctx->task is
always set to TASK_TOMBSTONE. Fix that by moving context lock section
backward to ensure ctx->task is not set to TASK_TOMBSTONE before
generating the read event.

Because perf_event_free_task calls perf_event_exit_task_context with
exit = false to tear down all child events from the context, and the
task never lived, accessing the task PID can lead to a use-after-free.

To address that, need an extra exit parameter for perf_event_exit_event
to teach it to distinguish callers. Only the caller that needs to exit
the task will trigger the read event, which will set the newly added
sync_child parameter of perf_child_detach.

Since now perf_event_exit_event may not carry DETACH_EXIT, rename it to
a more appropriate name "perf_event_detach_event".

This bug can be reproduced by running "perf record -s" and attaching to
any program that generates perf events in its child tasks. If we check
the result with "perf report -T", the last line of the report will leave
an empty table like "# PID  TID", which is expected to contain the
per-task event counts by design.

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
---
Changes in v2:
- Only trigger read event on task exit.
- Rename perf_event_exit_event to perf_event_detach_event.

Changes in v1:
- Set TASK_TOMBSTONE after the read event is tirggered.
- Link to v1: https://lore.kernel.org/all/20250720000424.12572-1-thaumy.love@gmail.com/

 kernel/events/core.c | 53 ++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c2857bb2..2e17883f2439 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1306,7 +1306,7 @@ static void put_ctx(struct perf_event_context *ctx)
  * perf_event_context::mutex nests and those are:
  *
  *  - perf_event_exit_task_context()	[ child , 0 ]
- *      perf_event_exit_event()
+ *      perf_event_detach_event()
  *        put_event()			[ parent, 1 ]
  *
  *  - perf_event_init_context()		[ parent, 0 ]
@@ -2318,7 +2318,7 @@ static void perf_group_detach(struct perf_event *event)
 
 static void sync_child_event(struct perf_event *child_event);
 
-static void perf_child_detach(struct perf_event *event)
+static void perf_child_detach(struct perf_event *event, bool sync_child)
 {
 	struct perf_event *parent_event = event->parent;
 
@@ -2336,7 +2336,9 @@ static void perf_child_detach(struct perf_event *event)
 	lockdep_assert_held(&parent_event->child_mutex);
 	 */
 
-	sync_child_event(event);
+	if (sync_child)
+		sync_child_event(event);
+
 	list_del_init(&event->child_list);
 }
 
@@ -2507,7 +2509,7 @@ __perf_remove_from_context(struct perf_event *event,
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
-		perf_child_detach(event);
+		perf_child_detach(event, (flags & DETACH_EXIT) != 0);
 	list_del_event(event, ctx);
 
 	if (!pmu_ctx->nr_events) {
@@ -2613,7 +2615,7 @@ static void __perf_event_disable(struct perf_event *event,
  * remains valid.  This condition is satisfied when called through
  * perf_event_for_each_child or perf_event_for_each because they
  * hold the top-level event's child_mutex, so any descendant that
- * goes to exit will block in perf_event_exit_event().
+ * goes to exit will block in perf_event_detach_event().
  *
  * When called from perf_pending_disable it's OK because event->ctx
  * is the current context on this CPU and preemption is disabled,
@@ -4579,9 +4581,9 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 }
 
 static void perf_remove_from_owner(struct perf_event *event);
-static void perf_event_exit_event(struct perf_event *event,
+static void perf_event_detach_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
-				  bool revoke);
+				  bool revoke, bool exit);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4608,7 +4610,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx, false);
+		perf_event_detach_event(event, ctx, false, true);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -6178,7 +6180,7 @@ EXPORT_SYMBOL_GPL(perf_event_pause);
 /*
  * Holding the top-level event's child_mutex means that any
  * descendant process that has inherited this event will block
- * in perf_event_exit_event() if it goes to exit, thus satisfying the
+ * in perf_event_detach_event() if it goes to exit, thus satisfying the
  * task existence requirements of perf_event_enable/disable.
  */
 static void perf_event_for_each_child(struct perf_event *event,
@@ -12413,7 +12415,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, true);
+	perf_event_detach_event(event, ctx, true, true);
 
 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -13995,13 +13997,16 @@ static void sync_child_event(struct perf_event *child_event)
 }
 
 static void
-perf_event_exit_event(struct perf_event *event,
-		      struct perf_event_context *ctx, bool revoke)
+perf_event_detach_event(struct perf_event *event,
+		      struct perf_event_context *ctx, bool revoke, bool exit)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = DETACH_EXIT;
+	unsigned long detach_flags = 0;
 	unsigned int attach_state;
 
+	if (exit)
+		detach_flags |= DETACH_EXIT;
+
 	if (parent_event) {
 		/*
 		 * Do not destroy the 'original' grouping; because of the
@@ -14077,6 +14082,17 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	 */
 	mutex_lock(&ctx->mutex);
 
+	/*
+	 * Report the task dead after unscheduling the events so that we
+	 * won't get any samples after PERF_RECORD_EXIT. We can however still
+	 * get a few PERF_RECORD_READ events.
+	 */
+	if (exit)
+		perf_event_task(task, ctx, 0);
+
+	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
+		perf_event_detach_event(child_event, ctx, false, exit);
+
 	/*
 	 * In a single ctx::lock section, de-schedule the events and detach the
 	 * context from the task such that we cannot ever get it scheduled back
@@ -14101,17 +14117,6 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	if (clone_ctx)
 		put_ctx(clone_ctx);
 
-	/*
-	 * Report the task dead after unscheduling the events so that we
-	 * won't get any samples after PERF_RECORD_EXIT. We can however still
-	 * get a few PERF_RECORD_READ events.
-	 */
-	if (exit)
-		perf_event_task(task, ctx, 0);
-
-	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, false);
-
 	mutex_unlock(&ctx->mutex);
 
 	if (!exit) {
-- 
2.50.1

