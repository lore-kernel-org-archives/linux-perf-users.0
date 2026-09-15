Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2E4AF9D5;
	Tue, 15 Sep 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487360; cv=none; b=pgk2haf9csDdqo4ty+YZ9KWF8lz5hbrDa+U0anu2+uHSsr4BCLxbB2YryC4phJmRO9OS/c6YRBC1KgP7xRm7TiKTrdanTqshAxvRcqT5RW7P85IoAiKGx+fuAjdFS5tMAcQjs7q/IF8qPkewad+a3G7zf3cKEe8Ct1dXQECjTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487360; c=relaxed/simple;
	bh=rzWBLuFeZQZl5yGb8RvJIlMSZz68zKpAICaDgrSBzSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nw+4PY7g44KykAu5ZmBpn0xJrSZJ4iF/TcoTed7x/PA1bkHdLZlMd1JDxTgLTS9bFJe79HWHDgERiKhmGZcok1UnNm98RL7cYI6OunHYMAClbbsvINyfLgSNEW11zEFvIHO3ksAsWu2949oBX8Fko0icFk83MaXUctjvolPq84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eKLnsicl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eKLnsicl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491A81570;
	Tue, 15 Sep 2026 08:49:13 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8044F3F882;
	Tue, 15 Sep 2026 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487356; bh=rzWBLuFeZQZl5yGb8RvJIlMSZz68zKpAICaDgrSBzSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eKLnsiclKicDCoZ/rB/R70y+EO9DbIexlf1O6Yb10Rv6CSilSlHAE9thwIc2HNElB
	 GoQBWpcBrUfJI+2VVbWemVQF8CA1uJ0t/fcAlO20lzPIZmU0MOG61mgK2i5oHB7x+B
	 hwntAJCW+bFowVKylN+sB+Rjd23zFqkGvfnHFDmM=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:51 +0100
Subject: [PATCH 05/25] coresight: perf: Extract AUX buffer update helper
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-5-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=4787;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rzWBLuFeZQZl5yGb8RvJIlMSZz68zKpAICaDgrSBzSA=;
 b=4HBcAcKHFe4Z45oSwhpAFqSLMoJr0D0hTz0E5G75YK2+UArFHFbpBZA1FUqME1bRFZPloWGo9
 wkUxKZvL/XuBdi3wav+Q9KeF+huvfDnz/ePbY8xjDF62bWATD2CQMb0
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The pause and stop callbacks duplicate the sequence that updates a sink
buffer and finishes the current AUX output transaction. Move the common
sequence into etm_event_update_buffer() for a single implementation.

The helper first verifies that perf handle is active. It updates the
buffer when PERF_EF_UPDATE is requested and otherwise ends the
transaction without data. The pause callback can then start a new perf
handle for resuming trace.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 89 ++++++++++--------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index a45f69f39f175f3044322b25fe5413fb97154496..13d865ca86f1161b2e21174f096473c4829afc8c 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -637,6 +637,38 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 }
 
+static void etm_event_update_buffer(struct perf_output_handle *handle,
+				    struct etm_event_data *event_data,
+				    struct coresight_device *sink,
+				    int mode)
+{
+	unsigned long size;
+
+	/*
+	 * Make sure the handle is still valid, as the sink may close it from
+	 * the IRQ handler. E.g., the sink driver may fail to restart the
+	 * handle during interrupt handling due to insufficient buffer space.
+	 * The sink driver must serialize update_buffer() with IRQ handling,
+	 * so this should return either a valid handle with a valid size
+	 * (which may be 0), or no handle at all.
+	 */
+	if (!perf_get_aux(handle))
+		return;
+
+	if (!sink_ops(sink)->update_buffer)
+		goto out;
+
+	if (mode & PERF_EF_UPDATE) {
+		size = sink_ops(sink)->update_buffer(sink, handle,
+						     event_data->snk_config);
+		perf_aux_output_end(handle, size);
+		return;
+	}
+
+out:
+	perf_aux_output_end(handle, 0);
+}
+
 static void etm_event_pause(struct coresight_path *path,
 			    struct perf_event *event,
 			    struct etm_ctxt *ctxt)
@@ -644,7 +676,6 @@ static void etm_event_pause(struct coresight_path *path,
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *source, *sink;
 	struct etm_event_data *event_data;
-	unsigned long size;
 
 	if (!path)
 		return;
@@ -669,27 +700,16 @@ static void etm_event_pause(struct coresight_path *path,
 	if (WARN_ON_ONCE(handle->event != event))
 		return;
 
-	if (!sink_ops(sink)->update_buffer)
-		return;
-
 	event_data = READ_ONCE(ctxt->event_data);
-	size = sink_ops(sink)->update_buffer(sink, handle,
-					     event_data->snk_config);
-	if (READ_ONCE(handle->event)) {
-		if (!size)
-			return;
+	etm_event_update_buffer(handle, event_data, sink, PERF_EF_UPDATE);
 
-		perf_aux_output_end(handle, size);
-		perf_aux_output_begin(handle, event);
-	} else {
-		WARN_ON_ONCE(size);
-	}
+	/* Prepare the handle for resuming trace */
+	perf_aux_output_begin(handle, event);
 }
 
 static void etm_event_stop(struct perf_event *event, int mode)
 {
 	int cpu = smp_processor_id();
-	unsigned long size;
 	struct coresight_device *source, *sink;
 	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
 	struct perf_output_handle *handle = &ctxt->handle;
@@ -742,45 +762,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	/* tell the core */
 	event->hw.state = PERF_HES_STOPPED;
 
-	/*
-	 * If the handle is not bound to an event anymore
-	 * (e.g, the sink driver was unable to restart the
-	 * handle due to lack of buffer space), we don't
-	 * have to do anything here.
-	 */
-	if (!handle->event)
-		goto out;
-
-	if (mode & PERF_EF_UPDATE) {
-		if (WARN_ON_ONCE(handle->event != event))
-			goto out;
-
-		/* update trace information */
-		if (!sink_ops(sink)->update_buffer)
-			goto out;
+	etm_event_update_buffer(handle, event_data, sink, mode);
 
-		size = sink_ops(sink)->update_buffer(sink, handle,
-					      event_data->snk_config);
-		/*
-		 * Make sure the handle is still valid as the
-		 * sink could have closed it from an IRQ.
-		 * The sink driver must handle the race with
-		 * update_buffer() and IRQ. Thus either we
-		 * should get a valid handle and valid size
-		 * (which may be 0).
-		 *
-		 * But we should never get a non-zero size with
-		 * an invalid handle.
-		 */
-		if (READ_ONCE(handle->event))
-			perf_aux_output_end(handle, size);
-		else
-			WARN_ON(size);
-	} else {
-		perf_aux_output_end(handle, 0);
-	}
-
-out:
 	/* Disabling the path make its elements available to other sessions */
 	coresight_disable_path(path);
 }

-- 
2.34.1

