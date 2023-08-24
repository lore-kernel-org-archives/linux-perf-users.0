Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6F7C71153
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Aug 2023 04:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbjHXEOy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 00:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbjHXEOT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE534E4B
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:14:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59263889eacso13515187b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850456; x=1693455256;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBOZX0I21RNlbaOmyE1OFvH/y3TB68ZzbJZaWpbHFe0=;
        b=4NOW3dpx9qa73CbVpBAG0qbfaJOx/etOkFLFKrSX2DIjSNB39FzMN8uSjYsXDMHa+t
         xI90Ph+dizTc+7f/vT3Ws0w8EHnBuWCzcEsP83hYBsZSYh+p1sQsYWi+Jjx4M0H5LSjx
         djZhNidDtlIY/TtDUzMLmGvokNHM+Qq7yUEIpO6xO/63CgI63XmRghExdgSwMrWnzCoM
         gg9qGPheUD6y6bbAnDopsJUPGAIIqdAuI+Mb3Vs8TsNGpdxCiq68mD+KEOGWbUwZvXN+
         1TIxSfcO6ntlv5MJmoeb3DT+FARD4B13jFIL/HCa2rC2T5NNlNhezOsGA/YCo0S8EI3M
         /tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850456; x=1693455256;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBOZX0I21RNlbaOmyE1OFvH/y3TB68ZzbJZaWpbHFe0=;
        b=Cj0tiJGeZjHvOsE47g8JCw7lEjq/DpACVKHkJZQXu+k8uJXi6MVBtBJn4Bjim3Yica
         mESYnNCBgx17B4vcDFEIbH59GiV3iKCG+sG5Dh4wU2XfNam1x3T9b/LJ6/7AXHk57Q6I
         Q9iW+E23azU1RHQrB1hnr3fdU6xWRsyB0bNKum+3EGNTYbo/AfaZQIHbY/gVP2bKLa1p
         /csOc2ja2Gn3gXzN/ZA6ViPmpnJo+e+ahVdTQGRsauKJgZiEVqcqBVsesRUhUJDip759
         KF40wsxLYDgIQ3oy2GIQMCHAaR64fxlDoAilmkY3PHCW2IYiqsboS6LHc0Eq0u3ZEhLp
         XRnw==
X-Gm-Message-State: AOJu0YyhFDKVBnN+BdZ6vIWRCfIL45wrN3evm+62Fr+VO2UU5+mrPMvU
        QoplcEpQpPl1/2QD+fti1Zxwue3nmF1T
X-Google-Smtp-Source: AGHT+IHL01tjChYXDvehm2MTSrHE8lSIYBYzTaMmjiLSwkJBCjgWqTExg0OxL3eJVjV8e5M3ca84cWpGOURD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:af4d:0:b0:586:896e:58b1 with SMTP id
 x13-20020a81af4d000000b00586896e58b1mr201131ywj.0.1692850456019; Wed, 23 Aug
 2023 21:14:16 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:25 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-14-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 13/18] perf pmu: Lazily add json events
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

Rather than scanning all json events and adding them when a PMU is
created, add the alias when the json event is needed.

Average core PMU scanning run time reduced by 60.2%. Average PMU
scanning run time reduced by 15%. Page faults with no events reduced
by 74 page faults, 4% of total.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 14 +++++++
 tools/perf/pmu-events/jevents.py         | 15 +++++++
 tools/perf/pmu-events/pmu-events.h       |  4 ++
 tools/perf/tests/pmu-events.c            |  2 +
 tools/perf/util/pmu.c                    | 50 ++++++++++++++++++------
 tools/perf/util/pmu.h                    | 15 +++++--
 6 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index ef18d403f25f..12bd043a05e3 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -298,6 +298,20 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
         return -1000;
 }
 
+size_t pmu_events_table__num_events(const struct pmu_events_table *table,
+                                    struct perf_pmu *pmu)
+{
+        size_t count = 0;
+
+	for (const struct pmu_event *pe = &table->entries[0]; pe->name; pe++) {
+                if (pmu && !pmu__name_match(pmu, pe->pmu))
+                        continue;
+
+		count++;
+	}
+        return count;
+}
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				      void *data)
 {
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index f07864fabd54..01335a452e70 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -909,6 +909,21 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
         return -1000;
 }
 
+size_t pmu_events_table__num_events(const struct pmu_events_table *table,
+                                    struct perf_pmu *pmu)
+{
+        size_t count = 0;
+
+        for (size_t i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+
+                if (pmu__name_match(pmu, pmu_name))
+                        count += table_pmu->num_entries;
+        }
+        return count;
+}
+
 static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics_table *table,
                                                 const struct pmu_table_entry *pmu,
                                                 pmu_metric_iter_fn fn,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 9882b7125761..f5aa96f1685c 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -3,6 +3,7 @@
 #define PMU_EVENTS_H
 
 #include <stdbool.h>
+#include <stddef.h>
 
 struct perf_pmu;
 
@@ -86,6 +87,9 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  const char *name,
                                  pmu_event_iter_fn fn,
 				 void *data);
+size_t pmu_events_table__num_events(const struct pmu_events_table *table,
+				    struct perf_pmu *pmu);
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 4fcb84fd1f65..9ac893ae5f0d 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -546,6 +546,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 
 	pmu->events_table = table;
 	pmu_add_cpu_aliases_table(pmu, table);
+	pmu->cpu_aliases_added = true;
 
 	res = pmu_events_table__find_event(table, pmu, "bp_l1_btb_correct", NULL, NULL);
 	if (res != 0) {
@@ -586,6 +587,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 		return -1;
 	pmu->events_table = events_table;
 	pmu_add_cpu_aliases_table(pmu, events_table);
+	pmu->cpu_aliases_added = true;
 	pmu_add_sys_aliases(pmu);
 
 	/* Count how many aliases we generated */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 685903c1970b..b6a118226541 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -523,8 +523,9 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	if (!pe) {
 		/* Update an event from sysfs with json data. */
 		if (pmu->events_table) {
-			pmu_events_table__find_event(pmu->events_table, pmu, name,
-						     update_alias, alias);
+			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
+							 update_alias, alias) == 0)
+				pmu->loaded_json_aliases++;
 		}
 	}
 
@@ -548,6 +549,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 					 "%s=%s", term->config, term->val.str);
 	}
 	alias->str = strdup(newval);
+	if (!pe)
+		pmu->sysfs_aliases++;
+	else
+		pmu->loaded_json_aliases++;
 	list_add_tail(&alias->list, &pmu->aliases);
 	return 0;
 }
@@ -878,7 +883,11 @@ static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 	if (!pmu->events_table)
 		return;
 
+	if (pmu->cpu_aliases_added)
+		return;
+
 	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
+	pmu->cpu_aliases_added = true;
 }
 
 static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
@@ -990,7 +999,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
 	pmu->events_table = perf_pmu__find_events_table(pmu);
-	pmu_add_cpu_aliases(pmu);
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
 
@@ -1368,6 +1376,7 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 					     struct parse_events_term *term)
 {
+	struct perf_pmu_alias *alias;
 	char *name;
 
 	if (parse_events__is_hardcoded_term(term))
@@ -1388,7 +1397,18 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 		return NULL;
 	}
 
-	return perf_pmu__find_alias(pmu, name);
+	alias = perf_pmu__find_alias(pmu, name);
+	if (alias || pmu->cpu_aliases_added)
+		return alias;
+
+	/* Alias doesn't exist, try to get it from the json events. */
+	if (pmu->events_table &&
+	    pmu_events_table__find_event(pmu->events_table, pmu, name,
+				         pmu_add_cpu_aliases_map_callback,
+				         pmu) == 0) {
+		alias = perf_pmu__find_alias(pmu, name);
+	}
+	return alias;
 }
 
 
@@ -1555,18 +1575,23 @@ bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 	return !pmu->is_core || perf_pmus__num_core_pmus() == 1;
 }
 
-bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
+bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 {
-	return perf_pmu__find_alias(pmu, name) != NULL;
+	if (perf_pmu__find_alias(pmu, name) != NULL)
+		return true;
+	if (pmu->cpu_aliases_added || !pmu->events_table)
+		return false;
+	return pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0;
 }
 
-size_t perf_pmu__num_events(const struct perf_pmu *pmu)
+size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
-	struct list_head *list;
-	size_t nr = 0;
+	size_t nr = pmu->sysfs_aliases;
 
-	list_for_each(list, &pmu->aliases)
-		nr++;
+	if (pmu->cpu_aliases_added)
+		 nr += pmu->loaded_json_aliases;
+	else if (pmu->events_table)
+		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
 
 	return pmu->selectable ? nr + 1 : nr;
 }
@@ -1604,7 +1629,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	return buf;
 }
 
-int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+int perf_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
 {
 	char buf[1024];
 	struct perf_pmu_alias *event;
@@ -1613,6 +1638,7 @@ int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_
 	};
 	int ret = 0;
 
+	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6bf0fbde4e85..288d2908382a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -118,6 +118,15 @@ struct perf_pmu {
 	 * @events_table: The events table for json events in pmu-events.c.
 	 */
 	const struct pmu_events_table *events_table;
+	/** @sysfs_aliases: Number of sysfs aliases loaded. */
+	uint32_t sysfs_aliases;
+	/** @sysfs_aliases: Number of json event aliases loaded. */
+	uint32_t loaded_json_aliases;
+	/**
+	 * @cpu_aliases_added: Have all json events table entries for the PMU
+	 * been added?
+	 */
+	bool cpu_aliases_added;
 	/** @caps_initialized: Has the list caps been initialized? */
 	bool caps_initialized;
 	/** @nr_caps: The length of the list caps. */
@@ -199,9 +208,9 @@ bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
-bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name);
-size_t perf_pmu__num_events(const struct perf_pmu *pmu);
-int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name);
+size_t perf_pmu__num_events(struct perf_pmu *pmu);
+int perf_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
 bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
 
 /**
-- 
2.42.0.rc1.204.g551eb34607-goog

