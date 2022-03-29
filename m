Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165A0C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Mar 2022 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiC2PsP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbiC2Pr4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855833A722
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 08:46:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so17885524pjb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rhwh9jxyPwcfCpsQO0KCczugdPBmMe7ki4JPplrKdX0=;
        b=1ZOjuYVV7IS49mm+29IIWCx9Kgw806xN7HcEro53PMxH+61SjdUcSsXzGPUYBBEH88
         uwKJaOwzbkvmfD6JHHJo/DrDfG7P1GwtqU9KbajcVCiZBlnrjlcspNGkc30DBibvKO0a
         WzNULbGBUuWwjO8xuVOTcMfY1exC724DLjk4ZtC3nNeV7FSLgKLprzgTrGQrDoABGLeH
         Gwq9ad9A6tDfoGOobXdgBJyW4FaOySqhkOSHUWmiUdatAzSGW0fWmqF5RIy7zn52Gjkh
         GDMB70CeSy9CZzN37x+re8L/OOI4ghmWSNrFRkdk28aZLVcUjiOiGm/GYi7hEpYn9L2y
         GiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rhwh9jxyPwcfCpsQO0KCczugdPBmMe7ki4JPplrKdX0=;
        b=kp+Xgkn7mFUkcOmp+38zenSzJgjEFiqaHly2V1avAZnggq/awoPRmsS3pNU3f6Rstk
         OIoQES1HQtV4TlG+H4Eeq9bME/tyrjIw8DFeuSiDnZamO2Im/84xceGdZMNgjBCtAqsw
         0UAVELEjaN1jc5QyfV0REdzMUKhKSF6RqFJ1o/w4Hn77dsQVea8aCqTePyC6PLxh7mjK
         NP7haCxyXCmid9jTAAgTq7SryuLEQZFu+0pxksocMuqJpQrTw9mz8S3/kywNwvsicvKQ
         3VWvUzqqejfFuly/1ZTxH0T5SzXfcwlxfEW+8YOum0H4lvfbO1lBtiEyAl1TJNW3Hpnn
         5Wog==
X-Gm-Message-State: AOAM5306bgZgHLJWlWnqo9xx6X78R8bsxoGtBPjMroZLxF41ltkj9FqA
        qq0caXnirch3dMHlYdnyb2ZsMA==
X-Google-Smtp-Source: ABdhPJxI2f60H+9yDfbq7bCXzPA5q5GFVR35gKrDEchQo7UVAUEKkvLhORP9cHiUPxiVJ/8hzds0VA==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr31141798plo.166.1648568772925;
        Tue, 29 Mar 2022 08:46:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm17930733pfi.163.2022.03.29.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:46:12 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 4/4] perf/core: Always set cpuctx cgrp when enable cgroup event
Date:   Tue, 29 Mar 2022 23:45:23 +0800
Message-Id: <20220329154523.86438-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329154523.86438-1-zhouchengming@bytedance.com>
References: <20220329154523.86438-1-zhouchengming@bytedance.com>
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
index 782b9f5e3fc7..a1f6f0a54ef7 100644
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
2.35.1

