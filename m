Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54351C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jul 2022 06:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiGOGiN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiGOGhs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562015D5B0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cdce3ed04so34243247b3.13
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kcxF1w4r9aBOkpbQLeFudp2yTxjxFQuyMbzQFLMUmAg=;
        b=NOY3joczGCi6r//rAMntvAhAO3xOSCFSUDKpss33aYZvk48OMCst9NFS0o03APhTw/
         Wr68ZJvZe5HIrsLuCbVzyJXPlbkQr4F/Dbd9SDdv7JA6mkdzSDHpo1EUt4TmmVZKZZno
         YQXSzdCU78Bp1UQ5x+kX5+Q6FdqfXkm5J1nq5TNAeia5c+CvkFeq36cmVzzfTLoRteAq
         P+CkHUqXstJTuq0NWhDBfPUHrroGvR23FXxx/eyXCuPMDuqkezaDeNKeAIO62IhrF5fe
         KqpmzTCo5HTiF8iGmVHN4MwUL/bKgdqgnvsEIqOEKYKkOLf4/p1REfPpSqN5uQBSIMZM
         9lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kcxF1w4r9aBOkpbQLeFudp2yTxjxFQuyMbzQFLMUmAg=;
        b=1D22ST4mhJq0v4oQj16GrbL3/R+FfHw/ZKfANd4gDqVrRiH3JzO3SsbwptkvtDua0Z
         7CSjAC90IQG8EZ+Y4e31jn32tLrn6dGOGkbdmr0FSzGqrgWTRwwE/k++/Av3gqHZKD/o
         FkJUVVHiuOgmzhD5w5ToAMJYV+bO7e37VZKgoDZCzgMTdtfxzylE3tl+mPNACeGwUy2C
         Of6VeW9o0C+l5yMmxqpCYW1o+C/84Q0wwmRUqbDat1uVboSs3eNcMlkq+aeDqi4wQHeI
         Rw8zIlcxPlMu2wGgHamtE+jDtVJpQ9fjsPqKHSOorskzc7TGMrK3aQJd9hSIN8jIsgaa
         A8pQ==
X-Gm-Message-State: AJIora+BiFP+8gDYNVcXq5rLxK7L7SKl6sRccOi3c19Leoe3TS0QJhKx
        Lw+yKyC2geDdG1NRl9dDZRPjnpwqCwM4
X-Google-Smtp-Source: AGRyM1uD7CHiGe5XAOZbEevtqwCNXSZBqC812AvNiQ4ugArj57f6g3h9AUTy6S4lLNfcc2+SyHVeAAoN86BP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a25:6044:0:b0:66f:5acc:e893 with SMTP id
 u65-20020a256044000000b0066f5acce893mr11824286ybb.343.1657867051563; Thu, 14
 Jul 2022 23:37:31 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:45 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-8-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 07/15] perf pmu-events: Hide pmu_sys_event_tables
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
index 34b686d27cef..432ecb5a33f5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -371,8 +371,14 @@ def print_mapping_table(archs: Sequence[str]) -> None:
 
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
@@ -383,6 +389,34 @@ def print_system_mapping_table() -> None:
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
 
 
@@ -414,7 +448,12 @@ def main() -> None:
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
index 0c9439cf77e1..4a7dee4ca7da 100644
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
2.37.0.170.g444d1eabd0-goog

