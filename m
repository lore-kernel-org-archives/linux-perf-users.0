Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749560;
	b=HgpIJLfV3b8V94cJ1b1Gwpnycfokvb5q+UzSB522StQbl+NmsmZpqJXhWE056LhtXxro
	 Q3ZYrzwJGB3Ddnd/vsSBQax8yrVCQ0Ds9hW4ErczWm8e/aCghfv7zzTllmCCvYDWADSv9
	 qj+Ee3VpDOD78PC6V7h5zItzjOHsw/Q1gCEc8dxzC+aTKWN5VJkm0dTccCpI2gW+PEVHv
	 13Bzs03W6MkOgymwW/wacwj2AWbJf/H2Mmovu/oek51cgM1YX02t9DjWxu2skDO1DKF6B
	 k/buvyzVJAvhpcIufFgBEAjlAT6V/qKsypSZwES5j8/QrDjAU46W/uliSin6Zn61p2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gDHFQmHLZ+icWgBCuGmjta80dJ2DTwcSijPYwttAH4s=;
	b=Bdo8m7R6sT6qpvdX5jY0Oacd27SI97icjAApRSztO2lQ34L8EJq8XufH76oYCg0j6STy
	 +SyHR/PxOj8dajO2Fdd9f3JzZ9JWaZrZMf1dMvgoK+azw21snH7qCmWcNlTrcL4Jm4JdP
	 apIvwshqUKJy4CGUOyPo0XLPeWeVI+tZKE9i97egWTA7osoiU0qHQFOalUnfXJmoBMdoT
	 Hv+/YCnRe7T/Dx8VsTpCTc9DIHyECE7CGafPWixEclr8zbWoPIgFvZ8/GSN2texYFuEgY
	 OeIl90lxjUC5ucGl/H4eKiuW3ox6htfEF95EaM99FxvCkj4nic2Y8WElhphAhfZqZRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JS9efY4x;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3BA6082BC7
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C3BA6082BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JS9efY4x
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e987ec84afso989525ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749559; x=1794354359; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gDHFQmHLZ+icWgBCuGmjta80dJ2DTwcSijPYwttAH4s=;
        b=JS9efY4xg2Tm/v8iM0gRgLxOzKdSj7KGeZYLXjtWy/wU3lyFRuwLm2utCQtGJL7pMK
         8jD+5PPPILG4cpwO0oSvvUBNkAa2V7vdl44o/1JE/0luYHRPPtavW+32sfLRJ4MCUzHf
         whNFW0vp9UVZYZudc4zn+CzifTruRmR1esS1XCKANazXqg4Uz9FkvyZ/dKUj45DdNxR4
         QjprnZOy53GsomWXXS4Btjh9EzdkNl1rQa2mC7wNs37iTltkfO0R1B+H6ia/HlFuft1Q
         HsVV7PL+sSJOmRR4w5hybSdlI6D/xfX8Y77KlTVQgPhgwMBukMDdHGbilvvdYMAkJaYp
         x9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749559; x=1794354359;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDHFQmHLZ+icWgBCuGmjta80dJ2DTwcSijPYwttAH4s=;
        b=XpBOLXVv1J7yqQfB1vFvta+51gytZpLa98BMGAnvvyvSki7xzioINSVT+b/HuQetu4
         4YnnGCNrfUjs3fMv78CfS7JuHfiucyq83ztXT1zJwnMS2+8Gh4v6wN4EDFMC+LHYgpyw
         8S5HoIL4KuID17HgyHH/x9+vG53sUmytRDuskQu8BXLj7Vimjt7vGBWBa+C7O7UQwIJy
         yCPm/jP5VKV29skeRBPUcZOlGglue2MZUUzmalelyL9q072AUM5Dz3XxYE16rn0+I0Ri
         WICgKBrfWK1Og3q5qqGG9eWezeKQIJPRzJ7EqlvPR7W6f3/pLabvGWEGQ7ZlxmWLQAek
         ZfSQ==
X-Gm-Message-State: APuU4Z/QOhP28hVQsQUSpgBdozE/6jZ1s7B49rdfxo8wilCFFqXhZAzf
	lY+/Xrk1Lj/lz0z1eDeUU2mhIqr+G8E3a7bHm9dyQbuf8wsv/kShOU2KCJmTl0w8g9vWqx6Lk+Q
	hBLTDAuapvGoO7+ebDiv1O8VaXaFa/ff++ysjNCZHiDGifdirweuesQp8S0sfa4Apo/CR9Juc7K
	cnYKLDBXEA4ISaLgbE0wubQEf7DfUTpQ2r/VwjqcYAHOCuWMLtiPI4ESA=
X-Received: from plbki14.prod.google.com ([2002:a17:903:68e:b0:2ea:44fa:2c44])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1209:b0:2e9:787c:8e68
 with SMTP id d9443c01a7336-2eb36298ae5mr126400265ad.0.1793749558344; Tue, 03
 Nov 2026 15:45:58 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:35 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-20-irogers@google.com>
Subject: [PATCH v1 19/41] perf metricgroup: Improve matching of metrics to
 recorded events
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Matching metrics to the events of a perf.data file compared only the
perf_event_attr type and config of events, which failed for common
cases:

 - Legacy hardware events, such as "cycles" with "perf record -e
   cycles", didn't match the sysfs event, such as "cpu_core/cpu-cycles/",
   that metrics are parsed to. Compare events with a key of the PMU name,
   counter encoding and exclude modifiers, converting legacy hardware
   events of core PMUs to the equivalent sysfs event's encoding.

 - A recorded event could be used by only one metric leader, as metrics
   set the event's metric_leader and later metrics with a different
   leader were skipped. Instead attach a copy of each metric expression
   to the recorded event of each PMU the metric applies to, adding the
   metric's event identifiers to the matched recorded evsels.

 - When the same counter was recorded more than once, such as for the
   default metrics of perf stat in different groups, the first was
   matched. Prefer a supported event with the same name, counts, and
   group membership.

Also avoid adding duplicate metrics and avoid event grouping warnings
when parsing the metrics. Metrics of a single event are kept as they
may usefully scale the event, for example from cache lines to bytes.

For example, on an Alder Lake system with legacy cycles and instructions
events recorded:

  $ perf record -e '{cycles,instructions}:S' -a sleep 1
  $ perf script -vv -F comm,metric 2>&1 | grep "Found metric" | \
    sed 's/ whose.*//' | sort | uniq
  Found metric 'insn_per_cycle'
  Found metric 'tma_info_core_cpi'
  Found metric 'tma_info_core_ipc'
  Found metric 'tma_info_inst_mix_instructions'
  Found metric 'tma_info_system_mux'
  Found metric 'tma_info_thread_clks'
  Found metric 'tma_info_thread_cpi'
  Found metric 'tma_info_thread_ipc'

where the json metrics use sysfs and json encodings of the events, such
as cpu_core/INST_RETIRED.ANY/, that now match the recorded legacy
events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 644 ++++++++++++++++++++++++++++------
 tools/perf/util/metricgroup.h |   5 +-
 2 files changed, 547 insertions(+), 102 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e87da791fd1e..90d22c67bfae 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -8,10 +8,13 @@
 #include "metricgroup.h"
 #include "debug.h"
 #include "evlist.h"
+#include "env.h"
 #include "evsel.h"
+#include "counts.h"
 #include "strbuf.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "parse-events.h"
 #include "print-events.h"
 #include "smt.h"
 #include "tool_pmu.h"
@@ -87,18 +90,24 @@ static struct rb_node *metric_event_new(struct rblist *rblist __maybe_unused,
 	return &me->nd;
 }
 
+static void metric_expr__delete(struct metric_expr *expr)
+{
+	if (!expr)
+		return;
+	zfree(&expr->metric_name);
+	zfree(&expr->metric_refs);
+	zfree(&expr->metric_events);
+	free(expr);
+}
+
 static void metric_event_delete(struct rblist *rblist __maybe_unused,
 				struct rb_node *rb_node)
 {
 	struct metric_event *me = container_of(rb_node, struct metric_event, nd);
 	struct metric_expr *expr, *tmp;
 
-	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
-		zfree(&expr->metric_name);
-		zfree(&expr->metric_refs);
-		zfree(&expr->metric_events);
-		free(expr);
-	}
+	list_for_each_entry_safe(expr, tmp, &me->head, nd)
+		metric_expr__delete(expr);
 
 	free(me);
 }
@@ -379,6 +388,9 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 * metric_events.
 		 */
 		evlist__for_each_entry_continue(metric_evlist, ev) {
+			if (!all_pmus && ev->pmu && evsel__is_hybrid(ev) &&
+			    strcmp(ev->pmu->name, pmu))
+				continue;
 			if (evsel__shares_metric_id(ev, metric_events[i]))
 				ev->metric_leader = metric_events[i];
 		}
@@ -471,151 +483,581 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
 	return pmu_for_each_sys_metric(metricgroup__sys_event_iter, &sys_data);
 }
 
+/*
+ * A key identifying the counter an evsel programs, used to match evsels parsed
+ * from a metric with those read from a perf.data file.
+ */
+struct counter_key {
+	/** @pmu_name: Name of the evsel's PMU, or NULL if unknown. */
+	const char *pmu_name;
+	/** @type: perf_event_attr type, PERF_TYPE_RAW for any dynamic PMU type. */
+	__u32 type;
+	/** @config: perf_event_attr config without legacy extended type bits. */
+	__u64 config;
+	/** @config1: perf_event_attr config1. */
+	__u64 config1;
+	/** @config2: perf_event_attr config2. */
+	__u64 config2;
+	/** @exclude: perf_event_attr exclude bits, a mask of COUNTER_KEY_EXCLUDE_*. */
+	unsigned int exclude;
+};
+
+#define COUNTER_KEY_EXCLUDE_USER	BIT(0)
+#define COUNTER_KEY_EXCLUDE_KERNEL	BIT(1)
+#define COUNTER_KEY_EXCLUDE_HV		BIT(2)
+#define COUNTER_KEY_EXCLUDE_HOST	BIT(3)
+#define COUNTER_KEY_EXCLUDE_GUEST	BIT(4)
+#define COUNTER_KEY_EXCLUDE_PRIV	(COUNTER_KEY_EXCLUDE_USER | COUNTER_KEY_EXCLUDE_KERNEL | \
+					 COUNTER_KEY_EXCLUDE_HV)
+
+/* Cached sysfs encodings of legacy hardware events on a PMU. */
+struct legacy_hw_key {
+	struct list_head list;
+	char *pmu_name;
+	__u64 hw_config;
+	struct counter_key key;
+};
+
 struct find_matching_metrics_args {
 	struct evlist *evlist;
+	/** @keys: Counter keys of evlist's evsels, indexed by evsel->core.idx. */
+	struct counter_key *keys;
+	/** @nr_keys: Number of entries in keys. */
+	int nr_keys;
+	/** @legacy_hw_keys: Cache of legacy_hw_key. */
+	struct list_head legacy_hw_keys;
 	bool system_wide;
 };
 
-static struct evsel *map_metric_evsel_to_evlist(struct evlist *data_evlist,
+static void counter_key__init_attr(struct counter_key *key, const char *pmu_name,
+				   const struct perf_event_attr *attr)
+{
+	key->pmu_name = pmu_name;
+	key->type = attr->type;
+	key->config = attr->config;
+	key->config1 = attr->config1;
+	key->config2 = attr->config2;
+	key->exclude = (attr->exclude_user ? COUNTER_KEY_EXCLUDE_USER : 0) |
+		       (attr->exclude_kernel ? COUNTER_KEY_EXCLUDE_KERNEL : 0) |
+		       (attr->exclude_hv ? COUNTER_KEY_EXCLUDE_HV : 0) |
+		       (attr->exclude_host ? COUNTER_KEY_EXCLUDE_HOST : 0) |
+		       (attr->exclude_guest ? COUNTER_KEY_EXCLUDE_GUEST : 0);
+	if (attr->type == PERF_TYPE_HARDWARE || attr->type == PERF_TYPE_HW_CACHE)
+		key->config &= PERF_HW_EVENT_MASK;
+	else if (attr->type >= PERF_TYPE_MAX)
+		key->type = PERF_TYPE_RAW;
+}
+
+/* Copy the counter encoding, but not the PMU name or modifiers, of @src. */
+static void counter_key__set_counter(struct counter_key *key, const struct counter_key *src)
+{
+	key->type = src->type;
+	key->config = src->config;
+	key->config1 = src->config1;
+	key->config2 = src->config2;
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
+static bool legacy_hw_key(struct find_matching_metrics_args *args, const char *pmu_name,
+			  __u64 hw_config, struct counter_key *key)
+{
+	struct legacy_hw_key *pos;
+	struct legacy_hw_name_args name_args;
+	struct perf_pmu *pmu;
+
+	list_for_each_entry(pos, &args->legacy_hw_keys, list) {
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
+	list_add(&pos->list, &args->legacy_hw_keys);
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
+static void evsel__counter_key(struct find_matching_metrics_args *args, struct evsel *evsel,
+			       struct counter_key *key)
+{
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	counter_key__init_attr(key, pmu ? pmu->name : NULL, &evsel->core.attr);
+	if (key->type == PERF_TYPE_HARDWARE && pmu && pmu->is_core)
+		legacy_hw_key(args, pmu->name, key->config, key);
+}
+
+static bool counter_key__equal(const struct counter_key *a, const struct counter_key *b)
+{
+	unsigned int a_priv, b_priv;
+
+	if (a->type != b->type || a->config != b->config ||
+	    a->config1 != b->config1 || a->config2 != b->config2)
+		return false;
+
+	/*
+	 * If the metric event specified privilege exclusion bits (e.g. :k or
+	 * :u), require the recorded event to match. Otherwise allow matching a
+	 * recorded event whose exclude_kernel/exclude_hv bits were set by
+	 * evsel__fallback() when perf_event_paranoid > 1.
+	 */
+	a_priv = a->exclude & COUNTER_KEY_EXCLUDE_PRIV;
+	b_priv = b->exclude & COUNTER_KEY_EXCLUDE_PRIV;
+	if (a_priv != b_priv && (a_priv != 0 || (b_priv & COUNTER_KEY_EXCLUDE_USER) != 0))
+		return false;
+
+	/*
+	 * Guest only events (:G) must match. A recorded event may count the
+	 * guest, when the metric event doesn't, if exclude_guest was cleared
+	 * by evsel__fallback() for kernels without support for it, but not the
+	 * other way around.
+	 */
+	if ((a->exclude ^ b->exclude) & COUNTER_KEY_EXCLUDE_HOST)
+		return false;
+	if (!(a->exclude & COUNTER_KEY_EXCLUDE_GUEST) && (b->exclude & COUNTER_KEY_EXCLUDE_GUEST))
+		return false;
+
+	if (a->pmu_name && b->pmu_name)
+		return !strcmp(a->pmu_name, b->pmu_name);
+
+	return true;
+}
+
+/* Were any counts read for @evsel, for example, from a perf stat record round? */
+static int evsel__count_score(struct evsel *evsel)
+{
+	int score = 0;
+
+	if (!evsel->counts)
+		return 0;
+
+	for (int cpu_idx = 0; cpu_idx < xyarray__max_x(evsel->counts->values); cpu_idx++) {
+		for (int thread = 0; thread < xyarray__max_y(evsel->counts->values); thread++) {
+			struct perf_counts_values *cnt =
+				perf_counts(evsel->counts, cpu_idx, thread);
+
+			if (cnt->run) {
+				if (cnt->val)
+					return 2;
+				score = 1;
+			}
+		}
+	}
+	return score;
+}
+
+/*
+ * Find the evsel in the data evlist programming the same counter as
+ * @metric_evsel. The same counter may be recorded more than once, such as when
+ * different metrics were measured in different groups. Prefer an evsel with the
+ * same name, as the metric would have been parsed to when recording, and an
+ * evsel with counts, over other evsels.
+ */
+static struct evsel *map_metric_evsel_to_evlist(struct find_matching_metrics_args *args,
 						struct evsel *metric_evsel)
 {
-	struct evsel *data_evsel;
+	struct evsel *data_evsel, *best = NULL;
+	struct counter_key metric_key;
+	bool metric_grouped = evsel__leader(metric_evsel)->core.nr_members > 1;
+	int best_score = -1;
+
+	evsel__counter_key(args, metric_evsel, &metric_key);
+	evlist__for_each_entry(args->evlist, data_evsel) {
+		bool data_grouped;
+		int score;
 
-	evlist__for_each_entry(data_evlist, data_evsel) {
-		/* Skip if perf_event_attr differ. */
-		if (metric_evsel->core.attr.type != data_evsel->core.attr.type)
+		if (!data_evsel->supported)
 			continue;
-		if (metric_evsel->core.attr.config != data_evsel->core.attr.config)
+
+		/* Skip if the evsels don't program the same counter. */
+		if (data_evsel->core.idx >= args->nr_keys ||
+		    !counter_key__equal(&metric_key, &args->keys[data_evsel->core.idx]))
 			continue;
-		return data_evsel;
+
+		data_grouped = evsel__leader(data_evsel)->core.nr_members > 1 ||
+			       (data_evsel->core.attr.read_format & PERF_FORMAT_GROUP);
+		score = (!strcmp(evsel__name(metric_evsel), evsel__name(data_evsel)) ? 16 : 0) +
+			(metric_key.exclude == args->keys[data_evsel->core.idx].exclude ? 8 : 0) +
+			evsel__count_score(data_evsel) * 2 +
+			(metric_grouped == data_grouped ? 1 : 0);
+		if (score > best_score) {
+			best = data_evsel;
+			best_score = score;
+		}
 	}
+	return best;
+}
+
+/*
+ * Find the evsel in @metric_evlist counting @ev, or an event merged with it as
+ * its metric leader, on @pmu.
+ */
+static struct evsel *metric_evsel_on_pmu(struct evlist *metric_evlist, struct evsel *ev,
+					 const struct perf_pmu *pmu)
+{
+	struct evsel *pos;
+
+	if (ev->pmu == pmu)
+		return ev;
+
+	evlist__for_each_entry(metric_evlist, pos) {
+		if (pos->pmu == pmu &&
+		    (pos->metric_leader == ev ||
+		     evsel__shares_metric_id(pos, ev)))
+			return pos;
+	}
+	if (ev->pmu && ev->pmu->is_core && pmu && pmu->is_core)
+		return NULL;
+	return ev;
+}
+
+/*
+ * Copy @expr, whose events are in @metric_evlist, replacing each event with the
+ * corresponding event on @pmu and then with the matching evsel of the data
+ * evlist. The metric identifiers of the events are added to the matched data
+ * evsel as different metrics may refer to the same recorded event by different
+ * names.
+ */
+static struct metric_expr *metric_expr__dup_for_data(struct find_matching_metrics_args *args,
+						     struct evlist *metric_evlist,
+						     const struct metric_expr *expr,
+						     const struct perf_pmu *pmu)
+{
+	struct metric_expr *copy = zalloc(sizeof(*copy));
+	int nr = 0;
+
+	if (!copy)
+		return NULL;
+
+	copy->metric_expr = expr->metric_expr;
+	copy->metric_threshold = expr->metric_threshold;
+	copy->metric_unit = expr->metric_unit;
+	copy->default_metricgroup_name = expr->default_metricgroup_name;
+	copy->runtime = expr->runtime;
+	copy->metric_name = strdup(expr->metric_name);
+	if (!copy->metric_name)
+		goto err;
+
+	if (expr->metric_refs) {
+		int nr_refs = 0;
+
+		while (expr->metric_refs[nr_refs].metric_name)
+			nr_refs++;
+		copy->metric_refs = calloc(nr_refs + 1, sizeof(*copy->metric_refs));
+		if (!copy->metric_refs)
+			goto err;
+		memcpy(copy->metric_refs, expr->metric_refs, nr_refs * sizeof(*copy->metric_refs));
+	}
+
+	while (expr->metric_events[nr])
+		nr++;
+	copy->metric_events = calloc(nr + 1, sizeof(*copy->metric_events));
+	if (!copy->metric_events)
+		goto err;
+
+	for (int i = 0; i < nr; i++) {
+		struct evsel *ev = metric_evsel_on_pmu(metric_evlist, expr->metric_events[i], pmu);
+
+		if (!ev)
+			goto err;
+		copy->metric_events[i] = map_metric_evsel_to_evlist(args, ev);
+		if (!copy->metric_events[i])
+			goto err;
+		if (evsel__copy_metric_ids(copy->metric_events[i], expr->metric_events[i]))
+			goto err;
+		/*
+		 * As in setup_metric_events(), a matched event without a metric
+		 * leader leads itself so that evsel__source_count() counts it.
+		 */
+		if (!copy->metric_events[i]->metric_leader)
+			copy->metric_events[i]->metric_leader = copy->metric_events[i];
+	}
+	return copy;
+err:
+	metric_expr__delete(copy);
 	return NULL;
 }
 
+/* Does @metric_events already contain a metric equivalent to @expr? */
+static bool metric_events__contains(struct rblist *metric_events, const struct metric_expr *expr)
+{
+	for (unsigned int i = 0; i < rblist__nr_entries(metric_events); i++) {
+		struct rb_node *nd = rblist__entry(metric_events, i);
+		struct metric_event *me = container_of(nd, struct metric_event, nd);
+		const struct metric_expr *pos;
+
+		list_for_each_entry(pos, &me->head, nd) {
+			int j;
+
+			if (strcmp(pos->metric_name, expr->metric_name))
+				continue;
+			for (j = 0; pos->metric_events[j] && expr->metric_events[j]; j++) {
+				if (pos->metric_events[j] != expr->metric_events[j])
+					break;
+			}
+			if (!pos->metric_events[j] && !expr->metric_events[j])
+				return true;
+		}
+	}
+	return false;
+}
+
+static int add_matching_metric_evlist(struct find_matching_metrics_args *args,
+				      struct evlist *metric_evlist,
+				      bool default_metricgroup)
+{
+	struct evlist *data_evlist = args->evlist;
+	struct evsel *metric_evsel;
+
+	if (default_metricgroup) {
+		evlist__for_each_entry(metric_evlist, metric_evsel) {
+			if (metric_evsel->default_show_events) {
+				struct evsel *data_evsel =
+					map_metric_evsel_to_evlist(args, metric_evsel);
+
+				if (data_evsel)
+					data_evsel->default_show_events = true;
+			}
+		}
+	}
+
+	/*
+	 * Metric expressions are associated with a metric leader event and
+	 * computed for each PMU of the events led by it. Rather than share
+	 * metric leaders between metrics, which may conflict, attach a copy of
+	 * the expression to each such data event using the data events of its
+	 * PMU.
+	 */
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		struct metric_event *metric_me =
+			metricgroup__lookup(evlist__metric_events(metric_evlist),
+					    metric_evsel,
+					    /*create=*/false);
+		struct metric_expr *expr;
+		struct evsel *pos;
+
+		if (!metric_me || metric_me->evsel != metric_evsel)
+			continue;
+
+		evlist__for_each_entry(metric_evlist, pos) {
+			struct evsel *data_evsel;
+
+			if (pos != metric_evsel &&
+			    (pos->metric_leader != metric_evsel ||
+			     !evsel__shares_metric_id(pos, metric_evsel)))
+				continue;
+
+			data_evsel = map_metric_evsel_to_evlist(args, pos);
+			if (!data_evsel)
+				continue;
+
+			list_for_each_entry(expr, &metric_me->head, nd) {
+				struct metric_event *data_me;
+				struct metric_expr *copy =
+					metric_expr__dup_for_data(args, metric_evlist, expr,
+								  pos->pmu);
+
+				if (!copy)
+					continue;
+				if (metric_events__contains(evlist__metric_events(data_evlist),
+							    copy)) {
+					metric_expr__delete(copy);
+					continue;
+				}
+				data_me = metricgroup__lookup(evlist__metric_events(data_evlist),
+							      data_evsel, /*create=*/true);
+				if (!data_me) {
+					metric_expr__delete(copy);
+					return -ENOMEM;
+				}
+				data_evsel->metric_leader = data_evsel;
+				if (default_metricgroup && metric_me->is_default)
+					data_me->is_default = true;
+				list_add_tail(&copy->nd, &data_me->head);
+				pr_debug("Found metric '%s' whose evsels match those in the perf data\n",
+					 copy->metric_name);
+			}
+		}
+	}
+	return 0;
+}
+
 static int find_matching_metrics_cb(const struct pmu_metric *pm,
 				    const struct pmu_metrics_table *table __maybe_unused,
 				    void *data)
 {
 	struct find_matching_metrics_args *args = data;
-	struct evlist *data_evlist = args->evlist;
 	struct evlist *metric_evlist = evlist__new();
 	struct evsel *metric_evsel;
-	int ret = metricgroup__parse_groups(metric_evlist,
+	int ret;
+
+	if (!metric_evlist)
+		return -ENOMEM;
+
+	evlist__set_session(metric_evlist, evlist__session(args->evlist));
+	/*
+	 * Event grouping doesn't affect the matching and avoids warnings about
+	 * grouping constraints.
+	 */
+	ret = metricgroup__parse_groups(metric_evlist,
 					/*pmu=*/"all",
 					/*cputype_filter=*/false,
 					pm->metric_name,
-					/*metric_no_group=*/false,
+					/*metric_no_group=*/true,
 					/*metric_no_merge=*/false,
 					/*metric_no_threshold=*/true,
 					/*user_requested_cpu_list=*/NULL,
 					args->system_wide,
 					/*hardware_aware_grouping=*/false);
-
 	if (ret) {
 		/* Metric parsing failed but continue the search. */
+		ret = 0;
 		goto out;
 	}
 
-	/*
-	 * Check the data_evlist has an entry for each metric_evlist entry. If
-	 * the data evsel was already set up avoid changing data that may
-	 * break it.
-	 */
+	/* Check the data_evlist has an entry for each metric_evlist entry. */
 	evlist__for_each_entry(metric_evlist, metric_evsel) {
-		struct evsel *data_evsel =
-			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
-		struct evsel *new_metric_leader;
-
-		if (!data_evsel) {
+		if (!map_metric_evsel_to_evlist(args, metric_evsel)) {
 			pr_debug("Skipping metric '%s' as evsel '%s' is missing\n",
-				pm->metric_name, evsel__name(metric_evsel));
-			goto out;
-		}
-
-		if (data_evsel->metric_leader == NULL)
-			continue;
-
-		if (metric_evsel->metric_leader == metric_evsel) {
-			new_metric_leader = data_evsel;
-		} else {
-			new_metric_leader =
-				map_metric_evsel_to_evlist(data_evlist,
-								 metric_evsel->metric_leader);
-		}
-		/* Mismatching evsel leaders. */
-		if (data_evsel->metric_leader != new_metric_leader) {
-			pr_debug("Skipping metric '%s' due to mismatching evsel metric leaders '%s' vs '%s'\n",
-				pm->metric_name, evsel__name(metric_evsel),
-				evsel__name(data_evsel));
+				 pm->metric_name, evsel__name(metric_evsel));
 			goto out;
 		}
 	}
-	/*
-	 * Metric events match those in the data evlist, copy metric evsel
-	 * data into the data evlist.
-	 */
-	evlist__for_each_entry(metric_evlist, metric_evsel) {
-		struct evsel *data_evsel =
-			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
-		struct metric_event *metric_me =
-			metricgroup__lookup(evlist__metric_events(metric_evlist),
-					    metric_evsel,
-					    /*create=*/false);
 
-		if (evsel__copy_metric_ids(data_evsel, metric_evsel))
-			goto out;
+	ret = add_matching_metric_evlist(args, metric_evlist,
+					 /*default_metricgroup=*/false);
+out:
+	evlist__put(metric_evlist);
+	return ret;
+}
 
-		if (data_evsel->metric_leader == NULL) {
-			if (metric_evsel->metric_leader == metric_evsel) {
-				data_evsel->metric_leader = data_evsel;
-			} else {
-				data_evsel->metric_leader =
-					map_metric_evsel_to_evlist(data_evlist,
-								       metric_evsel->metric_leader);
-			}
-		}
+static int find_matching_metrics_args__init(struct find_matching_metrics_args *args,
+					    struct evlist *evlist, bool system_wide)
+{
+	struct evsel *evsel;
+
+	memset(args, 0, sizeof(*args));
+	args->evlist = evlist;
+	args->system_wide = system_wide;
+	INIT_LIST_HEAD(&args->legacy_hw_keys);
+	args->nr_keys = evlist__nr_entries(evlist);
+	args->keys = calloc(args->nr_keys, sizeof(*args->keys));
+	if (!args->keys)
+		return -ENOMEM;
 
-		if (metric_me) {
-			struct metric_expr *expr;
-			struct metric_event *data_me =
-				metricgroup__lookup(evlist__metric_events(data_evlist),
-						    data_evsel,
-						    /*create=*/true);
-
-			if (!data_me) {
-				/*
-				 * As the metric_expr is created, the only
-				 * failure is a lack of memory.
-				 */
-				goto out;
-			}
-			list_splice_init(&metric_me->head, &data_me->head);
-			list_for_each_entry(expr, &data_me->head, nd) {
-				for (int i = 0; expr->metric_events[i]; i++) {
-					expr->metric_events[i] =
-						map_metric_evsel_to_evlist(data_evlist,
-									expr->metric_events[i]);
-				}
-			}
-		}
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.idx < args->nr_keys)
+			evsel__counter_key(args, evsel, &args->keys[evsel->core.idx]);
 	}
-	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
-		 pm->metric_name);
-out:
-	evlist__put(metric_evlist);
 	return 0;
 }
 
+static void find_matching_metrics_args__exit(struct find_matching_metrics_args *args)
+{
+	struct legacy_hw_key *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &args->legacy_hw_keys, list) {
+		list_del(&pos->list);
+		free(pos->pmu_name);
+		free(pos);
+	}
+	zfree(&args->keys);
+}
+
 int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide)
 {
 	struct perf_env *env = evlist__env(evlist) ?: host_env();
-	struct find_matching_metrics_args args = {
-		.evlist = evlist,
-		.system_wide = system_wide,
-	};
+	struct find_matching_metrics_args args;
+	int ret;
+
+	ret = find_matching_metrics_args__init(&args, evlist, system_wide);
+	if (ret)
+		return ret;
+
+	ret = metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
+					   find_matching_metrics_cb, &args);
 
-	return metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
-					    find_matching_metrics_cb, &args);
+	find_matching_metrics_args__exit(&args);
+	return ret;
 }
 
 static int append_metric_id_cb(const char *metric_id, void *data)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 2069211913dc..25398eafd6e2 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -104,7 +104,10 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
  *
  * For every metric whose events all have a corresponding evsel in @evlist,
  * add the metric to the metric events of @evlist so that it is computed and
- * displayed along with the counts of the evsels.
+ * displayed along with the counts of the evsels. Evsels correspond when they
+ * program the same counter on a PMU of the same name, with legacy hardware
+ * events matching the equivalent sysfs event of the PMU. A metric already added
+ * for the same evsels isn't added again.
  *
  * Return: 0 on success or a negative error code.
  */
-- 
2.56.0.385.gac671c819a-goog

