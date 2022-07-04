Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12537C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 08:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiGDIL5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiGDILz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689938A6
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Jul 2022 01:11:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v14so12273306wra.5
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Jul 2022 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zojxnvZpFWkM41A8//tAsHc+Fw1PYbCZcokYl1kSYpo=;
        b=pcELbfqKsb/9A6ba2dU8TOvaU/2GPdBJs8ngahCUzcvmfXQxiouyZZ6hGLmLM3A2p1
         DjH6LrIdkVWkoWFHLxoTxp8YFlqloWUJSYZA1aTjiCgclKfErG0OmdlWi9NDNIrNkFux
         NvqS5tFQbxQb9G5n5U1ISfFObevI1TD5P7g6odbGnqQP62pgMWigjUt0lepNZjurKDP9
         ZFx+odRQvSpLd26CN0P4L1bgSfPEdXmhReRxmqhrJ6lkE0+3076AdQqFP5BEFxTIrfSc
         LKdpF6vPW81OsbwaVXjsM6odS0Gy6vdRk7cUz1fAyKS28KkD6N3IE2aIoiFh16+Bv7yn
         ItMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zojxnvZpFWkM41A8//tAsHc+Fw1PYbCZcokYl1kSYpo=;
        b=pCXwyZx96Cp4VEfXf2Kn2C36+h/3K4zMJYwKdh95E3igLJQPRLdUkC1layCbXyHEcD
         AyogLM4zPd6UnLn6z3gzfFlT1ESHtja97Q8cTP/xOuHpOl69SX26lu5zOGZaR+G6I3ca
         nKx+HdQJDhW4SFMa2jTz4NH5PzJQN1EaFSs2nSw1iCmZOuLg+d5mGH/TlNk9KZhYsUfG
         K983IZxJa7w5r6CpM3KlMuAnDn/km56NR0ehW+KfhpqpeBmFbAMvvUgD1ST+9wxZNVP/
         JqWDj2HGmzN5LxijQJ7+RHdisO5HXsKBcdkwoOb41PkEFU4A9zu+Hry1DvbhKeec22cn
         loYw==
X-Gm-Message-State: AJIora/npP4zZNV4issxdbpwRcGv4VFGSyGAsFnbhT+dbUNCjdXV6UFr
        cOt3FGjAG4Q03T1pxp7nbVOebg==
X-Google-Smtp-Source: AGRyM1u2JUjmiAZ362yt+wwuOtw7QOGrzyblpb6xqNWVGU9CMqwYC7qrqVFcuiv32mEHJsSE4MswoA==
X-Received: by 2002:a05:6000:1b86:b0:21d:21d2:3e12 with SMTP id r6-20020a0560001b8600b0021d21d23e12mr26055596wru.515.1656922312928;
        Mon, 04 Jul 2022 01:11:52 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:52 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 01/13] coresight: trace-id: Add API to dynamically assign Trace ID values
Date:   Mon,  4 Jul 2022 09:11:37 +0100
Message-Id: <20220704081149.16797-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The existing mechanism to assign Trace ID values to sources is limited
and does not scale for larger multicore / multi trace source systems.

The API introduces functions that reserve IDs based on availabilty
represented by a coresight_trace_id_map structure. This records the
used and free IDs in a bitmap.

CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id /
coresight_trace_id_put_cpu_id pair of functions. The API will record
the ID associated with the CPU. This ensures that the same ID will be
re-used while perf events are active on the CPU. The put_cpu_id function
will pend release of the ID until all perf cs_etm sessions are complete.

Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
coresight_trace_id_put_system_id.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../hwtracing/coresight/coresight-trace-id.c  | 230 ++++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  |  65 +++++
 3 files changed, 296 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index b6c4a48140ec..329a0c704b87 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
 		coresight-cfg-preload.o coresight-cfg-afdo.o \
-		coresight-syscfg-configfs.o
+		coresight-syscfg-configfs.o coresight-trace-id.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
new file mode 100644
index 000000000000..dac9c89ae00d
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+#include "coresight-trace-id.h"
+
+/* need to keep data on ids & association with cpus. */
+struct cpu_id_info {
+	int id;
+	bool pend_rel;
+};
+
+/* default trace ID map. Used for systems that do not require per sink mappings */
+static struct coresight_trace_id_map id_map_default;
+
+/* maintain a record of the current mapping of cpu IDs */
+static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
+
+/* perf session active flag */
+static int perf_cs_etm_session_active;
+
+/* lock to protect id_map and cpu data  */
+static DEFINE_SPINLOCK(id_map_lock);
+
+/* ID 0 is reserved */
+#define CORESIGHT_TRACE_ID_RES_0 0
+
+/* ID 0x70 onwards are reserved */
+#define CORESIGHT_TRACE_ID_RES_RANGE_LO 0x70
+#define CORESIGHT_TRACE_ID_RES_RANGE_HI 0x7F
+
+#define IS_VALID_ID(id)	\
+	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_RANGE_LO))
+
+static void coresight_trace_id_set_inuse(int id, struct coresight_trace_id_map *id_map)
+{
+	if (IS_VALID_ID(id))
+		set_bit(id, id_map->avail_ids);
+}
+
+static void coresight_trace_id_clear_inuse(int id, struct coresight_trace_id_map *id_map)
+{
+	if (IS_VALID_ID(id))
+		clear_bit(id, id_map->avail_ids);
+}
+
+static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
+{
+	if (IS_VALID_ID(id))
+		set_bit(id, id_map->pend_rel_ids);
+}
+
+static void coresight_trace_id_clear_pend_rel(int id, struct coresight_trace_id_map *id_map)
+{
+	if (IS_VALID_ID(id))
+		clear_bit(id, id_map->pend_rel_ids);
+}
+
+static int coresight_trace_id_find_new_id(struct coresight_trace_id_map *id_map)
+{
+	int id;
+
+	id = find_first_zero_bit(id_map->avail_ids, CORESIGHT_TRACE_IDS_MAX);
+	if (id >= CORESIGHT_TRACE_IDS_MAX)
+		id = -EINVAL;
+	return id;
+}
+
+/* release all pending IDs for all current maps & clear CPU associations */
+static void coresight_trace_id_release_all_pending(void)
+{
+	struct coresight_trace_id_map *id_map = &id_map_default;
+	int cpu, bit;
+
+	for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_IDS_MAX) {
+		clear_bit(bit, id_map->avail_ids);
+		clear_bit(bit, id_map->pend_rel_ids);
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(cpu_ids, cpu).pend_rel) {
+			per_cpu(cpu_ids, cpu).pend_rel = false;
+			per_cpu(cpu_ids, cpu).id = 0;
+		}
+	}
+}
+
+static void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map)
+{
+	int bit;
+
+	/* set all reserved bits as in-use */
+	set_bit(CORESIGHT_TRACE_ID_RES_0, id_map->avail_ids);
+	for (bit = CORESIGHT_TRACE_ID_RES_RANGE_LO;
+	     bit <= CORESIGHT_TRACE_ID_RES_RANGE_HI; bit++)
+		set_bit(bit, id_map->avail_ids);
+}
+
+static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	/* check for existing allocation for this CPU */
+	id = per_cpu(cpu_ids, cpu).id;
+	if (id)
+		goto get_cpu_id_out;
+
+	/* find a new ID */
+	id = coresight_trace_id_find_new_id(id_map);
+	if (id < 0)
+		goto get_cpu_id_out;
+
+	/* got a valid new ID - save details */
+	per_cpu(cpu_ids, cpu).id = id;
+	per_cpu(cpu_ids, cpu).pend_rel = false;
+	coresight_trace_id_set_inuse(id, id_map);
+	coresight_trace_id_clear_pend_rel(id, id_map);
+
+get_cpu_id_out:
+	spin_unlock_irqrestore(&id_map_lock, flags);
+	return id;
+}
+
+static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	id = per_cpu(cpu_ids, cpu).id;
+	if (!id)
+		goto put_cpu_id_out;
+
+	if (perf_cs_etm_session_active) {
+		/* set release at pending if perf still active */
+		coresight_trace_id_set_pend_rel(id, id_map);
+		per_cpu(cpu_ids, cpu).pend_rel = true;
+	} else {
+		/* otherwise clear id */
+		coresight_trace_id_clear_inuse(id, id_map);
+		per_cpu(cpu_ids, cpu).id = 0;
+	}
+
+ put_cpu_id_out:
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+
+static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	id = coresight_trace_id_find_new_id(id_map);
+	if (id > 0)
+		coresight_trace_id_set_inuse(id, id_map);
+	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	return id;
+}
+
+static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *id_map, int id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	coresight_trace_id_clear_inuse(id, id_map);
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+
+/* API functions */
+int coresight_trace_id_get_cpu_id(int cpu)
+{
+	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
+
+void coresight_trace_id_put_cpu_id(int cpu)
+{
+	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
+
+int coresight_trace_id_get_system_id(void)
+{
+	return coresight_trace_id_map_get_system_id(&id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
+
+void coresight_trace_id_put_system_id(int id)
+{
+	coresight_trace_id_map_put_system_id(&id_map_default, id);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
+
+void coresight_trace_id_perf_start(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	perf_cs_etm_session_active++;
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
+
+void coresight_trace_id_perf_stop(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	perf_cs_etm_session_active--;
+	if (!perf_cs_etm_session_active)
+		coresight_trace_id_release_all_pending();
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
+
+void coresight_trace_id_init_default_map(void)
+{
+	coresight_trace_id_init_id_map(&id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_init_default_map);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
new file mode 100644
index 000000000000..63950087edf6
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(C) 2022 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_TRACE_ID_H
+#define _CORESIGHT_TRACE_ID_H
+
+/*
+ * Coresight trace ID allocation API
+ *
+ * With multi cpu systems, and more additional trace sources a scalable
+ * trace ID reservation system is required.
+ *
+ * The system will allocate Ids on a demand basis, and allow them to be
+ * released when done.
+ *
+ * In order to ensure that a consistent cpu / ID matching is maintained
+ * throughout a perf cs_etm event session - a session in progress flag will
+ * be maintained, and released IDs not cleared until the perf session is
+ * complete. This allows the same CPU to be re-allocated its prior ID.
+ *
+ *
+ * Trace ID maps will be created and initialised to prevent architecturally
+ * reserved IDs from being allocated.
+ *
+ * API permits multiple maps to be maintained - for large systems where
+ * different sets of cpus trace into different independent sinks.
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+
+/* architecturally we have 128 IDs some of which are reserved */
+#define CORESIGHT_TRACE_IDS_MAX 128
+
+/**
+ * Trace ID map.
+ *
+ * @avail_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
+ *		Initialised so that the reserved IDs are permanently marked as in use.
+ * @pend_rel_ids: CPU IDs that have been released by the trace source but not yet marked
+ *                as available, to allow re-allocation to the same CPU during a perf session.
+ */
+struct coresight_trace_id_map {
+	DECLARE_BITMAP(avail_ids, CORESIGHT_TRACE_IDS_MAX);
+	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+};
+
+/* Allocate and release IDs for a single default trace ID map */
+int coresight_trace_id_get_cpu_id(int cpu);
+int coresight_trace_id_get_system_id(void);
+void coresight_trace_id_put_cpu_id(int cpu);
+void coresight_trace_id_put_system_id(int id);
+
+/* notifiers for perf session start and stop */
+void coresight_trace_id_perf_start(void);
+void coresight_trace_id_perf_stop(void);
+
+/* initialise the default ID map */
+void coresight_trace_id_init_default_map(void);
+
+#endif /* _CORESIGHT_TRACE_ID_H */
-- 
2.17.1

