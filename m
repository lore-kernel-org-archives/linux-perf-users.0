Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0ABC678D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 12:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjAPMtr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjAPMto (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91A1E5EB
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so2429060wmb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q+K11GrFOPMrxvDYNvmhX0YpDA/5RBsqSxpF+D0Uhgs=;
        b=nF4xSw3rSARS2cIPc+a5XikugDM3czBaJC3hWw6A6F2JalQw5NqCuq3y8E9aui1E5U
         vxvz7VVZ4iBx9qfrJDGc6rv+Vg1HAFnww9Ysx40j84Mz1ounkdy6P/yWTQJs4kr29vVg
         2GrVvNbOVeS+Z+89cY52B1FU+bsJcWaF5j8jPIJmHsXf9pY3t+KEP/xmRU138PtpvXZn
         M6PhyIPfdTcd8lvs1W2Esv4KHic/PxxUKcRH5w323wLwg7TkKo1ymZ6E27ZBPBV1VzVN
         72Ev6GMLI18NmgpibFCi9MpBykskMYDV08C3RdkbnlFGRpEhHUeS7sMyOpEsK6khrjYz
         vPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+K11GrFOPMrxvDYNvmhX0YpDA/5RBsqSxpF+D0Uhgs=;
        b=1cAS6JkMI/FHOR/MpBkn0DqHw6qgVDx9A5pXsBBmbvNGNEZZAnQ0EH+1fPzvcmPQkK
         BPhSJt+ZqWdcZqxwoo0fejRfSFhNVl/7E3CVu5vZqa1Ee+STIkZSoQFbEPFGTJeGufGw
         4XH8fqOb2lOf1cMuL61sKJ+WgBM7o8JsLIHFrJJxgff6+3XTZ8TWKhGxH4i/k21gMqqY
         pLNR7l2eS5ijJ/uX2tijZgBUq+78mwTdueNRGi6JnDkI6g0/24JE4ejQsxbs17ug/6rE
         FkrIIFcN+89AxgaDH77qnbTXyaxjTF3MdfAeW8FoLOd1W3xemO3UB3GUQa67xPwP2pbL
         oJ2Q==
X-Gm-Message-State: AFqh2komMZUpsphY46HqDxyx4nSp6L0FpJT5+fLXgRoB3EyVdaCbVWss
        sBb5WqfSftRhCbp+1vFEnlk5GA==
X-Google-Smtp-Source: AMrXdXsZ4na2VjyrnvaqsD3z06ZUz28dEWublD6ZIMIXYyCep+SkSvBPnW8wpL42go7ROiCcu5AO3A==
X-Received: by 2002:a05:600c:1c21:b0:3cf:9844:7b11 with SMTP id j33-20020a05600c1c2100b003cf98447b11mr78716386wms.23.1673873377614;
        Mon, 16 Jan 2023 04:49:37 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:37 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 03/15] coresight: perf: traceid: Add perf ID allocation and notifiers
Date:   Mon, 16 Jan 2023 12:49:16 +0000
Message-Id: <20230116124928.5440-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds in calls to allocate and release Trace ID for the CPUs in use
by the perf session.

Adds in notifier calls to the trace ID allocator that perf
events are starting and stopping.

This ensures that Trace IDs associated with CPUs remain the same
throughout the perf session, and are only released when all perf
sessions are complete.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 43bbd5dc3d3b..bdb9ab86173a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
@@ -228,8 +229,12 @@ static void free_event_data(struct work_struct *work)
 		if (!(IS_ERR_OR_NULL(*ppath)))
 			coresight_release_path(*ppath);
 		*ppath = NULL;
+		coresight_trace_id_put_cpu_id(cpu);
 	}
 
+	/* mark perf event as done for trace id allocator */
+	coresight_trace_id_perf_stop();
+
 	free_percpu(event_data->path);
 	kfree(event_data);
 }
@@ -300,6 +305,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 {
 	u32 id, cfg_hash;
 	int cpu = event->cpu;
+	int trace_id;
 	cpumask_t *mask;
 	struct coresight_device *sink = NULL;
 	struct coresight_device *user_sink = NULL, *last_sink = NULL;
@@ -316,6 +322,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
 
+	/* tell the trace ID allocator that a perf event is starting up */
+	coresight_trace_id_perf_start();
+
 	/* check if user wants a coresight configuration selected */
 	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
 	if (cfg_hash) {
@@ -388,6 +397,13 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			continue;
 		}
 
+		/* ensure we can allocate a trace ID for this CPU */
+		trace_id = coresight_trace_id_get_cpu_id(cpu);
+		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
+
 		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
-- 
2.17.1

