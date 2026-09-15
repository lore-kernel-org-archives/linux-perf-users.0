Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DA74AC158;
	Tue, 15 Sep 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487363; cv=none; b=jGPPBXXwTqFs7cnvcK0Xi3D9DPmYD4jRuUFD668xwG/bcxxcI1vSlg92XJnbUh6NOIvi6IWK6FegSaW25qQIC7x3kRDJgla31/Re946fca6IOuFdBjinAlxihWDyKtEie42XuJGJd4f+Mwf6uUOOCi1liS7B5b+uf5+IgsglrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487363; c=relaxed/simple;
	bh=7nL38er/+3j2hefe4RM396+0d0LyX5ets3LkSWVeuic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDU5zpbkzVV9QnjoQ2lVjs63wuSrf9gC4CNr1PCLdTxOQ0V8itLcDvM3h6XU4BR+BJfX8NesYlWwVkTYFRnujP/o+xoREenSqURv+UIRokTZ702Bz04w0jPX/A99v/y0EW9F/l16FxSoM1GMi/9YuUK4b5/Au9BfLYkqbNJyW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UlXrf9bG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UlXrf9bG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E93AA15A1;
	Tue, 15 Sep 2026 08:49:15 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B6773F882;
	Tue, 15 Sep 2026 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487359; bh=7nL38er/+3j2hefe4RM396+0d0LyX5ets3LkSWVeuic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UlXrf9bG1nHvsbhlDq2E4hvdQ48e/xgGnPNTqQnkUU4iMAcdyjk5Mt6dgF/xRyREu
	 feRnKvGE6IhJfCvhg0WoKaA+7s9dDK9us7GIGGAyACSnr2WuhftjKjZpH6b/c3Y8u6
	 i5Th0XLO4bVHaTfCxF4xOxlC4PjanWLQ860IuneQ=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:52 +0100
Subject: [PATCH 06/25] coresight: perf: Simplify flow for CPUs without a
 path
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-6-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=3816;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7nL38er/+3j2hefe4RM396+0d0LyX5ets3LkSWVeuic=;
 b=8hME0Sh1ecVqfaF48gsV60DOyQlz651sF79Du8NnfVGtAoHKy6TX9oE3uLjzBJnEoXJECmOCH
 AMvYvk+9zeZBU+1uYlbRdJ1DDFFJtH9TmAdvqCUhqWwnBwrNAlCeU0p
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

etm_setup_aux() removes a CPU from the event mask when it cannot build a
path from that CPU's ETM to the selected sink. The start nevertheless
allocates buffer handle and keeps event data active until the
corresponding stop callback.

End the newly acquired handle immediately when the current CPU is not in
the mask, and do not publish event data in the per-CPU context. The
event remains logically active so that a task event can trace after
migrating to an eligible CPU. A stop on the unsupported CPU then has no
CoreSight modules to disable or trace data to synchronize. Mark its
hardware state stopped and up to date.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 38 +++++++++++-------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 13d865ca86f1161b2e21174f096473c4829afc8c..afd22fd4a851e600ab69fd5b6883e6f8518b2cab 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -572,13 +572,15 @@ static void etm_event_start(struct perf_event *event, int flags)
 	 * the sink was specified or hinted to the driver. For
 	 * now, simply don't record anything on this ETM.
 	 *
-	 * As such we pretend that everything is fine, and let
-	 * it continue without actually tracing. The event could
-	 * continue tracing when it moves to a CPU where it is
-	 * reachable to a sink.
+	 * In that case, leave the event logically active but stop AUX
+	 * output on this CPU. The event could continue tracing when
+	 * it moves to a CPU where it is reachable to a sink.
 	 */
-	if (!cpumask_test_cpu(cpu, &event_data->mask))
-		goto out;
+	if (!cpumask_test_cpu(cpu, &event_data->mask)) {
+		perf_aux_output_end(handle, 0);
+		event->hw.state = 0;
+		return;
+	}
 
 	path = etm_event_cpu_path(event_data, cpu);
 	path->handle = handle;
@@ -613,7 +615,6 @@ static void etm_event_start(struct perf_event *event, int flags)
 		perf_report_aux_output_id(event, hw_id);
 	}
 
-out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;
 	/* Save the event_data for this ETM */
@@ -709,7 +710,6 @@ static void etm_event_pause(struct coresight_path *path,
 
 static void etm_event_stop(struct perf_event *event, int mode)
 {
-	int cpu = smp_processor_id();
 	struct coresight_device *source, *sink;
 	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
 	struct perf_output_handle *handle = &ctxt->handle;
@@ -719,6 +719,15 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	if (mode & PERF_EF_PAUSE)
 		return etm_event_pause(path, event, ctxt);
 
+	/*
+	 * With no path enabled, there is no hardware to stop or trace data
+	 * to synchronize. Mark the event stopped and up to date.
+	 */
+	if (!path) {
+		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+		return;
+	}
+
 	/*
 	 * If we still have access to the event_data via handle,
 	 * confirm that we haven't messed up the tracking.
@@ -738,19 +747,6 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	if (WARN_ON(!event_data))
 		return;
 
-	/*
-	 * Check if this ETM was allowed to trace, as decided at
-	 * etm_setup_aux(). If it wasn't allowed to trace, then
-	 * nothing needs to be torn down other than outputting a
-	 * zero sized record.
-	 */
-	if (handle->event && (mode & PERF_EF_UPDATE) &&
-	    !cpumask_test_cpu(cpu, &event_data->mask)) {
-		event->hw.state = PERF_HES_STOPPED;
-		perf_aux_output_end(handle, 0);
-		return;
-	}
-
 	source = coresight_get_source(path);
 	sink = coresight_get_sink(path);
 	if (!source || !sink)

-- 
2.34.1

