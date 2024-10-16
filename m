Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817A215F74
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101255; cv=none; b=fmlgFjiQZucO5sO9rVLce5+8IMWIS29iQxGRNutkfr0SCpH2J/XsP3Mk+EqzzhpzL3L9nXXzEQXylJUtUdODPeS9hdR1BXcqS9FhZPmSRhVGLnH42u/kjWx8AibTK9r4bBK1pq28KSXYiae6UoD1UIIpXlJQmk+X4y2LWjWWjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101255; c=relaxed/simple;
	bh=WKjU1a/lx3TbexW2NN4+1n8Opn4CO4/epvYjmMZ59go=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PVUzv48hgjxiNmM3qtZi5iky3ueO7o1bM/kYBBLMTovjaNxKlwpL2OvxRQbpia5Lyru8dKm2feh/d7WmfAvg5oWwPoeEfqUdwbsIlf4jlY2nh8myicSg7ueo712KMEOw5P22l7a+pGnb7eFqeK9wAZ+aKZu7saSBDyDVeM1Z8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IfefOmx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IfefOmx"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29205f6063so95056276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101250; x=1729706050; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h17ekCegbTr4famvRlkpL0Qc+dXqqCi6gDChEA388fo=;
        b=1IfefOmx6STIPQ30UFtpuXO8G8zA09MlE/t33IswOJS/XJkTnlw1te982NNx0wNLOt
         wM6+O5c8hakTSpPxZdMNKfy9iGyAoRHE5j7Po99ItHectUoYljiJxQfkCipQ4gPzcfCD
         +vtkvtfCmxqLfB0k9MRah8ca7gB2hTOqVLc2dI85ZMHEGlCIBicQ79rccNeYIrFRyPSN
         JizReRdDlIS3/K82cSTLJ4ctv5CtFn0ILxQE9nSCctHKxESjqxm19mUy4F31/nqGema5
         yErwqZ4hrNmyxanF84tFXO/w0CeCaD9MD1q64RYDUnAq8iJHYFQ9Pr5xIuyWDA1i672X
         Nczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101250; x=1729706050;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h17ekCegbTr4famvRlkpL0Qc+dXqqCi6gDChEA388fo=;
        b=jjc1IFlJcSgt037j24O0PqRZBwADHbwJ/SI76ZCSgiacGwdK6pIww0+29dYjXqDTfa
         ryGziWp15Q7Evgtke3uXF7WzQNJhLn3ZaxtvhnbYalayVGm4YaPyrS7NVeFbQtfmAXeK
         rGzGPDJVOnh+yXe2PEYXLwTRRScNG8IDTbllBzRvWZgu0RB02KAhN7X31FETKhf7nddq
         OrEvsQZfLBtfWILAFQuMvkcluhxsmOxYwzA2dLKJytYKR5GJRL+W/tA/FSaY3/vWekoI
         2hO9T1WFqAFIsfG/gYD4xtxfFlxyhDaFVlJ2o96LHVLs1Cu2sFe8Trmgph7anu1A7y/D
         64/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxwteRP3tKo+yObdKeBY7Z8WeQ+AYjeWBin0PbcYgAAjRY8BzVW21h4EKig5PiXifXLRstgJ+XL28od2VbSeBs@vger.kernel.org
X-Gm-Message-State: AOJu0YzTz5PXiqT77Y+IgEn7XYhnnJ7+jFv1acFYalLSpAVrpTVzmFQz
	Zgy6AZb2S7lCPUGp2+Bw6iSBnUovrg8EzlXLodp2H04KmbpjpV6jQO/23FEFYnA9qE/FHvWROAX
	PPYdGjQ==
X-Google-Smtp-Source: AGHT+IGbtXQuViQyESTsQNdCvj0QvKmS2njrdxDrBpkQZ2WTjfdpex+ZxXZpJMCWC9ztNlNC03yf8ZAvNR1Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:b227:0:b0:e28:ee55:c3d with SMTP id
 3f1490d57ef6-e29782b0251mr3864276.1.1729101249705; Wed, 16 Oct 2024 10:54:09
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:49 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 7/8] perf stat: Add metric-threshold to json output
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
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 5 ++++-
 tools/perf/util/stat-display.c                      | 9 +++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

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
index f2750d1b34aa..5b700b259572 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -497,15 +497,20 @@ static void print_metric_csv(struct perf_stat_config *config,
 
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

