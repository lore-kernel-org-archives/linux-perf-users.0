Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EA2DE6F3;
	Tue,  2 Sep 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826130; cv=none; b=Koq1E4UyHoQXQ3A7nLZeIgI3sQLPDUhZQAhX+VP8yF/DTU0iMLffYUwi5ARRnPzjGTopZZjNeh0fuppqV69pPsjl+zhKOXefd42JxsfzhMwTZn82kEl0+fT7cDvVuBDREI6xem0PTRl91YB9BjEZyAPqTpbM1o+y70iafPrEDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826130; c=relaxed/simple;
	bh=CKRJGACJWHK8Hlud48RR8jl/VtJ79lLFYLx1AJc/+NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZG7OVd9KYL71W7qGjQjQGHIb/xpuYxNxZj4bwEPSHFYfJs1V2aI5i6T1nwOBBtfX50UCsV7uSWeV+At4zqm8oH4kqgL/cNb3zyKJTuTTJjEAutAO6xJFcnSgNBvQzOidB3iRxZw6TIQBfsAork77mt3/6dYbRowCfjVByDXGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCG4c3MY; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCG4c3MY"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-771fa8e4190so3670761b3a.1;
        Tue, 02 Sep 2025 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756826127; x=1757430927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISvkKKWDIq4+oW79gR956cg3AZDUxj8RaDon4KWZSA4=;
        b=BCG4c3MYRAK+Na++owkth3+rgNG+Xyi/aUfWVo22pZYhwQp7PSuwLOWyiksZ6zEIrs
         Pz9cC4PBxguCi0LtGkq6/4qVwS7r78+eGd3bItYdEWyNEfA7KRFV/yeL2XeqG1az3NdF
         bkEvIc/I7mUbNUcPtMV4vn/li7bUTbsMzKZd0v61KRrTiMMTk7iSWjI5xpqlQnGf4yJE
         PHBsWfH4Zwe3XBWKkBfxyUPqWFflFo+fm/LWchw86pcV6AqEMjZSE4IT/FJXCap9YlmJ
         whEl60mBN7wMzCVPEuZGyyeUNGq7EM27IesEsJYZ3sBiTYe3Su7UXhYB1lIjIkq16IU7
         hCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826127; x=1757430927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISvkKKWDIq4+oW79gR956cg3AZDUxj8RaDon4KWZSA4=;
        b=J40qrz9RlAHNA+/LOb700QfhDcYg7ok0LGp9lysz8P1TLU1ISfA7y3yGrN59P62RoK
         TjfGW+6sPfddUF1jkESQ11KBAo+JmnYCch6jtQ1AC6ffsZ1DdHVFUpB5otKBoBkTFpEo
         VbrYTfi55IowUadTHV6v/LYChyZ6s2vUr3XAQynDmitH8eSsgDwFjKrcyMTUyJpXJ244
         9eCytuc0blZ+EiuTw0ailsuWXYG8LA8zFJ3G3B2vxuTZqlTsuFYdIlqUxwVtnf3mAyJt
         hAxMGDrYQKavVDNtWaaryQxm7eMGHkkOhgU7RWxHGh9zXQVBH/lvntkUnBWTRI5IZmY0
         uEqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYhPFcmtjTihf8JOpFcV99pFZExt+QRUlCX9SW8JP5fx8Mya9wzK0D5P1oyR+eXFt0TQEZEj8wtSkqDhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaN0XYcp4vRTohNVRMJuX325vxq8gRwvuW97uwLHEmSZ+6qkyg
	S67u3AqLlHCgLVoDium7cfLbdeDGPw+q0I7YTf69TavKjaXER22wFWuW
X-Gm-Gg: ASbGncua1scIXBTpleNgTMJqc9RjDsQHPBPZ8VoHXmdqR38oM+ioBygGuZxcg7Qh4e2
	F8zf9qZ6KnCEzrrN5MtdtllI2sY+AKZWinDOxVxo1lL+bseG4OYKrlZ01LxKhGlSMqnhT5ifQUY
	PLg8Lpy7GyNBPBlzG8a27vglJ/pXlnFJWMTpcmp2D5pvVqOsev1ngChZswerWztVU4N+87jxFpZ
	V8BoMQEm2GDjpNoYNkJbkHftie2B+Rp3SLXTKXXKs8yMovasv9/Erdqs9ZWg3w6mhWXJ0q6TqG1
	L7295ii3+Gq9MuOExXgR47blInze5WKt2LegdVQzxWt+jhwChZ4ApHFOHhI3YZBac43sPY9CmML
	Ju35I+SdgdGtJSHcX41BvHT8LIW6NpaGQrhWZVrJ8IdpDRRWNkhtv0t+5z42vwe3yHhXD55crk9
	WOdVNJT4QPO4HhydiMKCa6MBI=
X-Google-Smtp-Source: AGHT+IHD/kMDE3gbLZYtH72UCAc8RJvLlzXy2nNXNk5ONXs9WsZINLIRyVS84hwdbwo3Y+p6pZ64JQ==
X-Received: by 2002:a05:6a20:394a:b0:246:458:8531 with SMTP id adf61e73a8af0-24604588bb9mr1031513637.4.1756826125731;
        Tue, 02 Sep 2025 08:15:25 -0700 (PDT)
Received: from nixos (ec2-18-179-42-135.ap-northeast-1.compute.amazonaws.com. [18.179.42.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77274171cf4sm1990505b3a.76.2025.09.02.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:15:24 -0700 (PDT)
From: Thaumy Cheng <thaumy.love@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thaumy Cheng <thaumy.love@gmail.com>
Subject: [PATCH v2 RESEND] perf/core: Fix missing read event generation on task exit
Date: Tue,  2 Sep 2025 23:15:17 +0800
Message-ID: <20250902151517.384635-1-thaumy.love@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

