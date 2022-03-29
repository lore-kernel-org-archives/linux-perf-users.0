Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2627EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Mar 2022 15:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiC2Prq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbiC2Prp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229D3B3FD
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 08:45:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so15196687pga.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zysooMn8IJ98VrrDS0WMswXwEoXCxIeE5qgjfz/kBk0=;
        b=tP53GDW0V6xO3Mc6lQ9a/ywqGjPQrFBuXylv2E+lWz1fyum/gB3R0xzsKhs8Qcny5w
         Bp5hw/OO2KHU9LnnO2++npNbSOm6AvfiZjg2XW59Ze415jjONWFRfBRQ2zvXQ1u/eHQO
         XpgfAMAa75Lerlc4uCJXdT8LRg43l4wUEbLCZ2Rspjhnb9/ZzSpFyxL0KqY6+63TTqQ3
         slhWFTfgGIHBfRCPg13N56XKxv/iJ8XMX20oe3NcthQCiENRu0GyxZC67yrthteVdlQk
         Q4Edw4TyDf56JBRFblClP2GXYJ7S8wXKtTv8uuIv84jsm1F8Re5nf42DEy+/q0e7dEdT
         B1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zysooMn8IJ98VrrDS0WMswXwEoXCxIeE5qgjfz/kBk0=;
        b=3S9mnWiocPFJTNQGyU4r8JSJtQJo2o5Kqq664kDL56NBMtQ8MRZCCCBAlpq4gY4MZl
         dABc6DEhZhOSNRD5zMfKZE6jURI6K1fmRYjkl6ROCgQD1Fj3AnW1nhq4Dr5IwywBOO2/
         IXkKI5xuGiti40cDeIXSvap7ibWiATKPYTt1B/C5e33eNRyjUKErHFabtCVha3Blhm5U
         3GQc0htokjZRO7r6yYuZpLeCTExKjy1Hp/6llW5k+i9BZwAAiDPdBYtJwXT7kaEovT0U
         azofT8jIMP5yI9Sc5mVOkFW51JBuBHz5ZCNOV+bL6DU60nFaNwny3GG9gLBTQao3OR/P
         LREA==
X-Gm-Message-State: AOAM5337TyCHLo7HFBrac55VAe/OXiSwI1xncHTPoIxO2P8D7A3GEawk
        5TSQ7XBv30SbG81TkyUgcNYlMQ==
X-Google-Smtp-Source: ABdhPJzc/ykja27CyhJnywo1svS553ci+1IAjRy0v1iRDw+KcTufkHUAhz0uSj45kr4a+uoaDKbRkQ==
X-Received: by 2002:a63:2ad0:0:b0:398:31d7:9955 with SMTP id q199-20020a632ad0000000b0039831d79955mr2400322pgq.198.1648568758750;
        Tue, 29 Mar 2022 08:45:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm17930733pfi.163.2022.03.29.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:45:58 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 2/4] perf/core: Use perf_cgroup_info->active to check if cgroup is active
Date:   Tue, 29 Mar 2022 23:45:21 +0800
Message-Id: <20220329154523.86438-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329154523.86438-1-zhouchengming@bytedance.com>
References: <20220329154523.86438-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since we use perf_cgroup_set_timestamp() to start cgroup time and
set active to 1, then use update_cgrp_time_from_cpuctx() to stop
cgroup time and set active to 0.

We can use info->active directly to check if cgroup is active.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d50f45012c05..dd985c77bc37 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -780,7 +780,6 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
 	struct perf_cgroup_info *info;
-	struct perf_cgroup *cgrp;
 
 	/*
 	 * ensure we access cgroup data only when needed and
@@ -789,14 +788,12 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	if (!is_cgroup_event(event))
 		return;
 
-	cgrp = perf_cgroup_from_task(current, event->ctx);
+	info = this_cpu_ptr(event->cgrp->info);
 	/*
 	 * Do not update time when cgroup is not active
 	 */
-	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
-		info = this_cpu_ptr(event->cgrp->info);
+	if (info->active)
 		__update_cgrp_time(info, perf_clock(), true);
-	}
 }
 
 static inline void
-- 
2.35.1

