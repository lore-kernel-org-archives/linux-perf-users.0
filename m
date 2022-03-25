Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F45C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Mar 2022 03:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354555AbiCYD4I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Mar 2022 23:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354615AbiCYD4D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Mar 2022 23:56:03 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA663EAAA
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Mar 2022 20:54:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c11so5433394pgu.11
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Mar 2022 20:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOjaONZKMKdSsuIYVocxhHlKftggb493wbtIiiPtVs0=;
        b=neNoe4SioYRiOAfumI2Qi6ZhxWfffkqMOShngq9XvSSMjo2sp4G17lYNkJXA1KtSYx
         Rb1KhAw8FXGu4Nno8BugqdMKDAxma23HIiMojIq8Ex3CSJ59l4JhpJeEmKAed3X5zcDO
         hJn+ZQ/qiOigxtZykRAKzOdTsjhhwP1G3lY+HdXIqHIcXxnpLv+ozSdXC1C8cj6r0QmH
         6zjn8mb1IoT1icbos6NbDdabmN7tSK0u4NMIzPQuLw3fpjkUr42p4QfVqVtGuKrvtr6P
         hBNh8LpM8f+WCk2nD3kHd+KhTIo482bAzzpw/n5Rmt6IpYMsE3sOflgu6wlBPQ0qj+zi
         y82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOjaONZKMKdSsuIYVocxhHlKftggb493wbtIiiPtVs0=;
        b=vim8akhB4BVCkZd8gmDzmLi149Bcq8AEjHqNX2XRK3A3PGTiMG8iZOD0+1RHn5/MFl
         HyQ6tmaW9VRMAKrGDKLf44U4lO3U4Z5yY4NV5gBYE/8dGYc9zV2peOUnIofPgIlr4b2L
         UohOULxQ6uId6pWCDvIgCfwHjdqdMaaeffk6b5IMjOtiEQPCqbsICPHpDzJoKFkLFqun
         i/5ncanGw+AMP94UT+uuBVhm8NzQ3YD91sfMeLV0Co71Sn5JAzlHGTsxre/rulnJC0OE
         fjA9t3RMecFW0wi1/tZMJx8q8MQ/BEROEgdLB+ZmH6foHM8cYpWEpcb9lpzPRlzQmr5K
         PEww==
X-Gm-Message-State: AOAM532vaV7U7xDlPn7xisULBTodR873+aOB1Cluwcd8nA6BpPebKkw1
        KsQpp/fdLMBHrVV+p6Rh4/pOaw==
X-Google-Smtp-Source: ABdhPJzgnlXnTMAAP50rmjk1RpE7Pq+oO0/kB529+we11ivjrAxlbhS4IWrReGZpq+lU0mKL4MF3Jg==
X-Received: by 2002:aa7:8385:0:b0:4f6:ef47:e943 with SMTP id u5-20020aa78385000000b004f6ef47e943mr8184087pfm.38.1648180469209;
        Thu, 24 Mar 2022 20:54:29 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:54:28 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 5/5] perf/core: Always set cpuctx cgrp when enable cgroup event
Date:   Fri, 25 Mar 2022 11:53:18 +0800
Message-Id: <20220325035318.42168-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325035318.42168-1-zhouchengming@bytedance.com>
References: <20220325035318.42168-1-zhouchengming@bytedance.com>
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

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d559fbbd3aaa..ccd4dfdf4810 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -967,22 +967,10 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
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
@@ -1004,9 +992,7 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 	if (--ctx->nr_cgroups)
 		return;
 
-	if (ctx->is_active && cpuctx->cgrp)
-		cpuctx->cgrp = NULL;
-
+	cpuctx->cgrp = NULL;
 	list_del(&cpuctx->cgrp_cpuctx_entry);
 }
 
-- 
2.20.1

