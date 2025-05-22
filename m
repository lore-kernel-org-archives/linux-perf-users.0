Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FAA28D83C;
	Thu, 22 May 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926328; cv=none; b=Tf7FcVNFzkcW1eRXt8q66JRgC1qntKX9Wvld8Deuh5k5vnjbXRQLTxovs8wLmCV+h4mKRpeFF9aSGwGVGxJReYdKN2o8rVP/0TCBFpFy9+4EXIMCxu7n9l1NeMtJF89NYhYBj4beX1zdLFnatywXzn4m6KpBwIYUVZEVHAdVEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926328; c=relaxed/simple;
	bh=QCwBzjkhTS0fWQNm/uc3ctFPsORSVaqbTt6L7wL56dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iFC2+iWK9gKChev4DIi2A+uJ60MX2WlB7Yg7csAsMngEosj8O/EsPEYzV+t1owDuWEGrND6C/wWwSAxyQNS7ZlZ1qHMb+iptonUzADO5KcMXAdd+j4LoZwFyR2n83EjX6Tayr3yKD2vhZWZh5ui33CtXtHtmBZC7ak+kl4hhCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CCD31A2D;
	Thu, 22 May 2025 08:05:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B4D23F673;
	Thu, 22 May 2025 08:05:22 -0700 (PDT)
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
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf/aux: Properly launch pending disable flow
Date: Thu, 22 May 2025 16:05:10 +0100
Message-Id: <20250522150510.2942814-1-leo.yan@arm.com>
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

Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
Fixes: 2b84def990d3 ("perf: Split __perf_pending_irq() out of perf_pending_irq()")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

