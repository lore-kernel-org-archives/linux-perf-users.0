Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5A42C1A2;
	Wed, 25 Jun 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871268; cv=none; b=VboGfk0uHt9GZnickjBquBmcpC4OAlbv24yiYVN/iSdjGXzHKFVCSU7blWkBLKmIoRjMtXsQ+d4LcJNTX9RIYIqd/0DRnSsyzQsGEHKVGyOjYVWhKDQ22eS6rzsEIhFMD6LjgB3ewU5PbvWZAW5pRZxtTfYlt1WbQHRxBHrfYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871268; c=relaxed/simple;
	bh=zjQ8JAxMMfKKMsmAptZqynlrTC/dCMOf5Z60eneNcWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DyXzJ9BEWIpMhAATya7jbi23S2AvJ5kR6vww4NPNJE2ZnKsXo6Mvu+d3GBcPqlSim5vaGKhv1JEaGWzjWhiWs+dHaXU8TqiJnn/2iyHTAFLnYs1a32bTNWAJIkYrvlBzAMjGobIKKfO+BySS6vaBqs0n+Vz5ETuKETPejh5B/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C5AE106F;
	Wed, 25 Jun 2025 10:07:27 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCE8B3F58B;
	Wed, 25 Jun 2025 10:07:42 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2] perf/aux: Properly launch pending disable flow
Date: Wed, 25 Jun 2025 18:07:37 +0100
Message-Id: <20250625170737.2918295-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an AUX event overruns, the event core layer intends to disable the
event by setting the 'pending_disable' flag. Unfortunately, the event
is not actually disabled afterwards.

Since commit ca6c21327c6a ("perf: Fix missing SIGTRAPs"), the
'pending_disable' flag was changed to a boolean toggles. However, the
AUX event code was not updated accordingly. The flag ends up holding a
CPU number. If this number is zero, the flag is taken as false and the
IRQ work is never triggered.

Later, with commit 2b84def990d3 ("perf: Split __perf_pending_irq() out
of perf_pending_irq()"), a new IRQ work 'pending_disable_irq' was
introduced to handle event disabling. The AUX event path was not updated
to kick off the work queue.

To fix this issue, when an AUX ring buffer overrun is detected, call
perf_event_disable_inatomic() to initiate the pending disable flow.

The comment for setting the flag is outdated; update it to reflect the
boolean values (0 or 1).

Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
Fixes: 2b84def990d3 ("perf: Split __perf_pending_irq() out of perf_pending_irq()")
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---

Changes from v1:
- Updated the comment for boolean values (0 or 1) (James Clark).

 kernel/events/core.c        | 6 +++---
 kernel/events/ring_buffer.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f746469fda5..7281230044d0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7251,15 +7251,15 @@ static void __perf_pending_disable(struct perf_event *event)
 	 *  CPU-A			CPU-B
 	 *
 	 *  perf_event_disable_inatomic()
-	 *    @pending_disable = CPU-A;
+	 *    @pending_disable = 1;
 	 *    irq_work_queue();
 	 *
 	 *  sched-out
-	 *    @pending_disable = -1;
+	 *    @pending_disable = 0;
 	 *
 	 *				sched-in
 	 *				perf_event_disable_inatomic()
-	 *				  @pending_disable = CPU-B;
+	 *				  @pending_disable = 1;
 	 *				  irq_work_queue(); // FAILS
 	 *
 	 *  irq_work_run()
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index d2aef87c7e9f..aa9a759e824f 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -441,7 +441,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 		 * store that will be enabled on successful return
 		 */
 		if (!handle->size) { /* A, matches D */
-			event->pending_disable = smp_processor_id();
+			perf_event_disable_inatomic(handle->event);
 			perf_output_wakeup(handle);
 			WRITE_ONCE(rb->aux_nest, 0);
 			goto err_put;
@@ -526,7 +526,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 
 	if (wakeup) {
 		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
-			handle->event->pending_disable = smp_processor_id();
+			perf_event_disable_inatomic(handle->event);
 		perf_output_wakeup(handle);
 	}
 
-- 
2.34.1

