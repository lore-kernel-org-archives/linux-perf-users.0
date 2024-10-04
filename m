Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1015920B
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085298; cv=none; b=DGJHNl8ZUMOWFQ24dL68jHUd+/T9ZkTXF5Uy/DW34SOIAbmV25Uis0bH0NWRCtv+x/1rwcYNp8Cw11sB10j1e1V5kq045Enz5zGYNvzm7edAsS/UxMjXiUR0iCoOVOZgwg92AYnVBOnnnnmvGUgmkyn6ASMZRmL7/aog0VgoP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085298; c=relaxed/simple;
	bh=eAeWj+dfa09lZhT7LmiGlH7KRUiexZ7z7VtbZvIM64Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MRzXd4ssLF1udX3ml9VSwA67BJDeqGVAxAR2fUNFBoj/oLEpHiaDYKFIYh7N3HsOmeCk6qYGq+OlSCs2veWNraO/vVdwAmSvaTpZFeuPxLvBHFGtT545IJYF/b1nOT260NuCWYKFE+Ighd6L/1u3y3F5I0Pw0mfo0aHxR1AZOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSgu/vwC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSgu/vwC"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso3994796276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085295; x=1728690095; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCnY8Lk9xKf0rzzmE4bkdPpj0hlyaDEDE7XtDK4a/8I=;
        b=PSgu/vwCESTA+BUaA6FqPxtYVcNAakX8rQiUDN2HFz7kW7gCReK6HBZJ55aw/Iaupm
         nGAsh/7wo9MYNkEIlk9XOIG5EcPTLREHAywqcvSGR+ZaSeq7863NDvjbjaFLRpBbFiqn
         S5FN+qfslN47hvin2pe+n3J+KoOl5xNMexJSJ+Tv8uOTZ+DP4BepPpfzWj3w4+RNrjKt
         wUXpg2EeDHhR6CsLyujPvsjB8/jAAVc5p8G4PnyBDVsGVImC28CZQtIhl88gSvNzG0NJ
         d2k0cbl7dcRkseZpCDPuKQQDwBXZXrUaNbERpIGDhlRq7gdhhdIPrP7hKuCFGCMuZr7L
         VCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085295; x=1728690095;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCnY8Lk9xKf0rzzmE4bkdPpj0hlyaDEDE7XtDK4a/8I=;
        b=cQ/IV1GrlTUR+x4Z9coSQ+IIzAddfPBZxIedAW4RQxLf1Q45wJkxeVNZwEYWCqrAsY
         qiJEdQGQ94uoeBMox2BkLGYOreL7E9mlWiVJf+2MJNqJtBX07SE5SC1c5InB4R3ywnpQ
         tZiJosMjG8aGWAtucRQuaPU/VKCAyFqUIaVwG28kqrUnkeYbBY35pX8VsxxgEgaBU37W
         +0YWF89rcGrXcAKvZzHcI+r50QAboNeknXAjQsb1sNtMCkql9+HwSgpCImGmbUBoISts
         mmalQkoSiGf00dmAtse+tXYR+8ujVn3HFFw2DMelvJ4qbQqPnfuXLETmTXKj2zKp4l+D
         x53g==
X-Forwarded-Encrypted: i=1; AJvYcCXzvCVKCepxNjXYBxk6U+7KT2O+9QH2XyH2pPdl3nrsZaVau576Xo+g0yLLzZFRDg8UE780hatU1p6xC9zfBnMN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywju55DfKiXQlFBGRBqgDLkAPJFfvlB93KzlM+d/XaI2xD+e+34
	S/qTTiQFCXpD6RnmeGGiqjOH78fnH9catftr/9UXVj9/aFzvO3/hUl3UlDicBl6QM5TA7TSyxcJ
	XUSvVuw==
X-Google-Smtp-Source: AGHT+IF/D1lzdKPwnfFKYHfMx8s/tVQly+6TaIflIAubFNFwvIxoIC1Khb87YvYmWJyNFDg+i72eoDzxmcl5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:ec09:0:b0:e25:cf7f:a065 with SMTP id
 3f1490d57ef6-e289392aee3mr10575276.8.1728085294844; Fri, 04 Oct 2024 16:41:34
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:17 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 5/8] perf stat: Change color to threshold in print_metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Colors don't mean things in CSV and JSON output, switch to a threshold
enum value that the standard output can convert to a color. Updating
the CSV and JSON output will be later changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/iostat.c |   2 +-
 tools/perf/builtin-script.c       |   6 +-
 tools/perf/util/stat-display.c    |  40 ++++++++----
 tools/perf/util/stat-shadow.c     | 105 +++++++++++++++---------------
 tools/perf/util/stat.h            |  12 +++-
 5 files changed, 97 insertions(+), 68 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index df7b5dfcc26a..366b44d0bb7e 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -444,7 +444,7 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 		iostat_value = (count->val - prev_count_val) /
 			       ((double) count->run / count->ena);
 	}
-	out->print_metric(config, out->ctx, NULL, "%8.0f", iostat_metric,
+	out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, "%8.0f", iostat_metric,
 			  iostat_value / (256 * 1024));
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a644787fa9e1..8c5d5cecfba4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2136,11 +2136,11 @@ struct metric_ctx {
 };
 
 static void script_print_metric(struct perf_stat_config *config __maybe_unused,
-				void *ctx, const char *color,
-			        const char *fmt,
-			        const char *unit, double val)
+				void *ctx, enum metric_threshold_classify thresh,
+				const char *fmt, const char *unit, double val)
 {
 	struct metric_ctx *mctx = ctx;
+	const char *color = metric_threshold_classify__color(thresh);
 
 	if (!fmt)
 		return;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 9b65968e37d1..0035f92274bc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -72,6 +72,19 @@ static const char *aggr_header_std[] = {
 	[AGGR_GLOBAL] 	=	""
 };
 
+const char *metric_threshold_classify__color(enum metric_threshold_classify thresh)
+{
+	const char * const colors[] = {
+		"", /* unknown */
+		PERF_COLOR_RED,     /* bad */
+		PERF_COLOR_MAGENTA, /* nearly bad */
+		PERF_COLOR_YELLOW,  /* less good */
+		PERF_COLOR_GREEN,   /* good */
+	};
+	static_assert(ARRAY_SIZE(colors) - 1  == METRIC_THRESHOLD_GOOD, "missing enum value");
+	return colors[thresh];
+}
+
 static void print_running_std(struct perf_stat_config *config, u64 run, u64 ena)
 {
 	if (run != ena)
@@ -404,13 +417,14 @@ static void do_new_line_std(struct perf_stat_config *config,
 }
 
 static void print_metric_std(struct perf_stat_config *config,
-			     void *ctx, const char *color, const char *fmt,
-			     const char *unit, double val)
+			     void *ctx, enum metric_threshold_classify thresh,
+			     const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	int n;
 	bool newline = os->newline;
+	const char *color = metric_threshold_classify__color(thresh);
 
 	os->newline = false;
 
@@ -442,7 +456,7 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 
 static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 			     void *ctx,
-			     const char *color __maybe_unused,
+			     enum metric_threshold_classify thresh __maybe_unused,
 			     const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
@@ -463,7 +477,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 
 static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 			     void *ctx,
-			     const char *color __maybe_unused,
+			     enum metric_threshold_classify thresh __maybe_unused,
 			     const char *fmt __maybe_unused,
 			     const char *unit, double val)
 {
@@ -559,13 +573,14 @@ static const char *fixunit(char *buf, struct evsel *evsel,
 }
 
 static void print_metric_only(struct perf_stat_config *config,
-			      void *ctx, const char *color, const char *fmt,
-			      const char *unit, double val)
+			      void *ctx, enum metric_threshold_classify thresh,
+			      const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
 	unsigned mlen = config->metric_only_len;
+	const char *color = metric_threshold_classify__color(thresh);
 
 	if (!valid_only_metric(unit))
 		return;
@@ -582,7 +597,8 @@ static void print_metric_only(struct perf_stat_config *config,
 }
 
 static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused,
-				  void *ctx, const char *color __maybe_unused,
+				  void *ctx,
+				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
 				  const char *unit, double val)
 {
@@ -604,7 +620,8 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 }
 
 static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
-				  void *ctx, const char *color __maybe_unused,
+				  void *ctx,
+				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
 				  const char *unit, double val)
 {
@@ -636,7 +653,8 @@ static void new_line_metric(struct perf_stat_config *config __maybe_unused,
 }
 
 static void print_metric_header(struct perf_stat_config *config,
-				void *ctx, const char *color __maybe_unused,
+				void *ctx,
+				enum metric_threshold_classify thresh __maybe_unused,
 				const char *fmt __maybe_unused,
 				const char *unit, double val __maybe_unused)
 {
@@ -810,7 +828,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
-			pm(config, os, NULL, "", "", 0);
+			pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);
 			return;
 		}
 
@@ -865,7 +883,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
 						      &out, &config->metric_events);
 	} else {
-		pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
+		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/"", /*val=*/0);
 	}
 
 	if (!config->metric_only) {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 1e6ba6bf244a..7de4e63718b9 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -136,18 +136,14 @@ static enum stat_type evsel__stat_type(struct evsel *evsel)
 	return STAT_NONE;
 }
 
-static const char *get_ratio_color(const double ratios[3], double val)
+static enum metric_threshold_classify get_ratio_thresh(const double ratios[3], double val)
 {
-	const char *color = PERF_COLOR_NORMAL;
+	assert(ratios[0] > ratios[1]);
+	assert(ratios[1] > ratios[2]);
 
-	if (val > ratios[0])
-		color = PERF_COLOR_RED;
-	else if (val > ratios[1])
-		color = PERF_COLOR_MAGENTA;
-	else if (val > ratios[2])
-		color = PERF_COLOR_YELLOW;
-
-	return color;
+	return val > ratios[1]
+		? (val > ratios[0] ? METRIC_THRESHOLD_BAD : METRIC_THRESHOLD_NEARLY_BAD)
+		: (val > ratios[2] ? METRIC_THRESHOLD_LESS_GOOD : METRIC_THRESHOLD_GOOD);
 }
 
 static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type type)
@@ -195,21 +191,21 @@ static void print_ratio(struct perf_stat_config *config,
 			const struct evsel *evsel, int aggr_idx,
 			double numerator, struct perf_stat_output_ctx *out,
 			enum stat_type denominator_type,
-			const double color_ratios[3], const char *_unit)
+			const double thresh_ratios[3], const char *_unit)
 {
 	double denominator = find_stat(evsel, aggr_idx, denominator_type);
 	double ratio = 0;
-	const char *color = NULL;
+	enum metric_threshold_classify thresh = METRIC_THRESHOLD_UNKNOWN;
 	const char *fmt = NULL;
 	const char *unit = NULL;
 
 	if (numerator && denominator) {
 		ratio = numerator / denominator * 100.0;
-		color = get_ratio_color(color_ratios, ratio);
+		thresh = get_ratio_thresh(thresh_ratios, ratio);
 		fmt = "%7.2f%%";
 		unit = _unit;
 	}
-	out->print_metric(config, out->ctx, color, fmt, unit, ratio);
+	out->print_metric(config, out->ctx, thresh, fmt, unit, ratio);
 }
 
 static void print_stalled_cycles_front(struct perf_stat_config *config,
@@ -217,9 +213,9 @@ static void print_stalled_cycles_front(struct perf_stat_config *config,
 				int aggr_idx, double stalled,
 				struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {50.0, 30.0, 10.0};
+	const double thresh_ratios[3] = {50.0, 30.0, 10.0};
 
-	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, color_ratios,
+	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, thresh_ratios,
 		    "frontend cycles idle");
 }
 
@@ -228,9 +224,9 @@ static void print_stalled_cycles_back(struct perf_stat_config *config,
 				int aggr_idx, double stalled,
 				struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {75.0, 50.0, 20.0};
+	const double thresh_ratios[3] = {75.0, 50.0, 20.0};
 
-	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, color_ratios,
+	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, thresh_ratios,
 		    "backend cycles idle");
 }
 
@@ -239,9 +235,9 @@ static void print_branch_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_BRANCHES, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_BRANCHES, thresh_ratios,
 		    "of all branches");
 }
 
@@ -250,9 +246,9 @@ static void print_l1d_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_DCACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_DCACHE, thresh_ratios,
 		    "of all L1-dcache accesses");
 }
 
@@ -261,9 +257,9 @@ static void print_l1i_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_ICACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_ICACHE, thresh_ratios,
 		    "of all L1-icache accesses");
 }
 
@@ -272,9 +268,9 @@ static void print_ll_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, thresh_ratios,
 		    "of all LL-cache accesses");
 }
 
@@ -283,9 +279,9 @@ static void print_dtlb_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_DTLB_CACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_DTLB_CACHE, thresh_ratios,
 		    "of all dTLB cache accesses");
 }
 
@@ -294,9 +290,9 @@ static void print_itlb_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_ITLB_CACHE, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_ITLB_CACHE, thresh_ratios,
 		    "of all iTLB cache accesses");
 }
 
@@ -305,9 +301,9 @@ static void print_cache_miss(struct perf_stat_config *config,
 			int aggr_idx, double misses,
 			struct perf_stat_output_ctx *out)
 {
-	static const double color_ratios[3] = {20.0, 10.0, 5.0};
+	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
 
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_CACHE_REFS, color_ratios,
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_CACHE_REFS, thresh_ratios,
 		    "of all cache refs");
 }
 
@@ -323,16 +319,16 @@ static void print_instructions(struct perf_stat_config *config,
 				find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_BACK));
 
 	if (cycles) {
-		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "insn per cycle",
-			     instructions / cycles);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
+			     "insn per cycle", instructions / cycles);
 	} else {
-		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "insn per cycle", 0);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
+			     "insn per cycle", 0);
 	}
-
 	if (max_stalled && instructions) {
 		out->new_line(config, ctxp);
-		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "stalled cycles per insn",
-			max_stalled / instructions);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
+			     "stalled cycles per insn", max_stalled / instructions);
 	}
 }
 
@@ -346,9 +342,11 @@ static void print_cycles(struct perf_stat_config *config,
 	if (cycles && nsecs) {
 		double ratio = cycles / nsecs;
 
-		out->print_metric(config, out->ctx, /*color=*/NULL, "%8.3f", "GHz", ratio);
+		out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, "%8.3f",
+				  "GHz", ratio);
 	} else {
-		out->print_metric(config, out->ctx, /*color=*/NULL, /*fmt=*/NULL, "GHz", 0);
+		out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
+				  "GHz", 0);
 	}
 }
 
@@ -362,10 +360,11 @@ static void print_nsecs(struct perf_stat_config *config,
 	double wall_time = avg_stats(&walltime_nsecs_stats);
 
 	if (wall_time) {
-		print_metric(config, ctxp, /*color=*/NULL, "%8.3f", "CPUs utilized",
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%8.3f", "CPUs utilized",
 			nsecs / (wall_time * evsel->scale));
 	} else {
-		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "CPUs utilized", 0);
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
+			     "CPUs utilized", 0);
 	}
 }
 
@@ -490,7 +489,7 @@ static void generic_metric(struct perf_stat_config *config,
 	double ratio, scale, threshold;
 	int i;
 	void *ctxp = out->ctx;
-	const char *color = NULL;
+	enum metric_threshold_classify thresh = METRIC_THRESHOLD_UNKNOWN;
 
 	pctx = expr__ctx_new();
 	if (!pctx)
@@ -513,8 +512,8 @@ static void generic_metric(struct perf_stat_config *config,
 			if (metric_threshold &&
 			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&
 			    !isnan(threshold)) {
-				color = fpclassify(threshold) == FP_ZERO
-					? PERF_COLOR_GREEN : PERF_COLOR_RED;
+				thresh = fpclassify(threshold) == FP_ZERO
+					? METRIC_THRESHOLD_GOOD : METRIC_THRESHOLD_BAD;
 			}
 
 			if (metric_unit && metric_name) {
@@ -529,22 +528,22 @@ static void generic_metric(struct perf_stat_config *config,
 					scnprintf(metric_bf, sizeof(metric_bf),
 					  "%s  %s", unit, metric_name);
 
-				print_metric(config, ctxp, color, "%8.1f",
+				print_metric(config, ctxp, thresh, "%8.1f",
 					     metric_bf, ratio);
 			} else {
-				print_metric(config, ctxp, color, "%8.2f",
+				print_metric(config, ctxp, thresh, "%8.2f",
 					metric_name ?
 					metric_name :
 					out->force_header ?  evsel->name : "",
 					ratio);
 			}
 		} else {
-			print_metric(config, ctxp, color, /*fmt=*/NULL,
+			print_metric(config, ctxp, thresh, /*fmt=*/NULL,
 				     out->force_header ?
 				     (metric_name ?: evsel->name) : "", 0);
 		}
 	} else {
-		print_metric(config, ctxp, color, /*fmt=*/NULL,
+		print_metric(config, ctxp, thresh, /*fmt=*/NULL,
 			     out->force_header ?
 			     (metric_name ?: evsel->name) : "", 0);
 	}
@@ -715,7 +714,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 				if (unit != ' ')
 					snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
-				print_metric(config, ctxp, /*color=*/NULL, "%8.3f",
+				print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%8.3f",
 					     unit_buf, ratio);
 			} else {
 				num = 0;
@@ -726,8 +725,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
 						  &num, NULL, out, metric_events);
 
-	if (num == 0)
-		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, /*unit=*/NULL, 0);
+	if (num == 0) {
+		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN,
+			     /*fmt=*/NULL, /*unit=*/NULL, 0);
+	}
 }
 
 /**
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index a5f3d7d00101..6f8cff3cd39a 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -154,8 +154,18 @@ struct evlist;
 extern struct stats walltime_nsecs_stats;
 extern struct rusage_stats ru_stats;
 
+enum metric_threshold_classify {
+	METRIC_THRESHOLD_UNKNOWN,
+	METRIC_THRESHOLD_BAD,
+	METRIC_THRESHOLD_NEARLY_BAD,
+	METRIC_THRESHOLD_LESS_GOOD,
+	METRIC_THRESHOLD_GOOD,
+};
+const char *metric_threshold_classify__color(enum metric_threshold_classify thresh);
+
 typedef void (*print_metric_t)(struct perf_stat_config *config,
-			       void *ctx, const char *color,
+			       void *ctx,
+			       enum metric_threshold_classify thresh,
 			       const char *fmt,
 			       const char *unit,
 			       double val);
-- 
2.47.0.rc0.187.ge670bccf7e-goog

