Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65750208D0
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765253778; cv=none; b=rwjt/bf0ehxwb719HiLHOBefp0bLEkanYmwGeznA7ICB7qkvhKQPY8XkqEX2C67tmPq6WY07+LCKOfcglZLh/nQqBSerkmhIkqD0tb3lAFDUmh0dSolRMqegdLnCLzrQ0l20jZBHYIgNUxS55BIv1u2eow3gaDB1QdSmcdS1d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765253778; c=relaxed/simple;
	bh=ywL2XffooPaoJtOW52uoNolWTfO4L1cPqhwxEZrSkdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYvCUe33FSuxam9VHcWZ4R7FYuMz/XH6hnkAp5hmFGpY7K4gu6vfbLK4zObdnu2w1qhieSQaXb3PSROph3Dt/NT203CEt5lxtSCc4po00pcWmitdcnwO3m4tkZkq7QMkaL2+zW/2GYCGmUtEwHKTRACgK6O8VGX9JsLGQtG9dLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdH9PSl3; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdH9PSl3"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297ef378069so47661725ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 20:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765253776; x=1765858576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlJMjioQT5hFyjTQfgGib/nn3aRlpyKPcJRzd9y5r+E=;
        b=kdH9PSl3Fx/laRO35dI5wNoLTc52VczkPkXldwAzix+S18hkFWxkYlCBzNYGWTEecV
         U8uevCt2RcbVfJvhyyu7BVVO4SIwzVbCtGtzxZPt3wko3R3JAvlAMmFgolQfdzuXLrJn
         JLAAEwXrlKQufXxLl+1WD2YjY/DJLNR3/l5PiGvfcIJspVU0WSlTiMkjV6dW9d4creqg
         3FHQqaUYPuUR7WFyBJf295gD5kZoEUO2S9hNLx39rVo0/pTbSUC0ezasRm/skZ8n7IRr
         VTyKbgDn6xzq+Es33Jp8sBqAw0/lXlBMmneRVYEVThLX522+rdsT1IIAJpMfgeBZ/JFm
         gmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765253776; x=1765858576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlJMjioQT5hFyjTQfgGib/nn3aRlpyKPcJRzd9y5r+E=;
        b=Twziv0K0aeQhOB/lO2QXbC0Uizwx+UUeh07cAES7qUEkGuHw6owMFmTWmOGrDpzEZa
         Mjwbt0QlmsL6ahnSDuaWBIrKEqEZgt9ejdsa709K7xjnZXrXqJXvU1cQNNN68s0RDgv4
         q0G+F8o/QATEOYl/yx51v1HXNHXaav8yKhFzvgiUnzJsEcID92mEzfkud+Fq52ekbUL2
         e+llqwRwIHiOIGxDRdoG1a7ShxismmuWq7wAm+s1iO0lTvLrNaSJ6R4zxkEo/SGeaiNG
         LaUXqIUS1yUe6i0AtOBswI98IC1faz8zsSz7455s0ZY/Xpoc94Mg4qcOBOQ4zWceEIJc
         2edQ==
X-Gm-Message-State: AOJu0YyIVhkHST4cQH1Rs4gg/z07kkDkePo+5h3JzQxjfiJj0NjUEbSi
	4DUbbwpmeIScJWZXKgsLODDp0FWPdVqkYXWuu203p+5ebaKwX6bX28fN
X-Gm-Gg: ASbGnctCXYBd/Cbe3YKGrr5erYO8difG7SebwXP3VzEYFevMKYeNI6VrS4VxnxBS6gG
	zJVASqFQwYLtJRsTsFdvVDnVOeE3YyWsBAoTw68F7JC6Rn51PaTu2wVyIioBXLU4r5r70zSIViU
	RjZQX8U4J4ij1zxpp6NNSXcPAfN++VLIwcgLkcKonJwLyStSiaarcCBvQEgiQB2G2IsGecXYhD/
	aimWlrh1yVN2PhuWSitD2yC+0yknVbZmKIYwm7+55G061bid7ADoZNImnNC0097Lhg/Cd5i/+VK
	YxOwvHyfNuA/AX0GLTEZMathGCoilIbp2Xtm0p3zGGvu5o0L+k5x9e7z5lf0rGdbtSiiPq4dEO9
	p4pTWcR05AFI7t3W7oKlJFCJ7QhOfz7HGSWAt66WM2g4ya0zitFolsGe7TxZkKJbCYZBpuq4W5J
	5r9iK8kE9UvwbQEKjjWzq1EBS9/TkpHhnp8/1hg6yQpzMzDlpFrKU=
X-Google-Smtp-Source: AGHT+IF+n41cK6qyOclXKfTA9gq7iCinUctpvRZ1cPZYr5mMQx60DHOAwzuQ2syrMzUSlAxPhD3pUA==
X-Received: by 2002:a17:903:110e:b0:294:ccc6:cd30 with SMTP id d9443c01a7336-29df5ab1c90mr115886225ad.17.1765253775595;
        Mon, 08 Dec 2025 20:16:15 -0800 (PST)
Received: from nixos (36-231-103-14.dynamic-ip.hinet.net. [36.231.103.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f01csm137394405ad.48.2025.12.08.20.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 20:16:15 -0800 (PST)
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
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thaumy Cheng <thaumy.love@gmail.com>
Subject: [PATCH v3 RESEND] perf/core: Fix missing read event generation on task exit
Date: Tue,  9 Dec 2025 12:16:00 +0800
Message-ID: <20251209041600.963586-1-thaumy.love@gmail.com>
X-Mailer: git-send-email 2.51.2
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

To fix that, let sync_child_event read task from argument and move the
call to the only place it should be triggered to avoid the effect of
setting ctx->task to TASK_TOMESTONE, and add a task parameter to
perf_event_exit_event to trigger the sync_child_event properly when
needed.

This bug can be reproduced by running "perf record -s" and attaching to
any program that generates perf events in its child tasks. If we check
the result with "perf report -T", the last line of the report will leave
an empty table like "# PID  TID", which is expected to contain the
per-task event counts by design.

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
---
Changes in v3:
- Fix the bug in a more direct way by moving the call to
  sync_child_event and bring back the task param to
  perf_event_exit_event.
  This approach avoids the event unscheduling issue in v2.

Changes in v2:
- Only trigger read event on task exit.
- Rename perf_event_exit_event to perf_event_detach_event.
- Link to v2: https://lore.kernel.org/all/20250817132742.85154-1-thaumy.love@gmail.com/

Changes in v1:
- Set TASK_TOMBSTONE after the read event is tirggered.
- Link to v1: https://lore.kernel.org/all/20250720000424.12572-1-thaumy.love@gmail.com/

 kernel/events/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c1a362..618e7947c358 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2316,7 +2316,8 @@ static void perf_group_detach(struct perf_event *event)
 	perf_event__header_size(leader);
 }

-static void sync_child_event(struct perf_event *child_event);
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *task);

 static void perf_child_detach(struct perf_event *event)
 {
@@ -2336,7 +2337,6 @@ static void perf_child_detach(struct perf_event *event)
 	lockdep_assert_held(&parent_event->child_mutex);
 	 */

-	sync_child_event(event);
 	list_del_init(&event->child_list);
 }

@@ -4587,6 +4587,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
+				  struct task_struct *task,
 				  bool revoke);

 /*
@@ -4614,7 +4615,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)

 		modified = true;

-		perf_event_exit_event(event, ctx, false);
+		perf_event_exit_event(event, ctx, ctx->task, false);
 	}

 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -12437,7 +12438,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, true);
+	perf_event_exit_event(event, ctx, ctx->task, true);

 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -13994,14 +13995,13 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);

-static void sync_child_event(struct perf_event *child_event)
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *task)
 {
 	struct perf_event *parent_event = child_event->parent;
 	u64 child_val;

 	if (child_event->attr.inherit_stat) {
-		struct task_struct *task = child_event->ctx->task;
-
 		if (task && task != TASK_TOMBSTONE)
 			perf_event_read_event(child_event, task);
 	}
@@ -14020,7 +14020,9 @@ static void sync_child_event(struct perf_event *child_event)

 static void
 perf_event_exit_event(struct perf_event *event,
-		      struct perf_event_context *ctx, bool revoke)
+		      struct perf_event_context *ctx,
+		      struct task_struct *task,
+		      bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
 	unsigned long detach_flags = DETACH_EXIT;
@@ -14043,6 +14045,9 @@ perf_event_exit_event(struct perf_event *event,
 		mutex_lock(&parent_event->child_mutex);
 		/* PERF_ATTACH_ITRACE might be set concurrently */
 		attach_state = READ_ONCE(event->attach_state);
+
+		if (attach_state & PERF_ATTACH_CHILD)
+			sync_child_event(event, task);
 	}

 	if (revoke)
@@ -14134,7 +14139,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 		perf_event_task(task, ctx, 0);

 	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, false);
+		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);

 	mutex_unlock(&ctx->mutex);

--
2.51.0
