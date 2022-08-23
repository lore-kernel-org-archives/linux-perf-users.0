Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A80C32796
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355495AbiHWKrw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355685AbiHWKoC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:44:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15AAB079
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so9186753wme.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=00nZRcZGH0Ch9kf2FG017OBarf3WrFRyr4+E06yZjt4=;
        b=HpDVHm11YxrrBB9xsaNFKAhRf3RMEuMDCYt/ZksGm4V2FqeiOg0HxpYQNLjepXXUvO
         T0A/Qs6JxvhXH/RbxYObI7rbn9urv4ibf+Q6OouveJTkDLkw1dqZvezYIEP/BH+a7tiW
         nyjMap+JtyCGZLy32XdhzDJNETOf86ByMkQHNE2veSJ5EPGcGd3TuMXEOLAbDDqN5Su8
         sGVWBhu3VFMUdQ1jZbSukiV8AszKnOsbo/tK9GNopSYAIi6KTWfceIOHgsdsah7WmIsJ
         ChRmUoT4AjQQZPDDV/rCCqWQjLO4CbKVzIPIlvidTtvJdXcMrL4G+BNNAahfjU14mXcx
         viRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=00nZRcZGH0Ch9kf2FG017OBarf3WrFRyr4+E06yZjt4=;
        b=LHM+r1dnC66OCrPRykkrewcDKchob0IA9BnVq1TVX+wx4oCC621BN0PzLeugBHVgzO
         0K6gjssy9RYmhHb70EJF1wId75XidiwJ2rCLrpHv7rjdZw8GaUfR/nJN4Cl0ETNBqxNx
         hIK4dvCiJ9Spmw7Zfl1922Dt4YlmSKefFyfOzx6A5ajjB6pwTWOZynGdNKIJzXmdNgak
         Ztum6pNpLpLyDEOK4fLtxkLUdfHqD5qW+mgFm7KlQODVGQPlnHnJFEnmLal8Gu0CRvx6
         h+wubsmRmrJfj43niLgA00y24qRiqvd3clv5yqQSUnuUZfWrTo1Or680QUXFQuJAlcDN
         4/mg==
X-Gm-Message-State: ACgBeo3X8PuFcI54MDd/NCJyKnYEjTfhtzW9LpHwiEjhe+Iz7NHPUyAf
        haKON+vqchSSQWIxmfKfGjHKjg==
X-Google-Smtp-Source: AA6agR4IyoYCMb8Rm017id592w1HTMLhZsUXS8pSrQLfOj5pTWDvOcRMSxJATztL4ntF4BhAcHH6Aw==
X-Received: by 2002:a7b:ca4c:0:b0:3a5:bbf1:9e3e with SMTP id m12-20020a7bca4c000000b003a5bbf19e3emr1545407wml.5.1661245826465;
        Tue, 23 Aug 2022 02:10:26 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:26 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 12/13] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Tue, 23 Aug 2022 10:10:08 +0100
Message-Id: <20220823091009.14121-13-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the perf_report_aux_output_id() call to output the CoreSight trace ID
and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
perf.data file.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
 include/linux/coresight-pmu.h                    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6166f716a6ac..59a2ad95c1dc 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -448,6 +449,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
+	u64 hw_id;
 
 	if (!csdev)
 		goto fail;
@@ -493,6 +495,11 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
 		goto fail_disable_path;
 
+	/* output cpu / trace ID in perf record */
+	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION) |
+		FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
+	perf_report_aux_output_id(event, hw_id);
+
 out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 99bc3cc6bf2d..9aafafff219a 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 
 /*
@@ -44,4 +46,16 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
+/*
+ * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
+ * Used to associate a CPU with the CoreSight Trace ID.
+ * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
+ * [59:08] - Unused (SBZ)
+ * [63:60] - Version
+ */
+#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
+#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_CURR_VERSION 0
+
 #endif
-- 
2.17.1

