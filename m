Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D1FC43334
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 15:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiGDPG5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiGDPGf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 11:06:35 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748BA11837
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Jul 2022 08:06:22 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id q18-20020a056402519200b004358ce90d97so7260347edd.4
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Jul 2022 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JfXu58z7UaUBjps4RoWkmcCG0rF85BXMjQyAUe0XzyE=;
        b=VH8XGPdq62Rza3vnPLknKrk0O1f7xVvLleAZbm2MuAvWCkVYSREcclsFfFCR1CwIoO
         nCzhh6GvtP6VQW3QMca5QB99LCVrwz+BWC4MGI82dimzDLsavq8xUci/JqBjiuDp0Kb8
         So9Ko2+q+ZP0vECWlvc72jWJ6CL3/K5a6LFTXzLsZBZufux7iopT/hsVDBP5DWHOSGtN
         YWILQ1TXAQjR/kH26tERJBcGD8his0ED7idiYMBtIoIq1UzxVBOnt70ESO5U7fREgsCz
         hh5LKAqZodTnQe9j/qsquwkpMRdMXEfmE+okX9lnSce+4/H9s63GYBxUwsBCWu1XdtG9
         uczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JfXu58z7UaUBjps4RoWkmcCG0rF85BXMjQyAUe0XzyE=;
        b=NTbURyx5/nNATJVmWqV1I8TVuXGOrAj9B93O10zx7gUlUIu1O+pSGm2tUWLggPC0tQ
         iOsjLoFSzN6IRYFG41iBu4ZDYo1XlfCiBz0u21QmKsaxSxgO65oRpEibPXPmV10V60Q7
         m9SLFPQKD+xeYLfjdrytjiQg1mQ0cQAVLRIimzDe7hSs2gBdFB8enCNmaLe/GVjhj4ll
         NTCqy08soA+UIm4JOcZQFlTZXt7ZM7SpHSJhzk2Qh+BmSl1maxWWXC3HYsOpiboPzX2Y
         lxt9ApS8Am2lvRhyHZ6H9nqyfVqGXRTCb3KnDXzczXLzNAkjz2uu0oqxZC1wonirP8F6
         5ILg==
X-Gm-Message-State: AJIora+lwtLWkBNJTBvmv9BrmlEHff9qC6Tgk5zf92xSObRz91ZOWS1y
        kQ/50MJdN01GLHrhFm31+MAv+g8WuA==
X-Google-Smtp-Source: AGRyM1siXSFXZcWR78TTJCh5dE+mn6R6iPz2ggivbemr0O5xdPKyOiNLVgqWLxlqyFGrsun4FJDJOes5rQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:a05:6402:4446:b0:43a:3f52:4172 with SMTP id
 o6-20020a056402444600b0043a3f524172mr9836137edb.417.1656947180619; Mon, 04
 Jul 2022 08:06:20 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:09 +0200
In-Reply-To: <20220704150514.48816-1-elver@google.com>
Message-Id: <20220704150514.48816-10-elver@google.com>
Mime-Version: 1.0
References: <20220704150514.48816-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 09/14] powerpc/hw_breakpoint: Avoid relying on caller synchronization
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Internal data structures (cpu_bps, task_bps) of powerpc's hw_breakpoint
implementation have relied on nr_bp_mutex serializing access to them.

Before overhauling synchronization of kernel/events/hw_breakpoint.c,
introduce 2 spinlocks to synchronize cpu_bps and task_bps respectively,
thus avoiding reliance on callers synchronizing powerpc's hw_breakpoint.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
v2:
* New patch.
---
 arch/powerpc/kernel/hw_breakpoint.c | 53 ++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 2669f80b3a49..8db1a15d7acb 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/spinlock.h>
 #include <linux/debugfs.h>
 #include <linux/init.h>
 
@@ -129,7 +130,14 @@ struct breakpoint {
 	bool ptrace_bp;
 };
 
+/*
+ * While kernel/events/hw_breakpoint.c does its own synchronization, we cannot
+ * rely on it safely synchronizing internals here; however, we can rely on it
+ * not requesting more breakpoints than available.
+ */
+static DEFINE_SPINLOCK(cpu_bps_lock);
 static DEFINE_PER_CPU(struct breakpoint *, cpu_bps[HBP_NUM_MAX]);
+static DEFINE_SPINLOCK(task_bps_lock);
 static LIST_HEAD(task_bps);
 
 static struct breakpoint *alloc_breakpoint(struct perf_event *bp)
@@ -174,7 +182,9 @@ static int task_bps_add(struct perf_event *bp)
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
+	spin_lock(&task_bps_lock);
 	list_add(&tmp->list, &task_bps);
+	spin_unlock(&task_bps_lock);
 	return 0;
 }
 
@@ -182,6 +192,7 @@ static void task_bps_remove(struct perf_event *bp)
 {
 	struct list_head *pos, *q;
 
+	spin_lock(&task_bps_lock);
 	list_for_each_safe(pos, q, &task_bps) {
 		struct breakpoint *tmp = list_entry(pos, struct breakpoint, list);
 
@@ -191,6 +202,7 @@ static void task_bps_remove(struct perf_event *bp)
 			break;
 		}
 	}
+	spin_unlock(&task_bps_lock);
 }
 
 /*
@@ -200,12 +212,17 @@ static void task_bps_remove(struct perf_event *bp)
 static bool all_task_bps_check(struct perf_event *bp)
 {
 	struct breakpoint *tmp;
+	bool ret = false;
 
+	spin_lock(&task_bps_lock);
 	list_for_each_entry(tmp, &task_bps, list) {
-		if (!can_co_exist(tmp, bp))
-			return true;
+		if (!can_co_exist(tmp, bp)) {
+			ret = true;
+			break;
+		}
 	}
-	return false;
+	spin_unlock(&task_bps_lock);
+	return ret;
 }
 
 /*
@@ -215,13 +232,18 @@ static bool all_task_bps_check(struct perf_event *bp)
 static bool same_task_bps_check(struct perf_event *bp)
 {
 	struct breakpoint *tmp;
+	bool ret = false;
 
+	spin_lock(&task_bps_lock);
 	list_for_each_entry(tmp, &task_bps, list) {
 		if (tmp->bp->hw.target == bp->hw.target &&
-		    !can_co_exist(tmp, bp))
-			return true;
+		    !can_co_exist(tmp, bp)) {
+			ret = true;
+			break;
+		}
 	}
-	return false;
+	spin_unlock(&task_bps_lock);
+	return ret;
 }
 
 static int cpu_bps_add(struct perf_event *bp)
@@ -234,6 +256,7 @@ static int cpu_bps_add(struct perf_event *bp)
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
+	spin_lock(&cpu_bps_lock);
 	cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
 	for (i = 0; i < nr_wp_slots(); i++) {
 		if (!cpu_bp[i]) {
@@ -241,6 +264,7 @@ static int cpu_bps_add(struct perf_event *bp)
 			break;
 		}
 	}
+	spin_unlock(&cpu_bps_lock);
 	return 0;
 }
 
@@ -249,6 +273,7 @@ static void cpu_bps_remove(struct perf_event *bp)
 	struct breakpoint **cpu_bp;
 	int i = 0;
 
+	spin_lock(&cpu_bps_lock);
 	cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
 	for (i = 0; i < nr_wp_slots(); i++) {
 		if (!cpu_bp[i])
@@ -260,19 +285,25 @@ static void cpu_bps_remove(struct perf_event *bp)
 			break;
 		}
 	}
+	spin_unlock(&cpu_bps_lock);
 }
 
 static bool cpu_bps_check(int cpu, struct perf_event *bp)
 {
 	struct breakpoint **cpu_bp;
+	bool ret = false;
 	int i;
 
+	spin_lock(&cpu_bps_lock);
 	cpu_bp = per_cpu_ptr(cpu_bps, cpu);
 	for (i = 0; i < nr_wp_slots(); i++) {
-		if (cpu_bp[i] && !can_co_exist(cpu_bp[i], bp))
-			return true;
+		if (cpu_bp[i] && !can_co_exist(cpu_bp[i], bp)) {
+			ret = true;
+			break;
+		}
 	}
-	return false;
+	spin_unlock(&cpu_bps_lock);
+	return ret;
 }
 
 static bool all_cpu_bps_check(struct perf_event *bp)
@@ -286,10 +317,6 @@ static bool all_cpu_bps_check(struct perf_event *bp)
 	return false;
 }
 
-/*
- * We don't use any locks to serialize accesses to cpu_bps or task_bps
- * because are already inside nr_bp_mutex.
- */
 int arch_reserve_bp_slot(struct perf_event *bp)
 {
 	int ret;
-- 
2.37.0.rc0.161.g10f37bed90-goog

