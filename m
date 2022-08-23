Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D693C49EC6
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356496AbiHWKre (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355456AbiHWKn0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:43:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89CAAB057
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso9210235wmc.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=HCRW4eIwlZpRf/XZUffQpi9I1G4v3uBwP5qgZgTJbJM=;
        b=qTQxXm9Hv6K+L8GXKBSdjf1P+6es8HGJQCR/wxjUIWfiwlJTu226y+yuguCPMtolnb
         gqpstQMw9RRQbCOSuY920abi1iS1Gc2VvCNuB83Phs81fA5pylXPeNYCfSumNYSp0lR+
         0HFB7TuzqbwEDqgyHsutVvbUKWq6Tu+WQcXWR0b8HOslyBwSsl8MtxCaoKtSb7IFjGJy
         /PtL0eTEb4QsuMUeaQYattl1ugIpYQOxSM/JHO+hvXY+sMq51LuVwCO16cBuCyrfyOwi
         I+W/4rpkclgeWProJwD3Pe3VIXfK2fuAmuhF4u9CLFSzz7q5AaNiSHzA4ZSuwXBlC9p/
         SGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=HCRW4eIwlZpRf/XZUffQpi9I1G4v3uBwP5qgZgTJbJM=;
        b=cVY3v/gfT/jYOjKMf4L0d/fGJX9cAo7gz/cCEXQXQAKoO5auGgt73WhC4aykwilHkB
         h5G0597xgQQfdZ5AP1Did2xBR4mLWS60GM8Z/1unmp9gsKyhE06bEGDtbieWtrAQ6W9P
         qizAu8VrxOBHwZFbRtrv2Oy27n6dbadyNytViD++JEY2rOowOOdEBI2Z6UTjPeUTaM9G
         0pm8Rptq0TZfnST9UZfxXAZUxjtmVRGuVx4PZjFGFxcTvKgGcpJILDEs4OYpU+vW5ASR
         FZjag02tzBVvySqDaGqbPdW8xu25MaJ3IyD31Nh0JvhVqmKEcmnCAxoUVc75CGdtmRH3
         rVNQ==
X-Gm-Message-State: ACgBeo0KS41zlyQSrXhbGZ7To2fEEo6FiYZMJcPTOATDl7JSm1nU2/i9
        /W73OF6EwBn/pRUdttbn+NNYig==
X-Google-Smtp-Source: AA6agR6vv/y/1orgUDhhWZI0hCPNOWrpLlYdPoRm0jLT9q3Hem4OZjYqauMuaLrfphbx+RiXdCnL1g==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr1535356wmq.188.1661245823376;
        Tue, 23 Aug 2022 02:10:23 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:22 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 09/13] perf: cs-etm: Update record event to use new Trace ID protocol
Date:   Tue, 23 Aug 2022 10:10:05 +0100
Message-Id: <20220823091009.14121-10-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
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

