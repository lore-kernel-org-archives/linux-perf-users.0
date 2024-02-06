Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532377F08
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193932; cv=none; b=fr4sJjGtmGgeVfmOr59XIAShD4omIyZ3JSGnvgiBje91/5Ya2OeW9r2cEKU7SU4v+8T+yE5obqPnkJNVKG7srdYuYB0tYDR/IuTY2mBOQ1r1heaTMAE80eesa9DxQRr8bJzVCxDJB/ZTyZHOLmYxopN9zxEbmb3KV1JNcB763VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193932; c=relaxed/simple;
	bh=H4Ot/tbzdD7mTU5prpB/Q+DedtdUrPrliS8HXaRvhm4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=jUj39lD+YlQPwgmSJmk9gH7oqzq+cdxQ1U1exFRpsxCaR8ybgr5N+pxmEVhVnw8rem1KuD+/CWGP8c4Oeuahyl2BbZIOYgpx8CbqVFoaQJ9IIb69Srh43sfJhTlHeW/G1ttfNKjmR9R8MCs6gZOTcOL5cktxXqOPT+20ZiwXec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+F9p+Uz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+F9p+Uz"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc7165d7ca3so1930279276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Feb 2024 20:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707193928; x=1707798728; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZUpnex2KPkifzX16ZZpXLaFgVrYfXozd164M4YKBC4=;
        b=k+F9p+Uz0w+cbOpW+KJkZ4I7dev6JX4AjMXrg3G7EieyTwOxfHRoXJSNEJTGoDe42v
         YRoi1BeADQplKbiwY0XNnyNVE8JPYZryZ711mTSYNS50R3ZC00X7A4gfpOwjKGNM1Y1f
         1NMl3cfCg/H/ivA+cZAOn/g+i+8kgCzua2iHN7FZB43k/vNO6hYgnweLGDSE0U5FdMJP
         GbkiQaG2HbbQzQQCwafGW44JzXHcXW2uTzpWu/7JegaTQS5b3Q0Sbvf7qjrrHBPlqrlY
         BBp2Kgo8GYCg6h22r02Haa78goXeESpkOsjLDLRnSQZYCATzLcgMuHL/qh/QwLv5ECwh
         vLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707193928; x=1707798728;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZUpnex2KPkifzX16ZZpXLaFgVrYfXozd164M4YKBC4=;
        b=YjkJZpBBVWJjpzigzDj+MqtrksMbzORKW1qwH6l5ldlsgiETLtOfYELNuXT07TFiIV
         CNDvpc7MNohWMBI91YaFpPEOwpjN1Xq8C6bVcFvWSadUoziOvfqSjGkJ7ng3tdzRaZ46
         VHU1SWrE5PgD+abqpBuBYqLeyB2/HYLPG375DV5vCvlKsT6GTcy63yCCHJ2/QpsRAfjT
         IsLuNxkYhz8HLm3beOIT4oIT2pwE+QIcMvtoGpHGJ9A+LwuGSC5mwXU0eQe3Y0twtCBH
         jL7tVfKxbDlUgT73HrTER6n+5AeH2GNpdNV/xtj7Ng2B0QEnr/UDY2PokNoKhec+G33N
         5N5g==
X-Gm-Message-State: AOJu0YxRDq6twE55mSsDEsV5rrsleNnGbUv+lgENVVa8y+KD4wJuTxXw
	0bzQzL2p2uitdndPvHRxsHRh5iMoBm/LmE6VDs1SR3XSo69QsKVial9N/mfUTH9NGUdH59j8QIn
	78saI7w==
X-Google-Smtp-Source: AGHT+IGF1c06XFHXPDyft9AbNZZU32/ebHE0GF+Lb5/J5jDeVr/9sBGL2CldohFM2dKJNsqOwT3E4mRsFL+B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:6902:240f:b0:dc6:4bf5:5a74 with SMTP
 id dr15-20020a056902240f00b00dc64bf55a74mr21509ybb.11.1707193928212; Mon, 05
 Feb 2024 20:32:08 -0800 (PST)
Date: Mon,  5 Feb 2024 20:31:58 -0800
In-Reply-To: <20240206043159.2539981-1-irogers@google.com>
Message-Id: <20240206043159.2539981-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206043159.2539981-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 2/3] perf metrics: Compute unmerged uncore metrics individually
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

When merging counts from multiple uncore PMUs the metric is only
computed for the metric leader. When merging/aggregation is disabled,
prior to this patch just the leader's metric would be computed. Fix
this by computing the metric for each PMU.

On a SkylakeX:
Before:
```
$ perf stat -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

CPU0               82,217      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9.2 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0.0 MB/s  memory_bandwidth_total
CPU0               61,395      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU0               81,570      UNC_M_CAS_COUNT.RD [uncore_imc_2]
CPU18             113,886      UNC_M_CAS_COUNT.RD [uncore_imc_2]
CPU0               62,330      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU18              66,942      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU0               75,489      UNC_M_CAS_COUNT.RD [uncore_imc_3]
CPU18              27,958      UNC_M_CAS_COUNT.RD [uncore_imc_3]
CPU0               55,864      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU18              38,727      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU0               75,423      UNC_M_CAS_COUNT.RD [uncore_imc_5]
CPU18             104,527      UNC_M_CAS_COUNT.RD [uncore_imc_5]
CPU0               57,596      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU18              56,777      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU0        1,003,440,851 ns   duration_time

       1.003440851 seconds time elapsed
```

After:
```
$ perf stat -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

CPU0               88,968      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9.5 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0.0 MB/s  memory_bandwidth_total
CPU0               59,498      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0.0 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0.0 MB/s  memory_bandwidth_total
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU0               88,635      UNC_M_CAS_COUNT.RD [uncore_imc_2] #      9.5 MB/s  memory_bandwidth_total
CPU18             117,975      UNC_M_CAS_COUNT.RD [uncore_imc_2] #     11.5 MB/s  memory_bandwidth_total
CPU0               60,829      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU18              62,105      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU0               82,238      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      8.7 MB/s  memory_bandwidth_total
CPU18              22,906      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      3.6 MB/s  memory_bandwidth_total
CPU0               53,959      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU18              32,990      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0.0 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0.0 MB/s  memory_bandwidth_total
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU0               83,595      UNC_M_CAS_COUNT.RD [uncore_imc_5] #      8.9 MB/s  memory_bandwidth_total
CPU18             110,151      UNC_M_CAS_COUNT.RD [uncore_imc_5] #     10.5 MB/s  memory_bandwidth_total
CPU0               56,540      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU18              53,816      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU0        1,003,353,416 ns   duration_time
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c |  2 ++
 tools/perf/util/stat-shadow.c | 31 +++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ca3e0404f187..c33ffee837ca 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -44,6 +44,8 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 	if (!metric_events)
 		return NULL;
 
+	if (evsel->metric_leader)
+		me.evsel = evsel->metric_leader;
 	nd = rblist__find(metric_events, &me);
 	if (nd)
 		return container_of(nd, struct metric_event, nd);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index b3a25659b9e6..c745337f50a4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -356,6 +356,7 @@ static void print_nsecs(struct perf_stat_config *config,
 }
 
 static int prepare_metric(const struct metric_expr *mexp,
+			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
 {
@@ -399,8 +400,29 @@ static int prepare_metric(const struct metric_expr *mexp,
 			source_count = 1;
 		} else {
 			struct perf_stat_evsel *ps = metric_events[i]->stats;
-			struct perf_stat_aggr *aggr = &ps->aggr[aggr_idx];
+			struct perf_stat_aggr *aggr;
 
+			/*
+			 * If there are multiple uncore PMUs and we're not
+			 * reading the leader's stats, determine the stats for
+			 * the appropriate uncore PMU.
+			 */
+			if (evsel && evsel->metric_leader &&
+			    evsel->pmu != evsel->metric_leader->pmu &&
+			    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
+				struct evsel *pos;
+
+				evlist__for_each_entry(evsel->evlist, pos) {
+					if (pos->pmu != evsel->pmu)
+						continue;
+					if (pos->metric_leader != mexp->metric_events[i])
+						continue;
+					ps = pos->stats;
+					source_count = 1;
+					break;
+				}
+			}
+			aggr = &ps->aggr[aggr_idx];
 			if (!aggr)
 				break;
 
@@ -421,7 +443,8 @@ static int prepare_metric(const struct metric_expr *mexp,
 				 * metric.
 				 */
 				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
-				source_count = evsel__source_count(metric_events[i]);
+				if (!source_count)
+					source_count = evsel__source_count(metric_events[i]);
 			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
@@ -468,7 +491,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(mexp, pctx, aggr_idx);
+	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -529,7 +552,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp, pctx, aggr_idx) < 0)
+	if (prepare_metric(mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
-- 
2.43.0.594.gd9cf4e227d-goog

