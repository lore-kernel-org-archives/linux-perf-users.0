Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF062D8395
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234517; cv=none; b=oME4jCgZ0EP6dpbdu/qf5e0+2aCmvvWj2dZ4+xerZA4KDu1ZR3XmdhuQqbj7nXbg+K4XD0ZDIWzWDPMdAHk56NT4EzASg9obyk1km7dVsmM2Zrinf6M2m1zc39OHcXxSLCEzwxwBbSYePnwQNq+we2CDU9Dw/By8+XBDpME7uFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234517; c=relaxed/simple;
	bh=08ijCr0uGlsFSbZ/fgqz1ZTZskEhlF1NYYU1LmYJx3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=odGSYzRKVNIAuX59W+VuVPYV11HWyY9JDqIuDdIy6KnmG00c+nfYt5GKt9SVtiTpQDUoa31vEY8wQ7YUabNzW3Do8rygpFzTxX/ELeewsitWjqA9mMPxX2alqSHSbyp7gORYBYAUi3MPASClM4KrQt7MykjdaQjH5Qr47jbxItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHNYGM1A; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHNYGM1A"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3407734d98bso5247499a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2025 21:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762234515; x=1762839315; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1KvbIMxbd19M72vJDZRo+HtVoi/M7IAdLRCZTkMiOI=;
        b=NHNYGM1A1PrVZNMOoywzfE3vDgeND22YT/63OSuI4KPyxUVRqVnyRHkiVwh0H/1nuE
         xdy2riuShdHTgbsCcZZc6mrRI3qHzDO32Y+64ZbeSuCifa8jB/TmGgJWx1RFNwyPPkEs
         Co3fYP6CLMCRMuzIxju61zvh2Z/v1L7VJnRYjiJNlOz7uK6Ornqa55Okvp4kHtifbTfW
         XOTrvMIqYpldfQNKodCdIz11yfU69snZ/QMjhA7MmlP+P/Mo79qNcuonc/z3fGnzgckI
         mAv8FfD5LZlfrqGH1byHJfH5Sgn7vxsN8WtyPdGCVzjw6PqAMVOQ8mW2FIiem+OOGbUs
         Dlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234515; x=1762839315;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1KvbIMxbd19M72vJDZRo+HtVoi/M7IAdLRCZTkMiOI=;
        b=ffPaLwJTxtDHKV3WWfMlTrCnVRukWkUKeDaSH7zhzX4DWul3aQjxUeRvqIacY+v4X/
         HxsnPYmmW1/E3SuXibRHtjMDmM3mR6f4pzeJRteBvNFaUU4YBeHTvmlZZqIervAWC1Ad
         R5uK4LRxO/HQ18G0iOFojxUl28r83sakfNTP+lwfGgzrNzbG1U7zWwsz+Vlb7RJevhys
         BmIRbyx1fdL+e4zxaLAfo9VQtWWt+qT6bn4OGtGY9TKLIUTO3QdMmPeOrsPXKCvGYGa3
         BEJnNB3vlvfr1awVfIXugJQGDIU1V0ZDz51nNe5DmWTjcd6Z3rQ/qt0A7zAgX+fssXng
         VC4A==
X-Forwarded-Encrypted: i=1; AJvYcCXC+rMAaGCbQLo4xA6NBLB90ss+kdTxKFN0le8ynsY6lwRkF306vu2nPYhSjpIVyQB67ECJIXGn+Fcs6fShVMTN@vger.kernel.org
X-Gm-Message-State: AOJu0YxRVB+mo5pztykaiUuCTSf323iEE4pAoglu96P7js0KLv9WfUMo
	JXa15uJyb9md0Xwok6njgDqDi2WKku80QL+kUHw96otUFeNo/tXMJBj7BwHxk5Vl/OOMkTK5L8V
	/W6P3NLMBCg==
X-Google-Smtp-Source: AGHT+IHg8vuuK24MUAVn/T8iJAz+pTziBsjHRF/6BK9JjvJ4pGSGVYhCzJOL2/pjhA8JvCw4LkfTl2GieJwB
X-Received: from pjbml3.prod.google.com ([2002:a17:90b:3603:b0:340:5073:f80f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c06:b0:341:2150:4856
 with SMTP id 98e67ed59e1d1-341215049b9mr8725601a91.17.1762234514796; Mon, 03
 Nov 2025 21:35:14 -0800 (PST)
Date: Mon,  3 Nov 2025 21:34:48 -0800
In-Reply-To: <20251104053449.1208800-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251104053449.1208800-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104053449.1208800-2-irogers@google.com>
Subject: [PATCH v1 2/3] perf stat-shadow: Read tool events directly
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When reading time values for metrics don't use the globals updated in
builtin-stat, just read the events as regular events. The only
exception is for time events where nanoseconds need converting to
seconds as metrics assume time metrics are in seconds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 123 +++++++++++++---------------------
 1 file changed, 45 insertions(+), 78 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..9fae3d32a519 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -371,6 +371,18 @@ static void print_nsecs(struct perf_stat_config *config,
 	}
 }
 
+static double tool_pmu__scale_for_metric(const struct evsel *evsel)
+{
+	enum tool_pmu_event event = evsel__tool_event(evsel);
+
+	if (event == TOOL_PMU__EVENT_DURATION_TIME ||
+	    event == TOOL_PMU__EVENT_USER_TIME ||
+	    event == TOOL_PMU__EVENT_SYSTEM_TIME)
+		return 1e-9; /* Scale nanoseconds to seconds. */
+
+	return 1.0;
+}
+
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -382,90 +394,45 @@ static int prepare_metric(const struct metric_expr *mexp,
 
 	for (i = 0; metric_events[i]; i++) {
 		char *n;
-		double val;
+		double val, scale = tool_pmu__scale_for_metric(metric_events[i]);
 		int source_count = 0;
+		struct perf_stat_evsel *ps = metric_events[i]->stats;
+		struct perf_stat_aggr *aggr;
 
-		if (evsel__is_tool(metric_events[i])) {
-			struct stats *stats;
-			double scale;
-
-			switch (evsel__tool_event(metric_events[i])) {
-			case TOOL_PMU__EVENT_DURATION_TIME:
-				stats = &walltime_nsecs_stats;
-				scale = 1e-9;
-				break;
-			case TOOL_PMU__EVENT_USER_TIME:
-				stats = &ru_stats.ru_utime_usec_stat;
-				scale = 1e-6;
-				break;
-			case TOOL_PMU__EVENT_SYSTEM_TIME:
-				stats = &ru_stats.ru_stime_usec_stat;
-				scale = 1e-6;
+		/*
+		 * If there are multiple uncore PMUs and we're not reading the
+		 * leader's stats, determine the stats for the appropriate
+		 * uncore PMU.
+		 */
+		if (evsel && evsel->metric_leader &&
+		    evsel->pmu != evsel->metric_leader->pmu &&
+		    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
+			struct evsel *pos;
+
+			evlist__for_each_entry(evsel->evlist, pos) {
+				if (pos->pmu != evsel->pmu)
+					continue;
+				if (pos->metric_leader != mexp->metric_events[i])
+					continue;
+				ps = pos->stats;
+				source_count = 1;
 				break;
-			case TOOL_PMU__EVENT_NONE:
-				pr_err("Invalid tool event 'none'");
-				abort();
-			case TOOL_PMU__EVENT_MAX:
-				pr_err("Invalid tool event 'max'");
-				abort();
-			case TOOL_PMU__EVENT_HAS_PMEM:
-			case TOOL_PMU__EVENT_NUM_CORES:
-			case TOOL_PMU__EVENT_NUM_CPUS:
-			case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
-			case TOOL_PMU__EVENT_NUM_DIES:
-			case TOOL_PMU__EVENT_NUM_PACKAGES:
-			case TOOL_PMU__EVENT_SLOTS:
-			case TOOL_PMU__EVENT_SMT_ON:
-			case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
-			default:
-				pr_err("Unexpected tool event '%s'", evsel__name(metric_events[i]));
-				abort();
 			}
-			val = avg_stats(stats) * scale;
-			source_count = 1;
-		} else {
-			struct perf_stat_evsel *ps = metric_events[i]->stats;
-			struct perf_stat_aggr *aggr;
-
+		}
+		aggr = &ps->aggr[aggr_idx];
+		if (!aggr || !metric_events[i]->supported) {
 			/*
-			 * If there are multiple uncore PMUs and we're not
-			 * reading the leader's stats, determine the stats for
-			 * the appropriate uncore PMU.
+			 * Not supported events will have a count of 0, which
+			 * can be confusing in a metric. Explicitly set the
+			 * value to NAN. Not counted events (enable time of 0)
+			 * are read as 0.
 			 */
-			if (evsel && evsel->metric_leader &&
-			    evsel->pmu != evsel->metric_leader->pmu &&
-			    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
-				struct evsel *pos;
-
-				evlist__for_each_entry(evsel->evlist, pos) {
-					if (pos->pmu != evsel->pmu)
-						continue;
-					if (pos->metric_leader != mexp->metric_events[i])
-						continue;
-					ps = pos->stats;
-					source_count = 1;
-					break;
-				}
-			}
-			aggr = &ps->aggr[aggr_idx];
-			if (!aggr)
-				break;
-
-			if (!metric_events[i]->supported) {
-				/*
-				 * Not supported events will have a count of 0,
-				 * which can be confusing in a
-				 * metric. Explicitly set the value to NAN. Not
-				 * counted events (enable time of 0) are read as
-				 * 0.
-				 */
-				val = NAN;
-				source_count = 0;
-			} else {
-				val = aggr->counts.val;
-				if (!source_count)
-					source_count = evsel__source_count(metric_events[i]);
-			}
+			val = NAN;
+			source_count = 0;
+		} else {
+			val = aggr->counts.val * scale;
+			if (!source_count)
+				source_count = evsel__source_count(metric_events[i]);
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.51.2.1006.ga50a493c49-goog

