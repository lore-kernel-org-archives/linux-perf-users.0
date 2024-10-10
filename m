Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7519006F
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523316; cv=none; b=gok94+jjSQS5C4qSU94MyQSgfhgSqrKaCWkjnvaspLPaaH4V5S2/MaUCxyvtwzV8BKL+m2Z6Y39WQd8YNzYbAMVPiMa3aQK+29Wwdtc+JC70QKxV+xdWqgInz3UMm2W5j7f8omol4ab47guGALPv3lzFkubK+9LPiXTVqYDe01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523316; c=relaxed/simple;
	bh=y9oDWwclikRMV44veYy4NteJ9B9046N9/nsDDXlj3AY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iJdFvy4eKwRypqOiT0xaNHVRKZIrDWeXQz53ZREpcYcW7u1RnQpcb24l8FkCr/LvOhUkPQG5TGjT1IBetG0LGo0A5XO/sTYDMdZ6wwjfl61Z+ncP+hFhnQZIA44bWDKjgitiTodg1v+1t8lmEYSiKOyLs6ax12DWkE+gtndzFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uk3mws3k; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uk3mws3k"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2d287f944so10816427b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 18:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523314; x=1729128114; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7UO+Jwq3ZdJxz6tultIv+LNJVzpQeU7Lfk7TZbknkQ=;
        b=Uk3mws3kJ6xntS0O/DN++jqMvV6P5B02JOlGsWi3rXfoEpk4MN2m3ArOsNYdUJRVnN
         yQv6KzlTJk5aK2x7FmChIcWWfWsTjKzPTEjm76C+HlKdN7ZAzqZsJG2BMMMU4wZisVx7
         hM6Oi5IL2fSGQ3bX8BmXS20wf3g2vmMW2YUFwy4omQSVCpLaLsvJ3SFVND47kibTB41n
         EtP11WgP1hqoLbu7GI0rVZP8pF+YqK6bDi+V6yOSrrk3OgXhaB24VxDgYW3FNFw5p9UN
         7L/OQOUKEImeXN+JuYvI9IvAXtpaIODpEkq0DVCRTWoGp5ju7r0pGReyT1VeYkUrfp7L
         T0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523314; x=1729128114;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7UO+Jwq3ZdJxz6tultIv+LNJVzpQeU7Lfk7TZbknkQ=;
        b=cZwHsWOyfWY0wH/OPJ9LZOdTRGofoVabks2hw7iFjyxGnTpF/DgKqzfEk0t7vz17+Z
         FUHRvI3vJKqA8KB8xaI6eLuqq6k5KM3NT761sGagjhRdhW6lJuaiymaClsz884Sa4dNU
         aj0ayycpOL6NwHc91ngg9+7wtqrHbbpQybcMJEn42QNEb5BPrJSwpr0cdMRQpHVlMD/q
         r2F2wgCCSiwSceNthY8GOhv8wjqlhpDf6zkVDAmKjKY9ffj7KCIN4jDq/PIZTJJzR1NW
         mPDfhrHopNEHqU2o7m2YH/Dc3NH/+nTGTuqnf+rcoFn2BC9dA1PeQClfKAnzABkmdncP
         Q18Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7dlN2ZNyUB7MeSS7GkRiX9KWNvAj8IsGNm9V62a+cfobLjfxbeDs3UX8d1my72I1nKo1a8HAGU5qF9cCHDWod@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd32hPFm8B4d0ygNpDoE+rOYPbiCyI5+kgCxOYFN1pRR52ufxG
	IArLxO18KtRVOkWSO52k0lT/DKEm5w/m9zF4uTtO/y1jZZEKBXzNZt434t9uvK29hrEb9mdTf2j
	HoOh+LQ==
X-Google-Smtp-Source: AGHT+IH94d/FgOnQJGUCJA7UrSbuAGJUXY9x6cU/dfPnHY26ynRvGlw4Kx879HTPfkURmk14BaQfQXrnHOdX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a5b:948:0:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e28fe44cd86mr79440276.10.1728523313861; Wed, 09 Oct 2024
 18:21:53 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:33 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 7/8] perf stat: Add metric-threshold to json output
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
index 5b5923730a7b..f699e39abcd8 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -496,15 +496,20 @@ static void print_metric_csv(struct perf_stat_config *config,
 
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
2.47.0.rc1.288.g06298d1525-goog

