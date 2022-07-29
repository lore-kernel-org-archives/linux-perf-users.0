Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB3C19F2B
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiG2Hom (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiG2HoY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B781B01
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31edbd801b5so36397587b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5r7KpXClmZzIJUu6VoWF+PxBHcALGulwqyZkCHJz+dc=;
        b=L9UT7pFKEMv8kmhKTFboeMQHgbNjypzxWtClefHRJXeuk7El88DNhUGL4PqSb2pxBt
         UUcOzUDVOnbLXDk7ADQF8gwzoy0tFbnIJQoWp00c6r1J4xo8jWshWT4mpOhestPPnV2m
         31p0htLfJiSCQ2GcnIhA8XjMPzhJ6UF1OOS72tmsudDUX5X5uOjGU4aDnEPbBzQtFfPR
         h9/FepigXVjZTiyqlOKgRSaq9TO9PIy2rPBTb5Jiuxn3ceLTiENmnJj2kVS37+Xg+5sN
         C+JZfVZ4SXaxQMf/IsC0qlPUQKGYUPG8J+i1wpIpv4uwKIjNgz+tD/cTlkJWh3krAyHJ
         duMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5r7KpXClmZzIJUu6VoWF+PxBHcALGulwqyZkCHJz+dc=;
        b=TAc8r1TDU+kXMW+2h6DGNitEBGK4UciDrtptBshh4d+/AZeX063pYkPLhdhljXo8bT
         XjGgOpL8IMBT53d8tVfCZGPXPEt4eXvZNX46z72JpMNKRz9x4G9SYqTWFd0pCZgWD9YF
         NTgL1o85Y6zvaSXdN4gFju9xj08McGowILGXWyStbWZy67wwkDceBKPxehTSK233r0YX
         OpcgLwl7W+olbfIqhM2KiFxMseUqDkAtHyqxwdXV++aHIjNpak9hNAmjIh+y2rmPa9i0
         TO7m27TER0GzrX9kpZtzVq9RS0hAZQd3yPbVp8sAVPoRnA2TtEqvpMUGlDHKGYBgHM6A
         JpJQ==
X-Gm-Message-State: ACgBeo0rijuk2MzhxOcxRQbo/Q7+4kC7k+c1HDZsxNX4T9xqTNjLBBH1
        Xo866mk7IS9lYhw2mRfmXtZN7wAYAJ/U
X-Google-Smtp-Source: AA6agR4lvVMHfSoejMkozQjmS9qJTDKTwsU5cAD6r+dvPCEB7yVOfvYBAS7Y09yz2U8G7/kdQP/Wm9mQYGrh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:41d6:0:b0:673:817c:e163 with SMTP id
 o205-20020a2541d6000000b00673817ce163mr1461338yba.561.1659080662475; Fri, 29
 Jul 2022 00:44:22 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:42 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-9-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 08/17] perf pmu-events: Hide pmu_sys_event_tables
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move usage of the table to pmu-events.c so it may be hidden. By
abstracting the table the implementation can later be changed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 37 ++++++++++++++++++-
 tools/perf/pmu-events/jevents.py         | 45 ++++++++++++++++++++++--
 tools/perf/pmu-events/pmu-events.h       | 11 +++---
 tools/perf/tests/pmu-events.c            | 14 +-------
 tools/perf/util/pmu.c                    | 27 --------------
 tools/perf/util/pmu.h                    |  2 --
 6 files changed, 84 insertions(+), 52 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 4182a986f505..216ea0482c37 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -6,6 +6,8 @@
  * The test cpu/soc is provided for testing.
  */
 #include "pmu-events/pmu-events.h"
+#include <string.h>
+#include <stddef.h>
 
 static const struct pmu_event pme_test_soc_cpu[] = {
 	{
@@ -145,7 +147,12 @@ static const struct pmu_event pme_test_soc_sys[] = {
 	},
 };
 
-const struct pmu_sys_events pmu_sys_event_tables[] = {
+struct pmu_sys_events {
+	const char *name;
+	const struct pmu_event *table;
+};
+
+static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	{
 		.table = pme_test_soc_sys,
 		.name = "pme_test_soc_sys",
@@ -154,3 +161,31 @@ const struct pmu_sys_events pmu_sys_event_tables[] = {
 		.table = 0
 	},
 };
+
+const struct pmu_event *find_sys_events_table(const char *name)
+{
+	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+	     tables->name;
+	     tables++) {
+		if (!strcmp(tables->name, name))
+			return tables->table;
+	}
+	return NULL;
+}
+
+int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
+{
+	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+	     tables->name;
+	     tables++) {
+		for (const struct pmu_event *pe = &tables->table[0];
+		     pe->name || pe->metric_group || pe->metric_name;
+		     pe++) {
+			int ret = fn(pe, data);
+
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 30e0e792221a..dd21bc9eeeed 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -370,8 +370,14 @@ def print_mapping_table(archs: Sequence[str]) -> None:
 
 def print_system_mapping_table() -> None:
   """C struct mapping table array for tables from /sys directories."""
-  _args.output_file.write(
-      '\nconst struct pmu_sys_events pmu_sys_event_tables[] = {\n')
+  _args.output_file.write("""
+struct pmu_sys_events {
+\tconst char *name;
+\tconst struct pmu_event *table;
+};
+
+static const struct pmu_sys_events pmu_sys_event_tables[] = {
+""")
   for tblname in _sys_event_tables:
     _args.output_file.write(f"""\t{{
 \t\t.table = {tblname},
@@ -382,6 +388,34 @@ def print_system_mapping_table() -> None:
 \t\t.table = 0
 \t},
 };
+
+const struct pmu_event *find_sys_events_table(const char *name)
+{
+        for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+             tables->name;
+             tables++) {
+                if (!strcmp(tables->name, name))
+                        return tables->table;
+        }
+        return NULL;
+}
+
+int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
+{
+        for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+             tables->name;
+             tables++) {
+                for (const struct pmu_event *pe = &tables->table[0];
+                     pe->name || pe->metric_group || pe->metric_name;
+                     pe++) {
+                        int ret = fn(pe, data);
+
+                        if (ret)
+                                return ret;
+                }
+        }
+        return 0;
+}
 """)
 
 
@@ -413,7 +447,12 @@ def main() -> None:
       'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
   _args = ap.parse_args()
 
-  _args.output_file.write("#include \"pmu-events/pmu-events.h\"\n")
+  _args.output_file.write("""
+#include "pmu-events/pmu-events.h"
+#include <string.h>
+#include <stddef.h>
+
+""")
   archs = []
   for item in os.scandir(_args.starting_dir):
     if not item.is_dir():
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index a491b117c8ac..2386212b1df0 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -43,16 +43,15 @@ struct pmu_events_map {
 	const struct pmu_event *table;
 };
 
-struct pmu_sys_events {
-	const char *name;
-	const struct pmu_event *table;
-};
-
 /*
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
 extern const struct pmu_events_map pmu_events_map[];
-extern const struct pmu_sys_events pmu_sys_event_tables[];
+
+const struct pmu_event *find_sys_events_table(const char *name);
+
+typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe, void *data);
+int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data);
 
 #endif
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 82192f1a7bf7..a39a2c99ede6 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -286,18 +286,6 @@ static const struct pmu_events_map *__test_pmu_get_events_map(void)
 	return NULL;
 }
 
-static const struct pmu_event *__test_pmu_get_sys_events_table(void)
-{
-	const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
-
-	for ( ; tables->name; tables++) {
-		if (!strcmp("pme_test_soc_sys", tables->name))
-			return tables->table;
-	}
-
-	return NULL;
-}
-
 static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event *e2)
 {
 	if (!is_same(e1->name, e2->name)) {
@@ -451,7 +439,7 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 				 int subtest __maybe_unused)
 {
-	const struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
+	const struct pmu_event *sys_event_tables = find_sys_events_table("pme_test_soc_sys");
 	const struct pmu_events_map *map = __test_pmu_get_events_map();
 	const struct pmu_event *table;
 	int map_events = 0, expected_events;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0112e1c36418..d8717c4548a4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -868,33 +868,6 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	pmu_add_cpu_aliases_map(head, pmu, map);
 }
 
-void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
-{
-	int i = 0;
-
-	while (1) {
-		const struct pmu_sys_events *event_table;
-		int j = 0;
-
-		event_table = &pmu_sys_event_tables[i++];
-
-		if (!event_table->table)
-			break;
-
-		while (1) {
-			const struct pmu_event *pe = &event_table->table[j++];
-			int ret;
-
-			if (!pe->name && !pe->metric_group && !pe->metric_name)
-				break;
-
-			ret = fn(pe, data);
-			if (ret)
-				break;
-		}
-	}
-}
-
 struct pmu_sys_event_iter_data {
 	struct list_head *head;
 	struct perf_pmu *pmu;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 4b45fd8da5a3..7e667eec2a01 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -133,8 +133,6 @@ const struct pmu_events_map *pmu_events_map__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
-typedef int (*pmu_sys_event_iter_fn)(const struct pmu_event *pe, void *data);
-void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
-- 
2.37.1.455.g008518b4e5-goog

