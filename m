Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6935C3F6B0
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Aug 2022 22:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiHIWes (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiHIWeZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2326580B
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Aug 2022 15:34:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n185so6951364wmn.4
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Aug 2022 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Wmt5utEn01FakaCjSV6ZsTv6W9xbPzrClska04k2gs=;
        b=WBnf+tQjhMAZgTQMlUHcR2hov53bx5/uA6zrlkjEJmGNKSbhwfGSWJ51ZsiLPQ447o
         pIeeoODnoSHLz55YY2PwDtBU8h0/4+fOUDrcbNjEXsA5/WCTcixFAE0XTZ9UvZwcOVmh
         MqemA//x4Oq7sWKVSmkU/jJDeSTLOS9qKMEETQFZojLpQf73m1j1FbAnAjLcocqmvCFU
         IpXKJrLwXLYbQSwUfmszaCVhbnGJpQtKg8ifqJ6yDwsU+VuJHhrxnmqn3tG6EI2hQwQo
         LfPSHf7HXnFqIAEZYhZ8/HYDVTfSmD0PDI5LUWHPjgE8DnkfIF2ttWiRFXy+H4VOpiat
         4qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Wmt5utEn01FakaCjSV6ZsTv6W9xbPzrClska04k2gs=;
        b=Mh2jsZ17CZoFV72VgKG4x1wovyYfzNSB7wXziaG/Qb1Iw4tUpUU43w7/WUb+VCYmQ4
         U/gWQsXxw/fMGplzdRcDnmCMr/vVlLrVAKIhElmpVZCKUlrQGaYySKNBrEL0B66f5elk
         KXyFuoO1g7lonkU+URhn1OHHOfNSxh5lzaBfl+gkjwwrzGSMFiaz+U/74evm1VxY4VaN
         kry/uMOTeL/mRMwz6OjdWJBgMCSLQTv3vydk0E0bQabqfBcSzsaxI/SUpizTSuat5u4S
         Auvn7Ihykcai/jdZv3SREVwojkrHjMhk7vv7jSGvTff/6rocrn9bHPsG1Q68rq2U8v8V
         upkQ==
X-Gm-Message-State: ACgBeo3DgR2BwMCY+S3wS3hH5/QvrVZviQ6eJgjTO31l9QkJLv+ouKVz
        +zwgDAVdCVe/YK2baK/xLcUDUg==
X-Google-Smtp-Source: AA6agR4pcP6KnBrfBu99TLZiqpgxLRCfsBSUER8fZ3LjaD5gBMcq/O0jYwDO7xU7JMpyTinfX6DDTQ==
X-Received: by 2002:a1c:2585:0:b0:3a5:2163:f33b with SMTP id l127-20020a1c2585000000b003a52163f33bmr307030wml.189.1660084453189;
        Tue, 09 Aug 2022 15:34:13 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:12 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 07/13] coresight: perf: traceid: Add perf notifiers for Trace ID
Date:   Tue,  9 Aug 2022 23:33:55 +0100
Message-Id: <20220809223401.24599-8-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds in notifier calls to the trace ID allocator that perf
events are starting and stopping.

This ensures that Trace IDs associated with CPUs remain the same
throughout the perf session, and are only released when all perf
sessions are complete.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 43bbd5dc3d3b..6166f716a6ac 100644
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
+		if (!IS_VALID_ID(trace_id)) {
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
+
 		*etm_event_cpu_path_ptr(event_data, cpu) = path;
 	}
 
-- 
2.17.1

