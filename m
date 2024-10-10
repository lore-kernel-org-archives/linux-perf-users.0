Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6027446
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518865; cv=none; b=knJ9HbPiCTbbHpO35BQE3h4EU0I4gspSm98RUpsxM0R7iv5hyEWnf4vgmZxw+0Q5tXRJx3VbgdpSJnWK64SNEhlREtoEBec8tTNwKfpnHAnbawfd28UE0L9mkPYEDC6xEsaNghp75aDEnMRxCCYwb1cOIpn6hq1+GVdD74owuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518865; c=relaxed/simple;
	bh=i2P8XZ8C8+KW3cQpvcq8swJ4pl42rq2Dmo38yCruSj4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k7ZHiba5my/qpjr+Yf4/6CLViZR3ExittFrtfxxJRLoTkhK4VbOYDitjlmSw8PyhqOGbCmZtViFPe5GjVEtpOklU0uxBVvnKh/bP4QKm2gexCRghzLsv0IjaLfAGJobT9iAtAjx0Rs+tBuUYSlLxkj4nlwRaKqhE3CGdJr2TYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0gCECvKj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gCECvKj"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2baf2ff64so9168507b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518863; x=1729123663; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SY35F8wtXf7s51KAxRJvlRRZZ0EtgMGdYbZDGjNC5K4=;
        b=0gCECvKjQA798MPxmgMLBYFPUWyMfyMTLAFXYuY9jCicIVxga9ewD21icdtQbTHt87
         1HTFrEr6bs4ZHi3quLMx5NUTQNXWRUXHigAhi4BzLN6yoAH8WNpT+S50Zwg8iqmfyoNu
         Iw4Msqm1mX4E0Uzu7d+5RQtjYIVoUKDlKSFU26kFdlaVREFaL0d/V00DKsj81nIFbf2m
         WPyjP2mCL+hmYeDtn+5v4dQiOCDHUJ2beonS0myaAvFg9z0/Al6stXRs9XIZ2fQjyWmh
         GXrL7SmglVimX5WOz5iITJKJO5xHjIXYaTPKRHDPl7q5PwX5aB62FDHgkWXbcGa/k0sW
         hIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518863; x=1729123663;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SY35F8wtXf7s51KAxRJvlRRZZ0EtgMGdYbZDGjNC5K4=;
        b=cLHS8eV/olxnlPPSVBcPdDePdfAtXg+XOuGRMtYERuPHB5QMr9kp9GKQzJmQBABcdM
         OKY/dpscapVXxXqMKcF2Tmh2ZFKBn2tJGFXc+2KgldzMyztpheG+UssTZ6RbE5lRkf1+
         WyGmg2XxaD2PD41n2J/y5zdAZkEGhz2tl9UKLPSFrBCSXDk064fssXiDfOaOGYCx6mrI
         qSTHQJyKDj7teelJJWSoQoiqJZM5RgvAco5IvkcTWZ2dh3nY8WpWge+ex/VFwX1hOr/h
         kgwTveeQ4j+5q9IkJsld6VbS2Ehddf2ZnxIJnfnChlBJyfc5BVHwFco+cXV9oNg36ogL
         P70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy5FuVmW5OyUVDk6gCxFm+KU0KAceURFCMDkaVf53mjH1UyKMu1+fBqVxUef2KNqptIvbB75Yauj7lIdpXDIyu@vger.kernel.org
X-Gm-Message-State: AOJu0YxaI3j7FDFKpimLZGFDpWA8M5b2e423//vq58In42BCEOp8lLPU
	ElBbUByT8QNgL4IvoPQqJhk7DK0HlZjmOwKztmE2x2/PA8d0zvYPyAc5HETfQa2WQBu831vTgLw
	hOqSCcg==
X-Google-Smtp-Source: AGHT+IFksJYqRDwuiHPDNzEXTVB/7fQgehW4IKPAtuP7oY/vQ66Jy1dBIhD1TaumqaV00XiICDFmrKFB8hba
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a87:b0:6e2:70e:e82e with SMTP id
 00721157ae682-6e3224227fcmr167907b3.6.1728518862623; Wed, 09 Oct 2024
 17:07:42 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:07:19 -0700
In-Reply-To: <20241010000719.1172854-1-irogers@google.com>
Message-Id: <20241010000719.1172854-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010000719.1172854-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 6/6] perf stat: Display metric threshold value in CSV output
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
index 7d42f22cd5f8..5b5923730a7b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -85,6 +85,19 @@ const char *metric_threshold_classify__color(enum metric_threshold_classify thre
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
@@ -454,14 +467,15 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
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
@@ -472,7 +486,12 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
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
@@ -527,7 +546,7 @@ static void print_metricgroup_header_csv(struct perf_stat_config *config,
 
 	for (i = 0; i < os->nfields; i++)
 		fputs(config->csv_sep, os->fh);
-	fprintf(config->output, "%s", metricgroup_name);
+	fprintf(config->output, "%s%s", metricgroup_name, config->csv_sep);
 	new_line_csv(config, ctx);
 }
 
-- 
2.47.0.rc1.288.g06298d1525-goog

