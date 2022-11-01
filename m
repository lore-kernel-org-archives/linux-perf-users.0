Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB90C43217
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 16:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKAQbn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiKAQbe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA81CB33
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 09:31:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5so9175400wmo.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4piIjBBSKKW5sIyFoW3hMNWYvv72XBKBYPL6wKArJpU=;
        b=NVomVUym4MEu73Zc4KkbF9IUF1zFehZxRoLf25QWFDl7VDQBzBKDknnRqR9uHQ2cDc
         15wWJHUlDh+GIO47pmpPeBDp/MQxWaNax9WJC4BMPkDHFtIH9rM7Z71q+QlZsAxY1Raz
         in0yCIZM3VRO2Y7+hS49NnCroJgqvSR09nvqPe6GlN68l1etg200ikxXdJStKNvsnkgu
         oVVVzok+ZVfveGIGv8XOto0WhKHVDv7wOGF6kQjNaO8q573xybusFJPBWzuFjXT/ay0N
         17pWEmcSctmxVtNHXEJAGz/UNV1r6y8RYgnc1S0y1PbP5ZvsKg+2A0wK3syHpoDOg1zV
         FMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4piIjBBSKKW5sIyFoW3hMNWYvv72XBKBYPL6wKArJpU=;
        b=mKIB+cnOZz8KXnJEBEYwuImDzyr1CjSHvZP/1RxIS03snlSdS2KMcf41KTzYzxTjwY
         SvD1AJPlPiSD0WWkVQKtbxpyMNcUjbaPwhboP2+tZuVI5Q/v5ZCxeCGD+ayQLXJ2edFx
         AmNgaGkUTGJfJ8MfOsr81z1FkJDrhXtfQrp81r7h6K5fq0EENnZcVbE5ScJzjom0+XMt
         6FVlE34whh2xJOLrfuIIUGEsR1KuzzTw4Xb2b+w4N4AbIWWqCNJ4C5PI3kTFAmMbFdWH
         d+UoL1qg5Y0uWc98ztOAw0iOGqyrYiiUEH78qgqjgt4J/t/+MWLxakT4Ksadp3xFSo8N
         jFvg==
X-Gm-Message-State: ACrzQf0h46TYWUkpq34qetFrEjvlUMXqcRZV6KqHgbOX3wx3vTNiNO+6
        z0HV2A0yzGwit5agXknPtuLcyA==
X-Google-Smtp-Source: AMsMyM512c5hnjHJ72cRbajL0gy8dflgBlyBhPcRBMxzumwO/x+k0WNiw15wm0LfVsstofG98S/q+w==
X-Received: by 2002:a05:600c:4618:b0:3cf:54ad:7bb3 with SMTP id m24-20020a05600c461800b003cf54ad7bb3mr18740796wmo.4.1667320291364;
        Tue, 01 Nov 2022 09:31:31 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:30 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 09/14] perf: cs-etm: Move mapping of Trace ID and cpu into helper function
Date:   Tue,  1 Nov 2022 16:30:58 +0000
Message-Id: <20221101163103.17921-10-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The information to associate Trace ID and CPU will be changing.

Drivers will start outputting this as a hardware ID packet in the data
file which if present will be used in preference to the AUXINFO values.

To prepare for this we provide a helper functions to do the individual ID
mapping, and one to extract the IDs from the completed metadata blocks.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/include/linux/coresight-pmu.h |  5 ++
 tools/perf/util/cs-etm.c            | 92 +++++++++++++++++++----------
 tools/perf/util/cs-etm.h            | 14 ++++-
 3 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 6c2fd6cc5a98..db9c7c0abb6a 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -7,9 +7,14 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
+/* CoreSight trace ID is currently the bottom 7 bits of the value */
+#define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
+
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 16db965ac995..11026c9694a4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -193,6 +193,30 @@ int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
 	return 0;
 }
 
+static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
+{
+	struct int_node *inode;
+
+	/* Get an RB node for this CPU */
+	inode = intlist__findnew(traceid_list, trace_chan_id);
+
+	/* Something went wrong, no need to continue */
+	if (!inode)
+		return -ENOMEM;
+
+	/*
+	 * The node for that CPU should not be taken.
+	 * Back out if that's the case.
+	 */
+	if (inode->priv)
+		return -EINVAL;
+
+	/* All good, associate the traceID with the metadata pointer */
+	inode->priv = cpu_metadata;
+
+	return 0;
+}
+
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id)
 {
@@ -2881,18 +2905,47 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
 	return 0;
 }
 
+/* map trace ids to correct metadata block, from information in metadata */
+static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
+{
+	u64 cs_etm_magic;
+	u8 trace_chan_id;
+	int i, err;
+
+	for (i = 0; i < num_cpu; i++) {
+		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
+		switch (cs_etm_magic) {
+		case __perf_cs_etmv3_magic:
+			trace_chan_id = (u8)((metadata[i][CS_ETM_ETMTRACEIDR]) &
+					     CORESIGHT_TRACE_ID_VAL_MASK);
+			break;
+		case __perf_cs_etmv4_magic:
+		case __perf_cs_ete_magic:
+			trace_chan_id = (u8)((metadata[i][CS_ETMV4_TRCTRACEIDR]) &
+					      CORESIGHT_TRACE_ID_VAL_MASK);
+			break;
+		default:
+			/* unknown magic number */
+			return -EINVAL;
+		}
+		err = cs_etm__map_trace_id(trace_chan_id, metadata[i]);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
-	struct int_node *inode;
 	unsigned int pmu_type;
 	int event_header_size = sizeof(struct perf_event_header);
 	int info_header_size;
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu, trcidr_idx;
+	int num_cpu;
 	int err = 0;
 	int i, j;
 	u64 *ptr, *hdr = NULL;
@@ -2962,23 +3015,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				cs_etm__create_meta_blk(ptr, &i,
 							CS_ETM_PRIV_MAX,
 							CS_ETM_NR_TRC_PARAMS_V0);
-
-			/* The traceID is our handle */
-			trcidr_idx = CS_ETM_ETMTRACEIDR;
-
 		} else if (ptr[i] == __perf_cs_etmv4_magic) {
 			metadata[j] =
 				cs_etm__create_meta_blk(ptr, &i,
 							CS_ETMV4_PRIV_MAX,
 							CS_ETMV4_NR_TRC_PARAMS_V0);
-
-			/* The traceID is our handle */
-			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
 		} else if (ptr[i] == __perf_cs_ete_magic) {
 			metadata[j] = cs_etm__create_meta_blk(ptr, &i, CS_ETE_PRIV_MAX, -1);
-
-			/* ETE shares first part of metadata with ETMv4 */
-			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
 		} else {
 			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
 				  ptr[i]);
@@ -2990,26 +3033,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 			err = -ENOMEM;
 			goto err_free_metadata;
 		}
-
-		/* Get an RB node for this CPU */
-		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
-
-		/* Something went wrong, no need to continue */
-		if (!inode) {
-			err = -ENOMEM;
-			goto err_free_metadata;
-		}
-
-		/*
-		 * The node for that CPU should not be taken.
-		 * Back out if that's the case.
-		 */
-		if (inode->priv) {
-			err = -EINVAL;
-			goto err_free_metadata;
-		}
-		/* All good, associate the traceID with the metadata pointer */
-		inode->priv = metadata[j];
 	}
 
 	/*
@@ -3090,6 +3113,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
+	/* before aux records are queued, need to map metadata to trace IDs */
+	err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+	if (err)
+		goto err_delete_thread;
+
 	err = cs_etm__queue_aux_records(session);
 	if (err)
 		goto err_delete_thread;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 90c83f932d9a..712a6f855f0e 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -28,13 +28,17 @@ enum {
 /*
  * Update the version for new format.
  *
- * New version 1 format adds a param count to the per cpu metadata.
+ * Version 1: format adds a param count to the per cpu metadata.
  * This allows easy adding of new metadata parameters.
  * Requires that new params always added after current ones.
  * Also allows client reader to handle file versions that are different by
  * checking the number of params in the file vs the number expected.
+ *
+ * Version 2: Drivers will use PERF_RECORD_AUX_OUTPUT_HW_ID to output
+ * CoreSight Trace ID. ...TRACEIDR metadata will be set to unused ID.
  */
-#define CS_HEADER_CURRENT_VERSION 1
+#define CS_HEADER_CURRENT_VERSION	2
+#define CS_AUX_HW_ID_VERSION_MIN	2
 
 /* Beginning of header common to both ETMv3 and V4 */
 enum {
@@ -85,6 +89,12 @@ enum {
 	CS_ETE_PRIV_MAX
 };
 
+/*
+ * Check for valid CoreSight trace ID. If an invalid value is present in the metadata,
+ * then IDs are present in the hardware ID packet in the data file.
+ */
+#define CS_IS_VALID_TRACE_ID(id) ((id > 0) && (id < 0x70))
+
 /*
  * ETMv3 exception encoding number:
  * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
-- 
2.17.1

