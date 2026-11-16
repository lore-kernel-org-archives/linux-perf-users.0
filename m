Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812530;
	b=wFisbNQPk0s5w4F2RsbXFIe62a1Umdx1TJRSNhYv3X7k5qiiNAlvEcn1L6dKHNl0rUL2
	 oS/cdRFQmsakn1ZIWawZ23/PZEF2D+6kI6WdOydw4wUW2tD9wjn2iKsBSVMfmI3MXYbkG
	 WNedhTcSKM5ibOZK6oN+XhNt+J5M3P/EX96z7y54TwKQru+Z0VtaLboe/lihV+2blEkoR
	 zMm0ctQEtH8jO8xk/rAxZ8F7uSE7PluSjWSchx3DG46nunhG6DpDAkgph+diXVz1sa5qF
	 0fmU9RoZR55X0gYtZVVbgAnrqad+9DKoVyX31cHAZUAJcE5Xe3D3pGngORy4dsF9MOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=puctTn//12Dz6Pg0YNqnLzODNCiSvOP5h4BJRWsY6K8=;
	b=jzyv6cQZxYOj5SxTNsdpeN4m0W8strU/D+be29mxMbLym7O9mxddLzsFUU15OGLI61BK
	 mxpBQFcqgyw2fkqku2KDaMwobQD3U6tXtC5uiBA/d3UavZV4972iIO0yJ+45oNYWlsVkO
	 xKoln+84T4IcYSoJpN7QffFvBDfRv4otVkLQZch8C02TxK3JQVlSfTwbD2GrldhJeEIsH
	 2HtIQbwO2PVrasigJp446lGm+QkD/OIU70iRW3r6M2oXLXRFsD1HMtsarpbAfj8dHpfkp
	 UQU9nfJRr9TMHj0tawsXKDDLilqYt+wNez0YYpDYDjWmaNeSmC3MzyUvG+PaoOlmmPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z9+bjCzj;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C080606A884
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C080606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z9+bjCzj
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-370230d93efso1746765eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794812529; x=1795417329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puctTn//12Dz6Pg0YNqnLzODNCiSvOP5h4BJRWsY6K8=;
        b=Z9+bjCzj5/wT/L6W4MyDm4iUZgtyr7tGB6Gk9B5Dkf3G3qWxKd+g0b1eic+YkwoN52
         EVdo5p10UnknRLlfM7diqQ5zFi0JuONVO4Er7cZArHPw2tXm6d1COZwtHXA2j3jNYoao
         7WMdj4j7+c7wrYd1hJK8sjw5wvy41g0oOgVuPaPh/jrJflHloOENnRG0V3+zZSy62iFH
         mlltkdoOVIErUbsWSEnLM3W9LJ0158D5NEz4W/igQgkcwoZZSnNKlcAPS6X8U7NRW/vT
         LMtb0KI4TcqbBkuZzbfSOL2ppjGQvLmePr2nyYeLp4ZxqM7uNd5xLDF6ibKJQOGde0bG
         gGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812529; x=1795417329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puctTn//12Dz6Pg0YNqnLzODNCiSvOP5h4BJRWsY6K8=;
        b=knF/sSREZd5jm3HvwLJ1tmZAiQyALoA/HBjb/mgROU502QLatVz7T48alfaMnc79Bz
         NHpjXuNduOqfvlzbZFZBPb0Y7bzJJ5u27kw97FqKWeL+1Tx4whjHUMtYwQIbbFXyb8hi
         /j36odFl/Jw+te6QjXuz+CFLMe7B82w+hKd491/ptUX7y1g6cUZnVI7vflFh5TobJv2s
         AuZZ49Yg2QTr1SfAA9tcjoRrQgSlye6yToB5K3mvE3TmPgx5uesXKz9IImjsmO+enMaN
         VxDTaQbNrbrQAX5RU8uUxzvy9nwbhZium+cvdNjyZ0XcdgfZ+0wr8o/OvSuw2x48zOE4
         BGvg==
X-Forwarded-Encrypted: i=1; AL+hErGRBKDf3kwNbMf8s2WCas8IcYuidqr/m1LOOlk7upwZ7kVl3V8ok6YQ+1UcE+6L6ki+Bdf5YLqBQspC5ZrmwO+2@vger.kernel.org
X-Gm-Message-State: APuU4Z84wNywrWMUxkp4DmhHhJiHMaZOMRSsNA0YNnQ+lFrFELQY6NDM
	KFsL3gVGWOa1t7hx3fvUGrv2LD/g6I1/ky6L8cG6py6Ay7N7rZrgHp0K+zEyHdrBGKf922WKc55
	JPN9xNlKsiw==
X-Received: from dlam9-n1.prod.google.com ([2002:a05:701b:2089:10b0:184:b43a:63ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2092:20b0:193:9aa3:474c
 with SMTP id a92af1059eb24-1b5030fb812mr10497356c88.21.1794812528388; Sun, 15
 Nov 2026 23:02:08 -0800 (PST)
Date: Sun, 15 Nov 2026 23:01:48 -0800
In-Reply-To: <20261116070200.2972362-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116070200.2972362-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116070200.2972362-3-irogers@google.com>
Subject: [PATCH v2 02/11] perf pmu: Add metric and metricgroup storage on
 struct perf_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend struct perf_pmu symmetrically with pmu->aliases to own resolved
metrics and metricgroup descriptions for the lifetime of the PMU while
keeping struct perf_pmu_metric and struct perf_pmu_metricgroup private
out of pmu.h:

- Add struct perf_pmu_metric, struct perf_pmu_metricgroup, and
  pmu_metric_file_kind() in pmu.c for metric sidecar extensions
  (.scale-unit, .desc, .long-desc, .group, .no-group, .default-group,
  .threshold, .compat, .aggr-mode, .constraint, and .show-events).
- Initialize pmu->metrics, pmu->metricgroups, and pmu->metrics_table in
  perf_pmu__init(), perf_pmu__lookup(), and
  perf_pmu__create_placeholder_core_pmu().
- Free owned metric and metricgroup strings in perf_pmu__delete().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 230 ++++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/pmu.h |  18 ++++
 2 files changed, 238 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d97653e4c168..94d821c27b5b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <linux/ctype.h>
@@ -164,6 +165,54 @@ struct perf_pmu_alias {
 	bool has_retire_lat_max;
 };
 
+enum pmu_metric_file_kind {
+	PMU_METRIC_FILE_BASE,
+	PMU_METRIC_FILE_SCALE_UNIT,
+	PMU_METRIC_FILE_DESC,
+	PMU_METRIC_FILE_LONG_DESC,
+	PMU_METRIC_FILE_GROUP,
+	PMU_METRIC_FILE_NO_GROUP,
+	PMU_METRIC_FILE_DEFAULT_GROUP,
+	PMU_METRIC_FILE_THRESHOLD,
+	PMU_METRIC_FILE_COMPAT,
+	PMU_METRIC_FILE_AGGR_MODE,
+	PMU_METRIC_FILE_CONSTRAINT,
+	PMU_METRIC_FILE_SHOW_EVENTS,
+};
+
+/**
+ * struct perf_pmu_metric - Owned metric entry cached on struct perf_pmu.
+ */
+struct perf_pmu_metric {
+	char *pmu;
+	char *metric_name;
+	char *metric_group;
+	char *metric_expr;
+	char *metric_threshold;
+	char *unit;
+	char *compat;
+	char *desc;
+	char *long_desc;
+	char *metricgroup_no_group;
+	char *default_metricgroup_name;
+	enum aggr_mode_class aggr_mode;
+	enum metric_event_groups event_grouping;
+	bool default_show_events;
+	bool has_aggr_mode;
+	bool has_event_grouping;
+	bool has_default_show_events;
+};
+
+/**
+ * struct perf_pmu_metricgroup - Owned metricgroup description cached on
+ * struct perf_pmu.
+ */
+struct perf_pmu_metricgroup {
+	char *name;
+	char *desc;
+	bool from_builtin;
+};
+
 static int pmu_aliases_parse(struct perf_pmu *pmu);
 
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
@@ -382,6 +431,43 @@ static inline bool pmu_alias_info_file(const char *name)
 	return pmu_event_file_kind(name, NULL) != PMU_EVENT_FILE_BASE;
 }
 
+static const struct {
+	const char *suffix;
+	size_t len;
+	enum pmu_metric_file_kind kind;
+} pmu_metric_suffixes[] = {
+	{ ".desc",		5,  PMU_METRIC_FILE_DESC },
+	{ ".group",		6,  PMU_METRIC_FILE_GROUP },
+	{ ".compat",		7,  PMU_METRIC_FILE_COMPAT },
+	{ ".no-group",		9,  PMU_METRIC_FILE_NO_GROUP },
+	{ ".aggr-mode",		10, PMU_METRIC_FILE_AGGR_MODE },
+	{ ".long-desc",		10, PMU_METRIC_FILE_LONG_DESC },
+	{ ".threshold",		10, PMU_METRIC_FILE_THRESHOLD },
+	{ ".scale-unit",	11, PMU_METRIC_FILE_SCALE_UNIT },
+	{ ".constraint",	11, PMU_METRIC_FILE_CONSTRAINT },
+	{ ".show-events",	12, PMU_METRIC_FILE_SHOW_EVENTS },
+	{ ".default-group",	14, PMU_METRIC_FILE_DEFAULT_GROUP },
+};
+
+static __maybe_unused enum pmu_metric_file_kind
+pmu_metric_file_kind(const char *name, size_t *base_len)
+{
+	size_t len = strlen(name);
+
+	for (size_t i = 0; i < ARRAY_SIZE(pmu_metric_suffixes); i++) {
+		size_t slen = pmu_metric_suffixes[i].len;
+
+		if (len > slen && !strcasecmp(name + len - slen, pmu_metric_suffixes[i].suffix)) {
+			if (base_len)
+				*base_len = len - slen;
+			return pmu_metric_suffixes[i].kind;
+		}
+	}
+	if (base_len)
+		*base_len = len;
+	return PMU_METRIC_FILE_BASE;
+}
+
 static int perf_pmu__parse_scale_at(int events_dir_fd, const char *event_name,
 				    struct perf_pmu_alias *alias)
 {
@@ -518,7 +604,7 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 	struct hashmap_entry *entry;
 	size_t bkt;
 
-	if (!pmu->aliases)
+	if (IS_ERR_OR_NULL(pmu->aliases))
 		return;
 
 	hashmap__for_each_entry(pmu->aliases, entry, bkt)
@@ -528,6 +614,87 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 	pmu->aliases = NULL;
 }
 
+static void perf_pmu_free_metric(struct perf_pmu_metric *metric)
+{
+	if (!metric)
+		return;
+
+	zfree(&metric->pmu);
+	zfree(&metric->metric_name);
+	zfree(&metric->metric_group);
+	zfree(&metric->metric_expr);
+	zfree(&metric->metric_threshold);
+	zfree(&metric->unit);
+	zfree(&metric->compat);
+	zfree(&metric->desc);
+	zfree(&metric->long_desc);
+	zfree(&metric->metricgroup_no_group);
+	zfree(&metric->default_metricgroup_name);
+	free(metric);
+}
+
+static void perf_pmu_free_metricgroup(struct perf_pmu_metricgroup *mg)
+{
+	if (!mg)
+		return;
+
+	zfree(&mg->name);
+	zfree(&mg->desc);
+	free(mg);
+}
+
+static __maybe_unused void
+perf_pmu_metric__to_pmu_metric(const struct perf_pmu_metric *src,
+			       struct pmu_metric *dst)
+{
+	*dst = (struct pmu_metric){
+		.pmu = src->pmu,
+		.metric_name = src->metric_name,
+		.metric_group = src->metric_group,
+		.metric_expr = src->metric_expr,
+		.metric_threshold = src->metric_threshold,
+		.unit = src->unit,
+		.compat = src->compat,
+		.desc = src->desc,
+		.long_desc = src->long_desc,
+		.metricgroup_no_group = src->metricgroup_no_group,
+		.default_metricgroup_name = src->default_metricgroup_name,
+		.aggr_mode = src->aggr_mode,
+		.event_grouping = src->event_grouping,
+		.default_show_events = src->default_show_events,
+	};
+}
+
+static void perf_pmu__del_metrics(struct perf_pmu *pmu)
+{
+	struct hashmap_entry *entry;
+	size_t bkt;
+
+	if (IS_ERR_OR_NULL(pmu->metrics))
+		return;
+
+	hashmap__for_each_entry(pmu->metrics, entry, bkt)
+		perf_pmu_free_metric(entry->pvalue);
+
+	hashmap__free(pmu->metrics);
+	pmu->metrics = NULL;
+}
+
+static void perf_pmu__del_metricgroups(struct perf_pmu *pmu)
+{
+	struct hashmap_entry *entry;
+	size_t bkt;
+
+	if (IS_ERR_OR_NULL(pmu->metricgroups))
+		return;
+
+	hashmap__for_each_entry(pmu->metricgroups, entry, bkt)
+		perf_pmu_free_metricgroup(entry->pvalue);
+
+	hashmap__free(pmu->metricgroups);
+	pmu->metricgroups = NULL;
+}
+
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			       const char *desc, const char *val, int val_fd,
 			       const struct pmu_event *pe, enum event_source src,
@@ -1336,6 +1503,33 @@ static bool aliases__equal(long key1, long key2, void *ctx __maybe_unused)
 	return strcasecmp((const char *)key1, (const char *)key2) == 0;
 }
 
+static size_t metrics__hash(long key, void *ctx __maybe_unused)
+{
+	return str_hash((const char *)key);
+}
+
+static bool metrics__equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return strcmp((const char *)key1, (const char *)key2) == 0;
+}
+
+static const struct pmu_metrics_table *perf_pmu__lookup_metrics_table(struct perf_pmu *pmu)
+{
+	const struct pmu_metrics_table *table = NULL;
+	const char *arch = perf_env__arch(NULL);
+	struct perf_cpu cpu = pmu ? perf_cpu_map__min(pmu->cpus) : (struct perf_cpu){ -1 };
+	char *cpuid = get_cpuid_allow_env_override(cpu);
+
+	if (cpuid) {
+		if (arch)
+			table = find_core_metrics_table(arch, cpuid);
+		free(cpuid);
+	}
+	if (!table)
+		table = pmu_metrics_table__find();
+	return table;
+}
+
 int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 {
 	pmu->type = type;
@@ -1347,8 +1541,22 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 		return -ENOMEM;
 
 	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
-	if (!pmu->aliases)
+	if (IS_ERR(pmu->aliases)) {
+		pmu->aliases = NULL;
 		return -ENOMEM;
+	}
+
+	pmu->metrics = hashmap__new(metrics__hash, metrics__equal, /*ctx=*/ NULL);
+	if (IS_ERR(pmu->metrics)) {
+		pmu->metrics = NULL;
+		return -ENOMEM;
+	}
+
+	pmu->metricgroups = hashmap__new(metrics__hash, metrics__equal, /*ctx=*/ NULL);
+	if (IS_ERR(pmu->metricgroups)) {
+		pmu->metricgroups = NULL;
+		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -1425,6 +1633,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
 	pmu->alias_name = pmu_find_alias_name(pmu, dirfd);
 	pmu->events_table = perf_pmu__find_events_table(pmu);
+	pmu->metrics_table = perf_pmu__lookup_metrics_table(pmu);
 	/*
 	 * Load the sys json events/aliases when loading the PMU as each event
 	 * may have a different compat regular expression. We therefore can't
@@ -1436,8 +1645,10 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 
 	perf_pmu__arch_init(pmu);
 
-	if (eager_load)
+	if (eager_load) {
 		pmu_aliases_parse_eager(pmu, dirfd);
+		pmu->eager_sysfs_loaded = true;
+	}
 
 	return pmu;
 }
@@ -1450,19 +1661,16 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 	if (!pmu)
 		return NULL;
 
-	pmu->name = strdup("cpu");
-	if (!pmu->name) {
-		free(pmu);
+	if (perf_pmu__init(pmu, PERF_TYPE_RAW, "cpu") != 0) {
+		perf_pmu__delete(pmu);
 		return NULL;
 	}
 
 	pmu->is_core = true;
-	pmu->type = PERF_TYPE_RAW;
 	pmu->cpus = cpu_map__online();
+	pmu->events_table = perf_pmu__find_events_table(pmu);
+	pmu->metrics_table = perf_pmu__lookup_metrics_table(pmu);
 
-	INIT_LIST_HEAD(&pmu->format);
-	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
-	INIT_LIST_HEAD(&pmu->caps);
 	list_add_tail(&pmu->list, core_pmus);
 	return pmu;
 }
@@ -2939,6 +3147,8 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 	perf_pmu__del_formats(&pmu->format);
 	perf_pmu__del_aliases(pmu);
+	perf_pmu__del_metrics(pmu);
+	perf_pmu__del_metricgroups(pmu);
 	perf_pmu__del_caps(pmu);
 
 	perf_cpu_map__put(pmu->cpus);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2c8916ad073e..2587279fa0ce 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -148,6 +148,18 @@ struct perf_pmu {
 	 * @events_table: The events table for json events in pmu-events.c.
 	 */
 	const struct pmu_events_table *events_table;
+	/**
+	 * @metrics: Hashmap of struct perf_pmu_metric resolved across layers.
+	 */
+	struct hashmap *metrics;
+	/**
+	 * @metricgroups: Hashmap of struct perf_pmu_metricgroup descriptions.
+	 */
+	struct hashmap *metricgroups;
+	/**
+	 * @metrics_table: The metrics table for json metrics in pmu-events.c.
+	 */
+	const struct pmu_metrics_table *metrics_table;
 	/** @sysfs_aliases: Number of sysfs aliases loaded. */
 	uint32_t sysfs_aliases;
 	/** @cpu_json_aliases: Number of json event aliases loaded specific to the CPUID. */
@@ -166,6 +178,12 @@ struct perf_pmu {
 	 * been added?
 	 */
 	bool cpu_aliases_added;
+	/** @aliases_loaded: Have all layered event aliases been enumerated? */
+	bool aliases_loaded;
+	/** @metrics_loaded: Have all layered metrics been enumerated? */
+	bool metrics_loaded;
+	/** @eager_sysfs_loaded: Were sysfs events eagerly loaded from a custom dirfd? */
+	bool eager_sysfs_loaded;
 	/** @caps_initialized: Has the list caps been initialized? */
 	bool caps_initialized;
 	/** @nr_caps: The length of the list caps. */
-- 
2.56.1.703.gf848ed807c-goog

