Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABE265614
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837582; cv=none; b=GaGtRKqH7tcyACrgKOh7pBjs9kE3uLswcn97szQuV99WO+Gyk0GCU3pObUBsfNe3L2PkFda3i7/6nDOTHrWrNayaF9oWS1Pc+7di2IJ8008VLBBMGmldyEcLFwv1OUN4YYlUMpD5u2upbV+4t5SY6xrarFfKh3L9ZWt8Ip9zcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837582; c=relaxed/simple;
	bh=r3ssglzgAyQY/LauolaMvaMBF1AHt8NxHXUa6wJ8Sj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W3BjVFA8W6AAP9K1pNpFsn0guO+Avq7T1qw9zDMBhAw0Nb+dALHXM8rCeeavx8Ifk0PmP8nZm05hqWhqQzUbfcr0oCU5YzLrbQvdSNhAHz5epYwDJlri2l/fHnsm3Z2mfbftSAXoxlNNyqfk43izd7ixOSqv1u8CQbr7aCGXLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Gr2/oF/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Gr2/oF/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8c5d185aso14009003a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837580; x=1743442380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=c4X7EuSOF1wxl7FggRxYWtDduMoeYbDYpmIUw2UV9ss=;
        b=3Gr2/oF/hSSb8mwQzfKAg5lunr08DhkCyOImNCLnSer7WpLucsML9voWLMcn+7ZBaC
         eOPM5CcYDM84sufWiqfCheFHOZJeo8oXF17MPVQBzMAQQqyy0Hd0pFybMTy/Xjv05KXy
         us8HS1V11q2slIwf9CSn6H6lqtZnzrL1oHgzhlRj3NpKGvUyzYkBasShX1EfgYTmiEO7
         eeGopja5nZLUl+n1vrsKMjhCcruO5VPqENml0foG0vg4nZVQ2BwAjcMp1OrGl+kJRgz5
         OkfMdhXAA0oxCXoCBVe2lMBMB/qlnONnTbxDsdLk66vqzn0W0yg8Jz/1AXNcDMlJUiMb
         qjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837580; x=1743442380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4X7EuSOF1wxl7FggRxYWtDduMoeYbDYpmIUw2UV9ss=;
        b=HBEPZc3pdMgHaWgiX5iXHf7K1jbNriVtKIPpuPHXt0u09ebwrNHpk4o1TKyPRtL55J
         RABUM1elIdQhU2sKVTG4GIeMDR4JNFdGIIk6YubWkkaappBB45cVnTuVPG56qaGFJb+s
         2n28PMLUcI2ag+q1SzYZtyEgCfdL2f5Egr6PlZgkNvGjSQdOcyixPjrhvN20oQypYwkA
         nufTS9/na5+w/GJzPw/drdX+suF1JD+b14sLZQWoiH16xXoqfvz48ieA+8ugFvgmPt7/
         VUHg/AR8wE7ipdCdLkBf0hshfgASsWuyiWQg4dqOtCsRRYWtPMmdCAdj1DQB1XmaJeRZ
         +fWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3LIi996guQxvMWqOfNs3mKA0J+JYwSEGdd/420JebhhsS1+z/1+JisJEH3yxse8KjYzy7nsO5HyB7+SDHoH84@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6qv1jq5geVJLJBPOsNJQAWXYhWnFrTB4Nsnankw/8jj7ffXp
	K1wguMT5v444AWCvzea/PX1lpL0RmmdbF191T/h6+qJ4bIBfLUVWpb1DP1xDPBo1B1QhAp7DwVh
	Ffz1isA==
X-Google-Smtp-Source: AGHT+IHhGvCKjJ5ueOY8WQhpRpbhZlPUOf/OMT+/j5IrFuYXtKUWrdlNkLg1d1zUxlvPTuSGiVaHP6pIolC9
X-Received: from pjf4.prod.google.com ([2002:a17:90b:3f04:b0:2fa:284f:adb2])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134b:b0:2ea:712d:9a82
 with SMTP id 98e67ed59e1d1-3031001d8fcmr22027868a91.29.1742837579839; Mon, 24
 Mar 2025 10:32:59 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:45 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-6-mizhang@google.com>
Subject: [PATCH v4 05/38] perf: Add generic exclude_guest support
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

Only KVM knows the exact time when a guest is entering/exiting. Expose
two interfaces to KVM to switch the ownership of the PMU resources.

All the pinned events must be scheduled in first. Extend the
perf_event_sched_in() helper to support extra flag, e.g., EVENT_GUEST.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 include/linux/perf_event.h |  4 ++
 kernel/events/core.c       | 80 ++++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7bda1e20be12..37187ee8e226 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1822,6 +1822,8 @@ extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
 int perf_get_mediated_pmu(void);
 void perf_put_mediated_pmu(void);
+void perf_guest_enter(void);
+void perf_guest_exit(void);
 #else /* !CONFIG_PERF_EVENTS: */
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
@@ -1919,6 +1921,8 @@ static inline int perf_get_mediated_pmu(void)
 }
 
 static inline void perf_put_mediated_pmu(void)			{ }
+static inline void perf_guest_enter(void)			{ }
+static inline void perf_guest_exit(void)			{ }
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7a2115b2c5c1..d05487d465c9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2827,14 +2827,15 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 				struct perf_event_context *ctx,
-				struct pmu *pmu)
+				struct pmu *pmu,
+				enum event_type_t event_type)
 {
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_PINNED | event_type);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE | event_type);
 }
 
 /*
@@ -2890,7 +2891,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (event_type & EVENT_PINNED)
 		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx, pmu);
+	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
 
 	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
@@ -4188,7 +4189,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
-	perf_event_sched_in(cpuctx, ctx, NULL);
+	perf_event_sched_in(cpuctx, ctx, NULL, 0);
 
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
@@ -6040,6 +6041,71 @@ void perf_put_mediated_pmu(void)
 }
 EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
 
+static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
+{
+	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
+	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
+	if (cpuctx->task_ctx) {
+		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
+		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
+		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
+	}
+}
+
+/* When entering a guest, schedule out all exclude_guest events. */
+void perf_guest_enter(void)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+
+	lockdep_assert_irqs_disabled();
+
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+
+	if (WARN_ON_ONCE(__this_cpu_read(perf_in_guest)))
+		goto unlock;
+
+	perf_host_exit(cpuctx);
+
+	__this_cpu_write(perf_in_guest, true);
+
+unlock:
+	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
+}
+EXPORT_SYMBOL_GPL(perf_guest_enter);
+
+static inline void perf_host_enter(struct perf_cpu_context *cpuctx)
+{
+	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
+	if (cpuctx->task_ctx)
+		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
+
+	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
+
+	if (cpuctx->task_ctx)
+		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
+}
+
+void perf_guest_exit(void)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+
+	lockdep_assert_irqs_disabled();
+
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+
+	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
+		goto unlock;
+
+	perf_host_enter(cpuctx);
+
+	__this_cpu_write(perf_in_guest, false);
+unlock:
+	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
+}
+EXPORT_SYMBOL_GPL(perf_guest_exit);
+
 /*
  * Holding the top-level event's child_mutex means that any
  * descendant process that has inherited this event will block
-- 
2.49.0.395.g12beb8f557-goog

