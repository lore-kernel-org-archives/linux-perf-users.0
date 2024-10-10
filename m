Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E6188A0C
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523312; cv=none; b=sg+I84SSeiuuDXyfFXloLWcsvU+1jl6ghk39DJMkVyd4OCSzjBSKBUZXlu72smg8f/f62gyjXWoGsUPMHyAw0HcISgQ9ZW9s93dl49EHdL/y480zVYYNbAFR4uqReqQ0Wsy6s6V0f1I2KdmVufBLF/ottwdslk4SE0bTSLs8IgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523312; c=relaxed/simple;
	bh=uiS+oLS4pffHMgCMpYDAqPQxwx7hTm/gSJ2Wy+m9tc0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MwEhy79tQs4ZeY4heqYSbElFO+4diqtPs3bwkIbwa6aXvvT76D+HDmg636YuSCG39hCPyOCoxmJ/7sZGmT1XANpBp+z714F7toD4/CfQV5cMR1TfWP83PSOGtnL2OYjJ/eNl4n2QrDodOqq/+FOFRHyHdCP4XCK4j9AdmMSX18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=27g9JfMg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="27g9JfMg"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e22f8dc491so11981647b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 18:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523309; x=1729128109; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSMf0ZciMHk1DLwXUrfHLBOPiqM+sa4aM1B7vJjuFJs=;
        b=27g9JfMgz+cUzRAkzA6WZWQlkQVoULC8x5rPxq45qgNo52XeftKJ6sj81B7fv3Lx/v
         bMHF/PNglxondqjTJlVyIONB/Ccit3N5834+PQ1/CcxSPxcH8nMByHV9uUKzbJiiP0qs
         D9gLlDwz8I30s9qVKYOTyE5twkcqCK0IXMODmuWIPYe5YyEdl/srROzK2q33IyhXqHr5
         0rL/8ZwQREmO10H7RZ/3L5I0fA1+04sPLsbk3QX6jitjSqZ3PepKczWT5iLV2oUEBu80
         sKR6crGqWAkcITvVD7jap8UFsEMRw7tAvMlgdgoq21O7MU7yjuhKEu8OBke/OBP8f8vr
         P+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523309; x=1729128109;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSMf0ZciMHk1DLwXUrfHLBOPiqM+sa4aM1B7vJjuFJs=;
        b=w+vSRurqY06/Yo17C+wx7CBi+e2LQ3Ff3TnKyQxCRaBAWIZgdFCe2D344kEeESnv6p
         INyFaX5pHRqEHh9WG/mJJrLPtyYM6YNolL+jK0/QB6vV0qCDjtoT59xwmoz00kYRXHM2
         DzA03Fpvb4DZ84zDY1tj5YbhQQDJPmct4SEwLq+aWorKuQvV/e7iWNWayuk1FPGQwAhG
         Hl0YAUZfX3AIIdCVrZMWHfHrJDxRoorhrS0ENKORr7p8SPi6HN4ahGa063qQIsh4ASbA
         F1X9mwMwHa3wO19hWqZKD4QYg4d0wvy5Z3YvRemOMm672bojZhJwdinprx5czTGEyIaO
         LHSg==
X-Forwarded-Encrypted: i=1; AJvYcCXYtOg9XQfSS2ijVgUNdF1CdJfAJQbDC8virSp8gyI7dNl8j8x6RlA97BJL+LUqe/qGTNnNVm8ijC8WeaO372lF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ATX65o8XxLfuxcC3F2bhDBvUcphnhkeu7ZoSLztDzA7GEUW7
	NVmtYOOelqqU0kgQ2kjXTC1ZmGSJzFPP8MjEKs0R2B3IASLxpkGf6p+5HS2p9yXQz/ELyMfPd1v
	Q6PopUg==
X-Google-Smtp-Source: AGHT+IELqYJotQaSZNeZiTSaHR+QUl1mFryQRbsYcyOP2J8EBG2jxhtexX5GZXgxNG/bBBQs9No0cfVtSGsU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a25:9105:0:b0:e20:25f5:a889 with SMTP id
 3f1490d57ef6-e28fe4a5550mr3066276.5.1728523309358; Wed, 09 Oct 2024 18:21:49
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:31 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 5/8] perf stat: Change color to threshold in print_metric
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
index 6bb048fefe9d..7d42f22cd5f8 100644
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
@@ -558,13 +572,14 @@ static const char *fixunit(char *buf, struct evsel *evsel,
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
@@ -581,7 +596,8 @@ static void print_metric_only(struct perf_stat_config *config,
 }
 
 static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused,
-				  void *ctx, const char *color __maybe_unused,
+				  void *ctx,
+				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
 				  const char *unit, double val)
 {
@@ -603,7 +619,8 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 }
 
 static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
-				  void *ctx, const char *color __maybe_unused,
+				  void *ctx,
+				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
 				  const char *unit, double val)
 {
@@ -635,7 +652,8 @@ static void new_line_metric(struct perf_stat_config *config __maybe_unused,
 }
 
 static void print_metric_header(struct perf_stat_config *config,
-				void *ctx, const char *color __maybe_unused,
+				void *ctx,
+				enum metric_threshold_classify thresh __maybe_unused,
 				const char *fmt __maybe_unused,
 				const char *unit, double val __maybe_unused)
 {
@@ -809,7 +827,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
-			pm(config, os, NULL, "", "", 0);
+			pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);
 			return;
 		}
 
@@ -864,7 +882,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
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
2.47.0.rc1.288.g06298d1525-goog

