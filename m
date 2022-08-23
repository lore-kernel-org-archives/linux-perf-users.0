Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D3C32792
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355856AbiHWKo7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354472AbiHWKm4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C687AB049
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso9166499wmh.5
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=8Wmt5utEn01FakaCjSV6ZsTv6W9xbPzrClska04k2gs=;
        b=A+9Z+A37/34JRrjkjRUhrIb2D6MwnQ/JxjETrHLcr8f84JvEw0+z0yg5IKg1RR9egK
         l8clrHK1qPsKV2WMARtRYMMu27Fy+ZVdg2FlQUk+eJVv42uTwwj5CVOD90Ix/XPhcpzI
         j28xsJuhBWZq8dyUUXOMD+dEo95mQ7uejKVfCO2qb1cR8kI+sZpj0UCo8w5PQjyQf9xV
         dzj0yY5OM6CvJX6jCJC+oHHR1lv0pVzuPtwHZntaC5mJVKGajrANk0jBxjU9mhq4k16i
         ej50dx1bxjoDwKTBkBTuXI2qvQ7ms34mguhX/nToGF9gW/j6C53cH/wM4gqv9p4NX9jZ
         p/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=8Wmt5utEn01FakaCjSV6ZsTv6W9xbPzrClska04k2gs=;
        b=771B6tHzghzpB1HuVJoE3iC7ZK5Im7pxDcz7XtK09/Yhr7/PgG0zcZwYWoZ/VkmAHV
         KzM8+TPx2fWK6y0QY4wBnjbDhYF2XeGhtzSId9K71oiS8gDezIgx9KlMxLbGtCb0Hc93
         YYjVRG4PaIl9agaFAdwFbB8QBYYYjoW7DIT2BLaFjaQgnwE3VEThaI9dtI4t5Axe5EQM
         LDbdMAoaP2BysoH237RTcDD/2WaJrkzISr7r3eoZ3vSbUh9YFltPWepmWaS5kfM3BSc7
         4ZMFa47qNFuM5sOdgdFfwNZlwhq3Bz//SJpek5Ft8Z/Tt9XyZI4i4sGGuxc6kQPTt0lR
         D4IQ==
X-Gm-Message-State: ACgBeo06LnwS1hjVix3phrb8lbnAZZOeWAj0Uka8pAIu2HYczrtIB5MF
        VwOVV66G47GYZACu3RMIdSuz2A==
X-Google-Smtp-Source: AA6agR6E18inp8xVeTb8LqKQ4Coe2UQ8N6qZcvm/XKfOwwvffHRr9JpChlVsJ13AtmY9YS07ieK6Lw==
X-Received: by 2002:a05:600c:19d0:b0:3a6:2eb1:cfa5 with SMTP id u16-20020a05600c19d000b003a62eb1cfa5mr1496498wmq.37.1661245821164;
        Tue, 23 Aug 2022 02:10:21 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:20 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 07/13] coresight: perf: traceid: Add perf notifiers for Trace ID
Date:   Tue, 23 Aug 2022 10:10:03 +0100
Message-Id: <20220823091009.14121-8-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
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

