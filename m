Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599683;
	b=iRznN3i+xmBqGP8RpUtRtQeClni1bcxkw8D0hbVL6Qw/q/Sq/vtf7uloKzMtez7V7i3m
	 bSKV0liRXVWaPCdqge+pFkoDQb5ImyUckfF1+R/6iD6nBuMWutZ35hghTh/vWJhTgQGnE
	 +qGU7lkVnpb5bVFgTwTS2rjvooM/gs9k4oxKXadpc6VWT86xTrRnE7hbGOYIZnngBMKZi
	 FfcwhlyMvpEP6bMqczfCtXClKANr1P9xHVHE9uMp95nX5HONtydvp6W6EoLcCQHCHsgul
	 YCjWI2Bq0toywYllf1v6ZFh6gUOgNh5ivbsshlNUam8Jg3FmjUEx71Uu8ckEzrtfuhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Immzj8o0di+LghIwvPmYkK00l4/VCtVXhOxxUWOhCIk=;
	b=uUAz3oFTHsRXU3eKkmRr5LjNWpqVwXgUEkpGDW1u7I4V9r/VL26pDcUtUEiLQ0e4ET/6
	 dv9Yfzx8+Ekj0AyKr332AYIrlymz0JGiSnAAyxw5gPlPDaJM1e+N7FoBzRfy86/wxKSjB
	 I02MyPwFWvOE8Epuqe30F4GjZycODpu6mcUOv/y0+I5hBswZPduI8UMoDjgozGlAnubpN
	 m5A6FpMfXQVZhmjTV0M2W0S+UkfliZ58qfrkHnN2LRJTKUkUPwvfY41j3Lm+/VZRRhRy/
	 ng1N9laAlOwjeajQuoiwYBypXhtWSq19sdHrbzOfrsYX9TLTPptlRqgRWVeYv0tpA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bo2yknOI;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A50606AE8D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A50606AE8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bo2yknOI
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1997867eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599679; x=1795204479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Immzj8o0di+LghIwvPmYkK00l4/VCtVXhOxxUWOhCIk=;
        b=bo2yknOIPgG/+5QjRYrbSDSXktc4ChPxPwU16IqbI7mF5WgZsdr3KH7V+CzMdMrT6r
         ECb1yIUGUD8FdUZNJUPl20Xnlf6SnvxitSxEzI6hDrrDz3DvrHySBe0wMqyr4YpBhTFX
         SaRUeML5axazl3aoRPuShOykiinVYxWNS0D3Wzub+pelVaUqsB+WwwAa9cS3jtM5Km5q
         0b2k58jUqVMUF74QUnC180L4KC26mlbAEbPGH9rENW1m79dRQKZGPNTH19A3zNvL31qI
         zMRoGVGY1OZkdgPkwP6eqRnqgUWz7WeF/qe9w6qUyGeQAsZs4LGqlOR5MEhuWMjz3XTb
         uq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599679; x=1795204479;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Immzj8o0di+LghIwvPmYkK00l4/VCtVXhOxxUWOhCIk=;
        b=fkfNZ/ER7FFGMtp4FfkeambaSrFMxjLs0r+cOWdoNPVrVU389g2ZBQGgpEnS3WAYiX
         l7RHI7B8DhH6MjoCPuO4J/hBATZeCnNGuaNSKev0Fth46YE2qiCIbwrgEEIh6ZjZCgoO
         Am/VORnhwU/1sQgKssNVRMQ4ONWz+UStAo52EX1PP9Ld61NJTpwZ3cPAvHBDlAsSeT2h
         LmqL3bHlgcewSG/RzJOq9aBArLlm2SYrofMHZeyYCRlm9Ad3IqM7u3eDbENQDe+AkWvb
         3TLazWTCFxAjp7cadW/5hIKgEt06loHXRM5Oer6exq5R6I5Ch9/IGCdlD/ddI+By17dT
         Kyow==
X-Gm-Message-State: APuU4Z+XYAXEZFF/Rb2dcUU+1XxkWX/2Mcn0CVFJAGuOmjs8JCEx2O5u
	L9oHio0xa+TsOFV1Ei0sGi9Ot5KdK22dCbLe8+x0CyQFmqRE4CWxEmKMGKo6ekxOWgeN4jHAkbx
	YPX44MfhkvA==
X-Received: from dycnd10.prod.google.com ([2002:a05:7301:c0a:b0:369:fbca:f649])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8816:20b0:36f:350b:3838
 with SMTP id 5a478bee46e88-379671247e7mr3026261eec.31.1794599678989; Fri, 13
 Nov 2026 11:54:38 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:28 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-24-irogers@google.com>
Subject: [PATCH v2 23/30] perf metricgroup: Share metric events by their
 counter encoding
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics share events to reduce multiplexing. Events were shared by the
names of the identifiers in the metric expressions: the identifiers of
ungrouped metrics were combined into one set of events, and a grouped
metric reused the events of an earlier metric whose identifiers were a
superset of its own. Events spelled differently but counting the same
thing, such as "slots" and "cpu_core/TOPDOWN.SLOTS/" or "cycles" and
"cpu-cycles", weren't shared, and events were only shared within the
metrics of one metricgroup__parse_groups() call.

Add an evsel matcher that compares a key of the counter an evsel
programs: the PMU name, the perf_event_attr type and config fields, the
exclusion bits and other modifiers, and the cgroup. Legacy hardware
events of core PMUs are compared using the encoding of the equivalent
sysfs or json event. Parse the events of each metric and then move them
to the evlist, unless the evlist already has an event counting the same
thing with compatible metric leadership, such as from an earlier metric,
an earlier metricgroup__parse_groups() call or the command line, in
which case that event is used. Events of a grouped metric are only
shared when all of them are found in one group; when grouping was only
forced by the architecture (such as x86 topdown slots and perf-metrics
events), new members are appended to an existing forced group. Ungrouped
events only match ungrouped events so that a metric's events aren't
split across multiplexing groups. The metric ids of a metric's events
are added to the shared events, and the metric's events refer to the
shared events. --metric-no-merge disables the sharing.

Remove build_combined_expr_ctx(), find_tool_events(), which added every
tool event to every metric so that the identifier sets could be
supersets, and expr__subset_of_ids(), now unused.

For example, on an Alder Lake system "--cputype=core -e
'{cpu_core/instructions/,cpu_core/cpu-cycles/}' -M tma_info_thread_ipc"
now shares that 2-event group on cpu_core rather than also opening
"{INST_RETIRED.ANY,CPU_CLK_UNHALTED.THREAD}".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c        |   15 -
 tools/perf/util/expr.h        |    2 -
 tools/perf/util/metricgroup.c | 1097 +++++++++++++++++++++++++++------
 3 files changed, 897 insertions(+), 217 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 09ced31ef59e..09dad66e3835 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -235,21 +235,6 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 	return hashmap__find(ctx->ids, id, data) ? 0 : -1;
 }
 
-bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
-			 struct expr_parse_ctx *needles)
-{
-	struct hashmap_entry *cur;
-	size_t bkt;
-	struct expr_id_data *data;
-
-	hashmap__for_each_entry(needles->ids, cur, bkt) {
-		if (expr__get_id(haystack, cur->pkey, &data))
-			return false;
-	}
-	return true;
-}
-
-
 int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap)
 {
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index ed12e4007d2d..7e22a1ea6ce1 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -42,8 +42,6 @@ int expr__add_id_val_source_count_aggr_nr(struct expr_parse_ctx *ctx, const char
 int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data);
-bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
-			 struct expr_parse_ctx *needles);
 int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f25709750c3e..f4a2b280091c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -155,11 +155,15 @@ struct metric {
 	/** Show events even if in the Default metric group. */
 	bool default_show_events;
 	/**
-	 * Parsed events for the metric. Optional as events may be taken from a
-	 * different metric whose group contains all the IDs necessary for this
-	 * one.
+	 * Events parsed for the metric before they are moved to, or replaced by
+	 * equivalent events in, the evlist the metrics are added to.
 	 */
 	struct evlist *evlist;
+	/**
+	 * The NULL terminated events of the metric's expression, placed in a
+	 * metric_expr.
+	 */
+	struct evsel **metric_events;
 };
 
 static void metric__watchdog_constraint_hint(const char *name, bool foot)
@@ -215,6 +219,7 @@ static void metric__free(struct metric *m)
 	expr__ctx_free(m->pctx);
 	zfree(&m->modifier);
 	evlist__put(m->evlist);
+	free(m->metric_events);
 	free(m);
 }
 
@@ -379,6 +384,9 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 * metric_events.
 		 */
 		evlist__for_each_entry_continue(metric_evlist, ev) {
+			if (!all_pmus && ev->pmu && evsel__is_hybrid(ev) &&
+			    strcmp(ev->pmu->name, pmu))
+				continue;
 			if (evsel__shares_metric_id(ev, metric_events[i]))
 				ev->metric_leader = metric_events[i];
 		}
@@ -471,6 +479,512 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
 	return pmu_for_each_sys_metric(metricgroup__sys_event_iter, &sys_data);
 }
 
+/*
+ * A key identifying the counter an evsel programs, used to find evsels counting
+ * the same thing, such as when metrics share events.
+ */
+struct counter_key {
+	/** @pmu_name: Name of the evsel's PMU, or NULL if unknown. */
+	const char *pmu_name;
+	/** @cgrp: The cgroup the evsel counts. */
+	const struct cgroup *cgrp;
+	/** @type: perf_event_attr type, PERF_TYPE_RAW for any dynamic PMU type. */
+	__u32 type;
+	/** @config: perf_event_attr config without legacy extended type bits. */
+	__u64 config;
+	/** @config1: perf_event_attr config1. */
+	__u64 config1;
+	/** @config2: perf_event_attr config2. */
+	__u64 config2;
+	/** @config3: perf_event_attr config3. */
+	__u64 config3;
+	/** @config4: perf_event_attr config4. */
+	__u64 config4;
+	/** @exclude: perf_event_attr exclude bits, a mask of COUNTER_KEY_EXCLUDE_*. */
+	unsigned int exclude;
+	/**
+	 * @modifiers: Other perf_event_attr and evsel modifiers affecting what
+	 * is counted, a mask of COUNTER_KEY_MOD_*.
+	 */
+	unsigned int modifiers;
+	/** @precise_ip: perf_event_attr precise_ip. */
+	unsigned int precise_ip;
+};
+
+#define COUNTER_KEY_EXCLUDE_USER	BIT(0)
+#define COUNTER_KEY_EXCLUDE_KERNEL	BIT(1)
+#define COUNTER_KEY_EXCLUDE_HV		BIT(2)
+#define COUNTER_KEY_EXCLUDE_HOST	BIT(3)
+#define COUNTER_KEY_EXCLUDE_GUEST	BIT(4)
+#define COUNTER_KEY_EXCLUDE_IDLE	BIT(5)
+
+#define COUNTER_KEY_MOD_PINNED		BIT(0)
+#define COUNTER_KEY_MOD_EXCLUSIVE	BIT(1)
+#define COUNTER_KEY_MOD_PERCORE		BIT(2)
+#define COUNTER_KEY_MOD_RETIRE_LAT	BIT(3)
+#define COUNTER_KEY_MOD_PRECISE_MAX	BIT(4)
+#define COUNTER_KEY_MOD_BPF		BIT(5)
+
+/* Cached sysfs encodings of legacy hardware events on a PMU. */
+struct legacy_hw_key {
+	struct list_head list;
+	char *pmu_name;
+	__u64 hw_config;
+	struct counter_key key;
+};
+
+struct evsel_matcher_entry {
+	struct evsel *evsel;
+	struct counter_key key;
+};
+
+/**
+ * struct evsel_matcher - Find the evsel, in a set of evsels, counting the same
+ * thing as another evsel.
+ */
+struct evsel_matcher {
+	/** @entries: The evsels that may be matched and their counter keys. */
+	struct evsel_matcher_entry *entries;
+	/** @nr_entries: Number of entries in use. */
+	size_t nr_entries;
+	/** @max_entries: Number of entries allocated. */
+	size_t max_entries;
+	/** @legacy_hw_keys: Cache of legacy_hw_key. */
+	struct list_head legacy_hw_keys;
+};
+
+static void counter_key__init_attr(struct counter_key *key, const char *pmu_name,
+				   const struct perf_event_attr *attr)
+{
+	memset(key, 0, sizeof(*key));
+	key->pmu_name = pmu_name;
+	key->type = attr->type;
+	key->config = attr->config;
+	key->config1 = attr->config1;
+	key->config2 = attr->config2;
+	key->config3 = attr->config3;
+	key->config4 = attr->config4;
+	key->exclude = (attr->exclude_user ? COUNTER_KEY_EXCLUDE_USER : 0) |
+		       (attr->exclude_kernel ? COUNTER_KEY_EXCLUDE_KERNEL : 0) |
+		       (attr->exclude_hv ? COUNTER_KEY_EXCLUDE_HV : 0) |
+		       (attr->exclude_host ? COUNTER_KEY_EXCLUDE_HOST : 0) |
+		       (attr->exclude_guest ? COUNTER_KEY_EXCLUDE_GUEST : 0) |
+		       (attr->exclude_idle ? COUNTER_KEY_EXCLUDE_IDLE : 0);
+	key->modifiers = (attr->pinned ? COUNTER_KEY_MOD_PINNED : 0) |
+			 (attr->exclusive ? COUNTER_KEY_MOD_EXCLUSIVE : 0);
+	key->precise_ip = attr->precise_ip;
+	if (attr->type == PERF_TYPE_HARDWARE || attr->type == PERF_TYPE_HW_CACHE) {
+		key->config &= PERF_HW_EVENT_MASK;
+	} else if (attr->type >= PERF_TYPE_MAX && pmu_name) {
+		/*
+		 * Dynamic PMU type numbers may differ between machines, compare
+		 * the PMU name instead. Without a PMU name keep the type so
+		 * that the event doesn't match the same config on any PMU.
+		 */
+		key->type = PERF_TYPE_RAW;
+	}
+}
+
+/* Copy the counter encoding, but not the PMU name or modifiers, of @src. */
+static void counter_key__set_counter(struct counter_key *key, const struct counter_key *src)
+{
+	key->type = src->type;
+	key->config = src->config;
+	key->config1 = src->config1;
+	key->config2 = src->config2;
+	key->config3 = src->config3;
+	key->config4 = src->config4;
+}
+
+/*
+ * Parse "<pmu_name>/<name>/" and, if the encoding isn't a legacy hardware
+ * event, such as because sysfs or json provide an encoding that is preferred
+ * by the perf tool, set @key to the encoding.
+ */
+static bool core_event_key(const char *pmu_name, const char *name, struct counter_key *key)
+{
+	struct parse_events_error err;
+	struct evlist *evlist;
+	struct evsel *evsel;
+	char *str;
+	bool found = false;
+
+	if (asprintf(&str, "%s/%s/", pmu_name, name) < 0)
+		return false;
+
+	evlist = evlist__new();
+	if (!evlist) {
+		free(str);
+		return false;
+	}
+	parse_events_error__init(&err);
+	if (!parse_events(evlist, str, &err) && evlist__nr_entries(evlist) == 1) {
+		evsel = evlist__first(evlist);
+		if (evsel->core.attr.type != PERF_TYPE_HARDWARE) {
+			counter_key__init_attr(key, pmu_name, &evsel->core.attr);
+			found = true;
+		}
+	}
+	parse_events_error__exit(&err);
+	evlist__put(evlist);
+	free(str);
+	return found;
+}
+
+struct legacy_hw_name_args {
+	const char *pmu_name;
+	struct counter_key *key;
+};
+
+/* Is there a non-legacy encoding of the legacy hardware event @name? */
+static int legacy_hw_name_cb(const char *name, void *data)
+{
+	struct legacy_hw_name_args *args = data;
+
+	return core_event_key(args->pmu_name, name, args->key) ? 1 : 0;
+}
+
+/*
+ * Legacy hardware events, such as "cycles" in "perf record -e cycles", are
+ * commonly also available as a sysfs or json event of the core PMU, such as
+ * "cpu_core/cpu-cycles/", whose encoding is preferred by the perf tool and is
+ * the encoding metrics use. Find the names of the legacy hardware event and
+ * compute the key of the preferred encoding using the live host PMU of the same
+ * name so that the two encodings match.
+ */
+static bool legacy_hw_key(struct evsel_matcher *matcher, const char *pmu_name,
+			  __u64 hw_config, struct counter_key *key)
+{
+	struct legacy_hw_key *pos;
+	struct legacy_hw_name_args name_args;
+	struct perf_pmu *pmu;
+
+	list_for_each_entry(pos, &matcher->legacy_hw_keys, list) {
+		if (pos->hw_config == hw_config && !strcmp(pos->pmu_name, pmu_name)) {
+			if (pos->key.type == PERF_TYPE_HARDWARE)
+				return false;
+			counter_key__set_counter(key, &pos->key);
+			return true;
+		}
+	}
+	pos = zalloc(sizeof(*pos));
+	if (!pos)
+		return false;
+	pos->pmu_name = strdup(pmu_name);
+	if (!pos->pmu_name) {
+		free(pos);
+		return false;
+	}
+	pos->hw_config = hw_config;
+	pos->key.type = PERF_TYPE_HARDWARE;
+	list_add(&pos->list, &matcher->legacy_hw_keys);
+
+	pmu = perf_pmus__find(perf_env__pmus(host_env()), pmu_name);
+	if (!pmu || !pmu->is_core)
+		return false;
+
+	name_args.pmu_name = pos->pmu_name;
+	name_args.key = &pos->key;
+	if (perf_pmu__for_each_name_from_config(pmu, PERF_TYPE_HARDWARE, hw_config,
+						legacy_hw_name_cb, &name_args) != 1) {
+		pos->key.type = PERF_TYPE_HARDWARE;
+		return false;
+	}
+	pos->key.pmu_name = pos->pmu_name;
+	counter_key__set_counter(key, &pos->key);
+	return true;
+}
+
+static void evsel_matcher__key(struct evsel_matcher *matcher, struct evsel *evsel,
+			       struct counter_key *key)
+{
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	counter_key__init_attr(key, pmu ? pmu->name : NULL, &evsel->core.attr);
+	key->cgrp = evsel->cgrp;
+	if (evsel->percore)
+		key->modifiers |= COUNTER_KEY_MOD_PERCORE;
+	if (evsel__is_retire_lat(evsel))
+		key->modifiers |= COUNTER_KEY_MOD_RETIRE_LAT;
+	if (evsel->precise_max)
+		key->modifiers |= COUNTER_KEY_MOD_PRECISE_MAX;
+	if (evsel->bpf_counter)
+		key->modifiers |= COUNTER_KEY_MOD_BPF;
+	if (key->type == PERF_TYPE_HARDWARE && pmu && pmu->is_core)
+		legacy_hw_key(matcher, pmu->name, key->config, key);
+}
+
+/* Do @a and @b count the same thing? */
+static bool counter_key__equal(const struct counter_key *a, const struct counter_key *b)
+{
+	if (a->type != b->type || a->config != b->config ||
+	    a->config1 != b->config1 || a->config2 != b->config2 ||
+	    a->config3 != b->config3 || a->config4 != b->config4)
+		return false;
+
+	if ((a->type == PERF_TYPE_RAW || a->type >= PERF_TYPE_MAX) &&
+	    !a->pmu_name != !b->pmu_name)
+		return false;
+
+	if (a->pmu_name && b->pmu_name && strcmp(a->pmu_name, b->pmu_name))
+		return false;
+
+	return a->exclude == b->exclude && a->modifiers == b->modifiers &&
+	       a->precise_ip == b->precise_ip && a->cgrp == b->cgrp;
+}
+
+static bool evsel__is_grouped(const struct evsel *evsel)
+{
+	return evsel__leader(evsel)->core.nr_members > 1 ||
+	       (evsel->core.attr.read_format & PERF_FORMAT_GROUP);
+}
+
+/**
+ * evsel_matcher__add() - Add @evsel to the evsels that may be matched.
+ * @matcher: The matcher.
+ * @evsel: The evsel to add.
+ */
+static int evsel_matcher__add(struct evsel_matcher *matcher, struct evsel *evsel)
+{
+	struct evsel_matcher_entry *entry;
+
+	if (matcher->nr_entries == matcher->max_entries) {
+		size_t max_entries = matcher->max_entries ? matcher->max_entries * 2 : 16;
+		struct evsel_matcher_entry *entries =
+			realloc(matcher->entries, max_entries * sizeof(*entries));
+
+		if (!entries)
+			return -ENOMEM;
+		matcher->entries = entries;
+		matcher->max_entries = max_entries;
+	}
+	entry = &matcher->entries[matcher->nr_entries++];
+	entry->evsel = evsel;
+	evsel_matcher__key(matcher, evsel, &entry->key);
+	return 0;
+}
+
+/**
+ * evsel_matcher__init() - Initialize a matcher of the evsels in @evlist.
+ * @matcher: The matcher to initialize.
+ * @evlist: The evsels that may be matched, more may be added with
+ *          evsel_matcher__add().
+ */
+static int evsel_matcher__init(struct evsel_matcher *matcher, struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	memset(matcher, 0, sizeof(*matcher));
+	INIT_LIST_HEAD(&matcher->legacy_hw_keys);
+	evlist__for_each_entry(evlist, evsel) {
+		int ret = evsel_matcher__add(matcher, evsel);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static void evsel_matcher__exit(struct evsel_matcher *matcher)
+{
+	struct legacy_hw_key *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &matcher->legacy_hw_keys, list) {
+		list_del(&pos->list);
+		free(pos->pmu_name);
+		free(pos);
+	}
+	zfree(&matcher->entries);
+	matcher->nr_entries = matcher->max_entries = 0;
+}
+
+static bool evsel__is_forced_group(struct evsel *leader)
+{
+	struct evsel *pos;
+
+	if (leader->dont_regroup)
+		return false;
+
+	for_each_group_evsel(pos, leader) {
+		if (!arch_evsel__must_be_in_group(pos))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * Does @pos have a metric_leader compatible with @evsel when @evsel's metric
+ * leader has @metric_sources events and was mapped to @mapped_metric_leader?
+ */
+static bool metric_leader_compatible(const struct evsel *evsel, int metric_sources,
+				     const struct evsel *mapped_metric_leader,
+				     const struct evsel *pos)
+{
+	if (!evsel->metric_leader || metric_sources == 0)
+		return true;
+
+	if (evsel->metric_leader == evsel) {
+		if (!pos->metric_leader)
+			return true;
+		return pos->metric_leader == pos && evsel__source_count(pos) == metric_sources;
+	}
+
+	if (!mapped_metric_leader)
+		return false;
+	if (!mapped_metric_leader->metric_leader)
+		return !pos->metric_leader && pos != mapped_metric_leader;
+	return pos->metric_leader == mapped_metric_leader;
+}
+
+static void own_evsel__metric_match_info(struct evsel **own, struct evsel **map, int nr,
+					 const struct evsel *ev, int *metric_sources,
+					 const struct evsel **mapped_metric_leader)
+{
+	int count = 0;
+
+	*metric_sources = 0;
+	*mapped_metric_leader = NULL;
+	if (!ev->metric_leader)
+		return;
+
+	for (int i = 0; i < nr; i++) {
+		if (own[i]->metric_leader == ev->metric_leader)
+			count++;
+		if (own[i] == ev->metric_leader)
+			*mapped_metric_leader = map[i];
+	}
+	*metric_sources = count;
+}
+
+/**
+ * evsel_matcher__find_for_metric() - Find the evsel counting the same thing as
+ *                                    @evsel with compatible metric leadership.
+ * @matcher: The matcher.
+ * @evsel: The evsel to match.
+ * @leader: If not NULL, the group leader of the matched evsel.
+ * @metric_sources: Number of events in @evsel's metric_leader family, or 0.
+ * @mapped_metric_leader: Replacement of @evsel->metric_leader when @evsel is
+ *                        not its own metric leader.
+ * @forced_group_leader: Require a group leader whose members all satisfy
+ *                       arch_evsel__must_be_in_group().
+ *
+ * The same counter may be present more than once, such as when the counter is
+ * in different groups. Prefer an evsel with the same name and the same group
+ * membership.
+ */
+static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matcher,
+						    struct evsel *evsel,
+						    const struct evsel *leader,
+						    int metric_sources,
+						    const struct evsel *mapped_metric_leader,
+						    bool forced_group_leader)
+{
+	struct evsel *best = NULL;
+	struct counter_key key;
+	bool grouped = evsel__is_grouped(evsel);
+	bool fake = evsel->pmu && perf_pmu__is_fake(evsel->pmu);
+	int best_score = -1;
+
+	evsel_matcher__key(matcher, evsel, &key);
+	for (size_t i = 0; i < matcher->nr_entries; i++) {
+		struct evsel_matcher_entry *entry = &matcher->entries[i];
+		struct evsel *pos = entry->evsel;
+		int score;
+
+		if (pos == evsel || (leader && evsel__leader(pos) != leader))
+			continue;
+
+		/*
+		 * Don't match an ungrouped event to a member of a group, as the
+		 * group may multiplex differently from the metric's other
+		 * events.
+		 */
+		if (!leader && !forced_group_leader && evsel__is_grouped(pos))
+			continue;
+
+		if (forced_group_leader &&
+		    (!evsel__is_group_leader(pos) || !evsel__is_forced_group(pos)))
+			continue;
+
+		/* Skip if the evsels don't program the same counter. */
+		if (!counter_key__equal(&key, &entry->key))
+			continue;
+
+		if (!metric_leader_compatible(evsel, metric_sources, mapped_metric_leader, pos))
+			continue;
+
+		/* The encoding of events on a fake PMU, used in testing, is meaningless. */
+		if ((fake || (pos->pmu && perf_pmu__is_fake(pos->pmu))) &&
+		    !evsel__shares_metric_id(evsel, pos))
+			continue;
+
+		score = (!strcmp(evsel__name(evsel), evsel__name(pos)) ? 2 : 0) +
+			(grouped == evsel__is_grouped(pos) ? 1 : 0);
+		if (score > best_score) {
+			best = pos;
+			best_score = score;
+		}
+	}
+	return best;
+}
+
+static __maybe_unused struct evsel *evsel_matcher__find(struct evsel_matcher *matcher,
+							struct evsel *evsel,
+							const struct evsel *leader)
+{
+	return evsel_matcher__find_for_metric(matcher, evsel, leader,
+					      /*metric_sources=*/0,
+					      /*mapped_metric_leader=*/NULL,
+					      /*forced_group_leader=*/false);
+}
+
+/**
+ * evsel_matcher__find_group() - Find a group of evsels counting the same thing
+ *                               as the members of the group led by @leader.
+ * @matcher: The matcher.
+ * @leader: The leader of the group to match.
+ * @own: Events of the metric being matched.
+ * @map: Matched replacements of @own.
+ * @nr: Number of events in @own.
+ * @out: Array, in the order of the group members, of the matched evsels.
+ */
+static bool evsel_matcher__find_group(struct evsel_matcher *matcher, struct evsel *leader,
+				      struct evsel **own, struct evsel **map, int nr,
+				      struct evsel **out)
+{
+	for (size_t i = 0; i < matcher->nr_entries; i++) {
+		struct evsel *pos_leader = matcher->entries[i].evsel;
+		struct evsel *member;
+		bool found = true;
+		int j = 0;
+
+		if (!evsel__is_group_leader(pos_leader) ||
+		    pos_leader->core.nr_members < leader->core.nr_members)
+			continue;
+
+		for_each_group_evsel(member, leader) {
+			int metric_sources;
+			const struct evsel *mapped_leader;
+
+			own_evsel__metric_match_info(own, map, nr, member,
+						     &metric_sources, &mapped_leader);
+			out[j] = evsel_matcher__find_for_metric(matcher, member, pos_leader,
+								metric_sources, mapped_leader,
+								/*forced_group_leader=*/false);
+			if (!out[j]) {
+				for (int k = 0; k < j; k++)
+					out[k] = NULL;
+				found = false;
+				break;
+			}
+			j++;
+		}
+		if (found)
+			return true;
+	}
+	return false;
+}
+
 struct find_matching_metrics_args {
 	struct evlist *evlist;
 	bool system_wide;
@@ -1335,89 +1849,20 @@ static void metricgroup__free_metrics(struct list_head *metric_list)
 	}
 }
 
-/**
- * find_tool_events - Search for the pressence of tool events in metric_list.
- * @metric_list: List to take metrics from.
- * @tool_events: Array of false values, indices corresponding to tool events set
- *               to true if tool event is found.
- */
-static void find_tool_events(const struct list_head *metric_list,
-			     bool tool_events[TOOL_PMU__EVENT_MAX])
-{
-	struct metric *m;
-
-	list_for_each_entry(m, metric_list, nd) {
-		int i;
-
-		tool_pmu__for_each_event(i) {
-			struct expr_id_data *data;
-
-			if (!tool_events[i] &&
-			    !expr__get_id(m->pctx, tool_pmu__event_to_str(i), &data))
-				tool_events[i] = true;
-		}
-	}
-}
-
-/**
- * build_combined_expr_ctx - Make an expr_parse_ctx with all !group_events
- *                           metric IDs, as the IDs are held in a set,
- *                           duplicates will be removed.
- * @metric_list: List to take metrics from.
- * @combined: Out argument for result.
- */
-static int build_combined_expr_ctx(const struct list_head *metric_list,
-				   struct expr_parse_ctx **combined)
-{
-	struct hashmap_entry *cur;
-	size_t bkt;
-	struct metric *m;
-	char *dup;
-	int ret;
-
-	*combined = expr__ctx_new();
-	if (!*combined)
-		return -ENOMEM;
-
-	list_for_each_entry(m, metric_list, nd) {
-		if (!m->group_events && !m->modifier) {
-			hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
-				dup = strdup(cur->pkey);
-				if (!dup) {
-					ret = -ENOMEM;
-					goto err_out;
-				}
-				ret = expr__add_id(*combined, dup);
-				if (ret)
-					goto err_out;
-			}
-		}
-	}
-	return 0;
-err_out:
-	expr__ctx_free(*combined);
-	*combined = NULL;
-	return ret;
-}
-
 /**
  * parse_ids - Build the event string for the ids and parse them creating an
  *             evlist. The encoded metric_ids are decoded.
- * @metric_no_merge: is metric sharing explicitly disabled.
  * @fake_pmu: use a fake PMU when testing metrics not supported by the current CPU.
  * @ids: the event identifiers parsed from a metric.
  * @modifier: any modifiers added to the events.
  * @group_events: should events be placed in a weak group.
- * @tool_events: entries set true if the tool event of index could be present in
- *               the overall list of metrics.
  * @out_evlist: the created list of events.
+ * @filter_pmu: only parse events of this PMU, or NULL for all PMUs.
+ * @cputype_filter: is @filter_pmu from --cputype.
  */
-static int parse_ids(bool metric_no_merge, bool fake_pmu,
-		     struct expr_parse_ctx *ids, const char *modifier,
-		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
-		     struct evlist **out_evlist,
-		     const char *filter_pmu,
-		     bool cputype_filter)
+static int parse_ids(bool fake_pmu, struct expr_parse_ctx *ids, const char *modifier,
+		     bool group_events, struct evlist **out_evlist,
+		     const char *filter_pmu, bool cputype_filter)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1425,39 +1870,18 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	int ret;
 
 	*out_evlist = NULL;
-	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
-		bool added_event = false;
-		int i;
+	if (hashmap__size(ids->ids) == 0) {
 		/*
-		 * We may fail to share events between metrics because a tool
-		 * event isn't present in one metric. For example, a ratio of
-		 * cache misses doesn't need duration_time but the same events
-		 * may be used for a misses per second. Events without sharing
-		 * implies multiplexing, that is best avoided, so place
-		 * all tool events in every group.
-		 *
-		 * Also, there may be no ids/events in the expression parsing
-		 * context because of constant evaluation, e.g.:
+		 * There may be no ids/events in the expression parsing context
+		 * because of constant evaluation, e.g.:
 		 *    event1 if #smt_on else 0
 		 * Add a tool event to avoid a parse error on an empty string.
 		 */
-		tool_pmu__for_each_event(i) {
-			if (tool_events[i]) {
-				char *tmp = strdup(tool_pmu__event_to_str(i));
-
-				if (!tmp)
-					return -ENOMEM;
-				ids__insert(ids->ids, tmp);
-				added_event = true;
-			}
-		}
-		if (!added_event && hashmap__size(ids->ids) == 0) {
-			char *tmp = strdup("duration_time");
+		char *tmp = strdup("duration_time");
 
-			if (!tmp)
-				return -ENOMEM;
-			ids__insert(ids->ids, tmp);
-		}
+		if (!tmp)
+			return -ENOMEM;
+		ids__insert(ids->ids, tmp);
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
 					      group_events);
@@ -1546,6 +1970,336 @@ static struct evsel *pick_display_evsel(struct list_head *metric_list,
 	return selected;
 }
 
+/* Find @evsel in @own and return its replacement in @map, or itself if none. */
+static struct evsel *own_evsel__mapped(struct evsel **own, struct evsel **map, int nr,
+				       struct evsel *evsel)
+{
+	for (int i = 0; i < nr; i++) {
+		if (own[i] == evsel)
+			return map[i] ?: evsel;
+	}
+	return evsel;
+}
+
+/* Add @evsel to the end of the group in @evlist led by @leader. */
+static void evlist__add_to_group(struct evlist *evlist, struct evsel *leader,
+				 struct evsel *evsel)
+{
+	struct evsel *pos, *last = leader;
+
+	for_each_group_evsel(pos, leader)
+		last = pos;
+
+	evlist__add(evlist, evsel);
+	if (list_empty(&evsel->core.node))
+		return;
+
+	evsel__set_leader(evsel, leader);
+	evsel->core.nr_members = 0;
+	if (leader->core.nr_members < 1)
+		leader->core.nr_members = 1;
+	leader->core.nr_members++;
+
+	if (list_next_entry(last, core.node) != evsel) {
+		int idx = 0;
+
+		list_move(&evsel->core.node, &last->core.node);
+		evlist__for_each_entry(evlist, pos) {
+			pos->core.idx = idx++;
+			pos->tracking = !pos->core.idx;
+		}
+	}
+}
+
+/*
+ * Match a group created for arch_evsel__must_be_in_group() events, such as x86
+ * topdown slots and perf-metrics events, to an existing such group, marking any
+ * new members to be appended to it so ungrouped topdown metrics share one group.
+ */
+static void metric__match_forced_group(struct evsel_matcher *matcher, struct evsel *ev,
+				       struct evsel **own, struct evsel **map,
+				       struct evsel **extend_leader, int nr, int start)
+{
+	int metric_sources;
+	const struct evsel *mapped_leader;
+	struct evsel *pos_leader;
+
+	own_evsel__metric_match_info(own, map, nr, ev, &metric_sources, &mapped_leader);
+	pos_leader = evsel_matcher__find_for_metric(matcher, ev, /*leader=*/NULL,
+						    metric_sources, mapped_leader,
+						    /*forced_group_leader=*/true);
+	if (!pos_leader)
+		return;
+
+	map[start] = pos_leader;
+	for (int j = start + 1; j < nr && evsel__leader(own[j]) == ev; j++) {
+		own_evsel__metric_match_info(own, map, nr, own[j],
+					     &metric_sources, &mapped_leader);
+		map[j] = evsel_matcher__find_for_metric(matcher, own[j], pos_leader,
+							metric_sources, mapped_leader,
+							/*forced_group_leader=*/false);
+		if (map[j])
+			continue;
+		if (evsel_matcher__find(matcher, own[j], pos_leader)) {
+			for (int k = start; k < j; k++) {
+				map[k] = NULL;
+				extend_leader[k] = NULL;
+			}
+			return;
+		}
+		extend_leader[j] = pos_leader;
+	}
+}
+
+/* Match an ungrouped event (and any multi-PMU siblings) to an earlier event of this metric. */
+static bool metric__match_ungrouped_intra(struct evsel_matcher *matcher, struct evsel **own,
+					  struct evsel **map, struct evsel **extend_leader,
+					  int nr, int idx)
+{
+	struct evsel *ev = own[idx];
+	const struct evsel *mapped_leader;
+	struct evsel *cand;
+	int metric_sources;
+
+	if (!evsel__is_group_leader(ev) || ev->core.nr_members > 1 ||
+	    (ev->metric_leader && ev->metric_leader != ev))
+		return false;
+
+	own_evsel__metric_match_info(own, map, nr, ev, &metric_sources, &mapped_leader);
+	cand = evsel_matcher__find_for_metric(matcher, ev, /*leader=*/NULL,
+					      metric_sources, mapped_leader,
+					      /*forced_group_leader=*/false);
+	if (!cand)
+		return false;
+
+	for (int j = idx + 1; metric_sources > 1 && j < nr; j++) {
+		if (own[j]->metric_leader != ev)
+			continue;
+		if (map[j] || extend_leader[j] || !evsel__is_group_leader(own[j]) ||
+		    own[j]->core.nr_members > 1 ||
+		    !evsel_matcher__find_for_metric(matcher, own[j], /*leader=*/NULL,
+						    metric_sources, cand,
+						    /*forced_group_leader=*/false))
+			return false;
+	}
+
+	map[idx] = cand;
+	for (int j = idx + 1; metric_sources > 1 && j < nr; j++) {
+		if (own[j]->metric_leader == ev) {
+			map[j] = evsel_matcher__find_for_metric(matcher, own[j], /*leader=*/NULL,
+								metric_sources, cand,
+								/*forced_group_leader=*/false);
+		}
+	}
+	return true;
+}
+
+/**
+ * metric__adopt_events - Move the events parsed for @m to @perf_evlist.
+ * @m: The metric whose events, in m->evlist, are moved.
+ * @perf_evlist: The evlist the metric's events are added to.
+ * @matcher: If not NULL, a matcher of the events of @perf_evlist. An event of
+ *           @perf_evlist counting the same thing as an event of the metric,
+ *           such as from an earlier metric, an earlier metric group or the
+ *           command line, is used instead of the metric's event. A group of
+ *           the metric is only replaced if all of its events are found in one
+ *           group of @perf_evlist, unless grouping was only forced by the
+ *           architecture (e.g. x86 topdown perf-metrics), in which case new
+ *           members are added to the existing forced group.
+ *
+ * The metric's metric_events, and the metric leaders of the events, are
+ * updated to refer to the events used in @perf_evlist.
+ */
+static int metric__adopt_events(struct metric *m, struct evlist *perf_evlist,
+				struct evsel_matcher *matcher)
+{
+	int nr = evlist__nr_entries(m->evlist);
+	struct evsel **own, **map, **extend_leader;
+	struct evsel *ev;
+	bool changed;
+	int i = 0, j, ret = 0;
+
+	if (!nr)
+		return 0;
+
+	own = calloc(nr, sizeof(*own));
+	map = calloc(nr, sizeof(*map));
+	extend_leader = calloc(nr, sizeof(*extend_leader));
+	if (!own || !map || !extend_leader) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	evlist__for_each_entry(m->evlist, ev)
+		own[i++] = ev;
+
+	for (i = 0; matcher && i < nr; i++) {
+		int metric_sources;
+		const struct evsel *mapped_leader;
+
+		ev = own[i];
+		if (!evsel__is_group_leader(ev))
+			continue;
+
+		if (ev->core.nr_members > 1) {
+			if (!evsel_matcher__find_group(matcher, ev, own, map, nr, &map[i]) &&
+			    !m->group_events && evsel__is_forced_group(ev)) {
+				metric__match_forced_group(matcher, ev, own, map,
+							   extend_leader, nr, i);
+			}
+		} else {
+			own_evsel__metric_match_info(own, map, nr, ev,
+						     &metric_sources, &mapped_leader);
+			map[i] = evsel_matcher__find_for_metric(matcher, ev, /*leader=*/NULL,
+								metric_sources, mapped_leader,
+								/*forced_group_leader=*/false);
+		}
+	}
+
+	/*
+	 * All events sharing a metric_leader across PMUs must either be
+	 * replaced together or kept together so metric_leader and source_count
+	 * remain consistent.
+	 */
+	do {
+		changed = false;
+		for (i = 0; i < nr; i++) {
+			struct evsel *ml = own[i]->metric_leader;
+			int l_idx = -1;
+
+			if (!ml || ml == own[i])
+				continue;
+			for (j = 0; j < nr; j++) {
+				if (own[j] == ml) {
+					l_idx = j;
+					break;
+				}
+			}
+			if (l_idx < 0 || !map[i] == !map[l_idx])
+				continue;
+			for (j = 0; j < nr; j++) {
+				struct evsel *grp;
+
+				if (own[j]->metric_leader != ml)
+					continue;
+				grp = evsel__leader(own[j]);
+				for (int k = 0; k < nr; k++) {
+					if (evsel__leader(own[k]) == grp &&
+					    (map[k] || extend_leader[k])) {
+						map[k] = NULL;
+						extend_leader[k] = NULL;
+						changed = true;
+					}
+				}
+			}
+		}
+	} while (changed);
+
+	/* Move the events not replaced, making them available to match. */
+	for (i = 0; i < nr; i++) {
+		if (map[i])
+			continue;
+		if (matcher && extend_leader[i]) {
+			int metric_sources;
+			const struct evsel *mapped_leader;
+
+			own_evsel__metric_match_info(own, map, nr, own[i],
+						     &metric_sources, &mapped_leader);
+			map[i] = evsel_matcher__find_for_metric(matcher, own[i], extend_leader[i],
+								metric_sources, mapped_leader,
+								/*forced_group_leader=*/false);
+			if (map[i]) {
+				extend_leader[i] = NULL;
+				continue;
+			}
+		} else if (matcher &&
+			   metric__match_ungrouped_intra(matcher, own, map, extend_leader, nr, i)) {
+			continue;
+		}
+		evlist__remove(m->evlist, own[i]);
+		if (extend_leader[i])
+			evlist__add_to_group(perf_evlist, extend_leader[i], own[i]);
+		else
+			evlist__add(perf_evlist, own[i]);
+		if (matcher && !list_empty(&own[i]->core.node)) {
+			ret = evsel_matcher__add(matcher, own[i]);
+			if (ret)
+				goto out;
+		}
+	}
+
+	/*
+	 * Update first_wildcard_match on kept events if the first match was
+	 * replaced and will be freed.
+	 */
+	for (i = 0; i < nr; i++) {
+		struct evsel *fwm = own[i]->first_wildcard_match;
+
+		if (map[i] || !fwm)
+			continue;
+		if (own_evsel__mapped(own, map, nr, fwm) == fwm)
+			continue;
+		own[i]->first_wildcard_match = NULL;
+		for (j = i + 1; j < nr; j++) {
+			if (own[j]->first_wildcard_match == fwm)
+				own[j]->first_wildcard_match = own[i];
+		}
+	}
+
+	/* Fix up the metric ids and metric leaders of the events. */
+	for (i = 0; i < nr; i++) {
+		struct evsel *leader = own[i]->metric_leader;
+
+		if (leader)
+			leader = own_evsel__mapped(own, map, nr, leader);
+		if (!map[i]) {
+			own[i]->metric_leader = leader;
+			continue;
+		}
+		pr_debug("Using event %s for metric %s's event %s\n",
+			 evsel__name(map[i]), m->metric_name, evsel__name(own[i]));
+		ret = evsel__copy_metric_ids(map[i], own[i]);
+		if (ret)
+			goto out;
+		if (own[i]->collect_stat)
+			map[i]->collect_stat = true;
+		if (leader && !map[i]->metric_leader)
+			map[i]->metric_leader = leader;
+	}
+
+	/*
+	 * Different events of the metric may be replaced by the same event,
+	 * whose metric ids are those of both. Only keep the first so the
+	 * event's value isn't counted more than once.
+	 */
+	for (i = 0, j = 0; m->metric_events[i]; i++) {
+		struct evsel *mapped = own_evsel__mapped(own, map, nr, m->metric_events[i]);
+		bool dup = false;
+
+		for (int k = 0; k < j; k++) {
+			if (m->metric_events[k] == mapped) {
+				dup = true;
+				break;
+			}
+		}
+		if (!dup)
+			m->metric_events[j++] = mapped;
+	}
+	m->metric_events[j] = NULL;
+
+	/* Free the replaced events. */
+	for (i = 0; i < nr; i++) {
+		if (map[i]) {
+			evlist__remove(m->evlist, own[i]);
+			evsel__put(own[i]);
+		}
+	}
+out:
+	free(own);
+	free(map);
+	free(extend_leader);
+	return ret;
+}
+
 static int parse_groups(struct evlist *perf_evlist,
 			const char *pmu, bool cputype_filter, const char *str,
 			bool metric_no_group,
@@ -1557,13 +2311,21 @@ static int parse_groups(struct evlist *perf_evlist,
 			const struct pmu_metrics_table *table)
 {
 	struct perf_pmus *pmus = perf_env__pmus(evlist__env(perf_evlist) ?: host_env());
-	struct evlist *combined_evlist = NULL;
+	struct evsel_matcher matcher;
 	LIST_HEAD(metric_list);
 	struct metric *m;
-	bool tool_events[TOOL_PMU__EVENT_MAX] = {false};
 	bool is_default = !strcmp(str, "Default");
+	const char *filter_pmu = (pmu && strcmp(pmu, "all") == 0) ? NULL : pmu;
 	int ret;
 
+	/*
+	 * Unless sharing is disabled, metrics use the events of other metrics,
+	 * and those already in perf_evlist, that count the same thing.
+	 */
+	ret = evsel_matcher__init(&matcher, perf_evlist);
+	if (ret)
+		goto out;
+
 	ret = metricgroup__add_metric_list(pmus, pmu, str, metric_no_group, metric_no_threshold,
 					   user_requested_cpu_list,
 					   system_wide, fake_pmu,
@@ -1571,28 +2333,27 @@ static int parse_groups(struct evlist *perf_evlist,
 	if (ret)
 		goto out;
 
-	/* Sort metrics from largest to smallest. */
+	/*
+	 * Sort metrics from largest to smallest so that the groups of smaller
+	 * metrics can be found within the groups of larger ones.
+	 */
 	list_sort(NULL, &metric_list, metric_list_cmp);
 
-	if (!metric_no_merge) {
-		struct expr_parse_ctx *combined = NULL;
-
-		find_tool_events(&metric_list, tool_events);
-
-		ret = build_combined_expr_ctx(&metric_list, &combined);
+	list_for_each_entry(m, &metric_list, nd) {
+		ret = parse_ids(fake_pmu, m->pctx, m->modifier, m->group_events, &m->evlist,
+				filter_pmu, cputype_filter);
+		if (ret)
+			goto out;
 
-		if (!ret && combined && hashmap__size(combined->ids)) {
-			ret = parse_ids(metric_no_merge, fake_pmu, combined,
-					/*modifier=*/NULL,
-					/*group_events=*/false,
-					tool_events,
-					&combined_evlist,
-					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
-					cputype_filter);
+		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
+					  m->evlist, &m->metric_events);
+		if (ret) {
+			pr_err("Cannot resolve IDs for %s: %s\n",
+				m->metric_name, m->metric_expr);
+			goto out;
 		}
-		if (combined)
-			expr__ctx_free(combined);
 
+		ret = metric__adopt_events(m, perf_evlist, metric_no_merge ? NULL : &matcher);
 		if (ret)
 			goto out;
 	}
@@ -1602,71 +2363,19 @@ static int parse_groups(struct evlist *perf_evlist,
 
 	list_for_each_entry(m, &metric_list, nd) {
 		struct metric_event *me;
-		struct evsel **metric_events;
-		struct evlist *metric_evlist = NULL;
-		struct metric *n;
 		struct metric_expr *expr;
 
-		if (combined_evlist && !m->group_events) {
-			metric_evlist = combined_evlist;
-		} else if (!metric_no_merge) {
-			/*
-			 * See if the IDs for this metric are a subset of an
-			 * earlier metric.
-			 */
-			list_for_each_entry(n, &metric_list, nd) {
-				if (m == n)
-					break;
-
-				if (n->evlist == NULL)
-					continue;
-
-				if ((!m->modifier && n->modifier) ||
-				    (m->modifier && !n->modifier) ||
-				    (m->modifier && n->modifier &&
-					    strcmp(m->modifier, n->modifier)))
-					continue;
-
-				if ((!m->pmu && n->pmu) ||
-				    (m->pmu && !n->pmu) ||
-				    (m->pmu && n->pmu && strcmp(m->pmu, n->pmu)))
-					continue;
-
-				if (expr__subset_of_ids(n->pctx, m->pctx)) {
-					pr_debug("Events in '%s' fully contained within '%s'\n",
-						 m->metric_name, n->metric_name);
-					metric_evlist = n->evlist;
-					break;
-				}
-
-			}
-		}
-		if (!metric_evlist) {
-			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
-					m->group_events, tool_events, &m->evlist,
-					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
-					cputype_filter);
-			if (ret)
-				goto out;
-
-			metric_evlist = m->evlist;
-		}
-		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
-					  metric_evlist, &metric_events);
-		if (ret) {
-			pr_err("Cannot resolve IDs for %s: %s\n",
-				m->metric_name, m->metric_expr);
-			goto out;
-		}
-
 		me = metricgroup__lookup(evlist__metric_events(perf_evlist),
-					 pick_display_evsel(&metric_list, metric_events),
+					 pick_display_evsel(&metric_list, m->metric_events),
 					 /*create=*/true);
+		if (!me) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		expr = malloc(sizeof(struct metric_expr));
 		if (!expr) {
 			ret = -ENOMEM;
-			free(metric_events);
 			goto out;
 		}
 
@@ -1685,44 +2394,32 @@ static int parse_groups(struct evlist *perf_evlist,
 
 		if (!expr->metric_name) {
 			ret = -ENOMEM;
+			free(expr->metric_refs);
 			free(expr);
-			free(metric_events);
 			goto out;
 		}
 		if (m->default_show_events) {
 			struct evsel *pos;
 
-			for (int i = 0; metric_events[i]; i++)
-				metric_events[i]->default_show_events = true;
-			evlist__for_each_entry(metric_evlist, pos) {
+			for (int i = 0; m->metric_events[i]; i++)
+				m->metric_events[i]->default_show_events = true;
+			evlist__for_each_entry(perf_evlist, pos) {
 				if (pos->metric_leader && pos->metric_leader->default_show_events)
 					pos->default_show_events = true;
 			}
 		}
 		expr->metric_threshold = m->metric_threshold;
 		expr->metric_unit = m->metric_unit;
-		expr->metric_events = metric_events;
+		expr->metric_events = m->metric_events;
+		m->metric_events = NULL;
 		expr->runtime = m->pctx->sctx.runtime;
 		expr->default_metricgroup_name = m->default_metricgroup_name;
 		me->is_default = is_default;
 		list_add(&expr->nd, &me->head);
 	}
 
-
-	if (combined_evlist) {
-		evlist__splice_list_tail(perf_evlist, &evlist__core(combined_evlist)->entries);
-		evlist__put(combined_evlist);
-		combined_evlist = NULL;
-	}
-
-	list_for_each_entry(m, &metric_list, nd) {
-		if (m->evlist)
-			evlist__splice_list_tail(perf_evlist, &evlist__core(m->evlist)->entries);
-	}
-
 out:
-	if (combined_evlist)
-		evlist__put(combined_evlist);
+	evsel_matcher__exit(&matcher);
 	metricgroup__free_metrics(&metric_list);
 	return ret;
 }
-- 
2.56.1.703.gf848ed807c-goog

