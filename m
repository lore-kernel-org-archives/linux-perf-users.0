Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE65C28B2B
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Aug 2022 22:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiHIWez (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiHIWe2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DFE65806
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Aug 2022 15:34:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l4so15782276wrm.13
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Aug 2022 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ht2C5hmUen8Zs+3SYPbHRSeYgcLBnHmLYbKN5MCrEgA=;
        b=ReoNsdK6Qf7stNbwqpvMm9Ps3u5XWBgokoaC2yhwkEv62aRu1zmFBrOA1cnNu8SB7I
         QjLddDNP2g4u9p6ZtPodt5virk5oHHyLDcmgzy14jfEvX3+F/6xCZ8ekLlzGgCRMo2ld
         XFAztJQYM006MYg5zp/2FsunjL7yoeHmv7+nTX3URAxE8MCR8HTCaSRn/xhXYhOgbZFo
         GRRKQgNTp7TFCR/ei2DxZOtlzQrXhCSworaV9VMnCceTGk5r84mkHs+kZWr7x0vFp+FG
         bC3Pa30f+tsH7R3remZY5HczWX0R+oqCsoW0vI2w+Fqo0bSR1CTLMFFAabzrFbdSlsuz
         kWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ht2C5hmUen8Zs+3SYPbHRSeYgcLBnHmLYbKN5MCrEgA=;
        b=fELfDA4D/lfln493SnT66yvvP7SpQNWlPzVYN4RqJYAknR/sytIImaEMeVBT2k0F2C
         6+xcVtbR1NIvwmFLy9fEImi78MR698mCkq48zer+prWKNlCxEzSVVz9dZsTzwtaR3DWD
         aO1EwPbxWOhdqeYpz3B/QZP0XlL6Pcx/f4fwUvFSugpRTmMHf1J4nAEOHzS+sRKRbaiY
         huWT/mp3aXTUwWvfKT/xjANYG91cLFExYOOGFegQ9IBA+2mhvkGmIXz3E5p9yIcrJy2z
         ScKArdTi8EHZuyDgYecMEY7gRO6QmvKObvVqwjEHbeNKIdgXtyTIhv6zqfv1U82/ivch
         dHyA==
X-Gm-Message-State: ACgBeo3nclwl/nE3agBFHujJIKCWQA4IJuSKzLvR+aeAoA10RT6+ZxjG
        lJgJxZw9cbaTyN44XI7FfnyArw==
X-Google-Smtp-Source: AA6agR7iJg2CnEWqKZ9yqi+h9y7+qiLbREP+KF0Qz0+eZXbO1MQ8ibEAp64ra1HPkU1Wop7FsiymEQ==
X-Received: by 2002:a05:6000:81c:b0:222:ed7f:4445 with SMTP id bt28-20020a056000081c00b00222ed7f4445mr5671154wrb.111.1660084459352;
        Tue, 09 Aug 2022 15:34:19 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:18 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 13/13] coresight: trace-id: Add debug & test macros to Trace ID allocation
Date:   Tue,  9 Aug 2022 23:34:01 +0100
Message-Id: <20220809223401.24599-14-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds in a number of pr_debug macros to allow the debugging and test of
the trace ID allocation system.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index ac9092896dec..24c19ff493a9 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -69,6 +69,30 @@ static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_ma
 	set_bit(id, id_map->pend_rel_ids);
 }
 
+/* #define TRACE_ID_DEBUG 1 */
+#ifdef TRACE_ID_DEBUG
+static char page_buf[PAGE_SIZE];
+
+static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
+					  const char *func_name)
+{
+	pr_debug("%s id_map::\n", func_name);
+	bitmap_print_to_pagebuf(0, page_buf, id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
+	pr_debug("Avial= %s\n", page_buf);
+	bitmap_print_to_pagebuf(0, page_buf, id_map->pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+	pr_debug("Pend = %s\n", page_buf);
+}
+#define DUMP_ID_MAP(map)   coresight_trace_id_dump_table(map, __func__)
+#define DUMP_ID_CPU(cpu, id) pr_debug("%s called;  cpu=%d, id=%d\n", __func__, cpu, id)
+#define DUMP_ID(id)   pr_debug("%s called; id=%d\n", __func__, id)
+#define PERF_SESSION(n) pr_debug("%s perf count %d\n", __func__, n)
+#else
+#define DUMP_ID_MAP(map)
+#define DUMP_ID(id)
+#define DUMP_ID_CPU(cpu, id)
+#define PERF_SESSION(n)
+#endif
+
 /* release all pending IDs for all current maps & clear CPU associations */
 static void coresight_trace_id_release_all_pending(void)
 {
@@ -88,6 +112,7 @@ static void coresight_trace_id_release_all_pending(void)
 		}
 	}
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
@@ -123,6 +148,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 get_cpu_id_out:
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -150,6 +177,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
 put_cpu_id_out:
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
@@ -161,6 +190,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	id = coresight_trace_id_alloc_new_id(id_map, 0);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -171,6 +202,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 	spin_lock_irqsave(&id_map_lock, flags);
 	coresight_trace_id_free(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 }
 
 /* API functions */
@@ -207,6 +241,7 @@ EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 void coresight_trace_id_perf_start(void)
 {
 	atomic_inc(&perf_cs_etm_session_active);
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
 
@@ -214,6 +249,7 @@ void coresight_trace_id_perf_stop(void)
 {
 	if (!atomic_dec_return(&perf_cs_etm_session_active))
 		coresight_trace_id_release_all_pending();
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
 
-- 
2.17.1

