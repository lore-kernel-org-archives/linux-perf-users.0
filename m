Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61361CD2B;
	Thu,  6 Mar 2025 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741238276; cv=none; b=bZyY8eo3J5Up5+fMqpQCZ8aON9+JwEXdGQUl5ApqKiGfPPb9kgGZuaQg7YPo/+x2hXEQ/uDyR3xlggye+TRrpKdEeW9HJ8a3bIIDMzlZQ0CttVdHw9AljPVUNErIZZDoTKggg2GVAs8F8jKaN8zEi3GV04ZDybYiJhr9BCYglTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741238276; c=relaxed/simple;
	bh=nAYrs8NJidgWSkW7vHjvMuwcwrY5Il+RPBY2gnn6LKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+wFcP1FffNqyS23AlyRMDHzVuK0WF3p5HPPgMJxCcu8/9OCNUyztZYg8kaLZ2XE9xnUxlym70Q3PWvfvTr3ri3LVxEmHrm0vVLdens6ckQOI3+RXVApClb6rGG5T/vPnCJ7dJHvz50kUB6k/UzZu6+h9PypdZodUQZMK5esS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <olsajiri@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][next] perf/x86/intel/bts: check if bts_ctx is allocated when call bts functions
Date: Thu, 6 Mar 2025 13:11:02 +0800
Message-ID: <20250306051102.2642-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) To
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-03-06 13:11:10:779
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-03-06 13:11:10:810
X-FEAS-Client-IP: 10.127.64.38
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

bts_ctx maybe not allocated, for example if the cpu has X86_FEATURE_PTI,
but intel_bts_disable/enable_local and intel_bts_interrupt are called
unconditionally from intel_pmu_handle_irq and exploding on accessing
bts_ctx

so check if bts_ctx is allocated when call bts functions

Fixes: 3acfcefa795c "(perf/x86/intel/bts: Allocate bts_ctx only if necessary)"
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/events/intel/bts.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8e09319..e8b3e7b 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -338,9 +338,14 @@ static void bts_event_stop(struct perf_event *event, int flags)
 
 void intel_bts_enable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
-	int state = READ_ONCE(bts->state);
+	struct bts_ctx *bts;
+	int state;
 
+	if (!bts_ctx)
+		return;
+
+	bts = this_cpu_ptr(bts_ctx);
+	state = READ_ONCE(bts->state);
 	/*
 	 * Here we transition from INACTIVE to ACTIVE;
 	 * if we instead are STOPPED from the interrupt handler,
@@ -358,7 +363,12 @@ void intel_bts_enable_local(void)
 
 void intel_bts_disable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
+	struct bts_ctx *bts;
+
+	if (!bts_ctx)
+		return;
+
+	bts = this_cpu_ptr(bts_ctx);
 
 	/*
 	 * Here we transition from ACTIVE to INACTIVE;
@@ -450,12 +460,17 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
 int intel_bts_interrupt(void)
 {
 	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
-	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
-	struct perf_event *event = bts->handle.event;
+	struct bts_ctx *bts;
+	struct perf_event *event;
 	struct bts_buffer *buf;
 	s64 old_head;
 	int err = -ENOSPC, handled = 0;
 
+	if (!bts_ctx)
+		return 0;
+
+	bts = this_cpu_ptr(bts_ctx);
+	event = bts->handle.event;
 	/*
 	 * The only surefire way of knowing if this NMI is ours is by checking
 	 * the write ptr against the PMI threshold.
-- 
2.9.4

