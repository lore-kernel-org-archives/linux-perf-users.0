Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6151DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3839161245
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbhJGQ7l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbhJGQ7d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B17C061766
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:57:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x3-20020a05620a448300b0045e3e24de82so5719221qkp.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oNaR5IsYpeWcbNZy8N7XGPBTmfg6etL4Pai8Y/zsBI0=;
        b=GaRcjEXFlIC49Fc6MZuV2xoW4+VP/yNreUJ/TRghdI3mqXHdyHu2GZWDkQ1r1C0FOk
         hRYFhmxXdzYlTwALwz1z9bm+9pGAExZgujJXi2WHj81GzePwZ3HXljYr4x8zDjdDdAAC
         OuC7AYhjzOCTPhdXQE6zexI0Fz3Bj5Rvl2qtMVX16xh1FK3F5WT51y6gug2YkbQ77YMq
         WPUHt/iMmZ7YNdh6QWRrgLwvPT82AZkkfAvzm7xQNZPhXb08lU0vL+dXPXE3Gs0JOTPo
         pK4UifyAKYegJtBlT1XJTXs9lS4+pqihmcgMayROU4C44k3N0vcfFikgG4zS79dVnfiX
         IQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oNaR5IsYpeWcbNZy8N7XGPBTmfg6etL4Pai8Y/zsBI0=;
        b=wAWU5aUQEiktcn1bLQpO5MnAWxZpz3tHKgfs3c/D7k1/q+MkqXSFQ6bPZEEzCCig2S
         lKatImWh86yPSSRqqYwOlVedJ9+YbUq4Zt2VIbhdba3NJaSd7CR234rib0ZLtWm8/xMa
         iZ+qkBt2D68qO3IXtF2u0Xw0q90fx+mjWcELVcT0gKBeLfAY8RrwPe70VKVGu0lLwlbN
         hwYVJ914JWieCes3tT9y9JHBeWET19sonjnxweYtOcuhW92VF1aXv14IN6jZ5CYKWmF0
         ct2t5j33eXjDn65l/36LmIB2ND9Pb9fEa/khWkI1BTb6KnsPTsJN7ntwLFSo0aYz1P+F
         903A==
X-Gm-Message-State: AOAM532aQ+xj7+smCYjsnv/H1I1Qrb+hTmWfan4Ufw1dWWYyIfN6e/wS
        RtWVN55Q/mFoaT1ANkmQCOHt0BzEJy3j
X-Google-Smtp-Source: ABdhPJzjry8Ky5ebCTzcC2d3M1o7kQYBWofMdHAuvykBE2YZrvJIHm2WvmhB7Mo0/5CtlZhVN4+f9ScbTu7W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:ac8:5617:: with SMTP id
 23mr6241251qtr.257.1633625858948; Thu, 07 Oct 2021 09:57:38 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:30 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-5-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 04/21] perf pmu: Make pmu_event tables const.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make lookup nature of data structures clearer through their type.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/header.c |  2 +-
 tools/perf/pmu-events/jevents.c       |  2 +-
 tools/perf/pmu-events/pmu-events.h    |  4 +--
 tools/perf/tests/pmu-events.c         | 16 ++++++------
 tools/perf/util/metricgroup.c         | 36 +++++++++++++--------------
 tools/perf/util/metricgroup.h         |  6 ++---
 tools/perf/util/pmu.c                 |  8 +++---
 tools/perf/util/pmu.h                 |  2 +-
 tools/perf/util/s390-sample-raw.c     |  2 +-
 9 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 58b2d610aadb..e8fe36b10d20 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -40,7 +40,7 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 	return bufp;
 }
 
-int arch_get_runtimeparam(struct pmu_event *pe)
+int arch_get_runtimeparam(const struct pmu_event *pe)
 {
 	int count;
 	char path[PATH_MAX] = "/devices/hv_24x7/interface/";
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index a31de0f77097..b3431c11c9cb 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -362,7 +362,7 @@ static int close_table;
 
 static void print_events_table_prefix(FILE *fp, const char *tblname)
 {
-	fprintf(fp, "struct pmu_event %s[] = {\n", tblname);
+	fprintf(fp, "const struct pmu_event %s[] = {\n", tblname);
 	close_table = 1;
 }
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index f6c9c9fc4ab2..6efe73976440 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -41,12 +41,12 @@ struct pmu_events_map {
 	const char *cpuid;
 	const char *version;
 	const char *type;		/* core, uncore etc */
-	struct pmu_event *table;
+	const struct pmu_event *table;
 };
 
 struct pmu_sys_events {
 	const char *name;
-	struct pmu_event *table;
+	const struct pmu_event *table;
 };
 
 /*
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index c0f8b61871c8..cc5cea141beb 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -256,7 +256,7 @@ static const struct pmu_events_map *__test_pmu_get_events_map(void)
 	return NULL;
 }
 
-static struct pmu_event *__test_pmu_get_sys_events_table(void)
+static const struct pmu_event *__test_pmu_get_sys_events_table(void)
 {
 	const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 
@@ -268,7 +268,7 @@ static struct pmu_event *__test_pmu_get_sys_events_table(void)
 	return NULL;
 }
 
-static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
+static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event *e2)
 {
 	if (!is_same(e1->name, e2->name)) {
 		pr_debug2("testing event e1 %s: mismatched name string, %s vs %s\n",
@@ -420,9 +420,9 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 /* Verify generated events from pmu-events.c are as expected */
 static int test_pmu_event_table(void)
 {
-	struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
+	const struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
 	const struct pmu_events_map *map = __test_pmu_get_events_map();
-	struct pmu_event *table;
+	const struct pmu_event *table;
 	int map_events = 0, expected_events;
 
 	/* ignore 3x sentinels */
@@ -774,7 +774,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	return ret;
 }
 
-static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
+static int check_parse_cpu(const char *id, bool same_cpu, const struct pmu_event *pe)
 {
 	struct parse_events_error error = { .idx = 0, };
 
@@ -838,7 +838,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 		all = true;
 		hashmap__for_each_entry_safe(pctx->ids, cur, cur_tmp, bkt) {
 			struct metric_ref *ref;
-			struct pmu_event *pe;
+			const struct pmu_event *pe;
 
 			pe = metricgroup__find_metric(cur->key, map);
 			if (!pe)
@@ -887,7 +887,7 @@ static int test_parsing(void)
 {
 	const struct pmu_events_map *cpus_map = pmu_events_map__find();
 	const struct pmu_events_map *map;
-	struct pmu_event *pe;
+	const struct pmu_event *pe;
 	int i, j, k;
 	int ret = 0;
 	struct expr_parse_ctx *ctx;
@@ -1028,7 +1028,7 @@ static int metric_parse_fake(const char *str)
 static int test_parsing_fake(void)
 {
 	const struct pmu_events_map *map;
-	struct pmu_event *pe;
+	const struct pmu_event *pe;
 	unsigned int i, j;
 	int err = 0;
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 74ea0a3540ce..b60ccbbf0829 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -427,7 +427,7 @@ static bool match_metric(const char *n, const char *list)
 	return false;
 }
 
-static bool match_pe_metric(struct pmu_event *pe, const char *metric)
+static bool match_pe_metric(const struct pmu_event *pe, const char *metric)
 {
 	return match_metric(pe->metric_group, metric) ||
 	       match_metric(pe->metric_name, metric);
@@ -511,7 +511,7 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 		putchar('\n');
 }
 
-static int metricgroup__print_pmu_event(struct pmu_event *pe,
+static int metricgroup__print_pmu_event(const struct pmu_event *pe,
 					bool metricgroups, char *filter,
 					bool raw, bool details,
 					struct rblist *groups,
@@ -586,14 +586,14 @@ struct metricgroup_print_sys_idata {
 	bool details;
 };
 
-typedef int (*metricgroup_sys_event_iter_fn)(struct pmu_event *pe, void *);
+typedef int (*metricgroup_sys_event_iter_fn)(const struct pmu_event *pe, void *);
 
 struct metricgroup_iter_data {
 	metricgroup_sys_event_iter_fn fn;
 	void *data;
 };
 
-static int metricgroup__sys_event_iter(struct pmu_event *pe, void *data)
+static int metricgroup__sys_event_iter(const struct pmu_event *pe, void *data)
 {
 	struct metricgroup_iter_data *d = data;
 	struct perf_pmu *pmu = NULL;
@@ -612,7 +612,7 @@ static int metricgroup__sys_event_iter(struct pmu_event *pe, void *data)
 	return 0;
 }
 
-static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
+static int metricgroup__print_sys_event_iter(const struct pmu_event *pe, void *data)
 {
 	struct metricgroup_print_sys_idata *d = data;
 
@@ -624,7 +624,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
 	const struct pmu_events_map *map = pmu_events_map__find();
-	struct pmu_event *pe;
+	const struct pmu_event *pe;
 	int i;
 	struct rblist groups;
 	struct rb_node *node, *next;
@@ -756,7 +756,7 @@ static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
 		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
 }
 
-static bool metricgroup__has_constraint(struct pmu_event *pe)
+static bool metricgroup__has_constraint(const struct pmu_event *pe)
 {
 	if (!pe->metric_constraint)
 		return false;
@@ -770,7 +770,7 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
 	return false;
 }
 
-int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
+int __weak arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused)
 {
 	return 1;
 }
@@ -785,7 +785,7 @@ struct metricgroup_add_iter_data {
 };
 
 static int __add_metric(struct list_head *metric_list,
-			struct pmu_event *pe,
+			const struct pmu_event *pe,
 			bool metric_no_group,
 			int runtime,
 			struct metric **mp,
@@ -909,10 +909,10 @@ static int __add_metric(struct list_head *metric_list,
 		    (match_metric(__pe->metric_group, __metric) ||	\
 		     match_metric(__pe->metric_name, __metric)))
 
-struct pmu_event *metricgroup__find_metric(const char *metric,
-					   const struct pmu_events_map *map)
+const struct pmu_event *metricgroup__find_metric(const char *metric,
+						 const struct pmu_events_map *map)
 {
-	struct pmu_event *pe;
+	const struct pmu_event *pe;
 	int i;
 
 	map_for_each_event(pe, i, map) {
@@ -968,7 +968,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 }
 
 static int add_metric(struct list_head *metric_list,
-		      struct pmu_event *pe,
+		      const struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **mp,
 		      struct expr_id *parent,
@@ -993,7 +993,7 @@ static int __resolve_metric(struct metric *m,
 		all = true;
 		hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
 			struct expr_id *parent;
-			struct pmu_event *pe;
+			const struct pmu_event *pe;
 
 			pe = metricgroup__find_metric(cur->key, map);
 			if (!pe)
@@ -1040,7 +1040,7 @@ static int resolve_metric(bool metric_no_group,
 }
 
 static int add_metric(struct list_head *metric_list,
-		      struct pmu_event *pe,
+		      const struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **m,
 		      struct expr_id *parent,
@@ -1070,7 +1070,7 @@ static int add_metric(struct list_head *metric_list,
 	return ret;
 }
 
-static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
+static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 						  void *data)
 {
 	struct metricgroup_add_iter_data *d = data;
@@ -1102,7 +1102,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   const struct pmu_events_map *map)
 {
 	struct expr_ids ids = { .cnt = 0, };
-	struct pmu_event *pe;
+	const struct pmu_event *pe;
 	struct metric *m;
 	LIST_HEAD(list);
 	int i, ret;
@@ -1286,7 +1286,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 bool metricgroup__has_metric(const char *metric)
 {
 	const struct pmu_events_map *map = pmu_events_map__find();
-	struct pmu_event *pe;
+	const struct pmu_event *pe;
 	int i;
 
 	if (!map)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index c931596557bf..88ba939a3082 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -43,8 +43,8 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_group,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
-struct pmu_event *metricgroup__find_metric(const char *metric,
-					   const struct pmu_events_map *map);
+const struct pmu_event *metricgroup__find_metric(const char *metric,
+						 const struct pmu_events_map *map);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_events_map *map,
 				   const char *str,
@@ -55,7 +55,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
-int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
+int arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused);
 void metricgroup__rblist_exit(struct rblist *metric_events);
 
 int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c04a89cc7cef..cdd6c3f6caf1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -315,7 +315,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc, char *val, struct pmu_event *pe)
+				 char *desc, char *val, const struct pmu_event *pe)
 {
 	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
@@ -834,7 +834,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 	i = 0;
 	while (1) {
 		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
-		struct pmu_event *pe = &map->table[i++];
+		const struct pmu_event *pe = &map->table[i++];
 		const char *pname = pe->pmu ? pe->pmu : cpu_name;
 
 		if (!pe->name) {
@@ -882,7 +882,7 @@ void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
 			break;
 
 		while (1) {
-			struct pmu_event *pe = &event_table->table[j++];
+			const struct pmu_event *pe = &event_table->table[j++];
 			int ret;
 
 			if (!pe->name && !pe->metric_group && !pe->metric_name)
@@ -900,7 +900,7 @@ struct pmu_sys_event_iter_data {
 	struct perf_pmu *pmu;
 };
 
-static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
+static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe, void *data)
 {
 	struct pmu_sys_event_iter_data *idata = data;
 	struct perf_pmu *pmu = idata->pmu;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index dd5cdde6a3d0..cc9f9e001347 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -127,7 +127,7 @@ const struct pmu_events_map *pmu_events_map__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
-typedef int (*pmu_sys_event_iter_fn)(struct pmu_event *pe, void *data);
+typedef int (*pmu_sys_event_iter_fn)(const struct pmu_event *pe, void *data);
 void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 13f33d1ddb78..cd3a34840389 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -140,7 +140,7 @@ static const char *get_counter_name(int set, int nr, const struct pmu_events_map
 	int rc, event_nr, wanted = get_counterset_start(set) + nr;
 
 	if (map) {
-		struct pmu_event *evp = map->table;
+		const struct pmu_event *evp = map->table;
 
 		for (; evp->name || evp->event || evp->desc; ++evp) {
 			if (evp->name == NULL || evp->event == NULL)
-- 
2.33.0.882.g93a45727a2-goog

