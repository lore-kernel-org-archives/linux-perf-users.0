Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139012AD0B;
	Wed, 22 Jan 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532667; cv=none; b=R7j1kL+d2VSVgL1UC+eSoTYGSqWJhnd2ZhL/uFe5JGc3sGCjSFRBM+CwbeSiNgo+gQ0HUgqhdWR/t0hYkHmwjjxPhjUoyZif9A6w5k+VxFD4tNKPzUAZBsyk+TRAOX1ikHc067L9xgIw6LCCzoYZURqaPutapUSGLWJZeD+e8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532667; c=relaxed/simple;
	bh=WDudFv2R3qllIHeIwmBhSefv8HWLQ+s3slBxDLJbBr8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jGexraBxgN3fox8RX/RZD2Csl5qL16/Hyk4uc3uBy3vIAaGGU5BWm9oEGQC0da8KwEkYqtE95cDuzdVVQlDIu2gT0x/jnu5k9ccIukKHLSP2fWmtjDJ1fa4i1n2PrFtes8D7II3pmI42gavumtHNeYwgXiScimAybuYP2rpALzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if necessary
Date: Wed, 22 Jan 2025 15:41:03 +0800
Message-ID: <20250122074103.3091-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BC-MAIL-EX01.internal.baidu.com (172.31.51.41) To
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-01-22 15:41:11:263
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-01-22 15:41:11:294
X-FEAS-Client-IP: 10.127.64.38
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
this can save 12K memory for each CPU

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/events/intel/bts.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8f78b0c..8e09319 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -36,7 +36,7 @@ enum {
 	BTS_STATE_ACTIVE,
 };
 
-static DEFINE_PER_CPU(struct bts_ctx, bts_ctx);
+static struct bts_ctx __percpu *bts_ctx;
 
 #define BTS_RECORD_SIZE		24
 #define BTS_SAFETY_MARGIN	4080
@@ -231,7 +231,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
 
 static void __bts_event_start(struct perf_event *event)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct bts_buffer *buf = perf_get_aux(&bts->handle);
 	u64 config = 0;
 
@@ -260,7 +260,7 @@ static void __bts_event_start(struct perf_event *event)
 static void bts_event_start(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct bts_buffer *buf;
 
 	buf = perf_aux_output_begin(&bts->handle, event);
@@ -290,7 +290,7 @@ static void bts_event_start(struct perf_event *event, int flags)
 
 static void __bts_event_stop(struct perf_event *event, int state)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 
 	/* ACTIVE -> INACTIVE(PMI)/STOPPED(->stop()) */
 	WRITE_ONCE(bts->state, state);
@@ -305,7 +305,7 @@ static void __bts_event_stop(struct perf_event *event, int state)
 static void bts_event_stop(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct bts_buffer *buf = NULL;
 	int state = READ_ONCE(bts->state);
 
@@ -338,7 +338,7 @@ static void bts_event_stop(struct perf_event *event, int flags)
 
 void intel_bts_enable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	int state = READ_ONCE(bts->state);
 
 	/*
@@ -358,7 +358,7 @@ void intel_bts_enable_local(void)
 
 void intel_bts_disable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 
 	/*
 	 * Here we transition from ACTIVE to INACTIVE;
@@ -450,7 +450,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
 int intel_bts_interrupt(void)
 {
 	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct perf_event *event = bts->handle.event;
 	struct bts_buffer *buf;
 	s64 old_head;
@@ -518,7 +518,7 @@ static void bts_event_del(struct perf_event *event, int mode)
 
 static int bts_event_add(struct perf_event *event, int mode)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -605,6 +605,10 @@ static __init int bts_init(void)
 		return -ENODEV;
 	}
 
+	bts_ctx = alloc_percpu(struct bts_ctx);
+	if (!bts_ctx)
+		return -ENOMEM;
+
 	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
 				  PERF_PMU_CAP_EXCLUSIVE;
 	bts_pmu.task_ctx_nr	= perf_sw_context;
-- 
2.9.4

