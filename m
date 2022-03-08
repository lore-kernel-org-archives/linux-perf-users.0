Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB89C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Mar 2022 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350265AbiCHUvF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350270AbiCHUvF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E48D3207B
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Mar 2022 12:50:07 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l10so226075wmb.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Mar 2022 12:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkKeTpGeVj1TsD7lgtJxbN6dJOpPm7ZIDu/PMW+d2/s=;
        b=R3oKdAIGROO1nl4fOdOTEC6Y6ElvV4vaUf0h9EF5Q1a6tdeoQKHA8CkWpHSUNVsgEs
         ZHznJ5jZZ8GKxjZ2ELfs3+r37otMN+c95llQLujM9jvz2mWWNN2pYDq0a2pE34b/CxXU
         6rJFepurHMqRcBEnqRRx4L7DMjnMYHb+gxHaG91CjEneKyPl0cfaHM8gXCa5B9ZK7ICh
         egqDwxIBpkTXEdtb1JGKu9HQ/Y3zMikdRGOraiJHtf7PgkdeHjcOZI+qpwCGMzN1yDcF
         5rupO50giyNJukaFq0ErZUZsGL/9E/7x2tcURZfwEppmaS22VfYyL1tYw8tsPhurAzxB
         auiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkKeTpGeVj1TsD7lgtJxbN6dJOpPm7ZIDu/PMW+d2/s=;
        b=g8tUBy6vQWcLnItnK+LDTeucUy6i9TB24bBXHiu2nq/WMiDnGRVme6pew4hhkn7Epm
         8GMLLx3mTVAT25m9zUTle5OsnST7YaZsa/5In6OSW6T80pCpqb5oU++i6AmK40uNF8wC
         84v3lY9g9Ei8b86+OUDUdW2Qq9tk0l7L/JXp34ZABTK8JgqYJ6L8L/qJuw2KY4iEquEa
         tWAqH4WI4oujSbZdNj8Wdt5HyrpN5wy9l+231WdAe02tPV2VohmNA+neqCqrXEabSWXJ
         BfK9fp3qhm/VrlcSxr0qDe5nkIQH7xWzJmnNjq4FTQsfS24dDSgw5bT5bAnjYAzky4jb
         0UHg==
X-Gm-Message-State: AOAM531z3Ce1a/N1nxeZScTjOUdEwrrz78qKXaC9BChvEewufaJR22pY
        Et0KmUfvIO/LW59FbHsoOgdM4Q==
X-Google-Smtp-Source: ABdhPJw8VChYAWgMdUZF0BnRoSIIHmH8w2IlzDcL5mxMB0asBtDYymYVai84TCVfRZXFdq+sUBYuGQ==
X-Received: by 2002:a1c:4b0e:0:b0:389:bf16:d8fb with SMTP id y14-20020a1c4b0e000000b00389bf16d8fbmr5094074wma.103.1646772605960;
        Tue, 08 Mar 2022 12:50:05 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:05 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 01/10] coresight: trace-id: Add API to dynamically assign trace ID values
Date:   Tue,  8 Mar 2022 20:49:51 +0000
Message-Id: <20220308205000.27646-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308205000.27646-1-mike.leach@linaro.org>
References: <20220308205000.27646-1-mike.leach@linaro.org>
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
 .../hwtracing/coresight/coresight-trace-id.c  | 222 ++++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  |  69 ++++++
 3 files changed, 292 insertions(+), 1 deletion(-)
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
index 000000000000..ce6c7d7b55d6
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -0,0 +1,222 @@
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
+/* maintain a record of the current mapping of cpu IDs */
+static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
+
+/* a list of currently used id_maps */
+static LIST_HEAD(id_map_list);
+
+/* perf session active flag */
+static int perf_cs_etm_session_active;
+
+/* lock to protect id_map list and cpu data  */
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
+	struct coresight_trace_id_map *id_map;
+	int cpu, bit;
+
+	list_for_each_entry(id_map, &id_map_list, node) {
+		for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_IDS_MAX) {
+			clear_bit(bit, id_map->avail_ids);
+			clear_bit(bit, id_map->pend_rel_ids);
+		}
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
+int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	id = per_cpu(cpu_ids, cpu).id;
+	if (!id) {
+		id = coresight_trace_id_find_new_id(id_map);
+		if (id < 0)
+			goto get_cpu_id_out;
+	}
+
+	per_cpu(cpu_ids, cpu).id = id;
+	per_cpu(cpu_ids, cpu).pend_rel = false;
+	coresight_trace_id_set_inuse(id, id_map);
+	coresight_trace_id_clear_pend_rel(id, id_map);
+
+get_cpu_id_out:
+	spin_unlock_irqrestore(&id_map_lock, flags);
+	return id;
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
+
+void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
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
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
+
+int coresight_trace_id_get_system_id(struct coresight_trace_id_map *id_map)
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
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
+
+void coresight_trace_id_put_system_id(struct coresight_trace_id_map *id_map, int id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	coresight_trace_id_clear_inuse(id, id_map);
+	spin_unlock_irqrestore(&id_map_lock, flags);
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
+void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int bit;
+
+	/* set all reserved bits as in-use */
+	set_bit(CORESIGHT_TRACE_ID_RES_0, id_map->avail_ids);
+	for (bit = CORESIGHT_TRACE_ID_RES_RANGE_LO;
+	     bit <= CORESIGHT_TRACE_ID_RES_RANGE_HI; bit++)
+		set_bit(bit, id_map->avail_ids);
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	/* add id_map to the list */
+	list_add(&id_map->node, &id_map_list);
+
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_init_id_map);
+
+void coresight_trace_id_release_id_map(struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	/* remove id_map from list */
+	list_del(&id_map->node);
+
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_release_id_map);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
new file mode 100644
index 000000000000..01db2441cee6
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -0,0 +1,69 @@
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
+ * @node:	List entry to add to list of managed trace id maps.
+ */
+struct coresight_trace_id_map {
+	DECLARE_BITMAP(avail_ids, CORESIGHT_TRACE_IDS_MAX);
+	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+	struct list_head node;
+};
+
+/* Allocate and release IDs */
+int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
+int coresight_trace_id_get_system_id(struct coresight_trace_id_map *id_map);
+void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
+void coresight_trace_id_put_system_id(struct coresight_trace_id_map *id_map, int id);
+
+/* initialise ID map - block reserved IDs, add to list of ID maps */
+void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map);
+/* remove ID maps from list of maps */
+void coresight_trace_id_release_id_map(struct coresight_trace_id_map *id_map);
+
+/* notifiers for perf session start and stop */
+void coresight_trace_id_perf_start(void);
+void coresight_trace_id_perf_stop(void);
+
+#endif /* _CORESIGHT_TRACE_ID_H */
-- 
2.17.1

