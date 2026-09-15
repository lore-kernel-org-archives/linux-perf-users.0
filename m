Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8524B127B;
	Tue, 15 Sep 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487387; cv=none; b=ILEcOIlId/PlEJ2Dd08N1w1tR95OMdgZmwp6TL611SvfsNcLSmB0O82+fcvhYdGXbwu3vb7FPq8RPPY4yBEYqhVU5lVPTaMvpOwDGB+d2dIX630kSrhCnUght0RtlEANO9RG2k1VuSnBMBrmHAxbtPmYLeDMHCr8LIO6KBUSUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487387; c=relaxed/simple;
	bh=5dh0uFLLLCouP6+OkfA97GnOOv7HsvkRRHLYhRReAf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWBTG4IwA+JItkWR2khrztqVQ7j0uJHeZc9bksf5AkK/BIRCFmiqMtv0c0cwgrhMdsQRNezaRAbWF2V0lnPHr2b2KRomJPiznli+Hm7cXA7FsoAoRvStAVdaCjGFIDs4ZDQe14TI1Nu2MLCE6/Pef4S5nom4qd+/8OYK2HMbB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NPKnQfww; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NPKnQfww"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D91EA15A1;
	Tue, 15 Sep 2026 08:49:39 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101303F882;
	Tue, 15 Sep 2026 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487383; bh=5dh0uFLLLCouP6+OkfA97GnOOv7HsvkRRHLYhRReAf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NPKnQfwwyvGRJkLdxdOuc4DOxZn0cS2zl3Sh37gf6CPZnWQVn7czhkpqTqTfXIIhU
	 JB69zI4H+zsQf4n/MUf8QXe97FeYiUEKeIhccYslYxwQU7bNrv2YPlL6KVTqMJvFcz
	 HZltalMaNQCuhZf4jlVtVXZe8eglNsAlvLmM/sKQ=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:01 +0100
Subject: [PATCH 15/25] coresight: perf: Serialize AUX pause and resume with
 event stops
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-15-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=7280;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=5dh0uFLLLCouP6+OkfA97GnOOv7HsvkRRHLYhRReAf8=;
 b=J1K+IWYMMLhzPcADLZNzQcjitD4TM/hnwUjyZeGWvamWNJUNExstCLAeZGNbjXw+P25hWod0G
 tcZpp4WVbX/BxhjEK9GOI09oVf8Z0ykXyeXAaZvljMidgM4vmEkRub3
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

A PMU NMI can throttle a group during an AUX pause or resume, stopping
its CoreSight event before the callback finishes. The callback can then
restart tracing or reopen an AUX output handle after teardown.

Use per-CPU atomic STOP and AUX bits to serialize these callbacks. Reject
AUX operations while a stop is pending and defer stops until an active
AUX operation finishes. Complete deferred stops through etm_event_stop()
and set PERF_HES_STOPPED only after disabling the source and path.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 104 ++++++++++++++++++-----
 1 file changed, 84 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8f803914e9abfb18e080ff68371ad8b32042f180..8020a4d8af18bb669441824cfdb687f4fa299eb4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
@@ -26,6 +27,9 @@
 #include "coresight-syscfg.h"
 #include "coresight-trace-id.h"
 
+#define ETM_PERF_ACT_STOP		BIT(0)
+#define ETM_PERF_ACT_AUX		BIT(1)
+
 static struct pmu etm_pmu;
 static bool etm_perf_up;
 
@@ -46,6 +50,7 @@ static bool etm_perf_up;
 struct etm_ctxt {
 	struct perf_output_handle handle;
 	struct etm_event_data *event_data;
+	atomic_t action;
 };
 
 static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
@@ -531,33 +536,69 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	goto out;
 }
 
-static int etm_event_resume(struct etm_ctxt *ctxt)
+static void etm_event_stop(struct perf_event *event, int mode);
+
+static bool etm_event_aux_begin(struct perf_event *event, struct etm_ctxt *ctxt)
+{
+	int action;
+
+	/* Claim exclusive access for the AUX operation */
+	action = atomic_fetch_or(ETM_PERF_ACT_AUX, &ctxt->action);
+	if (action & ETM_PERF_ACT_AUX)
+		return false;
+
+	/* Leave an existing stop to finish its own work */
+	if ((action & ETM_PERF_ACT_STOP) ||
+	    (READ_ONCE(event->hw.state) & PERF_HES_STOPPED)) {
+		atomic_fetch_andnot(ETM_PERF_ACT_AUX, &ctxt->action);
+		return false;
+	}
+
+	return true;
+}
+
+static void etm_event_aux_end(struct perf_event *event, struct etm_ctxt *ctxt)
+{
+	int action;
+
+	/* Complete any stop deferred while the AUX operation was active */
+	action = atomic_fetch_andnot(ETM_PERF_ACT_AUX, &ctxt->action);
+	if (action & ETM_PERF_ACT_STOP)
+		etm_event_stop(event, PERF_EF_UPDATE);
+}
+
+static int etm_event_resume(struct perf_event *event, struct etm_ctxt *ctxt)
 {
 	struct perf_output_handle *handle = &ctxt->handle;
-	struct perf_event *event = handle->event;
 	struct coresight_device *source;
 	struct coresight_path *path;
-	int ret;
+	int ret = 0;
 
-	if (!perf_get_aux(handle))
+	if (!etm_event_aux_begin(event, ctxt))
 		return 0;
 
+	if (!perf_get_aux(handle))
+		goto out;
+
 	path = etm_event_get_ctxt_path(ctxt);
 	if (!path)
-		return 0;
+		goto out;
 
 	source = coresight_get_source(path);
 	if (!source)
-		return 0;
+		goto out;
 
 	ret = coresight_resume_source(source);
 	if (ret < 0) {
 		dev_err(&source->dev, "Failed to resume ETM event.\n");
-		return ret;
+		goto out;
 	}
 
 	etm_event_clear_hw_state(event, PERF_HES_UPTODATE);
-	return 0;
+
+out:
+	etm_event_aux_end(event, ctxt);
+	return ret;
 }
 
 static void etm_event_start(struct perf_event *event, int flags)
@@ -571,7 +612,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	u64 hw_id;
 
 	if (flags & PERF_EF_RESUME) {
-		WARN_ON_ONCE(etm_event_resume(ctxt));
+		WARN_ON_ONCE(etm_event_resume(event, ctxt));
 		return;
 	}
 
@@ -697,18 +738,22 @@ static void etm_event_update_buffer(struct perf_event *event,
 static void etm_event_pause(struct perf_event *event,
 			    struct etm_ctxt *ctxt)
 {
-	struct coresight_path *path = etm_event_get_ctxt_path(ctxt);
+	struct coresight_path *path;
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *source, *sink;
 	struct etm_event_data *event_data;
 
-	if (!path)
+	if (!etm_event_aux_begin(event, ctxt))
 		return;
 
+	path = etm_event_get_ctxt_path(ctxt);
+	if (!path)
+		goto out;
+
 	source = coresight_get_source(path);
 	sink = coresight_get_sink(path);
 	if (WARN_ON_ONCE(!source || !sink))
-		return;
+		goto out;
 
 	/* Stop tracer */
 	coresight_pause_source(source);
@@ -720,7 +765,7 @@ static void etm_event_pause(struct perf_event *event,
 	 * disallows updating buffer for the per CPU sink case.
 	 */
 	if (coresight_is_percpu_sink(sink))
-		return;
+		goto out;
 
 	event_data = READ_ONCE(ctxt->event_data);
 	etm_event_update_buffer(event, handle, event_data, sink,
@@ -728,6 +773,9 @@ static void etm_event_pause(struct perf_event *event,
 
 	/* Prepare the handle for resuming trace */
 	perf_aux_output_begin(handle, event);
+
+out:
+	etm_event_aux_end(event, ctxt);
 }
 
 static void etm_event_stop(struct perf_event *event, int mode)
@@ -738,13 +786,28 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct coresight_path *path;
 	struct hw_perf_event *hwc = &event->hw;
 	struct etm_event_data *event_data;
+	int action;
+
+	if (mode & PERF_EF_PAUSE) {
+		etm_event_pause(event, ctxt);
+		return;
+	}
 
 	/* If we're already stopped, then nothing to do */
 	if (READ_ONCE(hwc->state) & PERF_HES_STOPPED)
 		return;
 
-	if (mode & PERF_EF_PAUSE)
-		return etm_event_pause(event, ctxt);
+	/* Leave STOP pending until the AUX operation releases its action bit */
+	action = atomic_fetch_or(ETM_PERF_ACT_STOP, &ctxt->action);
+	if (action & ETM_PERF_ACT_AUX)
+		return;
+
+	/*
+	 * A repeated throttling stop must not interrupt an active teardown.
+	 * PERF_EF_UPDATE lets the AUX callback complete a deferred stop.
+	 */
+	if ((action & ETM_PERF_ACT_STOP) && !(mode & PERF_EF_UPDATE))
+		return;
 
 	path = etm_event_get_ctxt_path(ctxt);
 
@@ -754,7 +817,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	 */
 	if (!path) {
 		etm_event_set_hw_state(event, PERF_HES_STOPPED | PERF_HES_UPTODATE);
-		return;
+		goto out;
 	}
 
 	event_data = READ_ONCE(ctxt->event_data);
@@ -764,18 +827,19 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	source = coresight_get_source(path);
 	sink = coresight_get_sink(path);
 	if (!source || !sink)
-		return;
+		goto out;
 
 	/* stop tracer */
 	coresight_disable_source(source, event);
 
-	/* tell the core */
-	etm_event_set_hw_state(event, PERF_HES_STOPPED);
-
 	etm_event_update_buffer(event, handle, event_data, sink, mode);
 
 	/* Disabling the path make its elements available to other sessions */
 	coresight_disable_path(path);
+	etm_event_set_hw_state(event, PERF_HES_STOPPED);
+
+out:
+	atomic_fetch_andnot(ETM_PERF_ACT_STOP, &ctxt->action);
 }
 
 static int etm_event_add(struct perf_event *event, int mode)

-- 
2.34.1

