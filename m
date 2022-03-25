Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CC7C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Mar 2022 03:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354145AbiCYDzw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Mar 2022 23:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354680AbiCYDzv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Mar 2022 23:55:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6143B01B
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Mar 2022 20:54:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y6so4286216plg.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Mar 2022 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0LhTTw9Vun6svrqvKc5N0TblTZhNbhimv3XzOgm9U8=;
        b=EdXqfngfPLwlPOx4i8FCvtA4gN5E1opa3zpKfbspNq0IG+ST7TnywUV76VfdDVBgJM
         irpWCQkZ1dBZ42r1p4JnnIk01lKq2Rw/D6rXnYnOW7jphqvg3lHa2ivf9aAdAWUplbW9
         nPdDjV0E9xw4f09dgE/2c4hzobAbE0OBBeOLCZ7VtpyAZJm/K9bW4d+o/v2Eq7CMAFTr
         YL08g9xNH95YCyF3FxaR5PZNbWil0s2stoR2COtTzUxsQv0kQCmV8YRGjmFN5idP+B45
         nbz71RPb1U4szlXjgctxPfb/BzxPKzOypbv7CeEA3hFCVaVpNp5qsoAg4v2v/75s5reW
         BUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0LhTTw9Vun6svrqvKc5N0TblTZhNbhimv3XzOgm9U8=;
        b=PNNoporDVUKifmtd5cuRCkxREHj+v6yb0jj9ZgzUzyzsezRuN7pJ/bgmPk7wUGzjry
         +3mKICw6n1zwQoUE06fJL+aOOu16OBq6h+Cb4/AM4DlKpSSqhQdRKVKJMinuWoNYxlix
         B4UWL5CTcV/4j9hUVQEELTYYozhmMkJGeHgsf6lC4aaWb0NltXad/QZwmLiiPJoQPT8C
         oQPzMf4z9lFreUIas4uwkcoT3Wph42jjWy/d95UML0JekB1YMDmo7Exr3n1IuUh0aXRE
         p7mkhAIU8B4WwoVDghoX72uO3igT106RRU2ZqrL9BqefPEX7b4fY2G79LnUVEu1iT+uX
         Kn5Q==
X-Gm-Message-State: AOAM532POuX8wBBBwJ3wIcJQfLMfO3z28vM5FvdYLZPl6V02/iacidEC
        1zWG06dAEzT/fDFNDjFXF5VmgVjmrhMzoQ==
X-Google-Smtp-Source: ABdhPJzhak+gVuerVwpZ2n/ocAh6wTFPCwP+XrfCNMYSqRxLV6nPg6Wn5h2UxTUIC5T4ENBC1GOkUg==
X-Received: by 2002:a17:90a:d584:b0:1bc:e520:91f2 with SMTP id v4-20020a17090ad58400b001bce52091f2mr22816450pju.192.1648180456095;
        Thu, 24 Mar 2022 20:54:16 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:54:15 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 3/5] perf/core: Don't need event_filter_match in merge_sched_in()
Date:   Fri, 25 Mar 2022 11:53:16 +0800
Message-Id: <20220325035318.42168-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325035318.42168-1-zhouchengming@bytedance.com>
References: <20220325035318.42168-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There is one obselete comment in perf_cgroup_switch(), since
we don't use event_filter_match() when event_sched_out().

Then found we needn't to use event_filter_match() in
merge_sched_in() too. Because now we use the perf_event groups
RB-tree to get the exact matched perf_events, don't need to
go through the event_filter_match() to check if matched again.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd985c77bc37..225d408deb1a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -856,7 +856,8 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
 			/*
 			 * must not be done before ctxswout due
-			 * to event_filter_match() in event_sched_out()
+			 * to update_cgrp_time_from_cpuctx() in
+			 * ctx_sched_out()
 			 */
 			cpuctx->cgrp = NULL;
 		}
@@ -3804,9 +3805,6 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
-		return 0;
-
 	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
 		if (!group_sched_in(event, cpuctx, ctx))
 			list_add_tail(&event->active_list, get_event_list(event));
-- 
2.20.1

