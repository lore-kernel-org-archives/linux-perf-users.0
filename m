Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79045C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 16:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiKAQbv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiKAQbh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813061C908
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 09:31:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z14so20874923wrn.7
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/OkoZY2NT7ICxt6pxMECbhZ/ZuX+9qnqpKwLzS1JpjA=;
        b=EhKSmM7wPBsoMr34pTYH6e/an7N4hbVBb7+MUj8exfJTgPvysY4/RZ/sDw+5OrBp1p
         EynSFNVHCstaJbQYy2hP8Q7iA4BNFO8Qqeqth5aS0bVBLkskG/uYguNwOC9a8Q4YisQE
         dNbMTLuWaz1AWw2EzmmCfquCOG7n0z3+B/z9biojkID7rdx+Fl9abdhOKSUelYVcJGvY
         lGKrxIyztTx4DtiWTH8bPyeK93ov/+WlRt8zkm+qWoJ2f0oTSc6yIzOOuc5hEisQFouO
         ISJjntj9pUl484uzl2EoFCqW/83vLno6cGnH7KOx965AsNVq/1uX84YS8DSnu+UFvJH+
         FReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OkoZY2NT7ICxt6pxMECbhZ/ZuX+9qnqpKwLzS1JpjA=;
        b=jcTKA6cTCxHnQnsCzd+SBjm6snX4E7lLiU7uCb9x6w6YPP+pzHy7KStTIEAnt5MYQY
         RZQzzo+PYoqk9mEFVtSL1xL1PMLAaKRfoCqYN2r4E20zkZfUbhHWTFPSfJGCntUfxqts
         efLxXfDVL0ymDL5a3zGD7+Gc3dB7HSD0fInYsMuPf+qSyT+pYPS805NIaZsrY5mkZ1wR
         yy48MYhtnzXzpX01rnDJsezjtDl1xyEO+Zp5DQ/2ADPTxrTabwTuA4+HQl/RiMXK01p1
         yUWmcD0kEJK1tlIJ1T+UsLZX0Zm2K77GlV8ZccCk4AeX1SGb0n6JdY1hn9EEF024eZ2o
         e+CQ==
X-Gm-Message-State: ACrzQf0vESJ8yZ9MQwzamr5/PTfuEqbJd7f5ZohLpNSfdPDrRoZjDgG1
        XD+JhwGQUzsKqUAQLSfwGuXTQg==
X-Google-Smtp-Source: AMsMyM77kln0fy1pQKA4tkqa0x+IGaKF48rLr+qQuFCXC+pvHrgYTw/Zh+Allkx6uCVtggLlSPQBWA==
X-Received: by 2002:a5d:5d09:0:b0:236:c650:e449 with SMTP id ch9-20020a5d5d09000000b00236c650e449mr8682046wrb.406.1667320296126;
        Tue, 01 Nov 2022 09:31:36 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:35 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 13/14] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
Date:   Tue,  1 Nov 2022 16:31:02 +0000
Message-Id: <20221101163103.17921-14-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
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

