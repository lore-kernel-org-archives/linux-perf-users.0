Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786012;
	b=ikeqgGSJ/VvexGrLOs576TrONS6AEBCns5Dr6j1r5aKfDBwgVD3B2O1XnfqANCtnoO5e
	 Rn2/NHYl1WOUqlXyR3QKIiZoKaYS2oXnubuCaIJkya2WhKEcd5CnV9O9wTm37PRrOIBhr
	 FaNeqPR/Ncek+nWqBpd0MMdMgYYoqQrmcEo22l0zOvn07KeB5kaNPCMPECVztY5Jtekpb
	 C30YEX2W1Cw2Dilq4z1D254mmiawm978zIAQTPWtd3MDFihtSXyWdxJeMH30vMeh7wX6S
	 dta3xPfGTMGycrZ51I9b6+ae//1BF2FfDadCTj9xK8huU4UmnBmcPNQieOqlg2d+xJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/WFY1Aa0rGDcg5SZYf13pEO+y4GAGpssafPS9WSoXdU=;
	b=mCzSKQ5DwuxGZ1IqrgAawg3ArZhBLGTkpQGujfCl1I+4N6vqgNcj7ceQydscy/p93LDe
	 vmpHkow/t2j+4T4LfOQEoylxH7ViN4L3HT2Ct61mkTDcr+K/XawHDyMz+dVgZd3uGTu4M
	 Gc2ORHz4J0os4CAuVn7MA1kekm8NhJbxlb73/Pyu2CZYt849l3wMdkalAGGnR70D0XYHD
	 e+7fi92hfC4dAywrzL64Er47bUyV5Q6t5Qx7lnDbpfoQnM2FTQodgaXetSUbit1lajzFJ
	 3/HUoQ7ncWasypNzMPOuHzlaA3yqFgfzYpjB1B3w/nbHM+I9P7txBT4Xb28J6Y3wenA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c9XqRbuT;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB09606A32C
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB09606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c9XqRbuT
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso2316829a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 15:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794786010; x=1795390810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WFY1Aa0rGDcg5SZYf13pEO+y4GAGpssafPS9WSoXdU=;
        b=c9XqRbuTnEbw5VwHAOvCkia8YwNiRigcFLm7zpQT5y8AYY25mg0yl3HvGwSpnyPTE7
         OjgIvALW/jDWbXQHyBLhmK5kzTjKfP2FdUj1zXr9Wltl9vP2TiK7OO8lOEtkV3MzzQdP
         R4je8rP2Xlb723liiKA/LCs4w/HbAH1BbPH6Nv79ih/t12mntyl25hi3Za9Wq2EyYA/B
         B8J5GwTm5uuOgQMGsvobp1uezn27lm3TRriM1v1Bv+pXSLsYvpvq1tR++Q2VfJuLYwU+
         IrhqDRE9BXpLVImFL1Xxphq8LQWxxnbcLdH9+B3e4J6NkEMJtLFmhvLwIfypfJsR/1He
         AieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794786010; x=1795390810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WFY1Aa0rGDcg5SZYf13pEO+y4GAGpssafPS9WSoXdU=;
        b=kNembgjv/py3F1Rga0sWIi81J945vCRqqbVeYa9sKkc+Mh3WdmUX5aKFTj4UfIj6Dt
         S/cs+bQkg6SeF+DKzMcht+qM4NnA6gWAtJrDNejwLSzWswnt6K1XVoWLn/f7/Et2O7UO
         S7xyiPA2dYnGsQdSXW7jwCg/dx1bh/c6dIhpyy0Q+PtKEARLQaH5JILaoLLP9ffZkAUz
         jvIa81HamQtlsISoxB0UjLky18FCB/+2U8lzrW8mmN6QTDfsWkj0glVpmlmwSr4lBFu5
         RTls/I/eUY7GTdjuMzsARRJBpIaZNf1XUrFbVEPPtAYTx7+7jpqJYy7pOjmvG0mHwAEc
         W/8A==
X-Forwarded-Encrypted: i=1; AL+hErFJA9vZNbzZrLQePcOgbv2TciaxgDWQ6wi+O61STSAdnYbWYhwDHKokmn5KYiOBKxyAekLKS1CcEzlYiwgtiiEe@vger.kernel.org
X-Gm-Message-State: APuU4Z9nCGA9bkgzj4ZRn1u0t62ZgiEMVwkAm9pwUddOmNi/jjNJFTE4
	dGcAC8fQ7iBdbRr02vE8TrOopNEIPJ0RO5d/B1mmi6b75pa8zVQbHBFx
X-Gm-Gg: AYBFou0ylqJtdgwb/ADw9xxg3DoSyFtNURnsZq4Q1PPvKT7GZDUIOLe2BLWAjRF1C/I
	tVlpeTuJP8YYTdYyIhJ2R0Oz6vhk+S4NQcLGaA22oDT+jcntNBcu3ErKxJj/huvJ50/oHxud/Fr
	itG1zDhBUyGKMxhEtsHPWNhghsweQBjhsm85eZQXmf2KXoGeLzEPjO4xgxlQorvE8dZQZ4H2SMe
	CVxs0CHP9JBoWroeaRwqwKPEf/8reizVWHLP6dKBG+Vg/C48MyVImhbQ/XgrnOfZssPMCDhNehu
	e7WwtsHyREg3n9NGaKnHoGEJjRinTYXVTfSDgUF1p1rClMd0anKCO5R3g4w2PbfEoee9Mb7F2VO
	Zm+o/ONB4aedkS0P3vdjzk41c6CCCq6ccumYmL1t3+W/GSx/w8PWatO7quXCgtVpsMxGlnHYOQ5
	Ojbgu0i1Aw3I0wWTPoKWahEPMHS0qPgoq7wksMvx7/SiIl3oFttPfC/zDAaaPsh133JgpkQIC0H
	vxVGfFaGQB+pawRVW/foUYHLZdg0AbJBsyZkNEjkyd4RCUzUHzRVroRELef+/LN3u1llLbtMpFw
	kA3hhnWZshnZbCv40aDdqPJwtSYLyZzEVKF1wS24CgIjw+u+jR2hzqWVqFwcGPmch3XG83rA2RE
	WQW7wZsQniQ8ndAINbjkW8bd494bUMiRh2ik2Sc2HEm1qCN7EVH4VfamOEfNfZBhNuVLcMu/Wjf
	qRJ36N5J9+EGqUKVdz11V0R0xIwxd35olaRF3dn+wOeI6tcUuF6P/ub2ZANhoXjGXURYZJiWTgs
	DfhgRie0+A3xF3EeM+el+SHrr8c6ntNVXQsgDLkn5y2NTgarTvCcr9945Z0YJiG
X-Received: by 2002:a17:90b:5147:b0:3b0:ae41:2706 with SMTP id 98e67ed59e1d1-3b1b0818413mr8265941a91.4.1794786009983;
        Sun, 15 Nov 2026 15:40:09 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197b76ccesm18921968a91.0.2026.11.15.15.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 15:40:09 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Marco Elver <elver@google.com>,
	Taeyang Lee <0wn@theori.io>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Don't take owner->perf_event_mutex under ctx->mutex on exec
Date: Mon, 16 Nov 2026 10:09:49 +1030
Message-Id: <20261115233949.13685-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_event_remove_on_exec() holds the exec'ing task's ctx->mutex and calls
perf_remove_from_owner(), which takes the owner's perf_event_mutex. The
order documented above perf_event_ctx_lock_nested() is the reverse:

    exec_update_lock
      task_struct::perf_event_mutex
        perf_event_context::mutex

perf_event_task_enable() and perf_event_task_disable() follow it, holding
current->perf_event_mutex while they lock the context of each event the
task owns. The two paths deadlock against each other:

  perf_event_task_disable()            perf_event_remove_on_exec()
    mutex_lock(perf_event_mutex)         mutex_lock(ctx->mutex)
    perf_event_ctx_lock()                perf_remove_from_owner()
      mutex_lock(ctx->mutex)               mutex_lock(perf_event_mutex)

Neither sleep is interruptible, so neither task can be killed, and the
target is stuck in execve() holding exec_update_lock for writing and
cred_guard_mutex. Reaching it takes no privilege beyond opening a
remove_on_exec event on the target: open one on a child and call
prctl(PR_TASK_PERF_EVENTS_DISABLE) while the child execs.

Lockdep does not report the inversion because perf_remove_from_owner()
takes the mutex with SINGLE_DEPTH_NESTING, annotated there for a caller
arriving through perf_event_exit_task() with a child's ctx->mutex held.
No such caller exists; the only other caller, perf_event_release_kernel(),
takes ctx->mutex afterwards.

Do not unlink the event from its owner on exec. It stays on the owner's
perf_event_list until perf_event_release_kernel() or the owner's
perf_event_exit_task() removes it, as an event of an exited task does.
perf_event_task_enable() and perf_event_task_disable() still visit it but
leave it alone, as _perf_event_enable() and _perf_event_disable() return
early for PERF_EVENT_STATE_EXIT. They now also reach its child events,
which PERF_EVENT_IOC_ENABLE and PERF_EVENT_IOC_DISABLE already do.

perf_remove_from_owner() is then never called under a ctx->mutex, so take
the mutex without the nesting annotation and let lockdep check it.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Reported-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/all/CAP-5=fVq=2D6XjVEbAvJz54hG6PcwZZjn-za0hAfK8YV-J+MtQ@mail.gmail.com/
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Cc: stable@vger.kernel.org
---
 kernel/events/core.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5f2261..ec51e6b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4747,7 +4747,6 @@ out:
 		put_ctx(clone_ctx);
 }
 
-static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
 				  struct task_struct *task,
@@ -4756,6 +4755,11 @@ static void perf_event_exit_event(struct perf_event *event,
 /*
  * Removes all events from the current task that have been marked
  * remove-on-exec, and feeds their values back to parent events.
+ *
+ * Top-level events stay on their owner's perf_event_list, like the events of
+ * an exited task, until perf_event_release_kernel() or the owner's
+ * perf_event_exit_task() takes them off. They cannot be unlinked here:
+ * owner->perf_event_mutex nests outside of ctx->mutex.
  */
 static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 {
@@ -4773,9 +4777,6 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 		if (!event->attr.remove_on_exec)
 			continue;
 
-		if (!is_kernel_event(event))
-			perf_remove_from_owner(event);
-
 		modified = true;
 
 		perf_event_exit_event(event, ctx, ctx->task, DETACH_GROUP);
@@ -5876,6 +5877,9 @@ static void free_event(struct perf_event *event)
 
 /*
  * Remove user event from the owner task.
+ *
+ * Must not be called with a ctx->mutex held: owner->perf_event_mutex nests
+ * outside of it, see perf_event_task_enable().
  */
 static void perf_remove_from_owner(struct perf_event *event)
 {
@@ -5900,15 +5904,7 @@ static void perf_remove_from_owner(struct perf_event *event)
 	rcu_read_unlock();
 
 	if (owner) {
-		/*
-		 * If we're here through perf_event_exit_task() we're already
-		 * holding ctx->mutex which would be an inversion wrt. the
-		 * normal lock order.
-		 *
-		 * However we can safely take this lock because its the child
-		 * ctx->mutex.
-		 */
-		mutex_lock_nested(&owner->perf_event_mutex, SINGLE_DEPTH_NESTING);
+		mutex_lock(&owner->perf_event_mutex);
 
 		/*
 		 * We have to re-check the event->owner field, if it is cleared
