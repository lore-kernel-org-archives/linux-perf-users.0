Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9BC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 12:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiCVMMF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiCVMMD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 08:12:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDF8564F
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 05:10:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id t2so17949196pfj.10
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uePDHamTg8Aaje9cV7GXZKI4UAeGuCXRnl2ENUUEXxk=;
        b=FsRTO4RlcjR5SvPCtQOCwI3kpAD3W7w49KGuO99dqINQ6uOWZ5gOIMsgNsI6jxy9Uz
         QSCMtlPoMeim6YGW8OkevyocYuF/DBt28S6HI1X+CAidRFCDU9fJZc/XNpuAAXEslwpm
         MD1wTijilB06RSk200EmVDcbKzgWhOF3W3kILccXJCG46DTFvKTbFTHYC4tgb/ONeh/h
         G0l+INhk24k4SzX4HTlxzbuqMok45TzQGdon9rrL6losB9H0wWpTEArGsFSqIKO3OuWb
         UxSgpXULxwsvVnj0i/ff5ZkKHE9EpnJbUO+MjLpDReoR0eUp6kCZJjB9EBleJC/iiR6z
         zm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uePDHamTg8Aaje9cV7GXZKI4UAeGuCXRnl2ENUUEXxk=;
        b=JXmWjWyHDEJvCqI6qu6FvfyykVSEA86RurLzM32zi5rwt67Jo2wt9u3HLnn7afmccl
         JwDnjCMDd/efyvRJJC0PXLVUIHEtkYrUai2XPmzg2yglg3iCbivxP8oP+29u9ivdKgJ/
         uiloq30WSJddNs3clRqn97gnqeTvXSVAWNSNA+oQndfhB3rtmUyjQSj9wLHz6dwyloGm
         IlY/pxy2QI2kvYJxh4CE6vZ4lHa3K7jqlwm3E65SdgFtpjVBs3lgd7P40TPKYtA0cRoV
         c9mwr1sVgfUsuDUglvAA96pxIss3LYe6hBLs++dr0zXJEy3SMEJLZG9Oc5hFnTfwqbcu
         8XAg==
X-Gm-Message-State: AOAM531sAPf/WvCWY6bhunPpGuBS/R9CjPZGwEf7OnZ5Kcqia+tm5EOI
        zlRH81ZxF/LlexsqKerKg8Zzzg==
X-Google-Smtp-Source: ABdhPJzdsnGKnRy+ZLFU+RCMb/c6l9MPuXmGqraFSCQJyAYNskxfSG2QUnuOF5/VdE382cVcf+ByYQ==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr28841152pfw.39.1647951026185;
        Tue, 22 Mar 2022 05:10:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:10:25 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 5/6] perf/core: Always set cpuctx cgrp when enable cgroup event
Date:   Tue, 22 Mar 2022 20:08:33 +0800
Message-Id: <20220322120834.98637-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322120834.98637-1-zhouchengming@bytedance.com>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When enable a cgroup event, cpuctx->cgrp setting is conditional
on the current task cgrp matching the event's cgroup, so have to
do it for every new event. It brings complexity but no advantage.

To keep it simple, this patch would always set cpuctx->cgrp
when enable the first cgroup event, and reset to NULL when disable
the last cgroup event.

In this way, perf_cgroup_match() won't see cpuctx->cgrp == NULL if
it's a cgroup event, so add a WARN_ON_ONCE(!cpuctx->cgrp) there.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 849a81299906..4c8657b08301 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -703,7 +703,7 @@ perf_cgroup_match(struct perf_event *event)
 		return true;
 
 	/* wants specific cgroup scope but @cpuctx isn't associated with any */
-	if (!cpuctx->cgrp)
+	if (WARN_ON_ONCE(!cpuctx->cgrp))
 		return false;
 
 	/*
@@ -975,22 +975,10 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
 	 */
 	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
 
-	/*
-	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
-	 * matching the event's cgroup, we must do this for every new event,
-	 * because if the first would mismatch, the second would not try again
-	 * and we would leave cpuctx->cgrp unset.
-	 */
-	if (ctx->is_active && !cpuctx->cgrp) {
-		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
-
-		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
-			cpuctx->cgrp = cgrp;
-	}
-
 	if (ctx->nr_cgroups++)
 		return;
 
+	cpuctx->cgrp = perf_cgroup_from_task(current, ctx);
 	list_add(&cpuctx->cgrp_cpuctx_entry,
 			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
 }
@@ -1012,9 +1000,7 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 	if (--ctx->nr_cgroups)
 		return;
 
-	if (ctx->is_active && cpuctx->cgrp)
-		cpuctx->cgrp = NULL;
-
+	cpuctx->cgrp = NULL;
 	list_del(&cpuctx->cgrp_cpuctx_entry);
 
 	if (list_empty(per_cpu_ptr(&cgrp_cpuctx_list, event->cpu)))
-- 
2.20.1

