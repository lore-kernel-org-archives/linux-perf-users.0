Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116152;
	b=WSRlbIh9hjjmK7gMJKE6HFJMilw1dQblbeoE9JwaPoRkg6xAcgTdKbe0tdPdm/OXRh94
	 Bm6RAMQQUognk2D3mY6eahCC7R29BVf9qNF048gDtKk8+3WwAYvhLvypmCAxnKYsizJXW
	 fzeISg7+Y9WOXlkUPKc3cnvYkIm2Ceg2aXWe6U6DVYPpPXsLpUocTtCcptsLIREOS4Khn
	 22D/cY29xIJzAFC++RgUQU5XF6UORI6O/Py9jHhekT/TmGetrhW9CU/asQF16upqrnRdp
	 TBqR5eAyeQcqKjDO6KtkK/PYDiuarAueUOOq1+a99rsoUF8uekxj80yolfw4ecxNJiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=k4jowK9SsXzCTs+CSQSMJwZkh7DPqF/tvPPgils0taM=;
	b=yXoQGri1CODVymLgKEqvTTpwMXPcDfBd1kN1nRk8H+tLi/n8Y2X+v1Gz8+CghO3MvqBH
	 92h2gdltoP+1s027JggEmmVcjaZ0Xd1tz6QEj2Zk3DGCoW/PKKEtxERoVM5Vbldn1cbTv
	 uv724GlfP9vK8Q1casNNs3Zu6aKnfuj8njadthIkXqU7w/QNS8Rlff8gb8E9rdo2U7+uh
	 AVpy2vOLB1g3q3V4ERdfO+Qi2xssKWsNT5L8YzeB9qtRe7cFno3HLoDDW1WA19wPxlNcY
	 cD4DVznqS2LNxc1Y3/nUwoCs2mKRMYHIeflAnjzngggajDTeG/rQX+oJDXdWUWUGnXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="f/PGyafq";
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2181606A33D
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2181606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f/PGyafq
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c42888c50c4so17296466b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116150; x=1795720950; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k4jowK9SsXzCTs+CSQSMJwZkh7DPqF/tvPPgils0taM=;
        b=f/PGyafqWcEK/oTyqqQF92DZu1NxAV16NL9iX2zqRevZOws5rzNIUmyw8mWiIwHDNJ
         MWiWJYIoWNcNbxyJ9aWmi7NpgqMdBpbG1CPrjz3oS6Vvv+2tWvR8yMqhFOuorCbZb1ml
         tPZ4EzM+uv//kQiMs5y7Jnp3ltR0DhQxG67aOES3RX7KzjgzzoCt4iyOVLKJIaDneanb
         /aWjVtFHGJT91mxu33qtU1ZrtkuKh3Q9qFuANcgxwfaEdaPOXFzL1W4n0RVggk1KUVTi
         ozV2brJWIAmRTUpitoJ/qnt6EI9zUgnFMIYJ3Zp7REo/xz1PhEdNzD76Mdn/v8S8c6cT
         dnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116150; x=1795720950;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4jowK9SsXzCTs+CSQSMJwZkh7DPqF/tvPPgils0taM=;
        b=yc+kcYJbI/1jzivfrVlSHaNdHEoEohc0MHwKDQPNVodCyHfZglaqvo7jqFoIm70IOw
         ZZbYrs1RMG3XsqMTGSGoQt+duC8rJvaAb1hun8l0uTN2hOm0cWnwzKBHCW+QsgeuiOCE
         6Cl5zck3ZuyrJDQAiFv5XAWDMFSnfL9YlQ5ogKoX/YI+7MK1G1y+T8UbElw4/vtA1uxN
         shXB0TLEgRhLx/lUUJkg1cwrApQ+R71GVJQFko6s3dnr/ou3uhk4nWpbAEHpwAwSyXG4
         mZn+5aFaBStHxY2YW88r2B0i6F6Cl4FJcopCmwokf8YD1Kkm8T5xBNBvj3Z3qkNE1gXp
         XgEQ==
X-Forwarded-Encrypted: i=1; AL+hErETWiesbTleJ1bWaCLFMB794Rt8IlPiK/dRQD7CSXRcIfr5722l22ygvjDqhdUb963uO1nSuFAT2BIOmYPIf0h2@vger.kernel.org
X-Gm-Message-State: APuU4Z8CaoBeAu3oRys+WYsKgeVl+BrlacyjlJjhfT9Lab2G4owlyqiS
	DRELFAh+B26Lv3anljkpkUQDHHLS0swsK6Z6jNeaRH53wviN3y2EC7snad5rjgJlgr1Xz9PhJQ=
	=
X-Received: from ejeb25.prod.google.com ([2002:a17:906:1959:b0:c4c:ef20:d8f0])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:e24c:b0:c2b:f3d5:2090
 with SMTP id a640c23a62f3a-c513ab1dca1mr68190066b.27.1795116149427; Thu, 19
 Nov 2026 11:22:29 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:28 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192228.2661266-1-dmnk@google.com>
Subject: [PATCH] perf/hw_breakpoint: fix ctx->mutex vs perf_event_mutex
 inversion on attr modify
From: Dominik Maier <dmnk@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Marco Elver <elver@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

The perf events lock hierarchy documented in kernel/events/core.c orders
task_struct::perf_event_mutex outside perf_event_context::mutex, which
perf_event_open() and prctl(PR_TASK_PERF_EVENTS_ENABLE) follow.

However, perf_ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) acquires
ctx->mutex first via perf_event_ctx_lock() and then calls
perf_event_modify_attr() -> modify_user_hw_breakpoint_check() ->
modify_bp_slot() -> bp_constraints_lock(), which locks
bp->hw.target->perf_event_mutex when bp_type changes. If one thread in a
process calls prctl(PR_TASK_PERF_EVENTS_ENABLE) while another calls
ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) with an alternating bp_type on a
self-targeted breakpoint, the two threads deadlock against each other in
TASK_UNINTERRUPTIBLE state.

Decouple bp_constraints_lock() from task_struct::perf_event_mutex by
using a small static array of dedicated mutexes indexed by
hash_ptr(tsk, BP_TASK_MUTEX_BITS). At most one bp_task_mutexes[] entry
is ever held at a time, and ordering becomes strictly
perf_event_mutex -> ctx->mutex -> bp_task_mutexes[] -> bp_cpuinfo_sem
without extending task_struct.

This issue was discovered with an AI-assisted code review tool (ARTIST)
and reproduced in QEMU/KVM on an unmodified v7.4-rc3 kernel without
kernel modifications or error injection; a standalone reproducer is
available upon maintainers' request. The fix was compile-tested with
-Werror and checked with checkpatch.pl --strict; an equivalent fix was
verified against the reproducer in QEMU/KVM.

Fixes: 0912037fec11 ("perf/hw_breakpoint: Reduce contention with large number of tasks")
Fixes: 32ff77e8cc9e ("perf/core: Implement fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 kernel/events/hw_breakpoint.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 7a60621..540c747 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -23,6 +23,7 @@
 #include <linux/bug.h>
 #include <linux/cpu.h>
 #include <linux/export.h>
+#include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
 #include <linux/kdebug.h>
@@ -94,22 +95,21 @@ static bool constraints_initialized __ro_after_init;
  */
 DEFINE_STATIC_PERCPU_RWSEM(bp_cpuinfo_sem);
 
+#define BP_TASK_MUTEX_BITS	6
+static struct mutex bp_task_mutexes[1 << BP_TASK_MUTEX_BITS];
+
 /*
  * Return mutex to serialize accesses to per-task lists in task_bps_ht. Since
  * rhltable synchronizes concurrent insertions/deletions, independent tasks may
- * insert/delete concurrently; therefore, a mutex per task is sufficient.
- *
- * Uses task_struct::perf_event_mutex, to avoid extending task_struct with a
- * hw_breakpoint-only mutex, which may be infrequently used. The caveat here is
- * that hw_breakpoint may contend with per-task perf event list management. The
- * assumption is that perf usecases involving hw_breakpoints are very unlikely
- * to result in unnecessary contention.
+ * insert/delete concurrently; therefore, a hashed mutex pool indexed by task
+ * pointer is sufficient without extending task_struct or coupling lock ordering
+ * with task_struct::perf_event_mutex and perf_event_context::mutex.
  */
 static inline struct mutex *get_task_bps_mutex(struct perf_event *bp)
 {
 	struct task_struct *tsk = bp->hw.target;
 
-	return tsk ? &tsk->perf_event_mutex : NULL;
+	return tsk ? &bp_task_mutexes[hash_ptr(tsk, BP_TASK_MUTEX_BITS)] : NULL;
 }
 
 static struct mutex *bp_constraints_lock(struct perf_event *bp)
@@ -117,17 +117,7 @@ static struct mutex *bp_constraints_lock(struct perf_event *bp)
 	struct mutex *tsk_mtx = get_task_bps_mutex(bp);
 
 	if (tsk_mtx) {
-		/*
-		 * Fully analogous to the perf_try_init_event() nesting
-		 * argument in the comment near perf_event_ctx_lock_nested();
-		 * this child->perf_event_mutex cannot ever deadlock against
-		 * the parent->perf_event_mutex usage from
-		 * perf_event_task_{en,dis}able().
-		 *
-		 * Specifically, inherited events will never occur on
-		 * ->perf_event_list.
-		 */
-		mutex_lock_nested(tsk_mtx, SINGLE_DEPTH_NESTING);
+		mutex_lock(tsk_mtx);
 		percpu_down_read(&bp_cpuinfo_sem);
 	} else {
 		percpu_down_write(&bp_cpuinfo_sem);
@@ -1008,6 +998,9 @@ int __init init_hw_breakpoint(void)
 {
 	int ret;
 
+	for (int i = 0; i < ARRAY_SIZE(bp_task_mutexes); i++)
+		mutex_init(&bp_task_mutexes[i]);
+
 	ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
 	if (ret)
 		return ret;
-- 
2.56.1.750.gf70dc682cf-goog

