Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59336C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DECF61378
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhKHNkH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235351AbhKHNkH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdVgmV+ximVRKdYTA0v0NZ6l6Qg6PC0/Hk6i3qD0YJ0=;
        b=YKbpPiAyahnXzlUzwqmbj/RyiDJh0ZzWe/zYSDT0DzLB4AnsKqII82+uMxHi6Ro9ojMp5W
        C9wm0qWe06qVxY3qWU9Xng5C/zG31H/Un15Xc4Yi3puhlyJZRjQcFb9AI2dHS0UN4qhVMh
        hOk1UcyCi2udQwspOi26zEE2axsm2L4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-cGedbMWBNt2w5BEkU0CEPQ-1; Mon, 08 Nov 2021 08:37:19 -0500
X-MC-Unique: cGedbMWBNt2w5BEkU0CEPQ-1
Received: by mail-wm1-f71.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so5765069wmh.6
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdVgmV+ximVRKdYTA0v0NZ6l6Qg6PC0/Hk6i3qD0YJ0=;
        b=wVHEXfUXQHV7/vOpYRAGonWKPWlsCHl62SmsbdXxFWJ0njQZ8jU+aVFupMJ55psKBs
         TOXoCyQtJQ6jIn8XUEgUAxcYlayKL3etKnkls7pZa7WxBAhcjc4IbB29ZZxyzaeXT/7s
         jjHNvirZmzm9jzwFOhCGlN0qQNL7hjSmtyqvRIJcvfUOb7VJbV1isvw2QOCgrIUN7OPi
         iYrPb/I8SPcAwinkvSJv/jXYxMlZD2TQmb314B/H9axHmJSpPXJVWykXvTxZXMVHdboY
         KipmSHWOmAyxfE+idvJjSh3/icg/kveTbRE/d8uZgORj8DAmAAhQ+rCfhr5mRu0LiYOd
         Ymgw==
X-Gm-Message-State: AOAM531j8dhZ6WgZN5Huv3OJeraj0znooXS8wutiG1umzdXmUpmIkI6j
        3U/UyxfKEZWtRQQVvsoNLTurw4v2QjTyQiZq6muwNsdrrwFEhb2caD7ZU5ij54hhJ9IqCnCnzfT
        UQO4a9OPtqK4QCP2zJi38GuWXF8j95A==
X-Received: by 2002:a05:600c:1d0e:: with SMTP id l14mr51308044wms.64.1636378638038;
        Mon, 08 Nov 2021 05:37:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnjooc56pCrrQf+p/+5N7p9iESS5jN5qEaOZxj+y6G6c07rQbtOZN0DCZIlLvBkBXxmda5uQ==
X-Received: by 2002:a05:600c:1d0e:: with SMTP id l14mr51308016wms.64.1636378637765;
        Mon, 08 Nov 2021 05:37:17 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m14sm9957895wrp.28.2021.11.08.05.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:37:17 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 01/59] libperf: Move pmu-events.h file to libperf
Date:   Mon,  8 Nov 2021 14:36:12 +0100
Message-Id: <20211108133710.1352822-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving pmu-events.h under libperf to be exported as
<perf/pmu-events.h> header.

This is a preparation before moving the whole pmu-events
framework under libperf coming in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/perf/pmu-events.h | 59 ++++++++++++++++++++++++
 tools/perf/pmu-events/Build              |  2 +-
 tools/perf/pmu-events/jevents.c          |  6 +--
 tools/perf/pmu-events/pmu-events.h       | 59 ------------------------
 tools/perf/tests/expand-cgroup.c         |  2 +-
 tools/perf/tests/parse-metric.c          |  2 +-
 tools/perf/tests/pmu-events.c            |  2 +-
 tools/perf/util/amd-sample-raw.c         |  2 +-
 tools/perf/util/metricgroup.h            |  2 +-
 tools/perf/util/pmu.h                    |  2 +-
 tools/perf/util/s390-sample-raw.c        |  2 +-
 11 files changed, 70 insertions(+), 70 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/pmu-events.h
 delete mode 100644 tools/perf/pmu-events/pmu-events.h

diff --git a/tools/lib/perf/include/perf/pmu-events.h b/tools/lib/perf/include/perf/pmu-events.h
new file mode 100644
index 000000000000..6efe73976440
--- /dev/null
+++ b/tools/lib/perf/include/perf/pmu-events.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PMU_EVENTS_H
+#define PMU_EVENTS_H
+
+enum aggr_mode_class {
+	PerChip = 1,
+	PerCore
+};
+
+/*
+ * Describe each PMU event. Each CPU has a table of PMU events.
+ */
+struct pmu_event {
+	const char *name;
+	const char *compat;
+	const char *event;
+	const char *desc;
+	const char *topic;
+	const char *long_desc;
+	const char *pmu;
+	const char *unit;
+	const char *perpkg;
+	const char *aggr_mode;
+	const char *metric_expr;
+	const char *metric_name;
+	const char *metric_group;
+	const char *deprecated;
+	const char *metric_constraint;
+};
+
+/*
+ *
+ * Map a CPU to its table of PMU events. The CPU is identified by the
+ * cpuid field, which is an arch-specific identifier for the CPU.
+ * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
+ * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
+ *
+ * The  cpuid can contain any character other than the comma.
+ */
+struct pmu_events_map {
+	const char *cpuid;
+	const char *version;
+	const char *type;		/* core, uncore etc */
+	const struct pmu_event *table;
+};
+
+struct pmu_sys_events {
+	const char *name;
+	const struct pmu_event *table;
+};
+
+/*
+ * Global table mapping each known CPU for the architecture to its
+ * table of PMU events.
+ */
+extern const struct pmu_events_map pmu_events_map[];
+extern const struct pmu_sys_events pmu_sys_event_tables[];
+
+#endif
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46a..5bc953ebdf25 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,7 @@
 hostprogs := jevents
 
 jevents-y	+= json.o jsmn.o jevents.o
-HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
+HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include -I$(srctree)/tools/lib/perf/include
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell [ -d $(JDIR) ] &&				\
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 2e7c4153875b..2815caf602f3 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -49,7 +49,7 @@
 #include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
-#include "pmu-events.h"
+#include <perf/pmu-events.h>
 
 int verbose;
 char *prog;
@@ -958,7 +958,7 @@ static void create_empty_mapping(const char *output_file)
 		_Exit(1);
 	}
 
-	fprintf(outfp, "#include \"pmu-events/pmu-events.h\"\n");
+	fprintf(outfp, "#include <perf/pmu-events.h>\n");
 	print_mapping_table_prefix(outfp);
 	print_mapping_table_suffix(outfp);
 	print_system_event_mapping_table_prefix(outfp);
@@ -1239,7 +1239,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* Include pmu-events.h first */
-	fprintf(eventsfp, "#include \"pmu-events/pmu-events.h\"\n");
+	fprintf(eventsfp, "#include <perf/pmu-events.h>\n");
 
 	/*
 	 * The mapfile allows multiple CPUids to point to the same JSON file,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
deleted file mode 100644
index 6efe73976440..000000000000
--- a/tools/perf/pmu-events/pmu-events.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PMU_EVENTS_H
-#define PMU_EVENTS_H
-
-enum aggr_mode_class {
-	PerChip = 1,
-	PerCore
-};
-
-/*
- * Describe each PMU event. Each CPU has a table of PMU events.
- */
-struct pmu_event {
-	const char *name;
-	const char *compat;
-	const char *event;
-	const char *desc;
-	const char *topic;
-	const char *long_desc;
-	const char *pmu;
-	const char *unit;
-	const char *perpkg;
-	const char *aggr_mode;
-	const char *metric_expr;
-	const char *metric_name;
-	const char *metric_group;
-	const char *deprecated;
-	const char *metric_constraint;
-};
-
-/*
- *
- * Map a CPU to its table of PMU events. The CPU is identified by the
- * cpuid field, which is an arch-specific identifier for the CPU.
- * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
- * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
- *
- * The  cpuid can contain any character other than the comma.
- */
-struct pmu_events_map {
-	const char *cpuid;
-	const char *version;
-	const char *type;		/* core, uncore etc */
-	const struct pmu_event *table;
-};
-
-struct pmu_sys_events {
-	const char *name;
-	const struct pmu_event *table;
-};
-
-/*
- * Global table mapping each known CPU for the architecture to its
- * table of PMU events.
- */
-extern const struct pmu_events_map pmu_events_map[];
-extern const struct pmu_sys_events pmu_sys_event_tables[];
-
-#endif
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index aaad51aba12f..61dec9783a1e 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -6,7 +6,7 @@
 #include "rblist.h"
 #include "metricgroup.h"
 #include "parse-events.h"
-#include "pmu-events/pmu-events.h"
+#include <perf/pmu-events.h>
 #include "pfm.h"
 #include <subcmd/parse-options.h>
 #include <stdio.h>
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index dfc797ecc750..23ed50c26368 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -5,7 +5,7 @@
 #include <perf/evlist.h>
 #include "metricgroup.h"
 #include "tests.h"
-#include "pmu-events/pmu-events.h"
+#include <perf/pmu-events.h>
 #include "evlist.h"
 #include "rblist.h"
 #include "debug.h"
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 50b1299fe643..78b03909bfe7 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include "debug.h"
-#include "../pmu-events/pmu-events.h"
+#include <perf/pmu-events.h>
 #include "util/evlist.h"
 #include "util/expr.h"
 #include "util/parse-events.h"
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index d19d765195c5..742c4f437c0b 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -15,7 +15,7 @@
 #include "session.h"
 #include "evlist.h"
 #include "sample-raw.h"
-#include "pmu-events/pmu-events.h"
+#include <perf/pmu-events.h>
 
 static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
 
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 2b42b778d1bf..8cc6b0b0cb90 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdbool.h>
-#include "pmu-events/pmu-events.h"
+#include <perf/pmu-events.h>
 
 struct evlist;
 struct evsel;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 15bbec3a9959..31a52ee963c8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -8,7 +8,7 @@
 #include <linux/list.h>
 #include <stdbool.h>
 #include "parse-events.h"
-#include "pmu-events/pmu-events.h"
+#include <perf/pmu-events.h>
 
 struct evsel_config_term;
 struct perf_cpu_map;
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index cd3a34840389..92af45ea22f6 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -27,7 +27,7 @@
 #include "color.h"
 #include "sample-raw.h"
 #include "s390-cpumcf-kernel.h"
-#include "pmu-events/pmu-events.h"
+#include <perf/pmu-events.h>
 
 static size_t ctrset_size(struct cf_ctrset_entry *set)
 {
-- 
2.31.1

