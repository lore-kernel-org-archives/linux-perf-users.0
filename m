Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6C8C88CB9
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Aug 2023 04:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbjHXEO3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 00:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbjHXEOE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C510F0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:14:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840ea40c59so80235277b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850441; x=1693455241;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thiR0red1e/TKgvXPJgbac9qLA8eyvIz0R2RRqFEpHo=;
        b=KuAatxxaPWqZiaJMcynl0wnH/7QYU2bCodav06EVZFsT0Axs/EhhiuVsYjweEa+qQj
         0KSCyPLJ1z1OEANEd8/5Kv/jDgqnewcE4w1XP2PlDR77dzoYcunGuIPXTyQl7Zs2WXMp
         4P6n2bGVDCEJh5cHhe4w3jY0M84QmRKsKAIOkuJQQnu1rhfNLP4Tsu6funSNrH4cnwq/
         cO6+cPvXvh4wKWWitDD93IGVw3YhO0rHlHtNnVwmOlCFydxkEwqJnQsqPBu/5xR81Pyq
         0jnRxi/Z4x9nUjhKAogkCTAXmbbUTfRhAV/09kBLUeOavNThZ02WGmYmssJcHkM/fJkx
         iNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850441; x=1693455241;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thiR0red1e/TKgvXPJgbac9qLA8eyvIz0R2RRqFEpHo=;
        b=I5o2v51fu5b1mmUZbFdGnTbBStkqMmtdD+TkDr9KLlvI4w8BVeHIr7Z0cg253vvYEU
         BYpEX91wOkkLRjhofUbu1OYcqrkSUavpJrXe9BY70ZsBT/DXru5Gtzv4+AAlNiOPj6db
         VwC835yTL0Dx8TKDisMB+EGtU1DBh+KXTwx1WgQC/pdd6siiF97gaoge/ollBb6g+9F+
         xRQCa2T9Yq4mvDBXyBk0UnS3GkJlbpX3aWPSLkeEI4IQ+q0i2y+tW1Bv4P1UO6CZ1B7z
         C+o0VdFS5Rkx900il9VQfoBRV+Eo1QmMaDbSxvstoyQcs4l4cjfQ8g/P+5EorPjQzuek
         oIsw==
X-Gm-Message-State: AOJu0YzIsXGVc6kQ0m/VMoD3xNf1Ll6wuVynSO12pK1tPdaMyzLK4LKF
        WZUopYYZ+JUxMre1QjFvObwTN1foEmY3
X-Google-Smtp-Source: AGHT+IGVieYHWFSwxUoXO0fYTzVaYMdJYQ+4v07AN1lUT7XmCg3GuIl2/WxWo7lrlcojBdPU1J08ek9KwfXc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:af0c:0:b0:589:a997:f9ce with SMTP id
 n12-20020a81af0c000000b00589a997f9cemr198887ywh.2.1692850441260; Wed, 23 Aug
 2023 21:14:01 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:20 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-9-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 08/18] perf pmu-events: Add pmu_events_table__find_event
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

jevents stores events sorted by name. Add a find function that will
binary search event names avoiding the need to linearly search through
events. Add a test in tests/pmu-events.c. If the PMU or event aren't
found -1000 is returned. If the event is found but no callback
function given, 0 is returned. This allows the find function also act
as a test for existence.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 16 ++++++
 tools/perf/pmu-events/jevents.py         | 64 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       |  5 ++
 tools/perf/tests/pmu-events.c            |  5 ++
 4 files changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 2d6f748280ac..ef18d403f25f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -282,6 +282,22 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table, struc
 	return 0;
 }
 
+int pmu_events_table__find_event(const struct pmu_events_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *name,
+                                 pmu_event_iter_fn fn,
+                                 void *data)
+{
+	for (const struct pmu_event *pe = &table->entries[0]; pe->name; pe++) {
+                if (pmu && !pmu__name_match(pmu, pe->pmu))
+                        continue;
+
+		if (!strcasecmp(pe->name, name))
+			return fn(pe, table, data);
+	}
+        return -1000;
+}
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				      void *data)
 {
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 396af53e0e45..991fcf6cca64 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -825,6 +825,49 @@ static int pmu_events_table__for_each_event_pmu(const struct pmu_events_table *t
         return 0;
  }
 
+static int pmu_events_table__find_event_pmu(const struct pmu_events_table *table,
+                                            const struct pmu_table_entry *pmu,
+                                            const char *name,
+                                            pmu_event_iter_fn fn,
+                                            void *data)
+{
+        struct pmu_event pe = {
+                .pmu = &big_c_string[pmu->pmu_name.offset],
+        };
+        int low = 0, high = pmu->num_entries - 1;
+
+        while (low <= high) {
+                int cmp, mid = (low + high) / 2;
+
+                decompress_event(pmu->entries[mid].offset, &pe);
+
+                if (!pe.name && !name)
+                        goto do_call;
+
+                if (!pe.name && name) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (pe.name && !name) {
+                        high = mid - 1;
+                        continue;
+                }
+
+                cmp = strcasecmp(pe.name, name);
+                if (cmp < 0) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (cmp > 0) {
+                        high = mid - 1;
+                        continue;
+                }
+  do_call:
+                return fn ? fn(&pe, table, data) : 0;
+        }
+        return -1000;
+}
+
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     struct perf_pmu *pmu,
                                     pmu_event_iter_fn fn,
@@ -845,6 +888,27 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
         return 0;
 }
 
+int pmu_events_table__find_event(const struct pmu_events_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *name,
+                                 pmu_event_iter_fn fn,
+                                 void *data)
+{
+        for (size_t i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+                int ret;
+
+                if (!pmu__name_match(pmu, pmu_name))
+                        continue;
+
+                ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
+                if (ret != -1000)
+                        return ret;
+        }
+        return -1000;
+}
+
 static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics_table *table,
                                                 const struct pmu_table_entry *pmu,
                                                 pmu_metric_iter_fn fn,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c0303ba42e97..9882b7125761 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -81,6 +81,11 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
 				    void *data);
+int pmu_events_table__find_event(const struct pmu_events_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *name,
+                                 pmu_event_iter_fn fn,
+				 void *data);
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 92d1f6f0e666..34f0de182fa9 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -546,6 +546,11 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 
 	pmu_add_cpu_aliases_table(pmu, table);
 
+	res = pmu_events_table__find_event(table, pmu, "bp_l1_btb_correct", NULL, NULL);
+	if (res != 0) {
+		pr_debug("Missing test event in test architecture");
+		return res;
+	}
 	for (; *test_event_table; test_event_table++) {
 		struct perf_pmu_test_event test_event = **test_event_table;
 		struct pmu_event const *event = &test_event.event;
-- 
2.42.0.rc1.204.g551eb34607-goog

