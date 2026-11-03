Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749563;
	b=aT0goxssfvwxxWDHcL5TA0kJ8T6WyM/JP7spUlK+IxuwR3u0YeKGIv4xXcqQFgn4D4cu
	 QZ4ZVdN0YIf8/cf9GqBjxrbYMzJ7/nFOWMmyJqdkIvgXWC4y4ZoS+bkjjKeOsS1TyXAEE
	 ShRGBehG/w3fgVrbgQXh0zJqdF9GG9jX2LxI3EaggcXLlXs2s/7LtdxBlALyXeMhyJh5O
	 gPif8EmhVH5ZqdQW/pKV+CiWzuqcis5DNnXrti67ZCvLHib6GCY+gDSrDaj7B5LIR/ZNA
	 L3KALbabtiNBlGEvHMVPudb34YyJvweU4lo+nW11SBxgw+/8T3UdF3R0vU/UfVTlu7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZuWVF9D/v1RC3BQN8gX3daT8IPVbOhDfT9Rld0gX7Sg=;
	b=tKSts0cpKMygTgj2ha3H/iFaMtpCYWcofRb+TpVToFSV18GIpAy+ZxWyTWTZXY21Taiu
	 i6SzEN3qpS4bc/Lf5GMqfZuhclyKwT/sUgbfbxRRtWmvsillE2DZbICB9RnzJ89eYUf6C
	 TnWERq38kLX/hfBsNBN9LTzSk6c6E0zC2od0AdH5nkpw0WVSo/htfGwu7BjpV4YDiqdsC
	 l+IK2IrQXjy6sX1w8hmbxHv7BfcURSu2Dxi2clbLt21y/BHHLRLayMHJ1WQYmDTQNUn9I
	 6UbFu4cvCiQv58z4tEG1bPrL0YNkHFaQYyV8lNWOjHsLR6orf+7EGo0SNh5dsyd82Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gTe2nEWu;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F137606A32D
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F137606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gTe2nEWu
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-154e9d2d94fso414782c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749562; x=1794354362; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZuWVF9D/v1RC3BQN8gX3daT8IPVbOhDfT9Rld0gX7Sg=;
        b=gTe2nEWum/AZU9hZSCj4dSrr0Lod2kwZ96EvpsBwGMuxPAVuzNXV0MvT+ISd4JxlTS
         HPV3IMs+YY5w3rvgTTsDKfG/Jjg/HbtixHv86TTvOvXevxPlzjgOr31epUyYqPFTH8Gv
         wYXzZgl6Xkf4M+1nYDcNL+hNyRbPj/EQAAC4oUOvuqSaJDSc4nRWXTg2XLg0gZIXlzfz
         YgBYzmWcs3cub9DeRu5bWLD9q5D60I7M8ET013y8+E1v5GUkDtbHDd3VgpglFLyorNR/
         XCyyRMhEbcYS+AsM+OKHGc3glL5EyM+u7rjih6K0R1zxQ6/198XM4o9U7cY7bdlCozJG
         1Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749562; x=1794354362;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuWVF9D/v1RC3BQN8gX3daT8IPVbOhDfT9Rld0gX7Sg=;
        b=TLT0DeVVg9ZKuAniX6qmOcAm04yuiFtIYDtSIHj11MPKm0IS2Cmrln+dGMh+wKAMfE
         3ZOO9cpOqxtYi9jSkbgIU4a2MmXBV2ij1QEb+/X9R3+l8GCsZGolj7f0IEIGG/qUO+SI
         m4zRRCYGdBKE4tXuXb5HLJ6sCTDPtkxOzs8dPaVJn1TaBH4XQWlqq41H9K9YjINnmu4h
         uM7QWXORkdo9TGcAJOs4ujBcsYotMOOJnXmW5Gy7hgjec/2RdCngwHCmUkTU5v1koLJu
         KPIsdduhyY/U76lUnKFLSjFL7F4fEwwSO/yqjwz2YOWB8XXEKviJtzSnfvXrhlFQOUXF
         dhiA==
X-Gm-Message-State: APuU4Z96MXsjrUZ9QPtgp5rIzymiScbJJpxVOxB2a7vetFIJ+Aj9jE46
	u6IoSOsV0Ci2A+LAFatGtxJp/+FtKWqnXVtS+Ng3KI9i218EeDnlMHxKmbNMEaSrMoJtP2plOZr
	LDspmCkT6/iWium6XMsgBN0voo+vNEJeXh3SmoZmbeRaNxm52l2/eJIhxQW3yLKbcF/215TRoOS
	Olee5Q3jErUG8RFiE51/D7C30C4exuce7GlrA2g1Ra6ND/GGb1ig8c7zw=
X-Received: from dlbvg18.prod.google.com ([2002:a05:7022:7f12:b0:1b2:3e9d:97df])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:230e:b0:16e:6e3:9a9f
 with SMTP id a92af1059eb24-1ac5c36b66cmr22149224c88.34.1793749561151; Tue, 03
 Nov 2026 15:46:01 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:36 -0800
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
Message-ID: <20261103234502.1008382-21-irogers@google.com>
Subject: [PATCH v1 20/41] perf metricgroup: Add metricgroup__add_recorded_metrics()
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
 tools/perf/util/metricgroup.c | 311 ++++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  61 +++++++
 2 files changed, 372 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 90d22c67bfae..668106d3e08f 100644
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
@@ -1060,6 +1062,315 @@ int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide)
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
+	struct evlist *metric_evlist;
+	int ret;
+
+	ret = find_matching_metrics_args__init(&args, evlist, system_wide);
+	if (ret)
+		return ret;
+
+	metric_evlist = evlist__new();
+	if (!metric_evlist) {
+		find_matching_metrics_args__exit(&args);
+		return -ENOMEM;
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
+				if (!all_metrics)
+					evsel->default_metricgroup = true;
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
index 25398eafd6e2..7b371171d315 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -112,6 +112,67 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
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
+ * metricgroup__has_metric_or_groups() - Check if any metric or metricgroup in
+ *                                       @metric_or_groups exists for @pmus.
+ * @pmus: The PMUs to search.
+ * @pmu: PMU filter name or "all".
+ * @metric_or_groups: Comma-separated list of metric or metricgroup names.
+ *
+ * Return: true if all names in @metric_or_groups match a metric or group.
+ */
 bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char *pmu,
 				       const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
-- 
2.56.0.385.gac671c819a-goog

