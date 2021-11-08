Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BCC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2BA61452
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhKHNkp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235351AbhKHNkp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9orBqX6zWBQ1/w4i5oL0QIKrOYIEV4ka+ndn3Nhp5w=;
        b=CraZ8a2KsvJvM60pKS3CQ452lhQC/BfsmKiEhljp3tmgIrUPe6ALFoRr2j4Xn2da075y4f
        ONCSPMkTXHrrkiFg87G88kZNjW/ZhuRx8//N8ZsylohRzWzQIu22WeLfqjuQ1hEKQItWl+
        jFRsLpIAYxiiSaSxN8Jty4OS2eHLDgg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-kqiXA2MYPMCuylRR-45vvA-1; Mon, 08 Nov 2021 08:37:59 -0500
X-MC-Unique: kqiXA2MYPMCuylRR-45vvA-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso10168459wms.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9orBqX6zWBQ1/w4i5oL0QIKrOYIEV4ka+ndn3Nhp5w=;
        b=zpcDAC+hxycUFpBYFplrhfZAsiWXZy2Mot9M61N8gqwaTv9IIAcZwcYHqxarwwCt+t
         6B0YCCNjkY7GOXRnOs/Q+frHXbib5e/bmsyDYFj1AOTamkkgekxBSIU7p15HqGsuCC+B
         fEJywLIFcV0lpqK1khyUCDY5FyfKHLGEL3L2m84Y5QX8ILammtvmPr7Tmnlber1ZqK4u
         Ej7JL+lFRS0onztzajJneQKjAXRH6kO1pewRnwiAsURHTEkNhq5gJM4pMC6Dqm1hdlyv
         +WJFCSvOIFEYulMQG/Svs1vvYlnCxl4JBPUHtFzvGq6dtKc421KnA1jHNaWGcrBRFhZz
         upFA==
X-Gm-Message-State: AOAM533PTS00AzOEX9k1ZUd06ObehQcq7TczmRShTDymuZYFCRt4Yep8
        St9jQ72EUM75oIh9gltvHFz98qeRDqYyGmomnNLawY7RtEoQGJRjitlPd7Q+WTPdRdFUqdU4c4d
        Ma8xR5wW6KktQ14wVfEGsSZOGbm1Wkg==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr37873734wrw.439.1636378678127;
        Mon, 08 Nov 2021 05:37:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0G9ChXfheK01NrUNsSQGRNaKjpFwgzqvcIQ11VngOB7OhLV33PZO3n/rjgauko6qIO6JK8g==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr37873694wrw.439.1636378677835;
        Mon, 08 Nov 2021 05:37:57 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f15sm16404816wrt.26.2021.11.08.05.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:37:57 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 06/59] libperf: Move in the pmu hybrid support
Date:   Mon,  8 Nov 2021 14:36:17 +0100
Message-Id: <20211108133710.1352822-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving in libperf the pmu hybrid support.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Build                         |  1 +
 tools/lib/perf/Makefile                      |  1 +
 tools/lib/perf/include/internal/pmu-hybrid.h | 33 ++++++++
 tools/lib/perf/include/internal/pmu.h        | 28 +++++++
 tools/lib/perf/pmu-hybrid.c                  | 88 ++++++++++++++++++++
 tools/perf/builtin-c2c.c                     |  2 +-
 tools/perf/builtin-list.c                    |  2 +-
 tools/perf/builtin-mem.c                     |  2 +-
 tools/perf/builtin-record.c                  |  2 +-
 tools/perf/builtin-stat.c                    |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c      |  2 +-
 tools/perf/tests/parse-events.c              |  2 +-
 tools/perf/tests/perf-time-to-tsc.c          |  2 +-
 tools/perf/util/Build                        |  1 -
 tools/perf/util/cputopo.c                    |  2 +-
 tools/perf/util/evlist-hybrid.c              |  3 +-
 tools/perf/util/evsel.c                      |  2 +-
 tools/perf/util/header.c                     |  2 +-
 tools/perf/util/mem-events.c                 |  2 +-
 tools/perf/util/metricgroup.c                |  2 +-
 tools/perf/util/parse-events-hybrid.c        |  2 +-
 tools/perf/util/parse-events.c               |  2 +-
 tools/perf/util/pmu-hybrid.c                 | 88 --------------------
 tools/perf/util/pmu-hybrid.h                 | 33 --------
 tools/perf/util/pmu.c                        |  2 +-
 tools/perf/util/pmu.h                        | 27 ------
 tools/perf/util/python-ext-sources           |  1 -
 tools/perf/util/stat-display.c               |  3 +-
 28 files changed, 171 insertions(+), 168 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/pmu-hybrid.h
 create mode 100644 tools/lib/perf/pmu-hybrid.c
 delete mode 100644 tools/perf/util/pmu-hybrid.c
 delete mode 100644 tools/perf/util/pmu-hybrid.h

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index 275ec24cad7b..006a9bef9566 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -10,6 +10,7 @@ libperf-y += lib.o
 libperf-y += pmu-flex.o
 libperf-y += pmu-bison.o
 libperf-y += pmu.o
+libperf-y += pmu-hybrid.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index bb6f53c215ad..344cfb801408 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -86,6 +86,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += -D_GNU_SOURCE
 
 all:
 
diff --git a/tools/lib/perf/include/internal/pmu-hybrid.h b/tools/lib/perf/include/internal/pmu-hybrid.h
new file mode 100644
index 000000000000..8a2fe7abffea
--- /dev/null
+++ b/tools/lib/perf/include/internal/pmu-hybrid.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PMU_HYBRID_H
+#define __PMU_HYBRID_H
+
+#include <linux/perf_event.h>
+#include <linux/compiler.h>
+#include <linux/list.h>
+#include <stdbool.h>
+#include <internal/pmu.h>
+
+extern struct list_head perf_pmu__hybrid_pmus;
+
+#define perf_pmu__for_each_hybrid_pmu(pmu)	\
+	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
+
+bool perf_pmu__hybrid_mounted(const char *name);
+
+struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
+bool perf_pmu__is_hybrid(const char *name);
+char *perf_pmu__hybrid_type_to_pmu(const char *type);
+
+static inline int perf_pmu__hybrid_pmu_num(void)
+{
+	struct perf_pmu *pmu;
+	int num = 0;
+
+	perf_pmu__for_each_hybrid_pmu(pmu)
+		num++;
+
+	return num;
+}
+
+#endif /* __PMU_HYBRID_H */
diff --git a/tools/lib/perf/include/internal/pmu.h b/tools/lib/perf/include/internal/pmu.h
index 2c742acd933c..b8a78e024f6d 100644
--- a/tools/lib/perf/include/internal/pmu.h
+++ b/tools/lib/perf/include/internal/pmu.h
@@ -12,6 +12,7 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
+#define CPUS_TEMPLATE_CPU       "%s/bus/event_source/devices/%s/cpus"
 
 struct perf_pmu_format {
 	char *name;
@@ -20,6 +21,33 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
+struct perf_pmu_caps {
+	char *name;
+	char *value;
+	struct list_head list;
+};
+
+struct perf_event_attr;
+
+struct perf_pmu {
+	char *name;
+	char *alias_name;
+	char *id;
+	__u32 type;
+	bool selectable;
+	bool is_uncore;
+	bool is_hybrid;
+	bool auxtrace;
+	int max_precise;
+	struct perf_event_attr *default_config;
+	struct perf_cpu_map *cpus;
+	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
+	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
+	struct list_head list;    /* ELEM */
+	struct list_head hybrid_list;
+};
+
 int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
 void perf_pmu__set_format(unsigned long *bits, long from, long to);
diff --git a/tools/lib/perf/pmu-hybrid.c b/tools/lib/perf/pmu-hybrid.c
new file mode 100644
index 000000000000..ffc214e77236
--- /dev/null
+++ b/tools/lib/perf/pmu-hybrid.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/list.h>
+#include <linux/compiler.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdarg.h>
+#include <locale.h>
+#include <api/fs/fs.h>
+#include <internal/pmu-hybrid.h>
+
+LIST_HEAD(perf_pmu__hybrid_pmus);
+
+bool perf_pmu__hybrid_mounted(const char *name)
+{
+	char path[PATH_MAX];
+	const char *sysfs;
+	FILE *file;
+	int n, cpu;
+
+	if (strncmp(name, "cpu_", 4))
+		return false;
+
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return false;
+
+	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
+	if (!file_available(path))
+		return false;
+
+	file = fopen(path, "r");
+	if (!file)
+		return false;
+
+	n = fscanf(file, "%u", &cpu);
+	fclose(file);
+	if (n <= 0)
+		return false;
+
+	return true;
+}
+
+struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
+{
+	struct perf_pmu *pmu;
+
+	if (!name)
+		return NULL;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		if (!strcmp(name, pmu->name))
+			return pmu;
+	}
+
+	return NULL;
+}
+
+bool perf_pmu__is_hybrid(const char *name)
+{
+	return perf_pmu__find_hybrid_pmu(name) != NULL;
+}
+
+char *perf_pmu__hybrid_type_to_pmu(const char *type)
+{
+	char *pmu_name = NULL;
+
+	if (asprintf(&pmu_name, "cpu_%s", type) < 0)
+		return NULL;
+
+	if (perf_pmu__is_hybrid(pmu_name))
+		return pmu_name;
+
+	/*
+	 * pmu may be not scanned, check the sysfs.
+	 */
+	if (perf_pmu__hybrid_mounted(pmu_name))
+		return pmu_name;
+
+	free(pmu_name);
+	return NULL;
+}
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a192014fa52b..9fe90eeb2730 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -43,7 +43,7 @@
 #include "ui/progress.h"
 #include "../perf.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 
 struct c2c_hists {
 	struct hists		hists;
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 468958154ed9..bf62760edbb9 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -12,7 +12,7 @@
 
 #include "util/parse-events.h"
 #include "util/pmu.h"
-#include "util/pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "util/debug.h"
 #include "util/metricgroup.h"
 #include <subcmd/pager.h>
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index fcf65a59bea2..49fc462b6d65 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -19,7 +19,7 @@
 #include "util/map.h"
 #include "util/symbol.h"
 #include "util/pmu.h"
-#include "util/pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 78185c982ebf..0f7440351842 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -47,7 +47,7 @@
 #include "util/util.h"
 #include "util/pfm.h"
 #include "util/clockid.h"
-#include "util/pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "util/evlist-hybrid.h"
 #include "asm/bug.h"
 #include "perf.h"
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f0ecfda34ece..4157faf03b2e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -70,7 +70,7 @@
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
-#include "util/pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "asm/bug.h"
 
 #include <linux/time64.h>
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 4e09f0a312af..c421e8137d74 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -5,7 +5,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include <errno.h>
 #include <linux/kernel.h>
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 69381fe1655d..d39aaeeaad0f 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -6,7 +6,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include <dirent.h>
 #include <errno.h>
 #include <sys/types.h>
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 7c56bc1f4cff..82b23eb6e1f7 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -21,7 +21,7 @@
 #include "mmap.h"
 #include "tests.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b93828aacc27..1d697cecf4ea 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -69,7 +69,6 @@ perf-y += trace-event-parse.o
 perf-y += parse-events-flex.o
 perf-y += parse-events-bison.o
 perf-y += pmu.o
-perf-y += pmu-hybrid.o
 perf-y += trace-event-read.o
 perf-y += trace-event-info.o
 perf-y += trace-event-scripting.o
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index ec77e2a7b3ca..2520d2549d9e 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -7,12 +7,12 @@
 #include <api/fs/fs.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
+#include <internal/pmu-hybrid.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
 #include "debug.h"
 #include "env.h"
-#include "pmu-hybrid.h"
 
 #define CORE_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index 7c554234b43d..67c53acfaa29 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -5,9 +5,10 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "../perf.h"
-#include "util/pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "util/evlist-hybrid.h"
 #include "debug.h"
+#include "pmu.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <linux/err.h>
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2cfc2935d1d2..d1e580c88be7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -47,11 +47,11 @@
 #include "memswap.h"
 #include "util.h"
 #include "hashmap.h"
-#include "pmu-hybrid.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
 #include <internal/lib.h>
+#include <internal/pmu-hybrid.h>
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1c7414f66655..971ae4744895 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -49,10 +49,10 @@
 #include "cputopo.h"
 #include "bpf-event.h"
 #include "clockid.h"
-#include "pmu-hybrid.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
+#include <internal/pmu-hybrid.h>
 
 /*
  * magic2 = "PERFILE2"
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f0e75df72b80..fb5f51432335 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -13,7 +13,7 @@
 #include "debug.h"
 #include "symbol.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4917e9704765..4a533740c939 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -11,7 +11,7 @@
 #include "evsel.h"
 #include "strbuf.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 9fc86971027b..de901e74ce3d 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -12,7 +12,7 @@
 #include "parse-events-hybrid.h"
 #include "debug.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "perf.h"
 
 static void config_hybrid_attr(struct perf_event_attr *attr,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 278199ed788b..84c4ef32034b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -36,7 +36,7 @@
 #include "util/event.h"
 #include "util/pfm.h"
 #include "util/parse-events-hybrid.h"
-#include "util/pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "perf.h"
 
 #define MAX_NAME_LEN 100
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
deleted file mode 100644
index 65fdce81a384..000000000000
--- a/tools/perf/util/pmu-hybrid.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/list.h>
-#include <linux/compiler.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <stdbool.h>
-#include <stdarg.h>
-#include <locale.h>
-#include <api/fs/fs.h>
-#include "pmu-hybrid.h"
-
-LIST_HEAD(perf_pmu__hybrid_pmus);
-
-bool perf_pmu__hybrid_mounted(const char *name)
-{
-	char path[PATH_MAX];
-	const char *sysfs;
-	FILE *file;
-	int n, cpu;
-
-	if (strncmp(name, "cpu_", 4))
-		return false;
-
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
-		return false;
-
-	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
-	if (!file_available(path))
-		return false;
-
-	file = fopen(path, "r");
-	if (!file)
-		return false;
-
-	n = fscanf(file, "%u", &cpu);
-	fclose(file);
-	if (n <= 0)
-		return false;
-
-	return true;
-}
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
-{
-	struct perf_pmu *pmu;
-
-	if (!name)
-		return NULL;
-
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		if (!strcmp(name, pmu->name))
-			return pmu;
-	}
-
-	return NULL;
-}
-
-bool perf_pmu__is_hybrid(const char *name)
-{
-	return perf_pmu__find_hybrid_pmu(name) != NULL;
-}
-
-char *perf_pmu__hybrid_type_to_pmu(const char *type)
-{
-	char *pmu_name = NULL;
-
-	if (asprintf(&pmu_name, "cpu_%s", type) < 0)
-		return NULL;
-
-	if (perf_pmu__is_hybrid(pmu_name))
-		return pmu_name;
-
-	/*
-	 * pmu may be not scanned, check the sysfs.
-	 */
-	if (perf_pmu__hybrid_mounted(pmu_name))
-		return pmu_name;
-
-	free(pmu_name);
-	return NULL;
-}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
deleted file mode 100644
index 2b186c26a43e..000000000000
--- a/tools/perf/util/pmu-hybrid.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PMU_HYBRID_H
-#define __PMU_HYBRID_H
-
-#include <linux/perf_event.h>
-#include <linux/compiler.h>
-#include <linux/list.h>
-#include <stdbool.h>
-#include "pmu.h"
-
-extern struct list_head perf_pmu__hybrid_pmus;
-
-#define perf_pmu__for_each_hybrid_pmu(pmu)	\
-	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
-
-bool perf_pmu__hybrid_mounted(const char *name);
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
-bool perf_pmu__is_hybrid(const char *name);
-char *perf_pmu__hybrid_type_to_pmu(const char *type);
-
-static inline int perf_pmu__hybrid_pmu_num(void)
-{
-	struct perf_pmu *pmu;
-	int num = 0;
-
-	perf_pmu__for_each_hybrid_pmu(pmu)
-		num++;
-
-	return num;
-}
-
-#endif /* __PMU_HYBRID_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 13e1835955e0..5bda7796f91a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -26,7 +26,7 @@
 #include "header.h"
 #include "string2.h"
 #include "strbuf.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 
 struct perf_pmu perf_pmu__fake;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 3127c877e043..091f49a655f8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -19,33 +19,6 @@ struct perf_cpu_map;
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 #define MAX_PMU_NAME_LEN 128
 
-struct perf_event_attr;
-
-struct perf_pmu_caps {
-	char *name;
-	char *value;
-	struct list_head list;
-};
-
-struct perf_pmu {
-	char *name;
-	char *alias_name;
-	char *id;
-	__u32 type;
-	bool selectable;
-	bool is_uncore;
-	bool is_hybrid;
-	bool auxtrace;
-	int max_precise;
-	struct perf_event_attr *default_config;
-	struct perf_cpu_map *cpus;
-	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
-	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
-	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
-	struct list_head list;    /* ELEM */
-	struct list_head hybrid_list;
-};
-
 extern struct perf_pmu perf_pmu__fake;
 
 struct perf_pmu_info {
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 992a76c2af01..d36348c4d788 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -38,4 +38,3 @@ util/units.c
 util/affinity.c
 util/rwsem.c
 util/hashmap.c
-util/pmu-hybrid.c
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 588601000f3f..e3ffc084cb09 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -18,8 +18,9 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include "iostat.h"
-#include "pmu-hybrid.h"
+#include <internal/pmu-hybrid.h>
 #include "evlist-hybrid.h"
+#include "pmu.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
-- 
2.31.1

