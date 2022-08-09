Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24627C25B0E
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Aug 2022 22:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiHIWev (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiHIWe0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940CA65818
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Aug 2022 15:34:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so142857wmc.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Aug 2022 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCRW4eIwlZpRf/XZUffQpi9I1G4v3uBwP5qgZgTJbJM=;
        b=qwWJknrrUP55UJA4IjukOy34ha6UOdN6e0pP4GNmA3dXq9rl4fTpiOyL1/BbSWV59U
         NGJCoThY4QLoDC+/DxCak7sw0HaBbFMqJoHUVnYCSRQBkf/ViSagLURo0f5H3AACtamm
         TW6r6Xe4cNsfwxKuEzmNyZDIgYCvgAlKz2Vw5xDUKRSlWsnZv09Uik44sjsSkoYiiIjA
         j+HgrrfDFCb/4mAHgfov02wynxRZpsrKKbVnSQLl+ha0NzchIOwOLosqMbLJAwFH5W1L
         uDn/rNdmNEG0KvWT7bJao+CbwLkkNaa49D+x5T/auifkOTpirkIzkmZWsM2cli0vZnfT
         RxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HCRW4eIwlZpRf/XZUffQpi9I1G4v3uBwP5qgZgTJbJM=;
        b=Ikg8+g61i2Aa4WZ0l6JpvxeFJZeir5S3eiAtrCeitUmQuWv4I1fS4HG3eI85HGKDIv
         CNZoc+EuiKqT37ULDkwGECeBNnTFqwlDXw6h9yT5fkkRleYmz9B6GNbZDdaIpyu6ZCSb
         RmVRawnWsJaCRIcGdOP2B6X6+I0Bce8GRTDjmc+oAK4iqUYE5ExibCql3juFv7T4LMsG
         y8Q9X7oWjvVx6Qi6MSIKUCOF+ATqR9P6MkNMC3T0wmIIzYx/gGBmTw1hvzew8IAymMLV
         m+VegjndiMWkIbFDaiYEIFZOobvm2+nbgSJ+hQIYXWcV/PFuWXG4E+gI55/Cqksfb447
         gXag==
X-Gm-Message-State: ACgBeo3zKtZ2or2vxld7zB/OjRfh8bF40YJo4748Ao0CgngTm45KxdTb
        /q+A/ECX6SMAl/j1mJfJbX9Wxw==
X-Google-Smtp-Source: AA6agR58Lz3ebbAFD/5uzgx2/ytQXagffAJQoE4+pWMqbytQpzEKaAbg/nO/2U6pzhcbjrRVIPNaKw==
X-Received: by 2002:a05:600c:4e12:b0:3a3:2fe2:7d0e with SMTP id b18-20020a05600c4e1200b003a32fe27d0emr315846wmq.151.1660084455155;
        Tue, 09 Aug 2022 15:34:15 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:14 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 09/13] perf: cs-etm: Update record event to use new Trace ID protocol
Date:   Tue,  9 Aug 2022 23:33:57 +0100
Message-Id: <20220809223401.24599-10-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Trace IDs are now dynamically allocated.

Previously used the static association algorithm that is no longer
used. The 'cpu * 2 + seed' was outdated and broken for systems with high
core counts (>46). as it did not scale and was broken for larger
core counts.

Trace ID will now be sent in PERF_RECORD_AUX_OUTPUT_HW_ID record.

Legacy ID algorithm renamed and retained for limited backward
compatibility use.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/include/linux/coresight-pmu.h | 30 +++++++++++++++++------------
 tools/perf/arch/arm/util/cs-etm.c   | 21 ++++++++++++--------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index db9c7c0abb6a..307f357defe9 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -10,11 +10,28 @@
 #include <linux/bits.h>
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
+
+/*
+ * The legacy Trace ID system based on fixed calculation from the cpu
+ * number. This has been replaced by drivers using a dynamic allocation
+ * system - but need to retain the legacy algorithm for backward comparibility
+ * in certain situations:-
+ * a) new perf running on older systems that generate the legacy mapping
+ * b) older tools e.g. simpleperf in Android, that may not update at the same
+ *    time as the kernel.
+ */
+#define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
 /* CoreSight trace ID is currently the bottom 7 bits of the value */
 #define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
 
+/*
+ * perf record will set the legacy meta data values as unused initially.
+ * This allows perf report to manage the decoders created when dynamic
+ * allocation in operation.
+ */
+#define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
+
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
@@ -39,15 +56,4 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
-
 #endif
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 1b54638d53b0..196fe1a77de9 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -421,13 +421,16 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	evlist__to_front(evlist, cs_etm_evsel);
 
 	/*
-	 * In the case of per-cpu mmaps, we need the CPU on the
-	 * AUX event.  We also need the contextID in order to be notified
+	 * get the CPU on the sample - need it to associate trace ID in the
+	 * AUX_OUTPUT_HW_ID event, and the AUX event for per-cpu mmaps.
+	 */
+	evsel__set_sample_bit(cs_etm_evsel, CPU);
+
+	/*
+	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
 	 * when a context switch happened.
 	 */
 	if (!perf_cpu_map__empty(cpus)) {
-		evsel__set_sample_bit(cs_etm_evsel, CPU);
-
 		err = cs_etm_set_option(itr, cs_etm_evsel,
 					BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
 		if (err)
@@ -633,8 +636,10 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 
 	/* Get trace configuration register */
 	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
-	/* Get traceID from the framework */
-	data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
+	/* traceID set to legacy version, in case new perf running on older system */
+	data[CS_ETMV4_TRCTRACEIDR] =
+		CORESIGHT_LEGACY_CPU_TRACE_ID(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
+
 	/* Get read-only information from sysFS */
 	data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
 					       metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
@@ -681,9 +686,9 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
 		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
-		/* Get traceID from the framework */
+		/* traceID set to legacy value in case new perf running on old system */
 		info->priv[*offset + CS_ETM_ETMTRACEIDR] =
-						coresight_get_trace_id(cpu);
+			CORESIGHT_LEGACY_CPU_TRACE_ID(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
 		/* Get read-only information from sysFS */
 		info->priv[*offset + CS_ETM_ETMCCER] =
 			cs_etm_get_ro(cs_etm_pmu, cpu,
-- 
2.17.1

