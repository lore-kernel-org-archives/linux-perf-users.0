Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF3C46467
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 12:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjAPMvG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjAPMuc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 07:50:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795711F5C5
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso2165697wms.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MmfeWQlT78drM8G0hOv804O+RJ2l1J7iO54NF0OyN8=;
        b=OG+yCtYVzaQodpp5T6SUkXT2vd5myZOrMNCUDO5yrofj+CGODUYrK/8xI2hIp2nRbd
         E3Qq3SKmVuG+EOosLDSbpA0nq0UX9H+BQsRsKPwcD7qNj/VYgANq7lQk+30QVWq7kGEq
         JTc6kL0nLQB0xTQi45E2H9rghaTildWKHE1gafYtESWuVhpRLSqSabilgprKvnVYnh9M
         WAIMERBv3Q7oLhafwPGM0UrRIwi4oiV/h9A2kQqA1OKRxfUgKMgdYJ5VoWF9+TIc0+pv
         LDx/4nUnQapRddV0hle2h4RW7Xt6fJQQWHWhkhqoVD4Dg/CYyayBTgzG16XkrIQwMe9D
         WO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MmfeWQlT78drM8G0hOv804O+RJ2l1J7iO54NF0OyN8=;
        b=rgBw874uBBUnWCh71hZVTtEp8a4tI8l3armhUKEqdSo/hP8Q7sPvfsWeAFn+fM5b++
         NxsYsoxVDVhEajP+bmPkov/wM20pDXpdoSzGZ8lokUTrVUCEBUWegh9xneRCtrTKUJTJ
         S13kpGuW3S0S44nagt67j823N1X+B3E4/x30u+c6MdfnUW1gtnUvkTKZhED1feqL2qu3
         WxR6Hy0qHoiYUYcdRyU5W516fOJhVZKHFyU41SgATTrawVjM+euZF9nsAr1HFRNYkycR
         YbZKKPWJhCCvVyr6KTMe3kqolMeRlTMrOdjfI2Sa7PvO0wAh9LdERdOx7+JXgSQ8iSL+
         ObHg==
X-Gm-Message-State: AFqh2krcu3jquZkFBKLBlzKZKvD4f9Vc4/WNiSI/PUMoDjPLSSlIo+QZ
        9RswlsGYxk41fVe6Umk+Gf+HOw==
X-Google-Smtp-Source: AMrXdXsUtzGA3B42oEx1FBsS5xtHjmaXQ/esRd6b013xNmvEMEa51m+oASURT2mCnf/3KE+2CMsiMw==
X-Received: by 2002:a05:600c:35d6:b0:3da:17f5:57b9 with SMTP id r22-20020a05600c35d600b003da17f557b9mr13228767wmq.5.1673873390001;
        Mon, 16 Jan 2023 04:49:50 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:49 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 14/15] coresight: trace-id: Add debug & test macros to Trace ID allocation
Date:   Mon, 16 Jan 2023 12:49:27 +0000
Message-Id: <20230116124928.5440-15-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds in a number of pr_debug macros to allow the debugging and test of
the trace ID allocation system.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 9b85c376cb12..367bbfb4c213 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -24,6 +24,27 @@ static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
 /* lock to protect id_map and cpu data  */
 static DEFINE_SPINLOCK(id_map_lock);
 
+/* #define TRACE_ID_DEBUG 1 */
+#if defined(TRACE_ID_DEBUG) || defined(CONFIG_COMPILE_TEST)
+
+static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
+					  const char *func_name)
+{
+	pr_debug("%s id_map::\n", func_name);
+	pr_debug("Used = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->used_ids);
+	pr_debug("Pend = %*pb\n", CORESIGHT_TRACE_IDS_MAX, id_map->pend_rel_ids);
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
 /* unlocked read of current trace ID value for given CPU */
 static int _coresight_trace_id_read_cpu_id(int cpu)
 {
@@ -127,6 +148,7 @@ static void coresight_trace_id_release_all_pending(void)
 		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
 	}
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
@@ -168,6 +190,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 get_cpu_id_out_unlock:
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -194,6 +218,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
 	}
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
+	DUMP_ID_CPU(cpu, id);
+	DUMP_ID_MAP(id_map);
 }
 
 static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
@@ -206,6 +232,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	id = coresight_trace_id_alloc_new_id(id_map, 0, true);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 	return id;
 }
 
@@ -216,6 +244,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 	spin_lock_irqsave(&id_map_lock, flags);
 	coresight_trace_id_free(id, id_map);
 	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	DUMP_ID(id);
+	DUMP_ID_MAP(id_map);
 }
 
 /* API functions */
@@ -253,6 +284,7 @@ EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 void coresight_trace_id_perf_start(void)
 {
 	atomic_inc(&perf_cs_etm_session_active);
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
 
@@ -260,6 +292,7 @@ void coresight_trace_id_perf_stop(void)
 {
 	if (!atomic_dec_return(&perf_cs_etm_session_active))
 		coresight_trace_id_release_all_pending();
+	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
 
-- 
2.17.1

