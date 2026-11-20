Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212960;
	b=y04piNiML4qgMQeDlv0DSxVuEnzq6QJGkk6CqSJzTDqUrtkezh6y+mZGRxtttkfpWk+r
	 ifFgJxYnkDiz52dl9FfNQCAe62bqn9bbhVc6pvcVjhoP3jVfB7Br5Di0SpIs/SRiyk6ea
	 6/+31horhfn0LrCqFnV7vK60F/Y+xSpiyur0B45fPXfMVPhB8+GnfcpxwjfkgWAXAQC67
	 fqNc0Myd82zEPSIMpC/D6jgOTPCfEZDcoAtgJs4ed53hvJ6+akb8BRGhFIpAJ87szh5U8
	 HTDpqQmxClhMnQJrkbXOfOyKHJ+XobDOD/3Bvosop6yhTYOR+SHV33c4gpg6iqfrmBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Smuc5oSE4Rk1CEz3klTX+3kN4HJeddocJmM5xW2MgiQ=;
	b=3dtb2alfFDlaiyuNGUvePaRCXYLNDP31CAerfF1T2upsMXwVwmCag+nhHQuKLyeypXUB
	 CHAVQl109l9QvPCOoSVn7/qhvQUJm/wt/2BVogKa96d18M6x1FTBqOnWhIuYa8wBXxvEq
	 br4gr0ZwFIfm+qXjOGevC4ghP1Ym1DiaRE5jjTdvlGzhSGE+AkCJV2SrmIa7e6M4wcM89
	 t58qPHsZHJlA/Ly54qG3w8HPv1y3n06HOpYNTA2uBS9WP6ishXvs/ACMYgmkZ1MHMusAJ
	 rN1t6faD7m2iKYxjG8HTekIPmaiQaqMXSHtU1BMd60AaZvGSR+Ip/qOP71ohexen00Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MrEQjImY;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715960A2629
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2715960A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MrEQjImY
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3a348a6dbso2600650c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212955; x=1795817755; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Smuc5oSE4Rk1CEz3klTX+3kN4HJeddocJmM5xW2MgiQ=;
        b=MrEQjImYFyv3JtbxTHqmlX3EmtEZPFkPi1VTaqdBWo8uXW8YrQt4q3BiNB3Emf3aXQ
         f/JvMyhaWPG8DWmxclAQnsydB7zKyjUg/+sasHrEtiquvvGW1kcxNAgxvoZj4w3hgK9j
         xgtzESSr4fUOpQarp/DnyeRzX12/xu2YzKN9e5t+SUVgKM9gObsS6dt5ouRvflFoa+6q
         vWorX8tk5KwFox1PHVzSMnAK3eUZ8sNe4qxOjEwTeuSJdE9uNz/lHJlKJWmp0aVmYsrl
         acnT38qvbUpaxtQq7+nLiY+GSbKqoGpBA28k1vxTIdDpW1ET5iiOXuIWiBLKluQzDTlm
         +l3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212955; x=1795817755;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Smuc5oSE4Rk1CEz3klTX+3kN4HJeddocJmM5xW2MgiQ=;
        b=z3tKhvUFek5T7s9SEeLcupeW49U1FrSmAErmbQEn5s2xdUs8ILnwbkhoehoFEuYOO3
         yBi4KfsSgo7GPJviTjujBOTvZcLCdbLtnx6KDxCavEg+8Scn09BBQVIYR8DDnp22BzRB
         HBNrd1eF+7uzJJSZ9pBphxSZa2nd3vtHr1MMQ3IGUZGLLTfBZRfnyv1gJSQ6KFwqHAz5
         KHx2GW3R3ZbfT6jATgebG3Rciscvg+LcqZce2E+HDdGuirGkIirWYJI8/UlE7zwTGE6p
         lt3aAqEKJ4p3E/DLrxkEK2VpRyMs7r39w89nqqsiTy3n4z4e9wT52QpPttvtU6XXCVqK
         G8Kw==
X-Gm-Message-State: APuU4Z+oz8D5FcoSajzIMaX7Fw+MSSkMOJ9RaOBn4k/+2kvYEHT9gnlA
	Dn+u6rq6ym8WCdUCdVY9Qmr0y6EIuMgs9PORm1XfOM0IwUZI7Kog8o/M5eHXf3XpmvrhoQ+Bcbm
	A1I6Lcka8nw==
X-Received: from dldyr5-n2.prod.google.com ([2002:a05:701b:4505:20b0:1b5:3561:2fe9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ed02:b0:14d:cb67:afc4
 with SMTP id a92af1059eb24-1b55691d6e4mr4397957c88.41.1795212954654; Fri, 20
 Nov 2026 14:15:54 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:28 -0800
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
Message-ID: <20261120221332.2245191-28-irogers@google.com>
Subject: [PATCH v3 27/30] perf metricgroup: Add metricgroup__add_recorded_metrics()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add metricgroup__add_matching_metric_groups() and
metricgroup__add_recorded_metrics() to parse metrics or metricgroups
requested on a recorded perf stat command line (or the Default
metricgroups when no events or metrics were explicitly specified) and
match them against the recorded events in the evlist.

When reporting commands such as 'perf stat report' or 'perf script'
inspect a perf.data file recorded by 'perf stat record', this allows
reconstructing the exact metrics requested at record time (including -M,
--transaction, --smi-cost, --topdown, -d, --cputype, and --pmu-filter)
or optionally adding all matching JSON metrics when --all-metrics is
enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 358 ++++++++++++++++++++++++++++++++--
 tools/perf/util/metricgroup.h |  62 ++++++
 2 files changed, 407 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 72b552829659..d4038cb5b3e0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -21,6 +21,7 @@
 #include "tool_pmu.h"
 #include "expr.h"
 #include "rblist.h"
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
@@ -1454,25 +1455,35 @@ static bool metric_events__contains(struct rblist *metric_events, const struct m
 	return false;
 }
 
+static void evsel_matcher__mark_default(struct evsel_matcher *matcher, struct evsel *metric_evsel)
+{
+	struct counter_key key;
+	bool fake = metric_evsel->pmu && perf_pmu__is_fake(metric_evsel->pmu);
+
+	evsel_matcher__key(matcher, metric_evsel, &key);
+	for (size_t i = 0; i < matcher->nr_entries; i++) {
+		struct evsel_matcher_entry *entry = &matcher->entries[i];
+		struct evsel *pos = entry->evsel;
+
+		if (!counter_key__equal(&key, &entry->key, matcher->mode))
+			continue;
+		if ((fake || (pos->pmu && perf_pmu__is_fake(pos->pmu))) &&
+		    !evsel__shares_metric_id(metric_evsel, pos))
+			continue;
+		pos->default_metricgroup = true;
+		if (metric_evsel->default_show_events)
+			pos->default_show_events = true;
+	}
+	counter_key__exit(&key);
+}
+
 static int add_matching_metric_evlist(struct find_matching_metrics_args *args,
 				      struct evlist *metric_evlist,
 				      bool default_metricgroup)
 {
 	struct evlist *data_evlist = args->evlist;
 	struct evsel *metric_evsel;
-
-	if (default_metricgroup) {
-		evlist__for_each_entry(metric_evlist, metric_evsel) {
-			if (metric_evsel->default_show_events) {
-				struct evsel *data_evsel =
-					evsel_matcher__find(&args->matcher, metric_evsel,
-							    /*leader=*/NULL);
-
-				if (data_evsel)
-					data_evsel->default_show_events = true;
-			}
-		}
-	}
+	bool any_matched = false;
 
 	/*
 	 * Metric expressions are associated with a metric leader event and
@@ -1515,6 +1526,7 @@ static int add_matching_metric_evlist(struct find_matching_metrics_args *args,
 								 pos->pmu, data_evsel);
 				if (!copy)
 					continue;
+				any_matched = true;
 				if (metric_events__contains(evlist__metric_events(data_evlist),
 							    copy)) {
 					metric_expr__delete(copy);
@@ -1535,6 +1547,17 @@ static int add_matching_metric_evlist(struct find_matching_metrics_args *args,
 			}
 		}
 	}
+
+	if (default_metricgroup && any_matched) {
+		/*
+		 * Mark all recorded events counting the same thing as a Default
+		 * metric event, including duplicates across groups, so
+		 * perf_stat__skip_metric_event() hides unused duplicates while
+		 * leaving unrelated events visible.
+		 */
+		evlist__for_each_entry(metric_evlist, metric_evsel)
+			evsel_matcher__mark_default(&args->matcher, metric_evsel);
+	}
 	return 0;
 }
 
@@ -1633,6 +1656,315 @@ int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide)
 	return ret;
 }
 
+int metricgroup__add_matching_metric_groups(struct evlist *evlist,
+					    const char *pmu,
+					    bool cputype_filter,
+					    const char *str,
+					    bool metric_no_group,
+					    bool metric_no_merge,
+					    bool metric_no_threshold,
+					    bool system_wide,
+					    bool default_metricgroup)
+{
+	struct find_matching_metrics_args args;
+	struct evlist *metric_evlist = NULL;
+	int ret;
+
+	ret = find_matching_metrics_args__init(&args, evlist, system_wide,
+					       /*match_grouping=*/!metric_no_group);
+	if (ret)
+		goto out;
+
+	metric_evlist = evlist__new();
+	if (!metric_evlist) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	evlist__set_session(metric_evlist, evlist__session(evlist));
+
+	ret = metricgroup__parse_groups(metric_evlist,
+					pmu ?: "all",
+					cputype_filter,
+					str,
+					metric_no_group,
+					metric_no_merge,
+					metric_no_threshold,
+					/*user_requested_cpu_list=*/NULL,
+					system_wide,
+					/*hardware_aware_grouping=*/false);
+	if (!ret) {
+		ret = add_matching_metric_evlist(&args, metric_evlist,
+						 default_metricgroup);
+	}
+
+out:
+	evlist__put(metric_evlist);
+	find_matching_metrics_args__exit(&args);
+	return ret;
+}
+
+static void append_recorded_metric_str(char **rec_metrics, const char *m_arg)
+{
+	char *tmp = NULL;
+
+	if (!m_arg)
+		return;
+	if (!*rec_metrics) {
+		*rec_metrics = strdup(m_arg);
+	} else if (asprintf(&tmp, "%s,%s", *rec_metrics, m_arg) >= 0) {
+		free(*rec_metrics);
+		*rec_metrics = tmp;
+	}
+}
+
+void metricgroup__add_recorded_metrics(struct evlist *evlist,
+				       const char *metrics,
+				       const char *pmu_filter,
+				       bool cputype_filter,
+				       bool metric_no_group,
+				       bool metric_no_merge,
+				       bool metric_no_threshold,
+				       bool all_metrics,
+				       bool system_wide,
+				       bool default_metricgroup,
+				       bool *metric_only)
+{
+	struct perf_env *env = evlist__env(evlist) ?: host_env();
+	struct perf_pmus *pmus = perf_env__pmus(env);
+	const char **argv = env->cmdline_argv;
+	int argc = env->nr_cmdline;
+	char *rec_metrics = NULL;
+	bool rec_transaction = false, rec_smi = false, rec_topdown = false;
+	bool rec_null = false, has_events = false, had_rec_metrics = false;
+	bool rec_metric_only = false, rec_force_metric_only = false;
+	bool rec_no_group = metric_no_group;
+	bool rec_no_merge = metric_no_merge;
+	bool rec_no_threshold = metric_no_threshold;
+	bool seen_record = false;
+	unsigned int rec_td_level = 0;
+	int rec_detailed = 0;
+
+	if (metrics) {
+		metricgroup__add_matching_metric_groups(evlist, pmu_filter,
+							cputype_filter, metrics,
+							metric_no_group,
+							metric_no_merge,
+							metric_no_threshold,
+							system_wide,
+							/*default_metricgroup=*/false);
+		if (all_metrics)
+			metricgroup__add_matching_metrics(evlist, system_wide);
+		return;
+	}
+
+	if (!argv || argc < 2 || strcmp(argv[1], "stat")) {
+		if (all_metrics)
+			metricgroup__add_matching_metrics(evlist, system_wide);
+		return;
+	}
+
+	for (int i = 2; i < argc && argv[i]; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--"))
+			break;
+
+		if (arg[0] != '-') {
+			if (!seen_record && strlen(arg) > 2 && strstarts("record", arg)) {
+				seen_record = true;
+				continue;
+			}
+			break;
+		}
+
+		if (arg[1] != '-') {
+			for (const char *p = arg + 1; *p; p++) {
+				if (*p == 'd') {
+					rec_detailed++;
+				} else if (*p == 'T') {
+					rec_transaction = true;
+				} else if (*p == 'n') {
+					rec_null = true;
+				} else if (*p == 'e') {
+					has_events = true;
+					if (!p[1])
+						i++;
+					break;
+				} else if (*p == 'M') {
+					const char *m_arg = p[1] ? p + 1 : NULL;
+
+					if (!m_arg && i + 1 < argc)
+						m_arg = argv[++i];
+					append_recorded_metric_str(&rec_metrics, m_arg);
+					break;
+				} else if (strchr("ptbrCxGoID", *p)) {
+					if (!p[1])
+						i++;
+					break;
+				}
+			}
+			continue;
+		}
+
+		if (!strcmp(arg, "--metrics") || strstarts(arg, "--metrics=")) {
+			const char *m_arg = arg[9] == '=' ? arg + 10
+							  : (i + 1 < argc ? argv[++i] : NULL);
+
+			append_recorded_metric_str(&rec_metrics, m_arg);
+		} else if (!strcmp(arg, "--transaction")) {
+			rec_transaction = true;
+		} else if (!strcmp(arg, "--smi-cost")) {
+			rec_smi = true;
+		} else if (!strcmp(arg, "--topdown")) {
+			rec_topdown = true;
+		} else if (!strcmp(arg, "--td-level") || strstarts(arg, "--td-level=")) {
+			const char *td_arg = arg[10] == '=' ? arg + 11
+							    : (i + 1 < argc ? argv[++i] : NULL);
+
+			if (td_arg)
+				rec_td_level = strtoul(td_arg, NULL, 10);
+		} else if (!strcmp(arg, "--detailed")) {
+			rec_detailed++;
+		} else if (!strcmp(arg, "--null")) {
+			rec_null = true;
+		} else if (!strcmp(arg, "--metric-only")) {
+			rec_metric_only = true;
+			rec_force_metric_only = true;
+		} else if (!strcmp(arg, "--no-metric-only")) {
+			rec_metric_only = false;
+			rec_force_metric_only = true;
+		} else if (!strcmp(arg, "--metric-no-group")) {
+			rec_no_group = true;
+		} else if (!strcmp(arg, "--no-metric-no-group")) {
+			rec_no_group = false;
+		} else if (!strcmp(arg, "--metric-no-merge")) {
+			rec_no_merge = true;
+		} else if (!strcmp(arg, "--no-metric-no-merge")) {
+			rec_no_merge = false;
+		} else if (!strcmp(arg, "--metric-no-threshold")) {
+			rec_no_threshold = true;
+		} else if (!strcmp(arg, "--no-metric-no-threshold")) {
+			rec_no_threshold = false;
+		} else if (!strcmp(arg, "--cputype") || strstarts(arg, "--cputype=")) {
+			const char *cpu_arg = arg[9] == '=' ? arg + 10
+							    : (i + 1 < argc ? argv[++i] : NULL);
+
+			if (cpu_arg) {
+				const struct perf_pmu *pmu =
+					perf_pmus__pmu_for_pmu_filter(pmus, cpu_arg);
+
+				pmu_filter = pmu ? pmu->name : cpu_arg;
+				cputype_filter = true;
+			}
+		} else if (!strcmp(arg, "--pmu-filter") || strstarts(arg, "--pmu-filter=")) {
+			pmu_filter = arg[12] == '=' ? arg + 13
+						    : (i + 1 < argc ? argv[++i] : NULL);
+			cputype_filter = false;
+		} else if (!strcmp(arg, "--event") || strstarts(arg, "--event=") ||
+			   !strcmp(arg, "--pfm-events") || strstarts(arg, "--pfm-events=")) {
+			has_events = true;
+			if (!strchr(arg, '='))
+				i++;
+		} else if (!strcmp(arg, "--iostat") || strstarts(arg, "--iostat=")) {
+			has_events = true;
+		} else if (!strchr(arg, '=') &&
+			   (!strcmp(arg, "--filter") || !strcmp(arg, "--pid") ||
+			    !strcmp(arg, "--tid") || !strcmp(arg, "--bpf-prog") ||
+			    !strcmp(arg, "--bpf-attr-map") || !strcmp(arg, "--repeat") ||
+			    !strcmp(arg, "--cpu") || !strcmp(arg, "--field-separator") ||
+			    !strcmp(arg, "--cgroup") || !strcmp(arg, "--for-each-cgroup") ||
+			    !strcmp(arg, "--output") || !strcmp(arg, "--log-fd") ||
+			    !strcmp(arg, "--pre") || !strcmp(arg, "--post") ||
+			    !strcmp(arg, "--interval-print") || !strcmp(arg, "--interval-count") ||
+			    !strcmp(arg, "--timeout") || !strcmp(arg, "--delay") ||
+			    !strcmp(arg, "--tpebs-mode") || !strcmp(arg, "--control"))) {
+			i++;
+		}
+	}
+
+	if (rec_force_metric_only && metric_only)
+		*metric_only = rec_metric_only;
+
+	if (rec_metrics) {
+		had_rec_metrics = true;
+		if (!all_metrics) {
+			metricgroup__add_matching_metric_groups(evlist, pmu_filter,
+								cputype_filter, rec_metrics,
+								rec_no_group, rec_no_merge,
+								rec_no_threshold, system_wide,
+								/*default_metricgroup=*/false);
+		}
+		zfree(&rec_metrics);
+	}
+
+	if (rec_transaction) {
+		if (!all_metrics) {
+			metricgroup__add_matching_metric_groups(evlist, pmu_filter,
+								cputype_filter, "transaction",
+								rec_no_group, rec_no_merge,
+								rec_no_threshold, system_wide,
+								/*default_metricgroup=*/false);
+		}
+	} else if (rec_smi) {
+		if (metric_only && !rec_force_metric_only && !all_metrics)
+			*metric_only = true;
+		if (!all_metrics) {
+			metricgroup__add_matching_metric_groups(evlist, pmu_filter,
+								cputype_filter, "smi",
+								rec_no_group, rec_no_merge,
+								rec_no_threshold, system_wide,
+								/*default_metricgroup=*/false);
+		}
+	} else if (rec_topdown) {
+		char str[] = "TopdownL1";
+
+		if (metric_only && !rec_force_metric_only && !all_metrics)
+			*metric_only = true;
+		if (!rec_td_level)
+			rec_td_level = 1;
+		str[8] = rec_td_level + '0';
+		if (!all_metrics) {
+			metricgroup__add_matching_metric_groups(evlist, pmu_filter,
+								cputype_filter, str,
+								/*metric_no_group=*/false,
+								/*metric_no_merge=*/false,
+								/*metric_no_threshold=*/true,
+								system_wide,
+								/*default_metricgroup=*/false);
+		}
+	} else if (!has_events && !had_rec_metrics && !rec_null) {
+		static const char * const default_names[] = {
+			"Default", "Default2", "Default3", "Default4",
+		};
+		struct evsel *evsel;
+
+		if (default_metricgroup) {
+			evlist__for_each_entry(evlist, evsel) {
+				if (!evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
+					evsel->skippable = true;
+			}
+		}
+		for (size_t i = 0; !all_metrics && i < ARRAY_SIZE(default_names); i++) {
+			if ((int)i > rec_detailed)
+				break;
+			if (!metricgroup__has_metric_or_groups(pmus, pmu_filter ?: "all",
+							       default_names[i]))
+				continue;
+			metricgroup__add_matching_metric_groups(evlist, pmu_filter,
+								cputype_filter,
+								default_names[i],
+								/*metric_no_group=*/false,
+								/*metric_no_merge=*/false,
+								/*metric_no_threshold=*/true,
+								system_wide,
+								default_metricgroup);
+		}
+	}
+
+	if (all_metrics)
+		metricgroup__add_matching_metrics(evlist, system_wide);
+}
+
 static int append_metric_id_cb(const char *metric_id, void *data)
 {
 	struct strbuf *sb = data;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 25398eafd6e2..20fb4ee3cacc 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -112,6 +112,68 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
  * Return: 0 on success or a negative error code.
  */
 int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide);
+/**
+ * metricgroup__add_matching_metric_groups() - Parse @str and attach metrics
+ *                                             whose events match @evlist.
+ * @evlist: The recorded evlist to attach matching metric expressions to.
+ * @pmu: PMU filter name or "all".
+ * @cputype_filter: Was @pmu specified via --cputype?
+ * @str: Metric or metricgroup names to parse.
+ * @metric_no_group: Do not group metric events.
+ * @metric_no_merge: Do not merge shared metric events.
+ * @metric_no_threshold: Ignore metric threshold expressions.
+ * @system_wide: Were the events recorded system-wide?
+ * @default_metricgroup: Mark matched events with Default metricgroup display flags.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int metricgroup__add_matching_metric_groups(struct evlist *evlist,
+					    const char *pmu,
+					    bool cputype_filter,
+					    const char *str,
+					    bool metric_no_group,
+					    bool metric_no_merge,
+					    bool metric_no_threshold,
+					    bool system_wide,
+					    bool default_metricgroup);
+/**
+ * metricgroup__add_recorded_metrics() - Add metrics for a recorded perf.data
+ *                                       evlist.
+ * @evlist: The recorded evlist to attach metrics to.
+ * @metrics: Explicit metric names requested by the reporting command, or NULL
+ *           to inspect the recorded perf stat command line in perf_env.
+ * @pmu_filter: Optional PMU filter string.
+ * @cputype_filter: Was @pmu_filter specified via --cputype?
+ * @metric_no_group: Default metric_no_group setting.
+ * @metric_no_merge: Default metric_no_merge setting.
+ * @metric_no_threshold: Default metric_no_threshold setting.
+ * @all_metrics: Also add all JSON metrics whose events match @evlist.
+ * @system_wide: Were the events recorded system-wide?
+ * @default_metricgroup: Enable Default metricgroup header/skip display flags.
+ * @metric_only: Optional pointer updated if the recorded command line forced
+ *               --metric-only or --no-metric-only.
+ */
+void metricgroup__add_recorded_metrics(struct evlist *evlist,
+				       const char *metrics,
+				       const char *pmu_filter,
+				       bool cputype_filter,
+				       bool metric_no_group,
+				       bool metric_no_merge,
+				       bool metric_no_threshold,
+				       bool all_metrics,
+				       bool system_wide,
+				       bool default_metricgroup,
+				       bool *metric_only);
+/**
+ * metricgroup__has_metric_or_groups() - Check if a metric or metricgroup
+ *                                       named @metric_or_groups exists.
+ * @pmus: The PMUs to search.
+ * @pmu: PMU filter name or "all".
+ * @metric_or_groups: A metric or metricgroup name.
+ *
+ * Return: true if a metric on @pmu is named @metric_or_groups or is in the
+ * metricgroup @metric_or_groups.
+ */
 bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char *pmu,
 				       const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
-- 
2.56.1.750.gf70dc682cf-goog

