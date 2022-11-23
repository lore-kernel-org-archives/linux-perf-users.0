Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D69C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 19:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiKWTvh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiKWTvC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 14:51:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B36C1F73
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x5so26966041wrt.7
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yRqldm/FdfNyFbQj65h6UroAtQ4UGZzHEB+lTVOfKUo=;
        b=zYdjxfGscIhxh6xArFzy4LgvKjYgl/BYqLtsSr8z/AagXcssbIObvxlx4mnbRdvMXs
         a74MMDvbjDzsZPDpvuU9TJxJNOk6STHL2rwUP/4FXwqmKiYOwfSDLqhkFRvhhAeIZCGL
         ejNswmM91mfKCJwtWp3HIX1bhNQp+Mq4jHedc4cAIRqMRGpEE9tHiUELY+viQ3+IzktB
         PAWmD2BCT/OIUgw/wwvNCY95RapbAh9jaJuvznHIxO6/8DwxH2Qe+TkUvOQpLKWWRJYn
         VBpAfpQh7d6j6OkeHLM/eAyCjkfPvkJdT1EVNY4Z06gq0cRpIZWdPj5lxloYIf15Rm8v
         95Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRqldm/FdfNyFbQj65h6UroAtQ4UGZzHEB+lTVOfKUo=;
        b=pMMQVEycsihXTBlK69wJA2Y8KWC92SHRvVhBaCTMQTn8H+h7/yUZV8UiE5eRGxlToX
         w2QUEd/TrPFTupOJoadnohGzsb06auLMXyAcul4Xalo29KWoYiYJbgXydtHe/dWYjBpA
         xHhecP+1rHVYD97EE3MkCU3/zHg6kDVYhQeevT2DsKGEdOF//mfwxYiEHDUk5tJwG75L
         T2DEfqULp44M74g+HfUme0hD/P695kQwiJIWjTekA43G9Q/tucRoBpjie0LtFFZisi+p
         zH5NhqEDguj90f7xZDbtWG6ULy3utuDdk65tR/WiRCSqUhNxs9uk0g/1V5sXRO0heHht
         LsmQ==
X-Gm-Message-State: ANoB5plkKxqPfbWUKZxD4xtpbuwnD2QwDCbHF2ncgxoMk6owHyFxshFK
        jE9NZ8yWXlPtVkaj7JooXs9H7yNgtCN/oQ==
X-Google-Smtp-Source: AA0mqf7TCodPPUK8zhWOAdzPfOYVd7M7RAfUC8tzK5A1ysBZc6lp33olazjEPyxpkpMAIXRiIWs+Mg==
X-Received: by 2002:a5d:66c8:0:b0:241:eabf:3b90 with SMTP id k8-20020a5d66c8000000b00241eabf3b90mr3444720wrw.31.1669233035185;
        Wed, 23 Nov 2022 11:50:35 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:34 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 13/14] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Wed, 23 Nov 2022 19:50:09 +0000
Message-Id: <20221123195010.6859-14-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the perf_report_aux_output_id() call to output the CoreSight trace ID
and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
perf.data file.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
 include/linux/coresight-pmu.h                    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdb9ab86173a..12fff661456e 100644
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
+	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION);
+	hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
+	perf_report_aux_output_id(event, hw_id);
+
 out:
 	/* Tell the perf core the event is alive */
 	event->hw.state = 0;
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 624f4843453e..51ac441a37c3 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 
 /*
@@ -43,4 +45,16 @@
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

