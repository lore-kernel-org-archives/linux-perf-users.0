Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D861D47D2
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847024; cv=none; b=PLP9IqQUKJlcHxLgMB/eGJn9JuJhK+BY42nBE2ac73HZGoVWjCqeoL9y5CtJUyy9aGExtDJ1SZZ5B+9i/JT7Hx3i4WJARKtmA+L7gUwOLmfiAM57yXnEuMP4iKuHd52/hwwC8qse3gQHKkjLAf493e0XlM+c1wQaOKYAfnBu0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847024; c=relaxed/simple;
	bh=hndESY0fTHq3ihnMSf4uOT1Ww2EQSwidUL8QqXZoiKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfZAdsaAaaFA0ZUL4Jb1vli8KF9Pzk972ujEniM2Z1/TTLzqJsd2lsF0Qu2B7RTB4jraLrAqFPHI9XOvtrKvOffqpLimxPOYkD5TyCQPCcj6aMLrs7XFw7YLMgIgxncNolpTvvKe+y2NK+w69iypcELRdrpjmmN+PjrYUZKLskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EAsr/TEU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAsr/TEU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d808ae924so1270291f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 02:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729847019; x=1730451819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLjvkm8Yhd4wQCCeRrOFLXQ8waVtWTu3jnkxfp+th8s=;
        b=EAsr/TEU8NdrP2iv4soa5WPUzoCdD3PQz4Wh+/ln3HeAbqGnOh1msvRkdHBk80CHlX
         oRlsC3oXx621g+3cauEop9yuSjYl/i9aiqh0UMo46b745pB7f8OiRl2kJffxRKpxHHg0
         iLGpuoCy/TNwDTAlIZB4/q+WJa7jsf3WVU+UseaW2KmEzesyuEmb+piC0oa4raEQlY0l
         NvASPanxKkpeQHp60/3eRtuD1o71AgWVEvFPZPglSiTVSqqd6kkRPhVWV3Skzl+tQSy5
         4ilBE5/PhHC7cNS+cq9jxCL0I6RnrAKqE0K3XqlPoaxuF4o4McDgvz6mz2rUfNj5df9G
         yOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847019; x=1730451819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLjvkm8Yhd4wQCCeRrOFLXQ8waVtWTu3jnkxfp+th8s=;
        b=gscWlueAnRly4DSDYd1lgZ5pjS4FgDwBn61RUMM5V0IuryR8w0Mr4u2e/s75cNnU0U
         lfGcPJ7YY8fwTRVfRDkOPxlnBym13c1DuSfmvfRub/ZURqXJKjP4Kkr5cV71q9jEbwJM
         bF9lv+BNYPa1yuHzEKnFv/a+piuED9nG8V/k5iQ7tN+p0r9a4ov3jsSCIr7KTglRl4lP
         UNtimMsBfolwiYXyCQRg+5+FhUkblRyVm503+CZdTEj/GXX9oi+4aTioGXr7/Z5qLpKL
         2dTmH3KilJDJpMJ4uSPZ51aaO5mINDXG7ayJ4bwMEDzu6EFUVoBVo7usQfz+IX73U56o
         CZUg==
X-Gm-Message-State: AOJu0YxqzTL6fUYididyPO6CoWrm6cXi9I8IhsY7nhKN4YxgD2j8Cifo
	7cZQzOTdUFZrqI5oSxEQdQ3XnS0KleNSHP+rIMwh4tQrOVJd7MaxDzXEFQOJ37kOJ39xU+Y3wF8
	qc2o=
X-Google-Smtp-Source: AGHT+IHzhIXfOJWzW4ipHHbIFJ4xgk6necEzEs8gRHYdZy5NwygeG64gB6emse7Doxm9eoFg/reDpw==
X-Received: by 2002:adf:f48d:0:b0:37d:481e:fca with SMTP id ffacd0b85a97d-38045865cb0mr3470914f8f.27.1729847018404;
        Fri, 25 Oct 2024 02:03:38 -0700 (PDT)
Received: from pop-os.. ([145.224.65.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c73sm988689f8f.72.2024.10.25.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:03:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf stat: Fix trailing comma when there is no metric unit
Date: Fri, 25 Oct 2024 10:03:04 +0100
Message-Id: <20241025090307.59127-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025090307.59127-1-james.clark@linaro.org>
References: <20241025090307.59127-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that printing metric-value and metric-unit is optional,
print_running_json() shouldn't add the comma in case it becomes
trailing.

Replace all manual json comma stuff with a json_out() function that uses
the existing os->first tracking and auto inserts a comma if it's needed.
Update the test to handle that two of the fields can be missing.

This fixes the following test failure on Cortex A57 where the branch
misses metric is missing a required event:

 $ perf test -vvv "json output"

 106: perf stat JSON output linter:
 --- start ---
 test child forked, pid 665682
 Checking json output: no args Test failed for input:
 ...
 {"counter-value" : "3112.000000", "unit" : "",
  "event" : "armv8_pmuv3_1/branch-misses/",
  "event-runtime" : 20699340, "pcnt-running" : 100.00, }
 ...
 json.decoder.JSONDecodeError: Expecting property name enclosed in
 double quotes: line 12 column 144 (char 2109)
 ---- end(-1) ----
 106: perf stat JSON output linter                 : FAILED!

Fixes: e1cc918b6cfd ("perf stat: Drop metric-unit if unit is NULL")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/util/stat-display.c                | 177 ++++++++++--------
 2 files changed, 104 insertions(+), 87 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 8ddb85586131..b066d721f897 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -69,16 +69,16 @@ def check_json_output(expected_items):
   for item in json.loads(input):
     if expected_items != -1:
       count = len(item)
-      if count != expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
+      if count not in expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
         # Events that generate >1 metric may have isolated metric
         # values and possibly other prefixes like interval, core,
         # aggregate-number, or event-runtime/pcnt-running from multiplexing.
         pass
-      elif count != expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
+      elif count not in expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
         pass
-      elif count == expected_items + 1 and 'metric-threshold' in item:
+      elif count - 1 in expected_items and 'metric-threshold' in item:
           pass
-      elif count != expected_items:
+      elif count not in expected_items:
         raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
                            f' in \'{item}\'')
     for key, value in item.items():
@@ -90,11 +90,11 @@ def check_json_output(expected_items):
 
 try:
   if args.no_args or args.system_wide or args.event:
-    expected_items = 7
+    expected_items = [5, 7]
   elif args.interval or args.per_thread or args.system_wide_no_aggr:
-    expected_items = 8
+    expected_items = [6, 8]
   elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cluster or args.per_cache:
-    expected_items = 9
+    expected_items = [7, 9]
   else:
     # If no option is specified, don't check the number of items.
     expected_items = -1
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 53dcdf07f5a2..a5d72f4a515c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -114,23 +114,44 @@ static void print_running_csv(struct perf_stat_config *config, u64 run, u64 ena)
 	fprintf(config->output, "%s%" PRIu64 "%s%.2f",
 		config->csv_sep, run, config->csv_sep, enabled_percent);
 }
+struct outstate {
+	FILE *fh;
+	bool newline;
+	bool first;
+	const char *prefix;
+	int  nfields;
+	int  aggr_nr;
+	struct aggr_cpu_id id;
+	struct evsel *evsel;
+	struct cgroup *cgrp;
+};
 
-static void print_running_json(struct perf_stat_config *config, u64 run, u64 ena)
+static const char *json_sep(struct outstate *os)
+{
+	const char *sep = os->first ? "" : ", ";
+
+	os->first = false;
+	return sep;
+}
+
+#define json_out(os, format, ...) fprintf((os)->fh, "%s" format, json_sep(os), ##__VA_ARGS__)
+
+static void print_running_json(struct outstate *os, u64 run, u64 ena)
 {
 	double enabled_percent = 100;
 
 	if (run != ena)
 		enabled_percent = 100 * run / ena;
-	fprintf(config->output, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f, ",
-		run, enabled_percent);
+	json_out(os, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f",
+		 run, enabled_percent);
 }
 
-static void print_running(struct perf_stat_config *config,
+static void print_running(struct perf_stat_config *config, struct outstate *os,
 			  u64 run, u64 ena, bool before_metric)
 {
 	if (config->json_output) {
 		if (before_metric)
-			print_running_json(config, run, ena);
+			print_running_json(os, run, ena);
 	} else if (config->csv_output) {
 		if (before_metric)
 			print_running_csv(config, run, ena);
@@ -153,20 +174,20 @@ static void print_noise_pct_csv(struct perf_stat_config *config,
 	fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
 }
 
-static void print_noise_pct_json(struct perf_stat_config *config,
+static void print_noise_pct_json(struct outstate *os,
 				 double pct)
 {
-	fprintf(config->output, "\"variance\" : %.2f, ", pct);
+	json_out(os, "\"variance\" : %.2f", pct);
 }
 
-static void print_noise_pct(struct perf_stat_config *config,
+static void print_noise_pct(struct perf_stat_config *config, struct outstate *os,
 			    double total, double avg, bool before_metric)
 {
 	double pct = rel_stddev_stats(total, avg);
 
 	if (config->json_output) {
 		if (before_metric)
-			print_noise_pct_json(config, pct);
+			print_noise_pct_json(os, pct);
 	} else if (config->csv_output) {
 		if (before_metric)
 			print_noise_pct_csv(config, pct);
@@ -176,7 +197,7 @@ static void print_noise_pct(struct perf_stat_config *config,
 	}
 }
 
-static void print_noise(struct perf_stat_config *config,
+static void print_noise(struct perf_stat_config *config, struct outstate *os,
 			struct evsel *evsel, double avg, bool before_metric)
 {
 	struct perf_stat_evsel *ps;
@@ -185,7 +206,7 @@ static void print_noise(struct perf_stat_config *config,
 		return;
 
 	ps = evsel->stats;
-	print_noise_pct(config, stddev_stats(&ps->res_stats), avg, before_metric);
+	print_noise_pct(config, os, stddev_stats(&ps->res_stats), avg, before_metric);
 }
 
 static void print_cgroup_std(struct perf_stat_config *config, const char *cgrp_name)
@@ -198,18 +219,19 @@ static void print_cgroup_csv(struct perf_stat_config *config, const char *cgrp_n
 	fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
 }
 
-static void print_cgroup_json(struct perf_stat_config *config, const char *cgrp_name)
+static void print_cgroup_json(struct outstate *os, const char *cgrp_name)
 {
-	fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
+	json_out(os, "\"cgroup\" : \"%s\"", cgrp_name);
 }
 
-static void print_cgroup(struct perf_stat_config *config, struct cgroup *cgrp)
+static void print_cgroup(struct perf_stat_config *config, struct outstate *os,
+			 struct cgroup *cgrp)
 {
 	if (nr_cgroups || config->cgroup_list) {
 		const char *cgrp_name = cgrp ? cgrp->name  : "";
 
 		if (config->json_output)
-			print_cgroup_json(config, cgrp_name);
+			print_cgroup_json(os, cgrp_name);
 		else if (config->csv_output)
 			print_cgroup_csv(config, cgrp_name);
 		else
@@ -324,47 +346,45 @@ static void print_aggr_id_csv(struct perf_stat_config *config,
 	}
 }
 
-static void print_aggr_id_json(struct perf_stat_config *config,
+static void print_aggr_id_json(struct perf_stat_config *config, struct outstate *os,
 			       struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
-	FILE *output = config->output;
-
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
+		json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d",
 			id.socket, id.die, id.core, aggr_nr);
 		break;
 	case AGGR_CACHE:
-		fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggregate-number\" : %d, ",
+		json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggregate-number\" : %d",
 			id.socket, id.die, id.cache_lvl, id.cache, aggr_nr);
 		break;
 	case AGGR_CLUSTER:
-		fprintf(output, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregate-number\" : %d, ",
+		json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregate-number\" : %d",
 			id.socket, id.die, id.cluster, aggr_nr);
 		break;
 	case AGGR_DIE:
-		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
+		json_out(os, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d",
 			id.socket, id.die, aggr_nr);
 		break;
 	case AGGR_SOCKET:
-		fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
+		json_out(os, "\"socket\" : \"S%d\", \"aggregate-number\" : %d",
 			id.socket, aggr_nr);
 		break;
 	case AGGR_NODE:
-		fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
+		json_out(os, "\"node\" : \"N%d\", \"aggregate-number\" : %d",
 			id.node, aggr_nr);
 		break;
 	case AGGR_NONE:
 		if (evsel->percore && !config->percore_show_thread) {
-			fprintf(output, "\"core\" : \"S%d-D%d-C%d\"",
+			json_out(os, "\"core\" : \"S%d-D%d-C%d\"",
 				id.socket, id.die, id.core);
 		} else if (id.cpu.cpu > -1) {
-			fprintf(output, "\"cpu\" : \"%d\", ",
+			json_out(os, "\"cpu\" : \"%d\"",
 				id.cpu.cpu);
 		}
 		break;
 	case AGGR_THREAD:
-		fprintf(output, "\"thread\" : \"%s-%d\", ",
+		json_out(os, "\"thread\" : \"%s-%d\"",
 			perf_thread_map__comm(evsel->core.threads, id.thread_idx),
 			perf_thread_map__pid(evsel->core.threads, id.thread_idx));
 		break;
@@ -376,29 +396,17 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 	}
 }
 
-static void aggr_printout(struct perf_stat_config *config,
+static void aggr_printout(struct perf_stat_config *config, struct outstate *os,
 			  struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
 	if (config->json_output)
-		print_aggr_id_json(config, evsel, id, aggr_nr);
+		print_aggr_id_json(config, os, evsel, id, aggr_nr);
 	else if (config->csv_output)
 		print_aggr_id_csv(config, evsel, id, aggr_nr);
 	else
 		print_aggr_id_std(config, evsel, id, aggr_nr);
 }
 
-struct outstate {
-	FILE *fh;
-	bool newline;
-	bool first;
-	const char *prefix;
-	int  nfields;
-	int  aggr_nr;
-	struct aggr_cpu_id id;
-	struct evsel *evsel;
-	struct cgroup *cgrp;
-};
-
 static void new_line_std(struct perf_stat_config *config __maybe_unused,
 			 void *ctx)
 {
@@ -413,7 +421,7 @@ static inline void __new_line_std_csv(struct perf_stat_config *config,
 	fputc('\n', os->fh);
 	if (os->prefix)
 		fputs(os->prefix, os->fh);
-	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
+	aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
 }
 
 static inline void __new_line_std(struct outstate *os)
@@ -499,9 +507,9 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	FILE *out = os->fh;
 
 	if (unit) {
-		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
+		json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 		if (thresh != METRIC_THRESHOLD_UNKNOWN) {
-			fprintf(out, ", \"metric-threshold\" : \"%s\"",
+			json_out(os, "\"metric-threshold\" : \"%s\"",
 				metric_threshold_classify__str(thresh));
 		}
 	}
@@ -514,9 +522,11 @@ static void new_line_json(struct perf_stat_config *config, void *ctx)
 	struct outstate *os = ctx;
 
 	fputs("\n{", os->fh);
+	os->first = true;
 	if (os->prefix)
-		fprintf(os->fh, "%s", os->prefix);
-	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
+		json_out(os, "%s", os->prefix);
+
+	aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
 }
 
 static void print_metricgroup_header_json(struct perf_stat_config *config,
@@ -526,7 +536,7 @@ static void print_metricgroup_header_json(struct perf_stat_config *config,
 	if (!metricgroup_name)
 		return;
 
-	fprintf(config->output, "\"metricgroup\" : \"%s\"}", metricgroup_name);
+	json_out((struct outstate *) ctx, "\"metricgroup\" : \"%s\"}", metricgroup_name);
 	new_line_json(config, ctx);
 }
 
@@ -644,7 +654,6 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 				  const char *unit, double val)
 {
 	struct outstate *os = ctx;
-	FILE *out = os->fh;
 	char buf[64], *ends;
 	char tbuf[1024];
 	const char *vals;
@@ -661,8 +670,7 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 	*ends = 0;
 	if (!vals[0])
 		vals = "none";
-	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
-	os->first = false;
+	json_out(os, "\"%s\" : \"%s\"", unit, vals);
 }
 
 static void new_line_metric(struct perf_stat_config *config __maybe_unused,
@@ -743,28 +751,27 @@ static void print_counter_value_csv(struct perf_stat_config *config,
 	fprintf(output, "%s", evsel__name(evsel));
 }
 
-static void print_counter_value_json(struct perf_stat_config *config,
+static void print_counter_value_json(struct outstate *os,
 				     struct evsel *evsel, double avg, bool ok)
 {
-	FILE *output = config->output;
 	const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
 
 	if (ok)
-		fprintf(output, "\"counter-value\" : \"%f\", ", avg);
+		json_out(os, "\"counter-value\" : \"%f\"", avg);
 	else
-		fprintf(output, "\"counter-value\" : \"%s\", ", bad_count);
+		json_out(os, "\"counter-value\" : \"%s\"", bad_count);
 
 	if (evsel->unit)
-		fprintf(output, "\"unit\" : \"%s\", ", evsel->unit);
+		json_out(os, "\"unit\" : \"%s\"", evsel->unit);
 
-	fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
+	json_out(os, "\"event\" : \"%s\"", evsel__name(evsel));
 }
 
-static void print_counter_value(struct perf_stat_config *config,
+static void print_counter_value(struct perf_stat_config *config, struct outstate *os,
 				struct evsel *evsel, double avg, bool ok)
 {
 	if (config->json_output)
-		print_counter_value_json(config, evsel, avg, ok);
+		print_counter_value_json(os, evsel, avg, ok);
 	else if (config->csv_output)
 		print_counter_value_csv(config, evsel, avg, ok);
 	else
@@ -772,12 +779,13 @@ static void print_counter_value(struct perf_stat_config *config,
 }
 
 static void abs_printout(struct perf_stat_config *config,
+			 struct outstate *os,
 			 struct aggr_cpu_id id, int aggr_nr,
 			 struct evsel *evsel, double avg, bool ok)
 {
-	aggr_printout(config, evsel, id, aggr_nr);
-	print_counter_value(config, evsel, avg, ok);
-	print_cgroup(config, evsel->cgrp);
+	aggr_printout(config, os, evsel, id, aggr_nr);
+	print_counter_value(config, os, evsel, avg, ok);
+	print_cgroup(config, os, evsel->cgrp);
 }
 
 static bool is_mixed_hw_group(struct evsel *counter)
@@ -868,17 +876,17 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	out.force_header = false;
 
 	if (!config->metric_only && !counter->default_metricgroup) {
-		abs_printout(config, os->id, os->aggr_nr, counter, uval, ok);
+		abs_printout(config, os, os->id, os->aggr_nr, counter, uval, ok);
 
-		print_noise(config, counter, noise, /*before_metric=*/true);
-		print_running(config, run, ena, /*before_metric=*/true);
+		print_noise(config, os, counter, noise, /*before_metric=*/true);
+		print_running(config, os, run, ena, /*before_metric=*/true);
 	}
 
 	if (ok) {
 		if (!config->metric_only && counter->default_metricgroup) {
 			void *from = NULL;
 
-			aggr_printout(config, os->evsel, os->id, os->aggr_nr);
+			aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
 			/* Print out all the metricgroup with the same metric event. */
 			do {
 				int num = 0;
@@ -891,8 +899,8 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 						__new_line_std_csv(config, os);
 				}
 
-				print_noise(config, counter, noise, /*before_metric=*/true);
-				print_running(config, run, ena, /*before_metric=*/true);
+				print_noise(config, os, counter, noise, /*before_metric=*/true);
+				print_running(config, os, run, ena, /*before_metric=*/true);
 				from = perf_stat__print_shadow_stats_metricgroup(config, counter, aggr_idx,
 										 &num, from, &out,
 										 &config->metric_events);
@@ -905,8 +913,8 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	}
 
 	if (!config->metric_only) {
-		print_noise(config, counter, noise, /*before_metric=*/false);
-		print_running(config, run, ena, /*before_metric=*/false);
+		print_noise(config, os, counter, noise, /*before_metric=*/false);
+		print_running(config, os, run, ena, /*before_metric=*/false);
 	}
 }
 
@@ -1083,12 +1091,17 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 		return;
 
 	if (!metric_only) {
-		if (config->json_output)
+		if (config->json_output) {
+			os->first = true;
 			fputc('{', output);
-		if (os->prefix)
-			fprintf(output, "%s", os->prefix);
-		else if (config->summary && config->csv_output &&
-			 !config->no_csv_summary && !config->interval)
+		}
+		if (os->prefix) {
+			if (config->json_output)
+				json_out(os, "%s", os->prefix);
+			else
+				fprintf(output, "%s", os->prefix);
+		} else if (config->summary && config->csv_output &&
+			   !config->no_csv_summary && !config->interval)
 			fprintf(output, "%s%s", "summary", config->csv_sep);
 	}
 
@@ -1114,15 +1127,19 @@ static void print_metric_begin(struct perf_stat_config *config,
 
 	if (config->json_output)
 		fputc('{', config->output);
-	if (os->prefix)
-		fprintf(config->output, "%s", os->prefix);
 
+	if (os->prefix) {
+		if (config->json_output)
+			json_out(os, "%s", os->prefix);
+		else
+			fprintf(config->output, "%s", os->prefix);
+	}
 	evsel = evlist__first(evlist);
 	id = config->aggr_map->map[aggr_idx];
 	aggr = &evsel->stats->aggr[aggr_idx];
-	aggr_printout(config, evsel, id, aggr->nr);
+	aggr_printout(config, os, evsel, id, aggr->nr);
 
-	print_cgroup(config, os->cgrp ? : evsel->cgrp);
+	print_cgroup(config, os, os->cgrp ? : evsel->cgrp);
 }
 
 static void print_metric_end(struct perf_stat_config *config, struct outstate *os)
@@ -1343,7 +1360,7 @@ static void prepare_interval(struct perf_stat_config *config,
 		return;
 
 	if (config->json_output)
-		scnprintf(prefix, len, "\"interval\" : %lu.%09lu, ",
+		scnprintf(prefix, len, "\"interval\" : %lu.%09lu",
 			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 	else if (config->csv_output)
 		scnprintf(prefix, len, "%lu.%09lu%s",
@@ -1557,7 +1574,7 @@ static void print_footer(struct perf_stat_config *config)
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
 			precision, avg, precision, sd);
 
-		print_noise_pct(config, sd, avg, /*before_metric=*/false);
+		print_noise_pct(config, NULL, sd, avg, /*before_metric=*/false);
 	}
 	fprintf(output, "\n\n");
 
-- 
2.34.1

