Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1F215F5E
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101250; cv=none; b=CbX6k7MqCBg2hAR9Snf8gP2lmhk7uN9ME5qFNNidF3oDnexZN27uJJNtcG+3m22Hkz/Sj/FKd/3rorR0qWqVDhcB652q0PJ8KHb72eOe/su663NJJwHfE5aTaQmF3vqJybKwsffFUxyo5E2ws54LeHuVrtWTLqh/H+4JNYvAKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101250; c=relaxed/simple;
	bh=E4U7wuaBoI9LgrVIYNQQ2sVZhXY461X+XET2GkpBy3I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZaqCNHji5g4uza+bJB94QTJDZAhgzSwsL3CXmC92tvtmkCwweZGVkaXp/teXA/8yGmU07UzjxpCInJYoTn3w1Qd6M6vpT8XxReltWblMsj3GBjnUu3lsbfXvpnLIp49MYLSDml9zegQ2rvNncu6IQZ6Fd+i/cM9rLy1zqQg8PAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7gGUFOQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7gGUFOQ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso74543276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101247; x=1729706047; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGXxZcfS4OJGTX3QvHqzTzFNN5FRZqsvmi/1r7EUvS4=;
        b=i7gGUFOQXRl1k3KQIKT01U/zYwe2lfirE2OjD93wJxLTq0hk82qra4y21YbPGqNL9l
         COVbKyXKY+AQDStIG0nR+fLdFO5t/ut0w4zGAUsn0Qu+hd03s+WTL/LAJXXkdwqAyQVh
         Gn9kYU9OvUKGdGlF2+7NCeAwylS/UzgtROwMDwfmKWzPvzwP0DlPOtUHfgn+ZaYFXrXF
         5u/7VqM6PCa2y2RoxbJvHkgeGtwUQBKq/UgMvaV+fJeblSwcSCD0LywdNyv/pFUT4QVp
         eIiibg9vnhCdmZ8HSCbTm60bU4Vox9VFnyLyErIRc6cZz41u9VEIidgsm8nQXDT6Qr3n
         n1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101247; x=1729706047;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGXxZcfS4OJGTX3QvHqzTzFNN5FRZqsvmi/1r7EUvS4=;
        b=EmqLzBumcmO0ey64Kr2sv8G5cmJSmtSUTxf1kpligB2O6EVrZpyCQdlwxs/5iu0nFD
         wsXynD6uWoAHkhAIp4XsyQg0cB71SWPJ4thGXS4UZ82tEJ8xKSsnFcfPxIw0lXaqPLdy
         Sf7UaGCnl1BuR7nnCmO47wF3myBuBQPP6WfBVp2SrqT1Q1r6o+Z8alm/HfkTkrBdT3B7
         qpT3SiksbMCVbRvFDw3URAW/6rDAvyYAbB7opepwHO+piYb0WI7ErBj83HSSsykvaAS4
         7WjRr5y8FYy4OHEQEaXqVMtyDtnspWIJmHGD02wVchIociOQtMbOumsa5/T8nz0jxasn
         z1dw==
X-Forwarded-Encrypted: i=1; AJvYcCVnU4BWLb8qosbbfHlG2/6E1ambH9nYKTdB0Uhc/7UsANdN7TJSRG0zumdM5/YeK6eIhBRnvpOrLN2JNPlC9yZH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7dxtxg8nvt9YIuN+HRZKwMvq122/bmB4Qw/j8Pw40RXhljgci
	S8bopj0wUchrkrwTcxSlliOmTqt4P5mo8oUyiE9mWMJBfAE83JIMZlrtXzRt+bHkQbZ8Y2Rhvxf
	yGf1evg==
X-Google-Smtp-Source: AGHT+IEwDyVefJvbnEcXnUCGDgtLYI48Vd4K1wm26M6QP/9FKjnedwPjo/gKvNj2E5l5gpOWprueXZVBXC8I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:3284:b0:e29:7cd6:593b with SMTP
 id 3f1490d57ef6-e297cd65b8amr5311276.8.1729101247548; Wed, 16 Oct 2024
 10:54:07 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:48 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 6/8] perf stat: Display metric threshold value in CSV output
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

Add a column with a metric threshold value. For example, the bad/good
in the last column below:
```
$ perf stat -a -M topdownl1 -x, -I 1000
1.000103288,4677067630,,TOPDOWN.SLOTS,16029302700,100.00,31.1,%  tma_backend_bound,bad
1.000103288,,,,,,51.0,%  tma_frontend_bound,bad
1.000103288,,,,,,7.6,%  tma_bad_speculation,good
1.000103288,,,,,,10.2,%  tma_retiring,good
1.000103288,476781750,,topdown-retiring,16029302700,100.00,,
1.000103288,2389693619,,topdown-fe-bound,16029302700,100.00,,
1.000103288,1431602465,,topdown-be-bound,16029302700,100.00,,
1.000103288,378991388,,topdown-bad-spec,16029302700,100.00,,
1.000103288,4934535,,INT_MISC.CLEARS_COUNT,16029339890,100.00,,
1.000103288,56474476,,IDQ.MS_UOPS,16029292873,100.00,,
1.000103288,3188888,,INT_MISC.UOP_DROPPING,16029239908,100.00,,
1.000103288,484429099,,UOPS_RETIRED.SLOTS,16029176080,100.00,,
1.000103288,49066178,,UOPS_DECODED.DEC0,16029100912,100.00,,
1.000103288,26472844,,cpu/UOPS_DECODED.DEC0,cmask=1/,16029009707,100.00,,
1.000103288,709313662,,UOPS_ISSUED.ANY,16028914990,100.00,,
1.000103288,346833383,,IDQ.MITE_UOPS,16028820330,100.00,,
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt    |  1 +
 tools/perf/tests/shell/stat+csv_output.sh | 24 ++++++++++----------
 tools/perf/util/stat-display.c            | 27 +++++++++++++++++++----
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 2bc063672486..9bfa1a085e98 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -622,6 +622,7 @@ The fields are in this order:
 	- optional variance if multiple values are collected with -r
 	- optional metric value
 	- optional unit of metric
+	- optional how the value relates to a metric threshold
 
 Additional metrics may be printed with all earlier fields being empty.
 
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index fc2d8cc6e5e0..a3bc3c99b534 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -31,19 +31,19 @@ function commachecker()
 	local exp=0
 
 	case "$1"
-	in "--no-args")		exp=6
-	;; "--system-wide")	exp=6
-	;; "--event")		exp=6
-	;; "--interval")	exp=7
+	in "--no-args")		exp=7
+	;; "--system-wide")	exp=7
+	;; "--event")		exp=7
+	;; "--interval")	exp=8
 	;; "--per-thread")	exp=7
-	;; "--system-wide-no-aggr")	exp=7
-				[ "$(uname -m)" = "s390x" ] && exp='^[6-7]$'
-	;; "--per-core")	exp=8
-	;; "--per-socket")	exp=8
-	;; "--per-node")	exp=8
-	;; "--per-die")		exp=8
-	;; "--per-cluster")	exp=8
-	;; "--per-cache")	exp=8
+	;; "--system-wide-no-aggr")	exp=8
+				[ "$(uname -m)" = "s390x" ] && exp='^[7-8]$'
+	;; "--per-core")	exp=9
+	;; "--per-socket")	exp=9
+	;; "--per-node")	exp=9
+	;; "--per-die")		exp=9
+	;; "--per-cluster")	exp=9
+	;; "--per-cache")	exp=9
 	esac
 
 	while read line
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5974aaead95f..f2750d1b34aa 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -86,6 +86,19 @@ const char *metric_threshold_classify__color(enum metric_threshold_classify thre
 	return colors[thresh];
 }
 
+static const char *metric_threshold_classify__str(enum metric_threshold_classify thresh)
+{
+	const char * const strs[] = {
+		"unknown",
+		"bad",
+		"nearly bad",
+		"less good",
+		"good",
+	};
+	static_assert(ARRAY_SIZE(strs) - 1  == METRIC_THRESHOLD_GOOD, "missing enum value");
+	return strs[thresh];
+}
+
 static void print_running_std(struct perf_stat_config *config, u64 run, u64 ena)
 {
 	if (run != ena)
@@ -455,14 +468,15 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 		fputs(config->csv_sep, os->fh);
 }
 
-static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
+static void print_metric_csv(struct perf_stat_config *config,
 			     void *ctx,
-			     enum metric_threshold_classify thresh __maybe_unused,
+			     enum metric_threshold_classify thresh,
 			     const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[64], *vals, *ends;
+	const char *thresh_str = "";
 
 	if (unit == NULL || fmt == NULL) {
 		fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
@@ -473,7 +487,12 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, skip_spaces(unit));
+	if (thresh != METRIC_THRESHOLD_UNKNOWN || !rblist__empty(&config->metric_events))
+		thresh_str = metric_threshold_classify__str(thresh);
+	fprintf(out, "%s%s%s%s%s%s",
+		config->csv_sep, vals,
+		config->csv_sep, skip_spaces(unit),
+		config->csv_sep, thresh_str);
 }
 
 static void print_metric_json(struct perf_stat_config *config __maybe_unused,
@@ -528,7 +547,7 @@ static void print_metricgroup_header_csv(struct perf_stat_config *config,
 
 	for (i = 0; i < os->nfields; i++)
 		fputs(config->csv_sep, os->fh);
-	fprintf(config->output, "%s", metricgroup_name);
+	fprintf(config->output, "%s%s", metricgroup_name, config->csv_sep);
 	new_line_csv(config, ctx);
 }
 
-- 
2.47.0.105.g07ac214952-goog

