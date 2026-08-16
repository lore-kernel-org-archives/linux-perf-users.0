Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CB3B0AF8
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786890168; cv=none; b=f6qzFPPAV/b81wJwtlbyjH3r8/K9QDhqhFZuQSP5PhFGXESNgVSh9kWLtPJjfTo+CStYNNqNcQc2vFl8BTPNZCD5EAr5YC4TbmxCOWGTX3CsLUZLMajmNPnGPIpRCdu35ATl/w+PuMOh3WRqLJQz2C9jku2CDL5qI4AvrPo0urY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786890168; c=relaxed/simple;
	bh=zEbOdsYLmiABDyfXCev+B7XhB/QfOxcoi0kPMyjH2LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/Fi9YaUvfVP4Tl/HvFkitnNAbNUoUFeEABn6yYMv4qhSR7zH4EWD8z7bv8HX07WNE0nLpuWInTA71MZSJ82O0z+yk/UFcCBjS9axZSbAGV3Mo4naYU59mbCo24Gn46tj8pCp8GLBIcK5bSzZsvLfumTfQ8sj6dtxVd8moeHf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpyJ930B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpyJ930B"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf50c6f235so31010185ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786890166; x=1787494966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m31MQUkSQS2jVChso5vZVbxBylBeL+g3s9FxURuBxhg=;
        b=cpyJ930BSxhcCWkTSZ69W2ejP6gLdp9VSu7Qrh5xl0rLdfHH5doU1VjjSs5u60WiVv
         CGdMJkmd67X/dw1RmTGmoJZh1D73pFYtNz7PH7wYgppNjlIHG8WVtgZO1Pd6pJz/fkCP
         2UJbirjrtzGTzecUxTCld856mX5JX1IjOnaYboWwM94THXWNH5AZgD33SpQHLsDV1SLa
         t4CxhOLJrZR+rpCv7PQsBua4v3TGlZVkrBmcO3RpaNhaQZhKw5JzENdKdsCgZ4p8WJcx
         Sbws5b1WitLnPDycNW/J0cFPgyhStH+qLR1Oboa2NBuh4lNoeKoWzoG1AIBylGEqzZQK
         lMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786890166; x=1787494966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m31MQUkSQS2jVChso5vZVbxBylBeL+g3s9FxURuBxhg=;
        b=QRhk1V/o5bgLGAOkRsx7IsbwIld/iwCs/Q0tfLY6oZztU2ezNwRcavzOAKTeBwi8/a
         oDmd3xU5aXwCPbKZn5EGG1l1uEoZM6ITvg/sxDzW67f/x6Zn4JbOws90d0HSAQoBVEjE
         27yVO0KnbXFdtku1L+ju2hUvnf0PC93Ls/76MIIy5rsC1Y+aF1M4eGM1Fk+r8NVyHbsi
         xJ5AiwVjOGxS6SwF1M7ve4oDi8h7wEynUchPgTx99+2BVmKqME0lo2Yjm0FZXcDdvo+I
         A94nsrVKHPx19QDYegGyO/luLOWDY7j7wEjU9WMCN9E2YZExdzlq3sVKJL+rKKT+ouV0
         LBxw==
X-Forwarded-Encrypted: i=1; AHgh+Rqt2GIvGqYTB3IbXpbvsfxLp9d04ert3Oq1KBQxHWjdrRO20fDWPC5ApN3YrY3YF6LijV6LRzmKa+uKKK7oiuUx@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQDOhw5ck68ny1Z9jDmqksZJ9OYStB+Y7b8slgLUxvB5rF1EQ
	NQ1NN9vgMEvi37NdAdf/u6GYWr/WihVAT162HO3Lpq+oHnuH/LaCBDRt
X-Gm-Gg: AR+sD11d13i7HRjCwcHt91RwNdu8slwL3gX+Dal06nEun2TLvFhEtwUhe5V6S7BxR29
	/YrGUKjrXR8vrzXno3SxjGXrFYsxW5vjRxBSH597q9hXVACJPZCjGFtQ+EA7dVQy4DzOLSaEIWx
	201Tw7nphOsD1YvCYMMDEb836genfSptuj0PVIi24RBkHpcWp69ShpYiBqhHrJWP0qQdxlFWlwB
	3qvoecXHhUBihkSV1JU9eW04gsozx/+qh8cJaaIR1D2tsYKvinPGVN2EY9Mw0Dx2Q1Egb+qaxeZ
	ZWnTiHH7A+KSOkPaQI1hfXNIDoinN7tv24BY/YWJBWjm+91hwOhBEQWF1liQgOj3dkca74rpJcD
	rEXqciGZrato5Xy+nDbCm7sSYkdVR0bDAccVcnc/76DVKIMqpfSTE/WfMEopYJ4S1Zcu//4ktEl
	61uCeotMhba/aAe+zoZ8gZOZAaiS+Bn0air/WLwKXuuQBIBdZz8X0OSriDiVpGxcDrnNUW08CwY
	nUOUDg=
X-Received: by 2002:a17:902:e80b:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2d3b08825e1mr196775075ad.7.1786890166204;
        Sun, 16 Aug 2026 07:22:46 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebc8199sm26102365ad.74.2026.08.16.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 07:22:44 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: will@kernel.org,
	mark.rutland@arm.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	kunwu.chan@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [RFC PATCH 1/4] mm/damon/perf: introduce AUX backend interface and Kconfig
Date: Sun, 16 Aug 2026 22:22:18 +0800
Message-ID: <20260816142222.689624-2-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816142222.689624-1-kunwu.chan@linux.dev>
References: <20260816142222.689624-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Add the backend operations used by AUX trace-buffer PMUs, backend state
to damon_perf_event, and stubs for configurations without AUX support.

Add CONFIG_DAMON_PERF_AUX for the ARM SPE transport and a separate
CONFIG_DAMON_PERF_SPE_KUNIT_TEST option.  The current transport requires
ARM SPE to be built into the kernel; it remains independent of the
optional observability counters and tracepoints.

Co-developed-by: Lian Wang (ProcessMission) <lianux.mm@gmail.com>
Signed-off-by: Lian Wang (ProcessMission) <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/damon.h       |  5 +++
 mm/damon/Kconfig            | 28 +++++++++++++++
 mm/damon/perf/aux_backend.h | 72 +++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 mm/damon/perf/aux_backend.h

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c191c065b0e4..a27c5f6c459b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -8,6 +8,7 @@
 #ifndef _DAMON_H_
 #define _DAMON_H_
 
+#include <linux/cpumask.h>
 #include <linux/math64.h>
 #include <linux/memcontrol.h>
 #include <linux/mutex.h>
@@ -127,6 +128,7 @@ struct damon_target {
 enum damon_report_source {
 	DAMON_REPORT_SRC_PERF_OVERFLOW = 0,  /* overflow_handler (IBS, PEBS) */
 	DAMON_REPORT_SRC_PAGE_FAULT,         /* damon_report_page_fault() */
+	DAMON_REPORT_SRC_PERF_AUX,           /* AUX trace-buffer backend */
 };
 
 /**
@@ -538,6 +540,7 @@ struct damos_filter {
 struct damon_ctx;
 struct damon_target_lookup;
 struct damos;
+struct damon_perf_backend_ops;
 
 /**
  * struct damos_walk_control - Control damos_walk().
@@ -1056,6 +1059,8 @@ struct damon_perf_event_attr {
 struct damon_perf_event {
 	struct damon_perf_event_attr attr;
 	void *priv;
+	const struct damon_perf_backend_ops *ops;
+	cpumask_t aux_cpumask;
 	struct list_head list;
 	struct hlist_node hlist_node;
 	bool init_complete;
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 9fac286df124..e9fb62ec186f 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -149,4 +149,32 @@ config DAMON_PERF_OBSERVE
 
 	  If unsure, say N.
 
+
+config DAMON_PERF_AUX
+	bool "DAMON AUX trace-buffer backend support"
+	depends on DAMON
+	depends on PERF_EVENTS
+	depends on ARM_SPE_PMU=y
+	default n
+	help
+	  Enable the functional AUX trace-buffer transport for DAMON perf
+	  events.  This provides backend selection and drain scheduling for
+	  ARM SPE, which does not deliver samples through an overflow
+	  callback.  ARM SPE must be built into the kernel.
+
+	  This transport is independent of CONFIG_DAMON_PERF_OBSERVE.
+
+	  If unsure, say N.
+
+config DAMON_PERF_SPE_KUNIT_TEST
+	bool "Test the DAMON perf SPE parser" if !KUNIT_ALL_TESTS
+	depends on DAMON_PERF_AUX && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Test the ARM SPE parser with byte-exact packet streams.  The cases
+	  cover valid records, truncation, alignment, error resynchronization
+	  and consumed-length accounting.  Results can be exposed through
+	  debugfs when CONFIG_KUNIT_DEBUGFS is enabled.
+
+	  If unsure, say N.
 endmenu
diff --git a/mm/damon/perf/aux_backend.h b/mm/damon/perf/aux_backend.h
new file mode 100644
index 000000000000..70e6ac6771bc
--- /dev/null
+++ b/mm/damon/perf/aux_backend.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DAMON_PERF_AUX_BACKEND_H
+#define _DAMON_PERF_AUX_BACKEND_H
+
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/perf_event.h>
+#include <linux/types.h>
+
+struct damon_ctx;
+struct damon_perf_event;
+
+/**
+ * struct damon_perf_backend_ops - PMU-specific AUX backend operations
+ * @name: Human-readable backend name.
+ * @flags: Bitmask of DAMON_PERF_BACKEND_* flags.
+ * @match_pmu: Return true when this backend claims @perf_event.
+ * @init: Allocate per-event, per-CPU resources.
+ * @cleanup: Release resources initialized for one CPU.
+ * @arm: Prepare the AUX producer before perf_event_enable().
+ * @disarm: Quiesce backend state after perf_event_disable().
+ * @drain: Parse pending AUX data into DAMON access reports.
+ *
+ * All callbacks run in process context.  The caller serializes resource
+ * lifetime against CPU hotplug and invokes @drain only for CPUs recorded
+ * in damon_perf_event::aux_cpumask.
+ */
+struct damon_perf_backend_ops {
+	const char *name;
+	u32 flags;
+	bool (*match_pmu)(struct perf_event *perf_event);
+	int (*init)(struct damon_perf_event *event, int cpu,
+		    struct perf_event *perf_event);
+	void (*cleanup)(struct damon_perf_event *event, int cpu);
+	int (*arm)(struct damon_perf_event *event, int cpu);
+	void (*disarm)(struct damon_perf_event *event, int cpu);
+	unsigned int (*drain)(struct damon_perf_event *event, int cpu);
+};
+
+#define DAMON_PERF_BACKEND_AUX	BIT(0)
+
+#ifdef CONFIG_DAMON_PERF_AUX
+void damon_perf_aux_drain(struct damon_ctx *ctx);
+int damon_perf_aux_register_backend(const struct damon_perf_backend_ops *ops);
+const struct damon_perf_backend_ops *
+damon_perf_aux_find_backend(struct perf_event *perf_event);
+void damon_perf_aux_select(struct damon_perf_event *event,
+			   struct perf_event *perf_event);
+#else
+static inline void damon_perf_aux_drain(struct damon_ctx *ctx)
+{
+}
+
+static inline int
+damon_perf_aux_register_backend(const struct damon_perf_backend_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline const struct damon_perf_backend_ops *
+damon_perf_aux_find_backend(struct perf_event *perf_event)
+{
+	return NULL;
+}
+
+static inline void damon_perf_aux_select(struct damon_perf_event *event,
+					 struct perf_event *perf_event)
+{
+}
+#endif
+
+#endif /* _DAMON_PERF_AUX_BACKEND_H */
-- 
2.43.0

