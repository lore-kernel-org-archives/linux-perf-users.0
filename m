Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599689;
	b=0kkvXm0Ur7zMhNgnKrHBrSsr+06Qrom+10ZW6DG0Ji6hB6j0fI/oImieChjrIo6sDK9P
	 ++ClQyQepscU7kjf26avjzwZHUvg3td75aNyAJFVDPbtw+7BE1pWY+8YBk+7gEWtrCCbR
	 zUkN5damOFBrKGxjfNdTiGrbqJeWeVwnfK8PEpjoUOqy4wQNe7s0yFy3RbtEFUUz4DvTu
	 HwVTZ8Vt7ac+3+VeOcgHeUvx+9vZ0SOAXDDouoWDUGhhEt+QB/phvPcHgT7xTC6k8kHsz
	 7Cz4Lz/xSd6NsLydrQytGG0//yTxWy44GtUHPp8qRJryH0+Rrnh7bF1qBtLRHrqSvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zWngNTk2mFhmIx+yfP2aG2VmE1/N90+y6eMS+ylEV6A=;
	b=GnnTtPmXTir4ee7OTdUmMMObkolRtYLGdyPAwWIJjEffrvLaJ8q+gtvJ//Exh/sFLC0A
	 rpo04zdgEidbhy18I/X9WpROqKCk0tYMy/oyAew2tSeBXCnfRVrv2UCgPo3izS0D27GVi
	 +k/7tXElA51Nw69nIX7LGPRK1t16ZOsThr5Bfl1cf8D7LE6VCHxmK8Zw0XOjcgPoDU6tM
	 G4BoYGFgYpMN640BWFd/pYbYRSDoy0sYVbsNKxfacQFPB6OBf8jD24CwbWH0CkrBSb97s
	 PlhUAX7qPGuR8XX47dC9CD5OhCCNTOC7wjZ+9mnNGBfriwvJ6JYo96BB0Mxdl520L3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OLRP2wwp;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E9606D0CA
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E4E9606D0CA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OLRP2wwp
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3724667bc16so815115eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599687; x=1795204487; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWngNTk2mFhmIx+yfP2aG2VmE1/N90+y6eMS+ylEV6A=;
        b=OLRP2wwpv9afSmZPzCD+gqGJEVcCh+mY3T3edqAERNrEXlw5KQGCSLEp3gL/k5JOgb
         OCzuQn3ZV5B4W70YZ3lv67e5xWqEhUPn6SLSFxGAJJXBFXs0LnzUKJC4WKBpxIfRFXvq
         7+13JduDq1tVVFI2a51WnexLD8DGrRmOMavEGtE0xa/3CBaePlglwbOfMm0ZpeZmGLDh
         xxh0qSfNV8sxYYWxv6zx+ceC0mOBS5AThgyjDM8qftfecvB+ohSXEerKXhD+kAdF0Xo+
         Jg7t5stvnrNOfnaB/Jb/BxKgfZZSN1RMJ5Y+KAVbr2c4wpXIkHN89fuqSZ8ZJlZEPnxo
         1M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599687; x=1795204487;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWngNTk2mFhmIx+yfP2aG2VmE1/N90+y6eMS+ylEV6A=;
        b=Lf+5QYtRfmrM4vvfXZY02A3lBERUK6tM8GxbgZ6TlFbOJ50w6EuDX74HSt0G0m6s1T
         6JcY6NvW8SzEZ8P++T7y/xY9ZtJF4/jLVt85adknukagQZwmCAtss5edYLG8jlNtgDfx
         z17NR727nzjBgIXxEz16PMNABVtKySg/rnP6SUBGWHSZGi4efgyRWI+sH/cdPQOoeGK2
         iTOtrDDv1YCzace4ALNGrSPEVW5bEgtsvLB2IfJr7SWxUmF9B9NNQulg/PFGKnwA8JFi
         y6bqubYQ0e+79QExwi9RF8Y8whi1qVhQEZ5BnB9iBeeruKhKMPgXsSz2yXzULhkrud8R
         zzpA==
X-Gm-Message-State: APuU4Z8U2CvqFc/c+Ii9HSX/sMjeBYL0wAuhSi3IblUC7UsuSx/8J/RO
	Lu7CR6pLuSbL1eHCKH5atKC7z+QWGEpuINN0y8mhR+LqFqympLxvw/cqMQKYGL2mCKHPurwZdwb
	biUA1Zv5VaA==
X-Received: from dycnm5.prod.google.com ([2002:a05:7300:d185:b0:35a:c4b6:314b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:83db:10b0:375:6fed:8e71
 with SMTP id 5a478bee46e88-377e093ba7amr5468682eec.7.1794599686984; Fri, 13
 Nov 2026 11:54:46 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:31 -0800
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
Message-ID: <20261113195335.2865725-27-irogers@google.com>
Subject: [PATCH v2 26/30] perf metricgroup: Improve matching of metrics to
 recorded events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Matching metrics to the events of a perf.data file compared only the
perf_event_attr type and config of events, which failed for common
cases:

 - Legacy hardware events, such as "cycles" with "perf record -e
   cycles", didn't match the sysfs event, such as "cpu_core/cpu-cycles/",
   that metrics are parsed to. Use the evsel matcher, as used for metrics
   sharing events, which compares the PMU name and counter encoding,
   converting legacy hardware events of core PMUs to the equivalent
   sysfs event's encoding. Add an EVSEL_MATCH_RECORDED mode to the
   matcher that tolerates the exclusion bits evsel__fallback() may have
   changed when recording, skips unsupported events and prefers events
   with counts.

 - A recorded event could be used by only one metric leader, as metrics
   set the event's metric_leader and later metrics with a different
   leader were skipped. Instead attach a copy of each metric expression
   to the recorded event of each PMU the metric applies to, adding the
   metric's event identifiers to the matched recorded evsels.

 - When the same counter was recorded more than once, such as for the
   default metrics of perf stat in different groups, the first was
   matched. Prefer a supported event with the same name and counts and,
   when the metric's events are grouped, the same group membership, as
   the matcher does.

 - On hybrid systems a metric was skipped unless the events of every
   core PMU were recorded. Add the metric for each PMU whose events were
   all recorded.

Also avoid adding duplicate metrics, avoid counting a recorded event
twice when different metric events match it, and avoid event grouping
warnings when parsing the metrics. Metrics of a single event are kept as
they may usefully scale the event, for example from cache lines to
bytes.

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
 tools/perf/util/metricgroup.c | 583 ++++++++++++++++++++++++++--------
 tools/perf/util/metricgroup.h |   5 +-
 2 files changed, 460 insertions(+), 128 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f4a2b280091c..f41e11a9a3e7 100644
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
@@ -481,12 +490,13 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
 
 /*
  * A key identifying the counter an evsel programs, used to find evsels counting
- * the same thing, such as when metrics share events.
+ * the same thing, such as when metrics share events or when matching evsels
+ * parsed from a metric with those read from a perf.data file.
  */
 struct counter_key {
 	/** @pmu_name: Name of the evsel's PMU, or NULL if unknown. */
 	const char *pmu_name;
-	/** @cgrp: The cgroup the evsel counts. */
+	/** @cgrp: The cgroup the evsel counts, compared by EVSEL_MATCH_LIVE. */
 	const struct cgroup *cgrp;
 	/** @type: perf_event_attr type, PERF_TYPE_RAW for any dynamic PMU type. */
 	__u32 type;
@@ -507,7 +517,7 @@ struct counter_key {
 	 * is counted, a mask of COUNTER_KEY_MOD_*.
 	 */
 	unsigned int modifiers;
-	/** @precise_ip: perf_event_attr precise_ip. */
+	/** @precise_ip: perf_event_attr precise_ip, compared by EVSEL_MATCH_LIVE. */
 	unsigned int precise_ip;
 };
 
@@ -517,6 +527,8 @@ struct counter_key {
 #define COUNTER_KEY_EXCLUDE_HOST	BIT(3)
 #define COUNTER_KEY_EXCLUDE_GUEST	BIT(4)
 #define COUNTER_KEY_EXCLUDE_IDLE	BIT(5)
+#define COUNTER_KEY_EXCLUDE_PRIV	(COUNTER_KEY_EXCLUDE_USER | COUNTER_KEY_EXCLUDE_KERNEL | \
+					 COUNTER_KEY_EXCLUDE_HV)
 
 #define COUNTER_KEY_MOD_PINNED		BIT(0)
 #define COUNTER_KEY_MOD_EXCLUSIVE	BIT(1)
@@ -533,6 +545,21 @@ struct legacy_hw_key {
 	struct counter_key key;
 };
 
+/** enum evsel_match_mode - How strictly evsels must agree to be matched. */
+enum evsel_match_mode {
+	/**
+	 * @EVSEL_MATCH_LIVE: Evsels parsed by this perf command, such as for
+	 * metrics sharing events, must agree on all modifiers.
+	 */
+	EVSEL_MATCH_LIVE,
+	/**
+	 * @EVSEL_MATCH_RECORDED: Evsels read from a perf.data file may have had
+	 * modifiers changed by evsel__fallback() and the counts of the evsels
+	 * are preferred.
+	 */
+	EVSEL_MATCH_RECORDED,
+};
+
 struct evsel_matcher_entry {
 	struct evsel *evsel;
 	struct counter_key key;
@@ -551,6 +578,13 @@ struct evsel_matcher {
 	size_t max_entries;
 	/** @legacy_hw_keys: Cache of legacy_hw_key. */
 	struct list_head legacy_hw_keys;
+	/** @mode: How strictly evsels must agree to be matched. */
+	enum evsel_match_mode mode;
+	/**
+	 * @match_grouping: Prefer evsels whose group membership is the same
+	 * as the evsel being matched.
+	 */
+	bool match_grouping;
 };
 
 static void counter_key__init_attr(struct counter_key *key, const char *pmu_name,
@@ -714,9 +748,12 @@ static void evsel_matcher__key(struct evsel_matcher *matcher, struct evsel *evse
 		legacy_hw_key(matcher, pmu->name, key->config, key);
 }
 
-/* Do @a and @b count the same thing? */
-static bool counter_key__equal(const struct counter_key *a, const struct counter_key *b)
+/* Do @a, from the evsel being matched, and @b count the same thing? */
+static bool counter_key__equal(const struct counter_key *a, const struct counter_key *b,
+			       enum evsel_match_mode mode)
 {
+	unsigned int a_priv, b_priv;
+
 	if (a->type != b->type || a->config != b->config ||
 	    a->config1 != b->config1 || a->config2 != b->config2 ||
 	    a->config3 != b->config3 || a->config4 != b->config4)
@@ -729,8 +766,62 @@ static bool counter_key__equal(const struct counter_key *a, const struct counter
 	if (a->pmu_name && b->pmu_name && strcmp(a->pmu_name, b->pmu_name))
 		return false;
 
-	return a->exclude == b->exclude && a->modifiers == b->modifiers &&
-	       a->precise_ip == b->precise_ip && a->cgrp == b->cgrp;
+	if ((a->modifiers ^ b->modifiers) & COUNTER_KEY_MOD_RETIRE_LAT)
+		return false;
+
+	if (mode == EVSEL_MATCH_LIVE) {
+		return a->exclude == b->exclude && a->modifiers == b->modifiers &&
+		       a->precise_ip == b->precise_ip && a->cgrp == b->cgrp;
+	}
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
+	 * Guest only events (:G) and host only events (:H) must match, except a
+	 * recorded event may exclude the guest when the metric event doesn't if
+	 * exclude_guest was set by evsel__fallback() on EOPNOTSUPP, such as on
+	 * Apple M1.
+	 */
+	if ((a->exclude ^ b->exclude) & COUNTER_KEY_EXCLUDE_HOST)
+		return false;
+	if ((a->exclude & COUNTER_KEY_EXCLUDE_GUEST) && !(b->exclude & COUNTER_KEY_EXCLUDE_GUEST))
+		return false;
+	if ((a->exclude ^ b->exclude) & COUNTER_KEY_EXCLUDE_IDLE)
+		return false;
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
 }
 
 static bool evsel__is_grouped(const struct evsel *evsel)
@@ -769,13 +860,19 @@ static int evsel_matcher__add(struct evsel_matcher *matcher, struct evsel *evsel
  * @matcher: The matcher to initialize.
  * @evlist: The evsels that may be matched, more may be added with
  *          evsel_matcher__add().
+ * @mode: How strictly evsels must agree to be matched.
+ * @match_grouping: Prefer evsels whose group membership is the same as the
+ *                  evsel being matched.
  */
-static int evsel_matcher__init(struct evsel_matcher *matcher, struct evlist *evlist)
+static int evsel_matcher__init(struct evsel_matcher *matcher, struct evlist *evlist,
+			       enum evsel_match_mode mode, bool match_grouping)
 {
 	struct evsel *evsel;
 
 	memset(matcher, 0, sizeof(*matcher));
 	INIT_LIST_HEAD(&matcher->legacy_hw_keys);
+	matcher->mode = mode;
+	matcher->match_grouping = match_grouping;
 	evlist__for_each_entry(evlist, evsel) {
 		int ret = evsel_matcher__add(matcher, evsel);
 
@@ -868,9 +965,10 @@ static void own_evsel__metric_match_info(struct evsel **own, struct evsel **map,
  * @forced_group_leader: Require a group leader whose members all satisfy
  *                       arch_evsel__must_be_in_group().
  *
- * The same counter may be present more than once, such as when the counter is
- * in different groups. Prefer an evsel with the same name and the same group
- * membership.
+ * The same counter may be present more than once, such as when different
+ * metrics were measured in different groups. Prefer an evsel with the same
+ * name, as a metric would have been parsed to, the same exclusion bits, counts
+ * and, if requested, the same group membership.
  */
 static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matcher,
 						    struct evsel *evsel,
@@ -895,19 +993,23 @@ static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matche
 			continue;
 
 		/*
-		 * Don't match an ungrouped event to a member of a group, as the
-		 * group may multiplex differently from the metric's other
-		 * events.
+		 * When measuring live events, don't match an ungrouped event to
+		 * a member of a group, as the group may multiplex differently
+		 * from the metric's other events.
 		 */
-		if (!leader && !forced_group_leader && evsel__is_grouped(pos))
+		if (matcher->mode == EVSEL_MATCH_LIVE && !leader && !forced_group_leader &&
+		    evsel__is_grouped(pos))
 			continue;
 
 		if (forced_group_leader &&
 		    (!evsel__is_group_leader(pos) || !evsel__is_forced_group(pos)))
 			continue;
 
+		if (matcher->mode == EVSEL_MATCH_RECORDED && !pos->supported)
+			continue;
+
 		/* Skip if the evsels don't program the same counter. */
-		if (!counter_key__equal(&key, &entry->key))
+		if (!counter_key__equal(&key, &entry->key, matcher->mode))
 			continue;
 
 		if (!metric_leader_compatible(evsel, metric_sources, mapped_metric_leader, pos))
@@ -918,8 +1020,10 @@ static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matche
 		    !evsel__shares_metric_id(evsel, pos))
 			continue;
 
-		score = (!strcmp(evsel__name(evsel), evsel__name(pos)) ? 2 : 0) +
-			(grouped == evsel__is_grouped(pos) ? 1 : 0);
+		score = (!strcmp(evsel__name(evsel), evsel__name(pos)) ? 16 : 0) +
+			(key.exclude == entry->key.exclude ? 8 : 0) +
+			evsel__count_score(pos) * 2 +
+			(matcher->match_grouping && grouped == evsel__is_grouped(pos) ? 1 : 0);
 		if (score > best_score) {
 			best = pos;
 			best_score = score;
@@ -928,9 +1032,8 @@ static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matche
 	return best;
 }
 
-static __maybe_unused struct evsel *evsel_matcher__find(struct evsel_matcher *matcher,
-							struct evsel *evsel,
-							const struct evsel *leader)
+static struct evsel *evsel_matcher__find(struct evsel_matcher *matcher, struct evsel *evsel,
+					 const struct evsel *leader)
 {
 	return evsel_matcher__find_for_metric(matcher, evsel, leader,
 					      /*metric_sources=*/0,
@@ -986,150 +1089,375 @@ static bool evsel_matcher__find_group(struct evsel_matcher *matcher, struct evse
 }
 
 struct find_matching_metrics_args {
+	/** @evlist: The evlist of the perf.data file. */
 	struct evlist *evlist;
+	/** @matcher: Matcher of evlist's evsels. */
+	struct evsel_matcher matcher;
 	bool system_wide;
 };
 
-static struct evsel *map_metric_evsel_to_evlist(struct evlist *data_evlist,
-						struct evsel *metric_evsel)
+/*
+ * Find the evsel in @metric_evlist counting @ev, or an event merged with it as
+ * its metric leader, on @pmu.
+ */
+static struct evsel *metric_evsel_on_pmu(struct evlist *metric_evlist, struct evsel *ev,
+					 const struct perf_pmu *pmu)
 {
-	struct evsel *data_evsel;
+	struct evsel *pos;
 
-	evlist__for_each_entry(data_evlist, data_evsel) {
-		/* Skip if perf_event_attr differ. */
-		if (metric_evsel->core.attr.type != data_evsel->core.attr.type)
-			continue;
-		if (metric_evsel->core.attr.config != data_evsel->core.attr.config)
-			continue;
-		return data_evsel;
+	if (ev->pmu == pmu)
+		return ev;
+
+	evlist__for_each_entry(metric_evlist, pos) {
+		if (pos->pmu == pmu &&
+		    (pos->metric_leader == ev ||
+		     evsel__shares_metric_id(pos, ev)))
+			return pos;
 	}
-	return NULL;
+	if (ev->pmu && ev->pmu->is_core && pmu && pmu->is_core)
+		return NULL;
+	return ev;
 }
 
-static int find_matching_metrics_cb(const struct pmu_metric *pm,
-				    const struct pmu_metrics_table *table __maybe_unused,
-				    void *data)
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
+						     const struct perf_pmu *pmu,
+						     struct evsel *target_data_evsel)
 {
-	struct find_matching_metrics_args *args = data;
-	struct evlist *data_evlist = args->evlist;
-	struct evlist *metric_evlist = evlist__new();
-	struct evsel *metric_evsel;
-	int ret = metricgroup__parse_groups(metric_evlist,
-					/*pmu=*/"all",
-					/*cputype_filter=*/false,
-					pm->metric_name,
-					/*metric_no_group=*/false,
-					/*metric_no_merge=*/false,
-					/*metric_no_threshold=*/true,
-					/*user_requested_cpu_list=*/NULL,
-					args->system_wide,
-					/*hardware_aware_grouping=*/false);
+	struct evsel *data_group = evsel__leader(target_data_evsel);
+	struct metric_expr *copy = zalloc(sizeof(*copy));
+	int nr = 0;
 
-	if (ret) {
-		/* Metric parsing failed but continue the search. */
-		goto out;
+	if (data_group->core.nr_members <= 1)
+		data_group = NULL;
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
 	}
 
+	while (expr->metric_events[nr])
+		nr++;
+	copy->metric_events = calloc(nr + 1, sizeof(*copy->metric_events));
+	if (!copy->metric_events)
+		goto err;
+
 	/*
-	 * Check the data_evlist has an entry for each metric_evlist entry. If
-	 * the data evsel was already set up avoid changing data that may
-	 * break it.
+	 * Map every event before modifying any data evsel so that a failure
+	 * doesn't leave metric ids or leaders on data evsels of an unused copy.
 	 */
-	evlist__for_each_entry(metric_evlist, metric_evsel) {
-		struct evsel *data_evsel =
-			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
-		struct evsel *new_metric_leader;
+	for (int i = 0; i < nr; i++) {
+		struct evsel *ev = metric_evsel_on_pmu(metric_evlist, expr->metric_events[i], pmu);
+
+		if (!ev)
+			goto err;
+		if (data_group && evsel__is_grouped(ev))
+			copy->metric_events[i] = evsel_matcher__find(&args->matcher, ev,
+								     data_group);
+		if (!copy->metric_events[i])
+			copy->metric_events[i] = evsel_matcher__find(&args->matcher, ev,
+								     /*leader=*/NULL);
+		if (!copy->metric_events[i])
+			goto err;
+	}
+	for (int i = 0, j = 0; i < nr; i++) {
+		struct evsel *data_evsel = copy->metric_events[i];
+		bool dup = false;
 
-		if (!data_evsel) {
-			pr_debug("Skipping metric '%s' as evsel '%s' is missing\n",
-				pm->metric_name, evsel__name(metric_evsel));
-			goto out;
+		if (evsel__copy_metric_ids(data_evsel, expr->metric_events[i]))
+			goto err;
+		/*
+		 * Different metric events may map to the same data evsel, whose
+		 * metric ids now include those of both. Only keep the first so
+		 * that the data evsel's value isn't counted more than once.
+		 */
+		for (int k = 0; k < j; k++) {
+			if (copy->metric_events[k] == data_evsel) {
+				dup = true;
+				break;
+			}
 		}
-
-		if (data_evsel->metric_leader == NULL)
+		copy->metric_events[i] = NULL;
+		if (dup)
 			continue;
+		copy->metric_events[j++] = data_evsel;
+		/*
+		 * As in setup_metric_events(), a matched event without a metric
+		 * leader leads itself so that evsel__source_count() counts it.
+		 */
+		if (!data_evsel->metric_leader)
+			data_evsel->metric_leader = data_evsel;
+	}
+	return copy;
+err:
+	metric_expr__delete(copy);
+	return NULL;
+}
 
-		if (metric_evsel->metric_leader == metric_evsel) {
-			new_metric_leader = data_evsel;
-		} else {
-			new_metric_leader =
-				map_metric_evsel_to_evlist(data_evlist,
-								 metric_evsel->metric_leader);
+static bool metric_evsel__has_pmu_siblings(struct evlist *metric_evlist,
+					   const struct evsel *ev)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(metric_evlist, pos) {
+		if (pos != ev && pos->pmu != ev->pmu &&
+		    pos->metric_leader == ev &&
+		    evsel__shares_metric_id(pos, ev))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Pick the event in @metric_evlist whose per-PMU instances @expr should be
+ * duplicated and displayed for. pick_display_evsel() may select a single-PMU
+ * event, such as software/cpu-clock/ in branch_frequency, when another event in
+ * @expr was expanded across multiple PMUs (e.g. hybrid core PMUs); prefer the
+ * multi-PMU event so @expr is matched for each PMU.
+ */
+static struct evsel *metric_expr__leader_evsel(struct evlist *metric_evlist,
+					       struct evsel *metric_evsel,
+					       const struct metric_expr *expr)
+{
+	if (metric_evsel__has_pmu_siblings(metric_evlist, metric_evsel))
+		return metric_evsel;
+
+	for (int i = 0; expr->metric_events[i]; i++) {
+		struct evsel *ev = expr->metric_events[i];
+
+		if (metric_evsel__has_pmu_siblings(metric_evlist, ev))
+			return ev;
+	}
+	return metric_evsel;
+}
+
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
 		}
-		/* Mismatching evsel leaders. */
-		if (data_evsel->metric_leader != new_metric_leader) {
-			pr_debug("Skipping metric '%s' due to mismatching evsel metric leaders '%s' vs '%s'\n",
-				pm->metric_name, evsel__name(metric_evsel),
-				evsel__name(data_evsel));
-			goto out;
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
+					evsel_matcher__find(&args->matcher, metric_evsel,
+							    /*leader=*/NULL);
+
+				if (data_evsel)
+					data_evsel->default_show_events = true;
+			}
 		}
 	}
+
 	/*
-	 * Metric events match those in the data evlist, copy metric evsel
-	 * data into the data evlist.
+	 * Metric expressions are associated with a metric leader event and
+	 * computed for each PMU of the events led by it. Rather than share
+	 * metric leaders between metrics, which may conflict, attach a copy of
+	 * the expression to each such data event using the data events of its
+	 * PMU.
 	 */
 	evlist__for_each_entry(metric_evlist, metric_evsel) {
-		struct evsel *data_evsel =
-			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
 		struct metric_event *metric_me =
 			metricgroup__lookup(evlist__metric_events(metric_evlist),
 					    metric_evsel,
 					    /*create=*/false);
+		struct metric_expr *expr;
 
-		if (evsel__copy_metric_ids(data_evsel, metric_evsel))
-			goto out;
+		if (!metric_me || metric_me->evsel != metric_evsel)
+			continue;
+
+		list_for_each_entry(expr, &metric_me->head, nd) {
+			struct evsel *leader =
+				metric_expr__leader_evsel(metric_evlist, metric_evsel, expr);
+			struct evsel *pos;
+
+			evlist__for_each_entry(metric_evlist, pos) {
+				struct evsel *data_evsel;
+				struct metric_event *data_me;
+				struct metric_expr *copy;
+
+				if (pos != leader &&
+				    (pos->metric_leader != leader ||
+				     !evsel__shares_metric_id(pos, leader)))
+					continue;
 
-		if (data_evsel->metric_leader == NULL) {
-			if (metric_evsel->metric_leader == metric_evsel) {
+				data_evsel = evsel_matcher__find(&args->matcher, pos,
+								 /*leader=*/NULL);
+				if (!data_evsel)
+					continue;
+
+				copy = metric_expr__dup_for_data(args, metric_evlist, expr,
+								 pos->pmu, data_evsel);
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
 				data_evsel->metric_leader = data_evsel;
-			} else {
-				data_evsel->metric_leader =
-					map_metric_evsel_to_evlist(data_evlist,
-								       metric_evsel->metric_leader);
+				if (default_metricgroup && metric_me->is_default)
+					data_me->is_default = true;
+				list_add_tail(&copy->nd, &data_me->head);
+				pr_debug("Found metric '%s' whose evsels match those in the perf data\n",
+					 copy->metric_name);
 			}
 		}
+	}
+	return 0;
+}
 
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
+static int find_matching_metrics_cb(const struct pmu_metric *pm,
+				    const struct pmu_metrics_table *table __maybe_unused,
+				    void *data)
+{
+	struct find_matching_metrics_args *args = data;
+	struct evlist *metric_evlist = evlist__new();
+	struct evsel *metric_evsel;
+	bool found;
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
+					/*pmu=*/"all",
+					/*cputype_filter=*/false,
+					pm->metric_name,
+					/*metric_no_group=*/true,
+					/*metric_no_merge=*/false,
+					/*metric_no_threshold=*/true,
+					/*user_requested_cpu_list=*/NULL,
+					args->system_wide,
+					/*hardware_aware_grouping=*/false);
+	if (ret) {
+		/* Metric parsing failed but continue the search. */
+		ret = 0;
+		goto out;
+	}
+
+	/*
+	 * Skip metrics none of whose events were recorded. Copies of the
+	 * metric for each PMU, such as on hybrid systems where only one core
+	 * PMU's events may have been recorded, are only added if all their
+	 * events match.
+	 */
+	found = false;
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		if (evsel_matcher__find(&args->matcher, metric_evsel, /*leader=*/NULL)) {
+			found = true;
+			break;
 		}
 	}
-	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
-		 pm->metric_name);
+	if (!found) {
+		pr_debug("Skipping metric '%s' as no evsels are in the data\n", pm->metric_name);
+		goto out;
+	}
+
+	ret = add_matching_metric_evlist(args, metric_evlist,
+					 /*default_metricgroup=*/false);
 out:
 	evlist__put(metric_evlist);
-	return 0;
+	return ret;
+}
+
+static int find_matching_metrics_args__init(struct find_matching_metrics_args *args,
+					    struct evlist *evlist, bool system_wide,
+					    bool match_grouping)
+{
+	args->evlist = evlist;
+	args->system_wide = system_wide;
+	return evsel_matcher__init(&args->matcher, evlist, EVSEL_MATCH_RECORDED, match_grouping);
+}
+
+static void find_matching_metrics_args__exit(struct find_matching_metrics_args *args)
+{
+	evsel_matcher__exit(&args->matcher);
 }
 
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
+	/*
+	 * The metrics are parsed without event grouping, so don't prefer
+	 * recorded events by their grouping.
+	 */
+	ret = find_matching_metrics_args__init(&args, evlist, system_wide,
+					       /*match_grouping=*/false);
+	if (ret)
+		goto out;
 
-	return metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
-					    find_matching_metrics_cb, &args);
+	ret = metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
+					   find_matching_metrics_cb, &args);
+out:
+	find_matching_metrics_args__exit(&args);
+	return ret;
 }
 
 static int append_metric_id_cb(const char *metric_id, void *data)
@@ -2322,7 +2650,8 @@ static int parse_groups(struct evlist *perf_evlist,
 	 * Unless sharing is disabled, metrics use the events of other metrics,
 	 * and those already in perf_evlist, that count the same thing.
 	 */
-	ret = evsel_matcher__init(&matcher, perf_evlist);
+	ret = evsel_matcher__init(&matcher, perf_evlist, EVSEL_MATCH_LIVE,
+				  /*match_grouping=*/true);
 	if (ret)
 		goto out;
 
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
2.56.1.703.gf848ed807c-goog

