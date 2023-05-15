Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A9C7EE24
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 22:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbjEOWBj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbjEOWAc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 18:00:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3BA275
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 14:59:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e65b34aso23904812276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684187967; x=1686779967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xo70dYhEcfCgGbPC8sbOAVfsz7lHN99PYmfDYjMXA94=;
        b=f829HRXKGHhrwUtQJHlJUuZW/kQHSdRQP17OzJ86X57kN1a2r2Kd3r1dtQh1BoqgyS
         BNnuMrt+PGQKKhDXqyfza4k1hlvecZ92MrhDYuj/vRs+AmOCTFrz64KXioBGHQpM7jV7
         D2Ka2capAGjZOERQ9x9uz6xfxC2dojijS8iBGvtYggo3kUWJ1eLxVPLYS9M4gkhI+RuF
         1MFyu+FoLYULe5fHX5SEWt8tCU96rkJsXBjY0l1MrpbnHMGxbImo+snT0u1rAB2DWOCW
         cIwR6YriMI/TGGsBd110UKtdfDzGAeHV+G5Bgyi2Z2kSqYQ8vtk0kWlhOc2wBmgpfEr9
         CY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187967; x=1686779967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xo70dYhEcfCgGbPC8sbOAVfsz7lHN99PYmfDYjMXA94=;
        b=g5iojHu4aK1cBHlgJho0EbUj8FKZAR1T3DxZxuYJkaH1LRx6+ezTNcKBPJkjCpXyFv
         zXMekT8Lp+2oK9qkAGccnT3H0EwoalKW2v8OjTTGyMUkCI8LLSvI45uHqDzf08H/PgUO
         qUy0hcVfpfNL/0CtV/noLpP+PN2fP6riQPNeiKXYj3jPIka6kkbnYHkDULhtq3ITYBQ4
         e//DU3fezkEvdx8TvrFbAKFA0xmNbl1dkHneSvQAzOShvikrDDJ7qHPx9QtaGd+rfUR0
         yOtKs7YX0GWatkz235/4urLPrK7NRcqY5HuPyt1I+V1PtUfmHhQ/8N8OOCMsSBXqhcBP
         DZmA==
X-Gm-Message-State: AC+VfDwUC16ISFZhztc/5romUSZEh+ryPWgd6WTECs/LJw4R7SB7QrtD
        Up6D99+SKsJIxfHDTb/KODyrmwSlZnHc
X-Google-Smtp-Source: ACHHUZ4WJyGL4EI3+IbnUzrXK/XAq2kTEJjp1Wsdo9Rx9kX98EKssBAdRaK2Je3lY22cMbcxXeCD92PUjxj9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:638e:7eff:a1d9:3b2b])
 (user=irogers job=sendgmr) by 2002:a25:4503:0:b0:b9d:b774:3a8b with SMTP id
 s3-20020a254503000000b00b9db7743a8bmr15101380yba.8.1684187967537; Mon, 15 May
 2023 14:59:27 -0700 (PDT)
Date:   Mon, 15 May 2023 14:58:43 -0700
In-Reply-To: <20230515215844.653610-1-irogers@google.com>
Message-Id: <20230515215844.653610-15-irogers@google.com>
Mime-Version: 1.0
References: <20230515215844.653610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 14/15] perf jevents: Add support for metricgroup descriptions
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
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Metrics have a field where the groups they belong to are listed like
the following from
tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json:

        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
        "MetricName": "tma_frontend_bound",

The metric groups are shown in 'perf list' like the following where
TopdownL1 is a metric group:

TopdownL1:
  tma_backend_bound
       [This category represents fraction of slots where no uops are being
        delivered due to a lack of required resources for accepting new uops
        in the Backend]
  tma_bad_speculation
       [This category represents fraction of slots wasted due to incorrect
        speculations]
  tma_frontend_bound
       [This category represents fraction of slots where the processor's
        Frontend undersupplies its Backend]
  tma_retiring
       [This category represents fraction of slots utilized by useful work
        i.e. issued uops that eventually get retired]

This patch adds support for a new json file in each model directory
called metricgroups.json that comprises a dictionary containing
entries that map from a metric group to a description:

{
...
    "TopdownL1": "Metrics for top-down breakdown at level 1",
...
}

perf list is then updated to support this changing the above output
to:

TopdownL1: [Metrics for top-down breakdown at level 1]
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c                | 11 ++++--
 tools/perf/pmu-events/empty-pmu-events.c |  5 +++
 tools/perf/pmu-events/jevents.py         | 49 +++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h       |  2 +
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c6bd0aa4a56e..e8520a027b45 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -192,9 +192,14 @@ static void default_print_metric(void *ps,
 		if (group && print_state->metricgroups) {
 			if (print_state->name_only)
 				printf("%s ", group);
-			else if (print_state->metrics)
-				printf("\n%s:\n", group);
-			else
+			else if (print_state->metrics) {
+				const char *gdesc = describe_metricgroup(group);
+
+				if (gdesc)
+					printf("\n%s: [%s]\n", group, gdesc);
+				else
+					printf("\n%s:\n", group);
+			} else
 				printf("%s\n", group);
 		}
 		zfree(&print_state->last_metricgroups);
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index e74defb5284f..a630c617e879 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -420,3 +420,8 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn __maybe_unused, void *data __m
 {
 	return 0;
 }
+
+const char *describe_metricgroup(const char *group __maybe_unused)
+{
+	return NULL;
+}
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 487ff01baf1b..8fca7c9adee0 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -37,6 +37,8 @@ _pending_metrics = []
 _pending_metrics_tblname = None
 # Global BigCString shared by all structures.
 _bcs = None
+# Map from the name of a metric group to a description of the group.
+_metricgroups = {}
 # Order specific JsonEvent attributes will be visited.
 _json_event_attributes = [
     # cmp_sevent related attributes.
@@ -512,6 +514,17 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
+  if item.name == 'metricgroups.json':
+    metricgroup_descriptions = json.load(open(item.path))
+    for mgroup in metricgroup_descriptions:
+      assert len(mgroup) > 1, parents
+      description = f"{metricgroup_descriptions[mgroup]}\\000"
+      mgroup = f"{mgroup}\\000"
+      _bcs.add(mgroup)
+      _bcs.add(description)
+      _metricgroups[mgroup] = description
+    return
+
   topic = get_topic(item.name)
   for event in read_json_events(item.path, topic):
     if event.name:
@@ -548,7 +561,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json'):
+  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
     return
 
   add_events_table_entries(item, get_topic(item.name))
@@ -911,6 +924,38 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 }
 """)
 
+def print_metricgroups() -> None:
+  _args.output_file.write("""
+static const int metricgroups[][2] = {
+""")
+  for mgroup in sorted(_metricgroups):
+    description = _metricgroups[mgroup]
+    _args.output_file.write(
+        f'\t{{ {_bcs.offsets[mgroup]}, {_bcs.offsets[description]} }}, /* {mgroup} => {description} */\n'
+    )
+  _args.output_file.write("""
+};
+
+const char *describe_metricgroup(const char *group)
+{
+        int low = 0, high = ARRAY_SIZE(metricgroups) - 1;
+
+        while (low <= high) {
+                int mid = (low + high) / 2;
+                const char *mgroup = &big_c_string[metricgroups[mid][0]];
+                int cmp = strcmp(mgroup, group);
+
+                if (cmp == 0) {
+                        return &big_c_string[metricgroups[mid][1]];
+                } else if (cmp < 0) {
+                        low = mid + 1;
+                } else {
+                        high = mid - 1;
+                }
+        }
+        return NULL;
+}
+""")
 
 def main() -> None:
   global _args
@@ -993,7 +1038,7 @@ struct compact_pmu_event {
 
   print_mapping_table(archs)
   print_system_mapping_table()
-
+  print_metricgroups()
 
 if __name__ == '__main__':
   main()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 3549e6971a4d..8cd23d656a5d 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -93,4 +93,6 @@ const struct pmu_metrics_table *find_sys_metrics_table(const char *name);
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data);
 int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data);
 
+const char *describe_metricgroup(const char *group);
+
 #endif
-- 
2.40.1.606.ga4b1b128d6-goog

