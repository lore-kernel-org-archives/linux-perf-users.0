Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6912C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3736113E
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbhJGQ7e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbhJGQ73 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:29 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3BC061768
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:57:35 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t2-20020a05620a450200b0045e34e4f9c7so5699065qkp.18
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WqmvM9N70HVzTEu0CvbsGBGn1/4vSMDbZNuUPp+1PA8=;
        b=E5sv7iQrp0XNDSXQBDap445WUJmE+yDJm2nrbFWsO/gvYxAqzsPmPl4JWuNmvJPdUP
         ENYpLkBHez+po9LBrqgbNWbk9wS1SM9jxP95xdAvfTh5nkvY8Iic1/bVknvNb8QqrAc5
         ZjUTHFIlG07jB+2GIJp3V6MatiL3B9mbSGBNKqtrTPFhMquM5KQ6rjM/RSViMujK5sDE
         7Kf4fJ/rKv0EUhJVDK7pr6JGogyyiWbmMPmwRkhjctvdBgYAjCgj30IAsf3OoS7cp+f1
         YEO3F2QquR5DDcbu6zisAdgf90JoQr6ShVwqJ624UVlPTQ1Gq1Z1bTOcvOcu24I3xxUf
         k1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WqmvM9N70HVzTEu0CvbsGBGn1/4vSMDbZNuUPp+1PA8=;
        b=jFt0MjfSTX6N+EIgPpK8DPp3vOIZpZ/G7bp1g+KncRK+gC+ypbb0s1I25439KQKU1b
         sxmN49G0G1LtjtuBJuCBsnoe0t+Hivxuz+6MApjDWSrriXFGNNF0EzQ59iHKKshLY9Xz
         C8S8MRJ6tGSEDolEZNtGXAK+Yw5QQSWPcsn660OIpi90Qc1fFhl8P2TxPafLLXhk9gEA
         stv7GihRRXfYDJxoc4FNTJ2jJHpZBGk+WzsIkYZX0r0+qgc8//6h2oaeHXU+ChWW8JEV
         DDTIFoIthBTcl/IVob/fOJT2yG2TLaR1iKs13DARQIke+I3LhipkC+Gr+eTrsBJHAw/5
         S7+g==
X-Gm-Message-State: AOAM531YtqRz8UPrAYCmyDja8t4ixqxT9cEm2eitNsaZsWJq4MugRCGF
        G1m/sE+GbF42m1+tdQHB5TchYgjIu0zo
X-Google-Smtp-Source: ABdhPJyMpODE9Vsxt085PPswKpU4OoJPJtDgUF1Ix2Wcxa/Vx1HTdgDbXyruz+teeuhOJZNlAaS0tEYTaRBf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a05:622a:295:: with SMTP id
 z21mr6540994qtw.125.1633625854072; Thu, 07 Oct 2021 09:57:34 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:28 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-3-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 02/21] perf pmu: Add const to pmu_events_map.
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

The pmu_events_map is generated at compile time and used for lookup. For
testing purposes we need to swap the map being used. Having the
pmu_events_map be non-const is misleading as it may be an out argument.
Make it const and update uses so they work on const too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  2 +-
 tools/perf/tests/expand-cgroup.c   |  2 +-
 tools/perf/tests/parse-metric.c    |  2 +-
 tools/perf/tests/pmu-events.c      | 18 +++++++++---------
 tools/perf/util/metricgroup.c      | 20 ++++++++++----------
 tools/perf/util/metricgroup.h      |  4 ++--
 tools/perf/util/pmu.c              | 10 +++++-----
 tools/perf/util/pmu.h              |  6 +++---
 tools/perf/util/s390-sample-raw.c  |  4 ++--
 10 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 19497e4f8a86..5624a37d6f93 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -798,7 +798,7 @@ static bool is_sys_dir(char *fname)
 
 static void print_mapping_table_prefix(FILE *outfp)
 {
-	fprintf(outfp, "struct pmu_events_map pmu_events_map[] = {\n");
+	fprintf(outfp, "const struct pmu_events_map pmu_events_map[] = {\n");
 }
 
 static void print_mapping_table_suffix(FILE *outfp)
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 5c2bf7275c1c..42c6db6bedec 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -53,7 +53,7 @@ struct pmu_sys_events {
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
-extern struct pmu_events_map pmu_events_map[];
+extern const struct pmu_events_map pmu_events_map[];
 extern struct pmu_sys_events pmu_sys_event_tables[];
 
 #endif
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 0e46aeb843ce..aaad51aba12f 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -193,7 +193,7 @@ static int expand_metric_events(void)
 			.metric_name	= NULL,
 		},
 	};
-	struct pmu_events_map ev_map = {
+	const struct pmu_events_map ev_map = {
 		.cpuid		= "test",
 		.version	= "1",
 		.type		= "core",
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 4f6f4904e852..dfc797ecc750 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -79,7 +79,7 @@ static struct pmu_event pme_test[] = {
 }
 };
 
-static struct pmu_events_map map = {
+static const struct pmu_events_map map = {
 	.cpuid		= "test",
 	.version	= "1",
 	.type		= "core",
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index d3534960ed25..8a1fdcd072f5 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -242,9 +242,9 @@ static bool is_same(const char *reference, const char *test)
 	return !strcmp(reference, test);
 }
 
-static struct pmu_events_map *__test_pmu_get_events_map(void)
+static const struct pmu_events_map *__test_pmu_get_events_map(void)
 {
-	struct pmu_events_map *map;
+	const struct pmu_events_map *map;
 
 	for (map = &pmu_events_map[0]; map->cpuid; map++) {
 		if (!strcmp(map->cpuid, "testcpu"))
@@ -421,7 +421,7 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 static int test_pmu_event_table(void)
 {
 	struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
-	struct pmu_events_map *map = __test_pmu_get_events_map();
+	const struct pmu_events_map *map = __test_pmu_get_events_map();
 	struct pmu_event *table;
 	int map_events = 0, expected_events;
 
@@ -518,7 +518,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 	struct perf_pmu *pmu;
 	LIST_HEAD(aliases);
 	int res = 0;
-	struct pmu_events_map *map = __test_pmu_get_events_map();
+	const struct pmu_events_map *map = __test_pmu_get_events_map();
 	struct perf_pmu_alias *a, *tmp;
 
 	if (!map)
@@ -571,7 +571,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	struct perf_pmu *pmu = &test_pmu->pmu;
 	const char *pmu_name = pmu->name;
 	struct perf_pmu_alias *a, *tmp, *alias;
-	struct pmu_events_map *map;
+	const struct pmu_events_map *map;
 	LIST_HEAD(aliases);
 	int res = 0;
 
@@ -825,7 +825,7 @@ struct metric {
 
 static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 				 struct list_head *compound_list,
-				 struct pmu_events_map *map,
+				 const struct pmu_events_map *map,
 				 const char *metric_name)
 {
 	struct hashmap_entry *cur, *cur_tmp;
@@ -885,8 +885,8 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 
 static int test_parsing(void)
 {
-	struct pmu_events_map *cpus_map = pmu_events_map__find();
-	struct pmu_events_map *map;
+	const struct pmu_events_map *cpus_map = pmu_events_map__find();
+	const struct pmu_events_map *map;
 	struct pmu_event *pe;
 	int i, j, k;
 	int ret = 0;
@@ -1027,7 +1027,7 @@ static int metric_parse_fake(const char *str)
  */
 static int test_parsing_fake(void)
 {
-	struct pmu_events_map *map;
+	const struct pmu_events_map *map;
 	struct pmu_event *pe;
 	unsigned int i, j;
 	int err = 0;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8ba5370f5f64..74ea0a3540ce 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -623,7 +623,7 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
-	struct pmu_events_map *map = pmu_events_map__find();
+	const struct pmu_events_map *map = pmu_events_map__find();
 	struct pmu_event *pe;
 	int i;
 	struct rblist groups;
@@ -910,7 +910,7 @@ static int __add_metric(struct list_head *metric_list,
 		     match_metric(__pe->metric_name, __metric)))
 
 struct pmu_event *metricgroup__find_metric(const char *metric,
-					   struct pmu_events_map *map)
+					   const struct pmu_events_map *map)
 {
 	struct pmu_event *pe;
 	int i;
@@ -977,7 +977,7 @@ static int add_metric(struct list_head *metric_list,
 static int __resolve_metric(struct metric *m,
 			    bool metric_no_group,
 			    struct list_head *metric_list,
-			    struct pmu_events_map *map,
+			    const struct pmu_events_map *map,
 			    struct expr_ids *ids)
 {
 	struct hashmap_entry *cur;
@@ -1025,7 +1025,7 @@ static int __resolve_metric(struct metric *m,
 
 static int resolve_metric(bool metric_no_group,
 			  struct list_head *metric_list,
-			  struct pmu_events_map *map,
+			  const struct pmu_events_map *map,
 			  struct expr_ids *ids)
 {
 	struct metric *m;
@@ -1099,7 +1099,7 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *metric_list,
-				   struct pmu_events_map *map)
+				   const struct pmu_events_map *map)
 {
 	struct expr_ids ids = { .cnt = 0, };
 	struct pmu_event *pe;
@@ -1173,7 +1173,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
 					struct list_head *metric_list,
-					struct pmu_events_map *map)
+					const struct pmu_events_map *map)
 {
 	char *llist, *nlist, *p;
 	int ret = -EINVAL;
@@ -1230,7 +1230,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			bool metric_no_merge,
 			struct perf_pmu *fake_pmu,
 			struct rblist *metric_events,
-			struct pmu_events_map *map)
+			const struct pmu_events_map *map)
 {
 	struct parse_events_error parse_error;
 	struct strbuf extra_events;
@@ -1266,14 +1266,14 @@ int metricgroup__parse_groups(const struct option *opt,
 			      struct rblist *metric_events)
 {
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
-	struct pmu_events_map *map = pmu_events_map__find();
+	const struct pmu_events_map *map = pmu_events_map__find();
 
 	return parse_groups(perf_evlist, str, metric_no_group,
 			    metric_no_merge, NULL, metric_events, map);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   struct pmu_events_map *map,
+				   const struct pmu_events_map *map,
 				   const char *str,
 				   bool metric_no_group,
 				   bool metric_no_merge,
@@ -1285,7 +1285,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 
 bool metricgroup__has_metric(const char *metric)
 {
-	struct pmu_events_map *map = pmu_events_map__find();
+	const struct pmu_events_map *map = pmu_events_map__find();
 	struct pmu_event *pe;
 	int i;
 
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index cc4a92492a61..c931596557bf 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -44,9 +44,9 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
 struct pmu_event *metricgroup__find_metric(const char *metric,
-					   struct pmu_events_map *map);
+					   const struct pmu_events_map *map);
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   struct pmu_events_map *map,
+				   const struct pmu_events_map *map,
 				   const char *str,
 				   bool metric_no_group,
 				   bool metric_no_merge,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bdabd62170d2..4bcdc595ce5e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -710,9 +710,9 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 	return cpuid;
 }
 
-struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
+const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 {
-	struct pmu_events_map *map;
+	const struct pmu_events_map *map;
 	char *cpuid = perf_pmu__getcpuid(pmu);
 	int i;
 
@@ -737,7 +737,7 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	return map;
 }
 
-struct pmu_events_map *__weak pmu_events_map__find(void)
+const struct pmu_events_map *__weak pmu_events_map__find(void)
 {
 	return perf_pmu__find_map(NULL);
 }
@@ -824,7 +824,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
  * as aliases.
  */
 void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
-			     struct pmu_events_map *map)
+			     const struct pmu_events_map *map)
 {
 	int i;
 	const char *name = pmu->name;
@@ -859,7 +859,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 
 static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
-	struct pmu_events_map *map;
+	const struct pmu_events_map *map;
 
 	map = perf_pmu__find_map(pmu);
 	if (!map)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 394898b07fd9..dd5cdde6a3d0 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -120,10 +120,10 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
-			     struct pmu_events_map *map);
+			     const struct pmu_events_map *map);
 
-struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
-struct pmu_events_map *pmu_events_map__find(void);
+const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
+const struct pmu_events_map *pmu_events_map__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 08ec3c3ae0ee..13f33d1ddb78 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -135,7 +135,7 @@ static int get_counterset_start(int setnr)
  * the name of this counter.
  * If no match is found a NULL pointer is returned.
  */
-static const char *get_counter_name(int set, int nr, struct pmu_events_map *map)
+static const char *get_counter_name(int set, int nr, const struct pmu_events_map *map)
 {
 	int rc, event_nr, wanted = get_counterset_start(set) + nr;
 
@@ -159,7 +159,7 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
 	struct cf_ctrset_entry *cep, ce;
-	struct pmu_events_map *map;
+	const struct pmu_events_map *map;
 	u64 *p;
 
 	map = pmu_events_map__find();
-- 
2.33.0.882.g93a45727a2-goog

