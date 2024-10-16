Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE31D47CD
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115528; cv=none; b=o/LyS4h2ItA0ygfYc68LtgT+9TmuJxMPBUcQooKledTvkKSZFTOzYUWgZEPGqOgkR9rbt4G/jDuuf41d+Z7cpY8CA57/7FzwGR1ECiNT1ok4sDq8WzbmQJWt9c5TKys81HHsn7tyAZXkGmknEjK/Uu/FSLjwXmr27HDhMCbqRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115528; c=relaxed/simple;
	bh=nR/8QLcBCh+39nvfzpZZaCLHNApxIUJpcbhdwvA+Oxk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SVu7Q7wrlxC+mnubzO9iBTwpjqyvXBDKKF0PaNqY7apOrgdmuTHlmBOCAy1pBx7LFIPhpXOvNiwEXaBsZl/dnBMs7TK3/tWlP/0vYwTbuoVPnlEAq4r0s6j1SWeXvEBNlxuekRWdrqDXFL9ekAM5jgWybn8PjUu37YqQ4lAieD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bm89Csiw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bm89Csiw"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so576666276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115526; x=1729720326; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/n/isiF2Sq7ntpurAmJIm0kx07dBkasA8rH7Du+HlQ=;
        b=bm89Csiw/+BWqYpC8Xzm1Or+pAEqQVIZmuFg6FC98M2Q9vDVhldAZE9BNkEmTyVQEv
         nRYGOJ+bVqzBdqoJi+6tUsRxU7PYrd5mG/HE4rRJD05wgFoLryy1HWS+r2Qg0JWY8kjl
         PZ3Pl0apVcsD1BtHD/GWGZ+nACInMEyfVIz+Y/HCIxZeaamTdilbVUVj2/zzhIYK54GQ
         o3iMCC4L9NNJz7lOi3rzTdrXfO1/RwoPTzs2zmsQFskcIolULXz9K9Nr5QYhEZ8JkYIO
         9lLQucptcOY0lbob2xeFFcSDqTFPYA0v5T4ffelT3HN2K5bNEEBkW5QN1lbpXlqr9Ze3
         Er+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115526; x=1729720326;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/n/isiF2Sq7ntpurAmJIm0kx07dBkasA8rH7Du+HlQ=;
        b=gfV6IYpAzNx8i4tYcr96/F775DoYpmHUQPM4cCl4zrSEjRmEtaPClDxAvr/WoQo6LP
         lmzoj5GPVcLYL8XAjAkxWikfdWwdWLdWfESfLwxIn+SNQhV63F0VkJPhAQQuIsHy6NBr
         HV1hplH6IO1UuKgwss3A7qmyEyO4XlwSesuXUrKcfmTjgGhXZ94QlKx5eqiHpVM9W3u0
         gGLSBpwgAG0rPPKj3tfyJrB2LmE3aLcTsskVMX6kDx54UUCkIAUh9NM2tOCv8b6ZpnSX
         QJkbDYm2EBxKZvRAFUyTPFPgHkOJe11txgm124axOJJON6q9MWeMBa5L7uUB4kxhYkNb
         zjbg==
X-Forwarded-Encrypted: i=1; AJvYcCXpg0ignSQpPjEKR24CKl6e+dCNU36+ANaDF04OqD3o3IXgicgsElN4DjjH7lNRNVJJQaPNG12OCZlNKrK+YdEL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0wqZPP95yfWVwrxLVDx8usCEY9M/pdzmyUrWSXAglJZx7vnuZ
	aTsAsfluc13HvhQb847bs5QcEFdbdSrsnMO07HsPECQTgW/ClXwimdVe65ommLpGosMdwgtppPj
	6m/EkuQ==
X-Google-Smtp-Source: AGHT+IFSvAouIEyGKuUHCGGxmtliMqlphatHL69knjIbTi+zL83r9H3bHCah6svBmYQ3oXXSz2bxFLai+XrX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:6982:0:b0:e29:6e61:3daf with SMTP id
 3f1490d57ef6-e29782d5207mr2545276.2.1729115526329; Wed, 16 Oct 2024 14:52:06
 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:37 -0700
In-Reply-To: <20241016215139.212939-1-irogers@google.com>
Message-Id: <20241016215139.212939-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016215139.212939-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 6/7] perf stat: Add metric-threshold to json output
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

When the threshold isn't unknown add a value to the json like:
"metric-threshold" : "good"

A more complete example:
```
$ perf stat -a -j -I 1000
{"interval" : 1.001089747, "counter-value" : "16045.281449", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 16045355135, "pcnt-running" : 100.00, "metric-value" : "16.045281", "metric-unit" : "CPUs utilized"}
{"interval" : 1.001089747, "counter-value" : "10003.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 16045314844, "pcnt-running" : 100.00, "metric-value" : "623.423156", "metric-unit" : "/sec"}
{"interval" : 1.001089747, "counter-value" : "328.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 16045321403, "pcnt-running" : 100.00, "metric-value" : "20.442147", "metric-unit" : "/sec"}
{"interval" : 1.001089747, "counter-value" : "20114.000000", "unit" : "", "event" : "page-faults", "event-runtime" : 16045355927, "pcnt-running" : 100.00, "metric-value" : "1.253577", "metric-unit" : "K/sec"}
{"interval" : 1.001089747, "counter-value" : "4066679471.000000", "unit" : "", "event" : "instructions", "event-runtime" : 16045369123, "pcnt-running" : 100.00, "metric-value" : "1.628330", "metric-unit" : "insn per cycle"}
{"interval" : 1.001089747, "counter-value" : "2497454658.000000", "unit" : "", "event" : "cycles", "event-runtime" : 16045374810, "pcnt-running" : 100.00, "metric-value" : "0.155650", "metric-unit" : "GHz"}
{"interval" : 1.001089747, "counter-value" : "914974294.000000", "unit" : "", "event" : "branches", "event-runtime" : 16045379877, "pcnt-running" : 100.00, "metric-value" : "57.024509", "metric-unit" : "M/sec"}
{"interval" : 1.001089747, "counter-value" : "9237201.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 16045375017, "pcnt-running" : 100.00, "metric-value" : "1.009559", "metric-unit" : "of all branches", "metric-threshold" : "good"}
{"interval" : 1.001089747, "event-runtime" : 16045397172, "pcnt-running" : 100.00, "metricgroup" : "TopdownL1"}
{"interval" : 1.001089747, "metric-value" : "22.036686", "metric-unit" : "%  tma_backend_bound", "metric-threshold" : "bad"}
{"interval" : 1.001089747, "metric-value" : "7.610161", "metric-unit" : "%  tma_bad_speculation", "metric-threshold" : "good"}
{"interval" : 1.001089747, "metric-value" : "36.729687", "metric-unit" : "%  tma_frontend_bound", "metric-threshold" : "bad"}
{"interval" : 1.001089747, "metric-value" : "33.623465", "metric-unit" : "%  tma_retiring"}
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  5 ++++-
 tools/perf/util/stat-display.c                | 22 +++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index abc1fd737782..8ddb85586131 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -57,6 +57,7 @@ def check_json_output(expected_items):
       'interval': lambda x: isfloat(x),
       'metric-unit': lambda x: True,
       'metric-value': lambda x: isfloat(x),
+      'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', 'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
       'pcnt-running': lambda x: isfloat(x),
@@ -68,13 +69,15 @@ def check_json_output(expected_items):
   for item in json.loads(input):
     if expected_items != -1:
       count = len(item)
-      if count != expected_items and count >= 1 and count <= 6 and 'metric-value' in item:
+      if count != expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
         # Events that generate >1 metric may have isolated metric
         # values and possibly other prefixes like interval, core,
         # aggregate-number, or event-runtime/pcnt-running from multiplexing.
         pass
       elif count != expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
         pass
+      elif count == expected_items + 1 and 'metric-threshold' in item:
+          pass
       elif count != expected_items:
         raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
                            f' in \'{item}\'')
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5974aaead95f..53dcdf07f5a2 100644
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
@@ -478,15 +491,20 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 
 static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 			     void *ctx,
-			     enum metric_threshold_classify thresh __maybe_unused,
+			     enum metric_threshold_classify thresh,
 			     const char *fmt __maybe_unused,
 			     const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	if (unit)
+	if (unit) {
 		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
+		if (thresh != METRIC_THRESHOLD_UNKNOWN) {
+			fprintf(out, ", \"metric-threshold\" : \"%s\"",
+				metric_threshold_classify__str(thresh));
+		}
+	}
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.105.g07ac214952-goog

