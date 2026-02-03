Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250B2ED87F
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160075; cv=none; b=kNQkfDocxRQ0XTTHCaSX0Kj0LFLJbx+Sn3cqIZ+7ByHp0F+L50J9Kr8+5SVYn16sa1cWkKvsrYE2yyTG8YUlXOcGE04zFWNBSSmoLVB10mosP9vDr2DdR3jIIsi31+ZPlyIT/Jpsk2DJi9t2gmnL5z4IFrD1QH9kTm3S6iuC9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160075; c=relaxed/simple;
	bh=ataIrsuT6kn+kBP7PwZqzZhRV80sJ6OEtLc1r1AZpfg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B1/1bu88EOhLWTwd5JOSZ7rTPWWAP/of0fGzILa3qHU7EvfkvFPuyNpFlCs9MGuRvm1nAQuyFSkKuYP0f8nUohAj2G/gNSC/6/LjL9c6YZOtYfNe6nGoV86/HgJK5eUihLiI+GbOoC/LLd8guNwu0QlpvHwm1VgkJbUNkqwbyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37PB8bN3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37PB8bN3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b8343aa8a9so273837eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 15:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770160073; x=1770764873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ImMNbS4iyuM4vqaiQqsBwPE5OsGP6r0BTMGG0rNNvs=;
        b=37PB8bN3veycEWAZh/3yPw/8Oiow4JKlUd7LcgroGdA5Zsf6YVo+r46Ih5xmTR97c+
         UAEs8jrhh47syUzr+AfNoxopkdVPru3vjVRhptN2QkcEpAYTSlOx+xBMHd+IAJtlTM2z
         ARJZN+s3U8FwyYbR5MIbwfIw43SHYnybjoUAR2/DDmJZAwMMAeKIouFHi9wfSzmCZ8nA
         vrpA9M9AihbDJlluQoYSWeiSqQqXd3RtMnn0MPBVhH/ohIX2BatPr6pbd9ocljldeEoM
         eew4s//ZvvIP6fVKtBXO/4q8VdVoJIneOpaIYdvAIctpEcX873Au9cKdO3gRQZ7psiYt
         o4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160073; x=1770764873;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ImMNbS4iyuM4vqaiQqsBwPE5OsGP6r0BTMGG0rNNvs=;
        b=Y3pZiq6CL9hxlpM11GEdNAU5VOqAUKzUAx4ijYrHqTy7M3zwtWXe0iHn1iT/I9IM3F
         5ZwLDtWgcJD8Wb+Z3beQQR2h8kg8d8ZD6FXWm1B7YDin+k+iAjLbUh5sfalCpas3jV/+
         AWN8qQkNudk4lH9u0CLsZbDKfEVQiGq2e61sC3G2js02h0sdkD0AUDVO1nAHFPKVcXSX
         m9IkoQclzqMaPqV9cTdy+owGxHiQ4gyfXMDFkcEn8wZ53LXIfbjKcjSFBOiZBJBjYa/k
         ShOdJuQyBz6NG7B4TOndiZQof/uMIlAMaIhH3lnJ2gozMEl2QXfaytku1IDME6r7ViZn
         NqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY9u29w8X/Yl4yX9t/UosCqOVU7Ys/2Mn10aT4tujIVN5JBywqKO1xjiErhdVogdMZxH3lPcWu0+jaelCM0XXQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNDMO847UuZmEOT39M67lSC5xZYufEbCXHJfF7VtBdg9mFIGi
	vVY6nwTdjyjUUNUWnWwll/LVx4zDxMr3/MHOeu4AMXyUc5NVdrmUZWBxxqxbdcWC9YHLT5MSB0a
	Sn4I55A==
X-Received: from dykg18.prod.google.com ([2002:a05:7300:5792:b0:2af:dc89:507f])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2f8c:b0:2ae:533d:19ee
 with SMTP id 5a478bee46e88-2b8329e39a7mr538318eec.21.1770160072569; Tue, 03
 Feb 2026 15:07:52 -0800 (PST)
Date: Tue,  3 Feb 2026 15:06:22 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203230733.1474840-1-ctshao@google.com>
Subject: [PATCH] perf stat: Ensure metrics are displayed even with failed events
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, kan.liang@linux.intel.com, 
	yang.lee@linux.alibaba.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, `perf stat` skips or hides metrics when the underlying
hardware events cannot be counted (e.g., due to insufficient permissions
or unsupported events). In `--metric-only` mode, this often results in
missing columns or blank spaces, making the output difficult to parse.

Modify the logic to ensure metrics are consistently displayed by
propagating NAN (Not a Number) through the expression evaluator.
Specifically:

1. Update `prepare_metric()` in stat-shadow.c to treat uncounted events
   (where `run == 0`) as NAN. This leverages the existing math in expr.y
   to propagate NAN through metric expressions.
2. Remove the early return in the display logic's `printout()` function
   that was previously skipping metrics in `--metric-only` mode for
   failed events.
3. Simplify `perf_stat__skip_metric_event()` to no longer depend on
   event runtime.

Tested:
1. `perf all metrics test` did not crash while paranoid is 2.
2. Multiple combinations with `CPUs_utilized` while paranoid is 2.

  $ ./perf stat -M CPUs_utilized -a -- sleep 1

   Performance counter stats for 'system wide':

     <not supported> msec cpu-clock:u                      #      nan CPUs  CPUs_utilized
       1,006,356,120      duration_time

         1.004375550 seconds time elapsed

  $ ./perf stat -M CPUs_utilized -a -j -- sleep 1
  {"counter-value" : "<not supported>", "unit" : "msec", "event" : "cpu-clock:u", "event-runtime" : 0, "pcnt-running" : 100.00, "metric-value" : "nan", "metric-unit" : "CPUs  CPUs_utilized"}
  {"counter-value" : "1006642462.000000", "unit" : "", "event" : "duration_time", "event-runtime" : 1, "pcnt-running" : 100.00}

  $ ./perf stat -M CPUs_utilized -a --metric-only -- sleep 1

   Performance counter stats for 'system wide':

    CPUs  CPUs_utilized
                      nan

         1.004424652 seconds time elapsed

  $ ./perf stat -M CPUs_utilized -a --metric-only -j -- sleep 1
  {"CPUs  CPUs_utilized" : "none"}

Signed-off-by: ctshao@google.com
---
 tools/perf/util/stat-display.c | 59 +++++++++++++++-------------------
 tools/perf/util/stat-shadow.c  |  8 ++---
 tools/perf/util/stat.h         |  2 +-
 3 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 2ce0602974a1..dc2b66855f6c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -820,12 +820,6 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	}
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
-		if (config->metric_only) {
-			pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL,
-			   /*unit=*/NULL, /*val=*/0);
-			return;
-		}
-
 		ok = false;
 
 		if (counter->supported) {
@@ -848,33 +842,32 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		print_running(config, os, run, ena, /*before_metric=*/true);
 	}
 
-	if (ok) {
-		if (!config->metric_only && counter->default_metricgroup && !counter->default_show_events) {
-			void *from = NULL;
-
-			aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
-			/* Print out all the metricgroup with the same metric event. */
-			do {
-				int num = 0;
-
-				/* Print out the new line for the next new metricgroup. */
-				if (from) {
-					if (config->json_output)
-						new_line_json(config, (void *)os);
-					else
-						__new_line_std_csv(config, os);
-				}
-
-				print_noise(config, os, counter, noise, /*before_metric=*/true);
-				print_running(config, os, run, ena, /*before_metric=*/true);
-				from = perf_stat__print_shadow_stats_metricgroup(config, counter, aggr_idx,
-										 &num, from, &out);
-			} while (from != NULL);
-		} else {
-			perf_stat__print_shadow_stats(config, counter, aggr_idx, &out);
-		}
+	if (!config->metric_only && counter->default_metricgroup &&
+	    !counter->default_show_events) {
+		void *from = NULL;
+
+		aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
+		/* Print out all the metricgroup with the same metric event. */
+		do {
+			int num = 0;
+
+			/* Print out the new line for the next new metricgroup. */
+			if (from) {
+				if (config->json_output)
+					new_line_json(config, (void *)os);
+				else
+					__new_line_std_csv(config, os);
+			}
+
+			print_noise(config, os, counter, noise,
+				    /*before_metric=*/true);
+			print_running(config, os, run, ena,
+				      /*before_metric=*/true);
+			from = perf_stat__print_shadow_stats_metricgroup(
+				config, counter, aggr_idx, &num, from, &out);
+		} while (from != NULL);
 	} else {
-		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/NULL, /*val=*/0);
+		perf_stat__print_shadow_stats(config, counter, aggr_idx, &out);
 	}
 
 	if (!config->metric_only) {
@@ -987,7 +980,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	if (perf_stat__skip_metric_event(counter, ena, run))
+	if (perf_stat__skip_metric_event(counter))
 		return;
 
 	if (val == 0 && should_skip_zero_counter(config, counter, &id))
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9c83f7d96caa..5d8d09e0e6ae 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -83,7 +83,7 @@ static int prepare_metric(struct perf_stat_config *config,
 		}
 		/* Time events are always on CPU0, the first aggregation index. */
 		aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
-		if (!aggr || !metric_events[i]->supported) {
+		if (!aggr || !metric_events[i]->supported || aggr->counts.run == 0) {
 			/*
 			 * Not supported events will have a count of 0, which
 			 * can be confusing in a metric. Explicitly set the
@@ -335,14 +335,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
  * perf_stat__skip_metric_event - Skip the evsel in the Default metricgroup,
  *				  if it's not running or not the metric event.
  */
-bool perf_stat__skip_metric_event(struct evsel *evsel,
-				  u64 ena, u64 run)
+bool perf_stat__skip_metric_event(struct evsel *evsel)
 {
 	if (!evsel->default_metricgroup)
 		return false;
 
-	if (!ena || !run)
-		return true;
-
 	return !metricgroup__lookup(&evsel->evlist->metric_events, evsel, false);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f986911c9296..4bced233d2fc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -163,7 +163,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   int aggr_idx,
 				   struct perf_stat_output_ctx *out);
-bool perf_stat__skip_metric_event(struct evsel *evsel, u64 ena, u64 run);
+bool perf_stat__skip_metric_event(struct evsel *evsel);
 void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 						struct evsel *evsel,
 						int aggr_idx,
-- 
2.53.0.rc2.204.g2597b5adb4-goog

