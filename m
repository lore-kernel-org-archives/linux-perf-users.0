Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA99C38147
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355528AbiHWKrx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355745AbiHWKot (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:44:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4959AA4FA
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d5so6848517wms.5
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=Ht2C5hmUen8Zs+3SYPbHRSeYgcLBnHmLYbKN5MCrEgA=;
        b=LO2vlQcldj97eJ/EAiMe3sDzqwdAJ5KhZ5h4WLtFEN68J3R7KlX7W5R9R9L/9nbs1S
         HJxD2qGpOK9VjAVOe8m0CMOIGcyXFn8BA2FoWD+DuW6Akq/W3gF0S/QbSo4qzgkqJPrL
         WWfljmJUdGiKMK/Gyd4ejB4SE22IkT3iCxxDFS/5qJOMzAQYVY9iFqhsc5C/WFjkq/qn
         QeAFD50yxhnNvK+8FXUJtZoGDcGKd2XJuaAo5aVjszRra3np8CSC36G5ozCePa3+AaWe
         M7w5wA9AY0E/oqNBNAKt4mGcN8weTZkNT8Og9MTC7GwgOgdZbFsfvfchqLFgb/mLNc43
         EMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=Ht2C5hmUen8Zs+3SYPbHRSeYgcLBnHmLYbKN5MCrEgA=;
        b=jdJ7MnGh/6gyF4qL1ExtDS0GYu4K9yDBc0hDFHAFT+XIaECMSEASV6KG6gVF/6Dajo
         roJRe6NH6Ljj0LqbhB1N5uB7RxxsWPEdQs/G/ZJEU4u3kQFJx+2HpYtV8l+BYO2/gBc3
         k/EfD8hm8nyVD4MU5Y8RtMfXlZg8CJP+otWjsMBJ0DeZkqY+trbdHgURxlJFZzrc2cIx
         pco67R9aE/L8jl8xiXRhAIPKnodGf1wH5XYxMYH2De5EnYD2nFoqj7KDmg85rH21Iiyx
         tvjJqMMr7FKTLvsnAtajUX/HQt69394WpO2wHX1FwwFW1+9M4reQuxRX5XqzAEQtBFUK
         MIVg==
X-Gm-Message-State: ACgBeo2TD++i75qVMiwwGac1LSKVnyzXcTcKphfXu3aMSFs79+F+lIGg
        hzkOOi5eSCF7vdBcJS7tP1MQMg==
X-Google-Smtp-Source: AA6agR6e0QA2utU8zvfbH4QHIRq6o/dB/68eeJl6bY4OuMMpiG55VDuB11PJ52QzGsOStd+B30puJw==
X-Received: by 2002:a1c:f217:0:b0:3a6:61f2:a9c2 with SMTP id s23-20020a1cf217000000b003a661f2a9c2mr1520593wmc.88.1661245827384;
        Tue, 23 Aug 2022 02:10:27 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:26 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 13/13] coresight: trace-id: Add debug & test macros to Trace ID allocation
Date:   Tue, 23 Aug 2022 10:10:09 +0100
Message-Id: <20220823091009.14121-14-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
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

