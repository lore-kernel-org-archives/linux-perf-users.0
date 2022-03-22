Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89DDC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiCVMLr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiCVMLi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 08:11:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828384EFB
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 05:10:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so17961235pfh.8
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 05:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AtraGYpELN2VSwkCm9o6LS6piIeW98lmVH595mjWM4=;
        b=hwJKy5xOXdff+V1T2YYlazuDSchivl9TpZ2ozJ1RZQs/ERArDQv0yeF6WPm1cJ542b
         d10soCXHyIn6EAHqTvFn1FP2T15MMb0u4qEb5WLEOa9gi0FUud9YBI/OSdWLSxoFIEE9
         G+GljbjomWdOmzgJx17mpZYEzVy1kAvj/iBTF64811SizHRg3pAaioRGjI19SOS6GcNI
         m/LViYBxwCz5XpfggYDE8sDzSTGxczOQfSdbmE2aDTBIablPSyPNfabZa+PWRjq3nBrT
         WppiL6Ydz3eO10GKfEELDYW9mlSFYeJl7exkx9R6qybF9EqDj5annknKWxBw0v+fJTsw
         7DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AtraGYpELN2VSwkCm9o6LS6piIeW98lmVH595mjWM4=;
        b=HHJ6THrPLQqcGiSW7L4o15JUmdeTb5CI8WWicmUCGB/D/IeSPf2rXz44q7+uoWW1JT
         rhnfoyrzrbhvfJ81B+D40F/nRE4EORkU7O6z62tFaMCFYG9vQeSaDTPvpPgtLmSUrVG3
         QZN63aPtLWA+2erz+jzBHcEmuihU7GeMDd1KX5mpxy/zlOp+P+gY/ozfd8R6RRg6rErE
         eU+tnVQlIgmIwIxRsXvlMcZXPVB0lJQ0AksxW0rE58hW7EJrAwccUYHcJQGklctrgEAI
         amuzCQjfSVleUYy280MeAbyaEarempfDrN9wSfpw6Gsx/YgAmvJWlYvW0/oRYgvvrg/Z
         Jqog==
X-Gm-Message-State: AOAM532/01X/wqjLYj2z5cxGVTavGg73WGbxLRVVzZ3VhwmeYwGe54VZ
        s4NQH+qIRAIwgTcKosK5X1fVQQ==
X-Google-Smtp-Source: ABdhPJxRZK3FL6qRyIV7r/JYlN57sohicd6xyx5VBOQnwCSmiucPv4tlAasC8Zcv/0WezxpGHtdg0Q==
X-Received: by 2002:a63:5547:0:b0:374:4ec0:bad0 with SMTP id f7-20020a635547000000b003744ec0bad0mr21603410pgm.169.1647951009847;
        Tue, 22 Mar 2022 05:10:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:10:09 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 3/6] perf/core: Don't pass task around when ctx sched in
Date:   Tue, 22 Mar 2022 20:08:31 +0800
Message-Id: <20220322120834.98637-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322120834.98637-1-zhouchengming@bytedance.com>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The current code pass task around for ctx_sched_in(), only
to get perf_cgroup of the task, then update the timestamp
of it and its ancestors and set them to active.

But we can use cpuctx->cgrp to get active perf_cgroup and
its ancestors since cpuctx->cgrp has been set before
ctx_sched_in().

This patch remove the task argument in ctx_sched_in()
and cleanup related code.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 54 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 848a3bfa9513..e27c06628bad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -574,8 +574,7 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 			      enum event_type_t event_type);
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type,
-			     struct task_struct *task);
+			     enum event_type_t event_type);
 
 static void update_context_time(struct perf_event_context *ctx);
 static u64 perf_event_time(struct perf_event *event);
@@ -801,10 +800,10 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct task_struct *task,
-			  struct perf_event_context *ctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 {
-	struct perf_cgroup *cgrp;
+	struct perf_event_context *ctx = &cpuctx->ctx;
+	struct perf_cgroup *cgrp = cpuctx->cgrp;
 	struct perf_cgroup_info *info;
 	struct cgroup_subsys_state *css;
 
@@ -813,10 +812,10 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	 * ensure we do not access cgroup data
 	 * unless we have the cgroup pinned (css_get)
 	 */
-	if (!task || !ctx->nr_cgroups)
+	if (!cgrp)
 		return;
 
-	cgrp = perf_cgroup_from_task(task, ctx);
+	WARN_ON_ONCE(!ctx->nr_cgroups);
 
 	for (css = &cgrp->css; css; css = css->parent) {
 		cgrp = container_of(css, struct perf_cgroup, css);
@@ -873,7 +872,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 		 * event_filter_match() to not have to pass
 		 * task around
 		 */
-		cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
+		cpu_ctx_sched_in(cpuctx, EVENT_ALL);
 
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -1057,8 +1056,7 @@ static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct task_struct *task,
-			  struct perf_event_context *ctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 {
 }
 
@@ -2651,8 +2649,7 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
-	     enum event_type_t event_type,
-	     struct task_struct *task);
+	     enum event_type_t event_type);
 
 static void task_ctx_sched_out(struct perf_cpu_context *cpuctx,
 			       struct perf_event_context *ctx,
@@ -2668,15 +2665,14 @@ static void task_ctx_sched_out(struct perf_cpu_context *cpuctx,
 }
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
-				struct perf_event_context *ctx,
-				struct task_struct *task)
+				struct perf_event_context *ctx)
 {
-	cpu_ctx_sched_in(cpuctx, EVENT_PINNED, task);
+	cpu_ctx_sched_in(cpuctx, EVENT_PINNED);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_PINNED, task);
-	cpu_ctx_sched_in(cpuctx, EVENT_FLEXIBLE, task);
+		ctx_sched_in(ctx, cpuctx, EVENT_PINNED);
+	cpu_ctx_sched_in(cpuctx, EVENT_FLEXIBLE);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_FLEXIBLE, task);
+		ctx_sched_in(ctx, cpuctx, EVENT_FLEXIBLE);
 }
 
 /*
@@ -2726,7 +2722,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (ctx_event_type & EVENT_PINNED)
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_event_sched_in(cpuctx, task_ctx);
 	perf_pmu_enable(cpuctx->ctx.pmu);
 }
 
@@ -2949,7 +2945,7 @@ static void __perf_event_enable(struct perf_event *event,
 		return;
 
 	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
 		return;
 	}
 
@@ -2958,7 +2954,7 @@ static void __perf_event_enable(struct perf_event *event,
 	 * then don't put it on unless the group is on.
 	 */
 	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
 		return;
 	}
 
@@ -3803,8 +3799,7 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
-	     enum event_type_t event_type,
-	     struct task_struct *task)
+	     enum event_type_t event_type)
 {
 	int is_active = ctx->is_active;
 
@@ -3816,7 +3811,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	if (is_active ^ EVENT_TIME) {
 		/* start ctx time */
 		__update_context_time(ctx, false);
-		perf_cgroup_set_timestamp(task, ctx);
+		perf_cgroup_set_timestamp(cpuctx);
 		/*
 		 * CPU-release for the below ->is_active store,
 		 * see __load_acquire() in perf_event_time_now()
@@ -3847,12 +3842,11 @@ ctx_sched_in(struct perf_event_context *ctx,
 }
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type,
-			     struct task_struct *task)
+			     enum event_type_t event_type)
 {
 	struct perf_event_context *ctx = &cpuctx->ctx;
 
-	ctx_sched_in(ctx, cpuctx, event_type, task);
+	ctx_sched_in(ctx, cpuctx, event_type);
 }
 
 static void perf_event_context_sched_in(struct perf_event_context *ctx,
@@ -3894,7 +3888,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
-	perf_event_sched_in(cpuctx, ctx, task);
+	perf_event_sched_in(cpuctx, ctx);
 
 	if (cpuctx->sched_cb_usage && pmu->sched_task)
 		pmu->sched_task(cpuctx->task_ctx, true);
@@ -4195,7 +4189,7 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	if (cpu_event)
 		rotate_ctx(&cpuctx->ctx, cpu_event);
 
-	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_event_sched_in(cpuctx, task_ctx);
 
 	perf_pmu_enable(cpuctx->ctx.pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -4267,7 +4261,7 @@ static void perf_event_enable_on_exec(int ctxn)
 		clone_ctx = unclone_ctx(ctx);
 		ctx_resched(cpuctx, ctx, event_type);
 	} else {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 
-- 
2.20.1

