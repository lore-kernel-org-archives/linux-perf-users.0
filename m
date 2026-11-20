Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212951;
	b=HgnS+5bi44fy3O+TE/JNhp5V0MKb55yUUPN3cVl0xwdnKhHVg/e6W5vrKkrUhba74umN
	 Yq/AXMprckDxGOGPHHPlITQmWajyJICi3Oauo+iKyZQ0YQYX25H3suUEl8W3fGcRpJK3F
	 s4yEWT2lCMSFs0hEh074ack8El7SyCXy4FRe3qn1oQg7atDAGP2AFEaTiht5Pu4Xdq2a2
	 KmXMrCMW3MkzBjaHP7WLs/EOMtIQKeKCkO8Lvcc7zAbCU/1R+MV1gaBWcNloxExgQIKTC
	 JqPNGUNPSZReCn8MncmIIxHQQHa85d7fmHSluRjJpn/wnb//qq2sc/bq2O6sG11YgOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5oSAS5rTMZpKmndtpKW47xjlBULmJlmzTFbWhRT19C4=;
	b=yQLSOpTi7ckxwo7CIwUGRor54bL8vPm4uyiZ4Qvi78KeJV9K5cd7P6Nx+MDPItyhoSE5
	 cOZpdk8GBNbO9eF7iUtfM4XpOnZMKcZrwByVF2d2lwsrrEOV/IQswnkXdm4ZLZlmub5kj
	 DDB75JWATwfShkwPJBMFLTi+evvz6VE//jhumtebL75SxxcJD5oIrvxo0wy76DXUGtzkV
	 jf6r2YkceSuYB8kuxhMdpKrhWeZMYNT9hiMoPvfYEkbJl5fU5eLQUxZ8InrZuHT0jlHh+
	 6kbLcqOLllMUr/HXHs1N2O6Ce6s2d1Gzbw4343sCMz99mHJEMSuMHZ2gNgnB+DYJU0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HzH+Gntp;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79851606A6BF
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79851606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HzH+Gntp
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so3612592c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212949; x=1795817749; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5oSAS5rTMZpKmndtpKW47xjlBULmJlmzTFbWhRT19C4=;
        b=HzH+GntpY/4eLrBPc6AV+MPbeOC5TAlF9UF7Eh1809RoUtm+6w9YJEg+1VagWLKeGy
         T57ZEdn81BEE02PPrQBDm5sDGMGocKZvSTLJl4+81SYA+RGevcVPMag4A2906SrqfqeB
         lZpflk3/yZipj+7v2F6uhSnxD0RVwCmHvNPAs0zhI4hooYgptJvCFOeG00Z98lJsjrQz
         LukGrsYkB0oLzkkkpiLRPOATRemSIfSN05PeTBYLldI0aK0lzcOkXgsAZ2JDmOwLbLDP
         sDQDDnwNE1AIXAP5VRlQgshdFCFgMYGa617rLzwcVIIffikSMsNCWkMSF8DvkyZ9yzLf
         mOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212949; x=1795817749;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5oSAS5rTMZpKmndtpKW47xjlBULmJlmzTFbWhRT19C4=;
        b=rKSW3EfBDATPpgnMOyqRH1ZEneToq8lBvgTENtWn0M0drfrpLgHqAOd2tPvEdP12iN
         Si4JFqX/GABkmEBYT1NxqfJq2eW+7UV32HepCqk05HVOhCRaI7WAWnbkmSkm5TFy63ZF
         eIp/YXrfJSXpEtEXDtA3sh2l4JfME81Y+QLglAoSnoP6u+iAlyrFULUnlTgzBr1FECT3
         zreiFUcRyIe3tpJa15Dve8qAgJC10g/C3D8pQrcKa6yr9WotBk/1hH8uyS/01sMU9wJL
         ZNzEVMUImUuYDLx2SnIdoZhqYiQ5hDbianDcY94KAbARXYz8Vv9LglsbuxrnzAWx98j9
         8HrQ==
X-Gm-Message-State: APuU4Z95pr/8sqO+VxQjKDm4Lu9tWRzj8OYOPKEELMQ52JVgRCLFSBfo
	+MMkNSeAUtdSxVBifeqby+zZCVurMVs/9AAz71VxAtS6SPYlcKGWcPr3JOwmBt2E3WnZmXxVYJT
	jzVyTgYtM3g==
X-Received: from dlgx9-n2.prod.google.com ([2002:a05:701a:ccc9:20b0:1b2:6c20:7e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b044:10b0:19b:39f4:88c9
 with SMTP id a92af1059eb24-1b5568a12e7mr4611387c88.10.1795212948246; Fri, 20
 Nov 2026 14:15:48 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:27 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-27-irogers@google.com>
Subject: [PATCH v3 26/30] perf metricgroup: Improve matching of metrics to
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
   changed when recording, requires equal CPUs when either event
   explicitly restricts CPUs (e.g. cpu=cpu_core), skips unsupported
   events and prefers events with counts.

 - A recorded event could be used by only one metric leader, as metrics
   set the event's metric_leader and later metrics with a different
   leader were skipped. Instead attach a copy of each metric expression
   to the recorded event of each PMU the metric applies to, adding the
   metric's event identifiers to the matched recorded evsels.

 - When the same counter was recorded more than once, such as for the
   default metrics of perf stat in different groups, the first was
   matched. Prefer a supported event with the same name, exclusion bits,
   counts, CPUs and, when the metric's events are grouped, the same
   group membership, as the matcher does.

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

# Conflicts:
#	tools/perf/util/metricgroup.c
---
 tools/perf/util/evsel.c        |   1 +
 tools/perf/util/evsel.h        |   1 +
 tools/perf/util/metricgroup.c  | 666 ++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.h  |   5 +-
 tools/perf/util/parse-events.c |   1 +
 5 files changed, 543 insertions(+), 131 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 73687e24f5bc..46443e9019d8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -619,6 +619,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->use_config_name = orig->use_config_name;
 	evsel->skippable = orig->skippable;
 	evsel->dont_regroup = orig->dont_regroup;
+	evsel->has_user_cpus = orig->has_user_cpus;
 	evsel->default_metricgroup = orig->default_metricgroup;
 	evsel->default_show_events = orig->default_show_events;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e776ca60a9a5..2e18630acaea 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -99,6 +99,7 @@ struct evsel {
 		bool			skippable;
 		bool			retire_lat;
 		bool			dont_regroup;
+		bool			has_user_cpus;
 		bool			default_metricgroup; /* A member of the Default metricgroup */
 		bool			default_show_events; /* If a default group member, show the event */
 		struct list_head	config_terms;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 5641a3676063..72b552829659 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -8,15 +8,20 @@
 #include "metricgroup.h"
 #include "debug.h"
 #include "evlist.h"
+#include "env.h"
 #include "evsel.h"
+#include "cpumap.h"
+#include "counts.h"
 #include "strbuf.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "parse-events.h"
 #include "print-events.h"
 #include "smt.h"
 #include "tool_pmu.h"
 #include "expr.h"
 #include "rblist.h"
+#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 #include "strlist.h"
@@ -88,18 +93,24 @@ static struct rb_node *metric_event_new(struct rblist *rblist __maybe_unused,
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
@@ -482,7 +493,8 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
 
 /*
  * A key identifying the counter an evsel programs, used to find evsels counting
- * the same thing, such as when metrics share events.
+ * the same thing, such as when metrics share events or when matching evsels
+ * parsed from a metric with those read from a perf.data file.
  */
 struct counter_key {
 	/** @pmu_name: Name of the evsel's PMU, or NULL if unknown. */
@@ -491,7 +503,7 @@ struct counter_key {
 	const struct perf_cpu_map *cpus;
 	/** @owned_cpus: Reference-counted CPU map owned by this key, or NULL. */
 	struct perf_cpu_map *owned_cpus;
-	/** @cgrp: The cgroup the evsel counts. */
+	/** @cgrp: The cgroup the evsel counts, compared by EVSEL_MATCH_LIVE. */
 	const struct cgroup *cgrp;
 	/** @type: perf_event_attr type, PERF_TYPE_RAW for any dynamic PMU type. */
 	__u32 type;
@@ -512,8 +524,10 @@ struct counter_key {
 	 * is counted, a mask of COUNTER_KEY_MOD_*.
 	 */
 	unsigned int modifiers;
-	/** @precise_ip: perf_event_attr precise_ip. */
+	/** @precise_ip: perf_event_attr precise_ip, compared by EVSEL_MATCH_LIVE. */
 	unsigned int precise_ip;
+	/** @has_user_cpus: Were @cpus restricted by an explicit cpu= term? */
+	bool has_user_cpus;
 };
 
 #define COUNTER_KEY_EXCLUDE_USER	BIT(0)
@@ -522,6 +536,8 @@ struct counter_key {
 #define COUNTER_KEY_EXCLUDE_HOST	BIT(3)
 #define COUNTER_KEY_EXCLUDE_GUEST	BIT(4)
 #define COUNTER_KEY_EXCLUDE_IDLE	BIT(5)
+#define COUNTER_KEY_EXCLUDE_PRIV	(COUNTER_KEY_EXCLUDE_USER | COUNTER_KEY_EXCLUDE_KERNEL | \
+					 COUNTER_KEY_EXCLUDE_HV)
 
 #define COUNTER_KEY_MOD_PINNED		BIT(0)
 #define COUNTER_KEY_MOD_EXCLUSIVE	BIT(1)
@@ -538,6 +554,21 @@ struct legacy_hw_key {
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
@@ -558,6 +589,13 @@ struct evsel_matcher {
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
 
 static void counter_key__exit(struct counter_key *key)
@@ -772,19 +810,77 @@ static struct perf_cpu_map *evsel_propagated_cpus(const struct perf_evlist *evli
 	return cpus;
 }
 
+/*
+ * Recorded evsels read from perf.data do not set evsel->has_user_cpus, and for
+ * PMUs without a sysfs cpumask (such as "msr") PERF_EVENT_UPDATE__CPUS records
+ * all online CPUs rather than an event's cpu= term. Recover any cpu= terms
+ * from the recorded event's name so per-PMU events like "msr/tsc,cpu=cpu_core/"
+ * and "msr/tsc,cpu=cpu_atom/" match only their corresponding CPU subsets.
+ */
+static struct perf_cpu_map *recorded_evsel_user_cpus(struct evsel *evsel)
+{
+	const char *name = evsel->name;
+	const char *slash = name ? strchr(name, '/') : NULL;
+	const char *end, *tok;
+	struct perf_pmus *pmus;
+	struct perf_cpu_map *cpus = NULL;
+
+	if (!slash)
+		return NULL;
+
+	end = strchr(slash + 1, '/');
+	if (!end)
+		end = slash + strlen(slash);
+
+	pmus = perf_env__pmus(evsel__env(evsel) ?: host_env());
+	for (tok = slash + 1; tok < end; ) {
+		const char *comma = memchr(tok, ',', end - tok);
+		const char *tok_end = comma ?: end;
+
+		if (tok_end - tok > 4 && strstarts(tok, "cpu=")) {
+			char *val = strndup(tok + 4, tok_end - (tok + 4));
+			struct perf_cpu_map *term_cpus = NULL;
+			struct perf_pmu *pmu;
+
+			if (!val) {
+				perf_cpu_map__put(cpus);
+				return NULL;
+			}
+			pmu = perf_pmus__find(pmus, val);
+			if (!pmu || perf_cpu_map__is_empty(pmu->cpus))
+				pmu = perf_pmus__find(perf_env__pmus(host_env()), val);
+			if (pmu) {
+				term_cpus = pmu->is_core && perf_cpu_map__is_empty(pmu->cpus)
+					    ? cpu_map__online()
+					    : perf_cpu_map__get(pmu->cpus);
+			} else {
+				term_cpus = perf_cpu_map__new(val);
+			}
+			free(val);
+			perf_cpu_map__merge(&cpus, term_cpus);
+			perf_cpu_map__put(term_cpus);
+		}
+		tok = comma ? comma + 1 : end;
+	}
+	return cpus;
+}
+
 static void evsel_matcher__key(struct evsel_matcher *matcher, struct evsel *evsel,
 			       struct counter_key *key)
 {
 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 
 	counter_key__init_attr(key, pmu ? pmu->name : NULL, &evsel->core.attr);
-	if (matcher->evlist && evlist__core(matcher->evlist)->needs_map_propagation &&
+	if (matcher->mode == EVSEL_MATCH_LIVE && matcher->evlist &&
+	    evlist__core(matcher->evlist)->needs_map_propagation &&
 	    evsel->evlist != matcher->evlist) {
 		key->owned_cpus = evsel_propagated_cpus(evlist__core(matcher->evlist), evsel);
 		key->cpus = key->owned_cpus;
 	} else {
-		key->cpus = evsel->core.cpus;
+		key->cpus = !perf_cpu_map__is_empty(evsel->core.cpus)
+			    ? evsel->core.cpus : evsel->core.pmu_cpus;
 	}
+	key->has_user_cpus = evsel->has_user_cpus;
 	key->cgrp = evsel->cgrp;
 	if (evsel->percore)
 		key->modifiers |= COUNTER_KEY_MOD_PERCORE;
@@ -798,9 +894,12 @@ static void evsel_matcher__key(struct evsel_matcher *matcher, struct evsel *evse
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
@@ -813,9 +912,67 @@ static bool counter_key__equal(const struct counter_key *a, const struct counter
 	if (a->pmu_name && b->pmu_name && strcmp(a->pmu_name, b->pmu_name))
 		return false;
 
-	return a->exclude == b->exclude && a->modifiers == b->modifiers &&
-	       a->precise_ip == b->precise_ip && a->cgrp == b->cgrp &&
-	       perf_cpu_map__equal(a->cpus, b->cpus);
+	if ((a->modifiers ^ b->modifiers) & COUNTER_KEY_MOD_RETIRE_LAT)
+		return false;
+
+	if (mode == EVSEL_MATCH_LIVE) {
+		return a->exclude == b->exclude && a->modifiers == b->modifiers &&
+		       a->precise_ip == b->precise_ip && a->cgrp == b->cgrp &&
+		       perf_cpu_map__equal(a->cpus, b->cpus);
+	}
+
+	if ((a->has_user_cpus || b->has_user_cpus) &&
+	    !perf_cpu_map__equal(a->cpus, b->cpus))
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
@@ -846,6 +1003,16 @@ static int evsel_matcher__add(struct evsel_matcher *matcher, struct evsel *evsel
 	entry = &matcher->entries[matcher->nr_entries++];
 	entry->evsel = evsel;
 	evsel_matcher__key(matcher, evsel, &entry->key);
+	if (matcher->mode == EVSEL_MATCH_RECORDED && !entry->key.has_user_cpus) {
+		struct perf_cpu_map *user_cpus = recorded_evsel_user_cpus(evsel);
+
+		if (user_cpus) {
+			counter_key__exit(&entry->key);
+			entry->key.owned_cpus = user_cpus;
+			entry->key.cpus = user_cpus;
+			entry->key.has_user_cpus = true;
+		}
+	}
 	return 0;
 }
 
@@ -854,14 +1021,20 @@ static int evsel_matcher__add(struct evsel_matcher *matcher, struct evsel *evsel
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
 	matcher->evlist = evlist;
 	INIT_LIST_HEAD(&matcher->legacy_hw_keys);
+	matcher->mode = mode;
+	matcher->match_grouping = match_grouping;
 	evlist__for_each_entry(evlist, evsel) {
 		int ret = evsel_matcher__add(matcher, evsel);
 
@@ -962,9 +1135,10 @@ enum evsel_group_match {
  *                        not its own metric leader.
  * @group_match: Whether grouped events may be matched when @leader is NULL.
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
@@ -989,11 +1163,12 @@ static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matche
 			continue;
 
 		/*
-		 * Don't match an ungrouped event to a member of a group, as the
-		 * group may multiplex differently from the metric's other
-		 * events.
+		 * When measuring live events, don't match an ungrouped event to
+		 * a member of a group, as the group may multiplex differently
+		 * from the metric's other events.
 		 */
-		if (!leader && group_match == EVSEL_GROUP_MATCH_UNGROUPED &&
+		if (matcher->mode == EVSEL_MATCH_LIVE && !leader &&
+		    group_match == EVSEL_GROUP_MATCH_UNGROUPED &&
 		    evsel__is_grouped(pos))
 			continue;
 
@@ -1001,8 +1176,11 @@ static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matche
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
@@ -1013,8 +1191,11 @@ static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matche
 		    !evsel__shares_metric_id(evsel, pos))
 			continue;
 
-		score = (!strcmp(evsel__name(evsel), evsel__name(pos)) ? 2 : 0) +
-			(grouped == evsel__is_grouped(pos) ? 1 : 0);
+		score = (!strcmp(evsel__name(evsel), evsel__name(pos)) ? 32 : 0) +
+			(key.exclude == entry->key.exclude ? 16 : 0) +
+			evsel__count_score(pos) * 4 +
+			(perf_cpu_map__equal(key.cpus, entry->key.cpus) ? 2 : 0) +
+			(matcher->match_grouping && grouped == evsel__is_grouped(pos) ? 1 : 0);
 		if (score > best_score) {
 			best = pos;
 			best_score = score;
@@ -1024,9 +1205,8 @@ static struct evsel *evsel_matcher__find_for_metric(struct evsel_matcher *matche
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
@@ -1082,150 +1262,375 @@ static bool evsel_matcher__find_group(struct evsel_matcher *matcher, struct evse
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
 
-		if (data_evsel->metric_leader == NULL) {
-			if (metric_evsel->metric_leader == metric_evsel) {
+				if (pos != leader &&
+				    (pos->metric_leader != leader ||
+				     !evsel__shares_metric_id(pos, leader)))
+					continue;
+
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
 
-	return metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
-					    find_matching_metrics_cb, &args);
+	/*
+	 * The metrics are parsed without event grouping, so don't prefer
+	 * recorded events by their grouping.
+	 */
+	ret = find_matching_metrics_args__init(&args, evlist, system_wide,
+					       /*match_grouping=*/false);
+	if (ret)
+		goto out;
+
+	ret = metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
+					   find_matching_metrics_cb, &args);
+out:
+	find_matching_metrics_args__exit(&args);
+	return ret;
 }
 
 static int append_metric_id_cb(const char *metric_id, void *data)
@@ -2441,7 +2846,8 @@ static int parse_groups(struct evlist *perf_evlist,
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
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b70ba9b58c43..fa528adf42cb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -341,6 +341,7 @@ __add_event(struct list_head *list, int *idx,
 	(*idx)++;
 	evsel->core.cpus = cpus;
 	evsel->core.pmu_cpus = pmu_cpus;
+	evsel->has_user_cpus = has_user_cpus;
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = is_pmu_core;
 	evsel->core.is_pmu_uncore = pmu ? pmu->is_uncore : false;
-- 
2.56.1.750.gf70dc682cf-goog

