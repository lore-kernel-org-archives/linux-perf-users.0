Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599692;
	b=KAfiI7ZNVbE0WIsI3wpBRgnCe+O35nL4IdE3lpzuMmIP8pwUU7BAbjq5sCY1NT4rIv34
	 fmHqu2qMw23z92pyPdYwXZQlFlMgVfix8OPMWuY8LyDG7uC/BkJNW9yu1Nn5s0p2IxqKa
	 eFHYigu27J9lhlRovjUbixMJvScDnARIwMZOVKYxdQ5Jz3fLUkn32oz7/6yLslGvPYftR
	 HaYZkU9ZrNxTGHVYNciN74YyL+3iPPQEY99Evyc5H6Ac0elffKMsEVII+N/5OzB+BhT9W
	 1ZRo8UG08xfzLwpaln2WVvJqW7lSN4CD2H2rti1HA+/fCdRyQgj/igLYN974lWeE7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Ef33p8P+lNzkgo4Zxe7nyfMSpZIl9Tn/ExeAlPLq0Kg=;
	b=Ii26fFdqV5g5xnWJYxc7qsgqMeFak+8O7UgQJnEz4t1+ryr9SciBj0rT2CBBYQGIMAOZ
	 hJvp1MbzRu21UQ0NxTlPOvA/oWmXY+S8ng1iHRSTHJ5RLtQS7V11ru6RbdxVXfT5XVs0n
	 gJ9bfpeSXHREmLxorTVvYJzufggNWxJX0BACuOIxiy5hSTzibWZRQC+zv82AqBsi5Wu1Y
	 NkXIJb/Yvz7S5JPpgb6Tzk4/rtHLSmSs8cohWsiX0275eStkQa2IzuYvKy4m/Fwxi7vfD
	 x189mTVUgdXci+nqRh6VHUNXgtukEH53DVM2OaX4lsNjKLblImPaSUnu+1Q+fMtKqGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VCyrI1dB;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641F606D0EB
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E641F606D0EB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VCyrI1dB
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36fa5673fccso2862048eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599690; x=1795204490; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ef33p8P+lNzkgo4Zxe7nyfMSpZIl9Tn/ExeAlPLq0Kg=;
        b=VCyrI1dBCo8hr8t8xjTP+hkp8AJHab+jjM+NflkuIYnabIy3x4QWaPWZ2IeO2oImfr
         MgG7C3qZSwK/bz+l6Oxz2sR3+C5pPJ2yMTVLCWHDmvh5LLbA302bLUUnBHNFdLam54cC
         cVLxoInY9NRgCqW/0QbxxQb2oiZOcTvdeiekOaCjpJvuc31mdxyRA5bGX+EO2oJv2T2T
         EF3JHgMsoAvFfXOVBi1O00RzyTxA11vhaN60BfEzL/CWmsRqIfdCAGCdq0mDWrHFBVsB
         JXvnX/o0Zm9JATww5jdVDCAJnwbu68A0GXmbxQXbBp06E8oLYIquF0F0pQvyM6LNn8Jx
         48CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599690; x=1795204490;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ef33p8P+lNzkgo4Zxe7nyfMSpZIl9Tn/ExeAlPLq0Kg=;
        b=iC4Pfi+mOH53OTOiDfqyKqtf4wXgNS7TsPEPbb59uX+P/1zEt5o7PH+nFWDQGuPmsP
         EtbfcWeG4fGYy1kNel45AiguSBQS6KmlsDCRUbirYaIGsUrBEl5pTiQfhdUU/y7iPlWl
         DP+gpR5hvCQ9YFjaKiR+zHLJPd/+BjRHr+KkB2mPijWgH6jvwmrR5OYwrjJ9LVgAcEjw
         Mf0Xr1DKqXZJgx+xyfycZFl5JBbKZEDMlKHeo4lk993lxAiVfzS6xnNH7o91/NR8J8Ha
         vBGev6P53V96TXoNqsj5Y5kjp0FW8afirnx6NJYGTR2NjzV6fBOUSnxxc3VQVKt3HtHx
         Wneg==
X-Gm-Message-State: APuU4Z8Dat9hunS63mDpyC/kieQOcafZ6pfD6RFDcGbUvXNI8hg5UibH
	uZyOlum/OdKKUIktCQtNurx11Wdu2FM0EfTz02jSctXt1loJ2+V5LgVcPVYJrQijtAUvMuZaS38
	XHZan4j3Tvw==
X-Received: from dybkz20.prod.google.com ([2002:a05:7301:1a14:b0:370:948e:79b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:41c7:20b0:371:ede8:3e9b
 with SMTP id 5a478bee46e88-379680cf32amr3214604eec.36.1794599689708; Fri, 13
 Nov 2026 11:54:49 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:32 -0800
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
Message-ID: <20261113195335.2865725-28-irogers@google.com>
Subject: [PATCH v2 27/30] perf metricgroup: Add metricgroup__add_recorded_metrics()
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
index f41e11a9a3e7..0918a3758bce 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -20,6 +20,8 @@
 #include "tool_pmu.h"
 #include "expr.h"
 #include "rblist.h"
+#include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 #include "strlist.h"
@@ -1281,25 +1283,34 @@ static bool metric_events__contains(struct rblist *metric_events, const struct m
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
@@ -1342,6 +1353,7 @@ static int add_matching_metric_evlist(struct find_matching_metrics_args *args,
 								 pos->pmu, data_evsel);
 				if (!copy)
 					continue;
+				any_matched = true;
 				if (metric_events__contains(evlist__metric_events(data_evlist),
 							    copy)) {
 					metric_expr__delete(copy);
@@ -1362,6 +1374,17 @@ static int add_matching_metric_evlist(struct find_matching_metrics_args *args,
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
 
@@ -1460,6 +1483,315 @@ int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide)
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
2.56.1.703.gf848ed807c-goog

