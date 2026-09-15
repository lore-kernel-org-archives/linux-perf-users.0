Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8EE4BD7AB;
	Tue, 15 Sep 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487389; cv=none; b=tV6WnIs3R6XFoooe1pMOh5LShcqfvwZoFtmM5SXJ1nqgb1KNhqtwL3pHeCJV1oNjcLitw1N2gLAbk5F6JE7AH2CNWZLmD+RSzHjLLUnHmuYdp9Z714dcnqdw3B9vDyrO69grudq8YAkXsgKS+H0RzWhjbmKjcCvHID3jVxhUmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487389; c=relaxed/simple;
	bh=ZKZYRDVVp0NsuoaDwzVZFXX6CxcoXZSRDbOKmH0PKD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pb/1ubnkANDU3zPf2kwVRBD38YHJ4saPQzfRr1lCgCpzDuSgbiYx7vkFrOpUE7Jh5ojUKZjd3y7f4a80U44SrEmNP5HBwYo0IRedfn1TAoyM8dXi3w2oC5/UmhyTuucFA2A3L5RAuPIzwLhpV+Q+ULafNp2Yp6YbvSyDfyMwBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iwBQyhqt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iwBQyhqt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A2B81570;
	Tue, 15 Sep 2026 08:49:42 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF4093FA32;
	Tue, 15 Sep 2026 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487386; bh=ZKZYRDVVp0NsuoaDwzVZFXX6CxcoXZSRDbOKmH0PKD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iwBQyhqt5/kaHNeFDyr/p/2HpdclR8fbc4oObfPiESfQeEC/DnyzeQhCYV1Sh0aDk
	 1ElcwSDPcZENTgua5v4/Okcb2LNZbZEOTslOTBrQ3k0nUZIxcwXKMjjcnwKLnqiP75
	 HKvxSWFh4evi26maAWKm305Pt7Cn9Hdtf8UL7JlU=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:02 +0100
Subject: [PATCH 16/25] coresight: perf: Support AUX sampling with per-CPU
 sinks
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-16-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=6175;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ZKZYRDVVp0NsuoaDwzVZFXX6CxcoXZSRDbOKmH0PKD4=;
 b=iltpZVgZYT6qQh4lQMWIjomzyc/itbmeHADGpKU7IqxBZK0WaS13MZ6fvnf+EzbjvRpzgHECk
 eZ1aE9vgzu7DUjEKSmzoJmgvXW3faUT2Fp4iiGfiothiipmLAVeqNCL
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add snapshot_aux() for per-CPU sinks with overwrite buffers. Shared
sinks can mix trace from multiple CPUs, making them unsuitable for
context-based profiling.

Pad missing trace with leading zeros, or zero-fill the requested AUX
payload when a snapshot is unavailable. This ensures that the decoder
can safely discard the zero-filled trace data.

Reuse the AUX action guard to defer concurrent stops until the snapshot
finishes. Skip snapshots during sink interrupt handling. On copy or
restart failure, mark the AUX output truncated so perf core disables
the event.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 123 +++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.h |   2 +
 2 files changed, 125 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8020a4d8af18bb669441824cfdb687f4fa299eb4..5e90ed49562c117879780f573072e6b522d9d048 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -456,6 +456,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (!event_data)
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
+	event_data->overwrite = overwrite;
 
 	/* First get the selected sink from user space. */
 	sink_hash = ATTR_CFG_GET_FLD(&event->attr, sinkid);
@@ -863,6 +864,127 @@ static void etm_event_del(struct perf_event *event, int mode)
 	etm_event_stop(event, PERF_EF_UPDATE);
 }
 
+/* A zero trace size pads the sample without accessing the AUX handle. */
+static long etm_event_snapshot_aux_copy_data(struct perf_output_handle *aux_handle,
+					     struct perf_output_handle *handle,
+					     unsigned long trace_size,
+					     unsigned long size)
+{
+	unsigned long pad;
+	long ret;
+
+	trace_size = min(size, trace_size);
+
+	/* Pad the front with zeros to keep the latest trace data at the end */
+	pad = size - trace_size;
+	while (pad) {
+		unsigned long chunk = min(pad, PAGE_SIZE);
+
+		if (perf_output_copy(handle, page_address(ZERO_PAGE(0)), chunk))
+			return -EFAULT;
+		pad -= chunk;
+	}
+
+	/*
+	 * Skip an empty snapshot, as equal offsets would otherwise copy the
+	 * entire AUX ring.
+	 */
+	if (trace_size) {
+		unsigned long to = aux_handle->head;
+
+		ret = perf_output_copy_aux(aux_handle, handle, to - trace_size, to);
+		if (ret < 0)
+			return ret;
+	}
+
+	return size;
+}
+
+static long etm_event_snapshot_aux(struct perf_event *event,
+				   struct perf_output_handle *handle,
+				   unsigned long size)
+{
+	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
+	struct perf_output_handle *aux_handle = &ctxt->handle;
+	struct etm_event_data *event_data;
+	struct coresight_device *source, *sink;
+	struct coresight_path *path;
+	unsigned long trace_size;
+	long ret = 0;
+
+	if (!etm_event_aux_begin(event, ctxt))
+		goto padding;
+
+	if (READ_ONCE(event->hw.aux_paused))
+		goto out;
+
+	event_data = perf_get_aux(aux_handle);
+	if (!event_data || !event_data->overwrite)
+		goto out;
+
+	path = etm_event_get_ctxt_path(ctxt);
+	if (!path)
+		goto out;
+
+	source = coresight_get_source(path);
+	sink = coresight_get_sink(path);
+	if (WARN_ON_ONCE(!source || !sink))
+		goto out;
+
+	if (!coresight_is_percpu_sink(sink)) {
+		dev_err_once(&sink->dev, "AUX sampling requires a per-CPU sink\n");
+		goto out;
+	}
+
+	/* Skip snapshots that preempt the sink's interrupt handler */
+	if (READ_ONCE(sink->in_interrupt))
+		goto out;
+
+	coresight_pause_source(source);
+	trace_size = sink_ops(sink)->update_buffer(sink, aux_handle,
+						   event_data->snk_config);
+	coresight_disable_path(path);
+
+	/*
+	 * If the AUX handle was closed or marked truncated, the sink is
+	 * expected to have notified perf core to disable the AUX event.
+	 */
+	if (!perf_get_aux(aux_handle) ||
+	    (aux_handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
+		goto fail;
+
+	ret = etm_event_snapshot_aux_copy_data(aux_handle, handle, trace_size, size);
+	if (ret < 0)
+		goto fail;
+
+	if (coresight_enable_path(path, CS_MODE_PERF))
+		goto fail;
+
+	if (coresight_resume_source(source)) {
+		coresight_disable_path(path);
+		goto fail;
+	}
+
+	goto out;
+
+fail:
+	/* Set the truncated AUX flag so perf core can disable the event */
+	if (perf_get_aux(aux_handle)) {
+		perf_aux_output_flag(aux_handle, PERF_AUX_FLAG_TRUNCATED);
+		perf_aux_output_end(aux_handle, 0);
+	}
+
+out:
+	etm_event_aux_end(event, ctxt);
+
+padding:
+	/* Pad the buffer with zeros on an early exit */
+	if (!ret)
+		ret = etm_event_snapshot_aux_copy_data(NULL, handle, 0, size);
+
+	return ret;
+}
+
 static int etm_addr_filters_validate(struct list_head *filters)
 {
 	bool range = false, address = false;
@@ -1109,6 +1231,7 @@ int __init etm_perf_init(void)
 	etm_pmu.free_aux		= etm_free_aux;
 	etm_pmu.start			= etm_event_start;
 	etm_pmu.stop			= etm_event_stop;
+	etm_pmu.snapshot_aux		= etm_event_snapshot_aux;
 	etm_pmu.add			= etm_event_add;
 	etm_pmu.del			= etm_event_del;
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 24d929428633f56f24a114d5bb93b8ac4799ca11..a69eb04a597efcfe630342a410cbf8fea3c4501e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -89,6 +89,7 @@ struct etm_filters {
  * @aux_hwid_done:	Whether a CPU has emitted the TraceID packet or not.
  * @snk_config:		The sink configuration.
  * @cfg_hash:		The hash id of any coresight config selected.
+ * @overwrite:		Whether the AUX buffer uses overwrite mode.
  * @path:		An array of path, each slot for one CPU.
  */
 struct etm_event_data {
@@ -97,6 +98,7 @@ struct etm_event_data {
 	cpumask_t aux_hwid_done;
 	void *snk_config;
 	u32 cfg_hash;
+	bool overwrite;
 	struct coresight_path * __percpu *path;
 };
 

-- 
2.34.1

