Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4938CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 12:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiCVMMM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiCVMME (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 08:12:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64DA85679
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 05:10:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k6so8110225plg.12
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/7NZbomHJNevRDviLAq47WogxJXAVWPPfKEsGLaM2Q=;
        b=u+N3p9kTmRnGrXL314WMH5VKZQw2nEgT4xoBO1regbTW10qO9UIqkNynJKqT6hJTQI
         GfE7w63Iyvv6FpRThYj5q1G6+loA64m2+EqaBgdw4tNHxFu2u7d90d5asSWZXnxF23bG
         ZsMTHS7CN4uLkCKYbBNYFmTP8sr4Ok1yodh7ZhdNGts6aWPMBVE4Lz2wIc0PBRP1g1Cx
         aHFwhyYcQNpwDnmqNls6pMAVG50I1fcCb1R4B+V0kMZVJdSbE98mqY0MkmRyBGyepID5
         u0ST1DHgNNRuXMPo0APBXThcgYAs8w3cnhfGw7CscQ/Ah9fyysaw89ORGlgdwn5Fh2PI
         vqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/7NZbomHJNevRDviLAq47WogxJXAVWPPfKEsGLaM2Q=;
        b=A5CxgoRkH9t4eV00evp2RvHB4LMz9TGfG1v7tnyELk/y55TtQR/7p9fMLL04pbUWK2
         /Z5DE092j3zWY9JdjZGxUoBu7z0nDZDGXhLpaPCzpi7QgHz9Gl/ug4zSpHM9W7iZ8Hpn
         FbJFFlZvIZci6bpfFZ7suywo0p+tts/6tdUB8X1xyoL6m6B/2fd2MQwVyw1aVmrR3ALD
         iGWwDcKkBTUts5H3SHpawveGKvuMt00PypgyW0U4kymkPTpL6NQ4Wtll3yTJXhNT8Pj1
         TtgyR22Q/ncez00GeqtAqBI0/vPVozUEWcUe7ZFp0sdKhY115QKgBhNomJ2FPIEKfA8d
         RxCA==
X-Gm-Message-State: AOAM530QDLcsmtF1AwLgjjRmPB9DbZ8AUUXsBAwfsnNsj+puyhIuo5hY
        5MXnnt5tTuZlwSbmB7XhNMWyiw==
X-Google-Smtp-Source: ABdhPJxjr0Mbq/yQ/Er0makurPOudwZPK8zCr3U/6Orououfw/iFmcSMXQY4it/+KgCKOLrzKVLcFw==
X-Received: by 2002:a17:90a:1197:b0:1bf:65ff:f542 with SMTP id e23-20020a17090a119700b001bf65fff542mr4610157pja.5.1647951034367;
        Tue, 22 Mar 2022 05:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:10:34 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 6/6] perf/core: Don't need event_filter_match when merge_sched_in()
Date:   Tue, 22 Mar 2022 20:08:34 +0800
Message-Id: <20220322120834.98637-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322120834.98637-1-zhouchengming@bytedance.com>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There are two obselete comments in perf_cgroup_switch(), since
we don't use event_filter_match() when event_sched_out(). And
found we needn't to use event_filter_match() when sched_in too.

Because now we use the perf_event groups RB-tree to get the
exact matched perf_events, don't need to go through the
event_filter_match() to check if matched.

We can remove it in merge_sched_in() actually, but this patch
changes it to a WARN_ON_ONCE for debug purpose, and found
no warning in our stress test.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c8657b08301..744078fe2819 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -860,15 +860,11 @@ static void perf_cgroup_switch(struct task_struct *task)
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
 		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
-		/*
-		 * must not be done before ctxswout due
-		 * to event_filter_match() in event_sched_out()
-		 */
 		cpuctx->cgrp = cgrp;
 		/*
 		 * set cgrp before ctxsw in to allow
-		 * event_filter_match() to not have to pass
-		 * task around
+		 * visit_groups_merge() to find matched
+		 * cgroup events
 		 */
 		cpu_ctx_sched_in(cpuctx, EVENT_ALL);
 
@@ -3729,7 +3725,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
+	if (WARN_ON_ONCE(!event_filter_match(event)))
 		return 0;
 
 	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
-- 
2.20.1

