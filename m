Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D33A8E1
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499279; cv=none; b=IZUUe2K1R6j0L16GygUuUOpiyCJQX1s6zbGqbOhgHtXnu6MUHeTlv4cqUkTtonoTPBzEBlExjO1/WKVCI98drvjFgwPB79sbFtXsbu1qdhn8sPZPsQJXOfiY2BX6uE0/0pKB+SkYYFFpSoz99nWIS+tPhLLGsYHzeNCwUrykqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499279; c=relaxed/simple;
	bh=Vctcg2i0KcfuRuGiF34q8FKyaNU+WFLIoo1taHhTiGA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=JihDLXVvDbTBcXCjybdctB2HJpxCtoT0gOsAdzw+3jAQgDb13e2g7V8LN2G/++O0jiGRu6QFWXstumXuvaMTNtIen3m4qmo7adAea8OXDMueF/rDY/y/RJt+4+FMOo9IW5uXljROVQACD8a654RInCyhtjMZSARXrIHXjonlsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrF/1n7d; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrF/1n7d"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608835a1febso4282267b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 23:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499277; x=1709104077; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjKYmJzQl8F9/gAiKS0z/bm1yBfw+nAatzaAOGPVP0k=;
        b=XrF/1n7dOXKAH5wwlFadyQT+L3Z6MR53hW/PKAjj+2En2vZI9bzH9ynIoY3vETgytt
         TG3qmFQPUux+TK0yo1csf/5DvXHXFFEPzh4ptDxH4PRAvosOb6LZwE543X/I+mFb+ZVz
         NsV8Qp5M0pQTczBSMiuMoVKTxpoXfUsVCQYVFNHFLlX8sBYQDv/w6qdzYj+VmUevsyjh
         6ho48hzhNE93SRUqEodChE7Gc8ltK+QAX9MuBMjHvr0hUCQ1dquctIgKsP0Lz35teJ0V
         0TL97/tQ3IAH46OU5ruNnB1T7PPMAuUEhI7QVSxYgUCKrbIAZjLgZYg12GAl+USPGaOX
         wGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499277; x=1709104077;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjKYmJzQl8F9/gAiKS0z/bm1yBfw+nAatzaAOGPVP0k=;
        b=Qgwcl4O9L/Q8sYiUPCnpFg3q9khxnn/8TuuwLzhwzGJX62GIcioJDLCKu3Mo5zOGXB
         yk35cq8WvDplCe2xkRlA2hqT0ae420bNVlgsfqeY6M4/luzqO4Jo3CyYhpeNonVvpUHF
         O4mv8dccQnQyWofJrtW/m/anCtV4RbHAjGKz1ozp2jyM3TU9ENpa9MVWbbj7/cTfYSgB
         rRMep3wDTMlU1zuaVCxfU19V3lfLfbNrQI65E21B4R9LXlky0fVy/mNVl8L45zodgHkh
         CF3AgQVRtGBpu+FW0fiLZxRAm+yyvg64aQhrvcDoojbTorOiEjp7rPwRA+PBHysVxDMY
         pJkg==
X-Forwarded-Encrypted: i=1; AJvYcCVN/V/RcfBKYUEDWP0yIF2OavptP8KFDkDn+0y60zt111thq9GxhjjKdIflBby8ffY7xxraRoJ3GwaHuv1BvoVyTGzn9JrO8sS63paEPwO9cQ==
X-Gm-Message-State: AOJu0YxqVvJDAWZ6CekhAqmwd0MYXpZ6a5fOIlbNXkmqwLk+Qo7O15VS
	9rpyjwZ1YHrXpSAlYEYjpPEG04AiPvhaVP9yrju8fTTQ3vZSD1MRR/zLekO+obk+dI/YRhrytaC
	nkepy/A==
X-Google-Smtp-Source: AGHT+IHqlDDgcr3rxtaox3ghXBLqkcK54ihRY+l5S7iwLrcnlNm+aa7RnDj8IoptqZzHNtAsKnMzftEqUTMC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a0d:d9c6:0:b0:608:77cd:bbfd with SMTP id
 b189-20020a0dd9c6000000b0060877cdbbfdmr485456ywe.1.1708499276945; Tue, 20 Feb
 2024 23:07:56 -0800 (PST)
Date: Tue, 20 Feb 2024 23:07:52 -0800
Message-Id: <20240221070754.4163916-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v3 1/3] perf stat: Pass fewer metric arguments
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

Pass metric_expr and evsel rather than specific variables from the
struct, thereby reducing the number of arguments. This will enable
later fixes.

To reduce the size of the diff, local variables are added to match the
previous parameter names. This isn't done in the case of "name" as
evsel->name is more intention revealing. A whitespace issue is also
addressed.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
v3 is a rebase fixing a merge conflict with
6d6be5eb45b4 ("perf metric: Don't remove scale from counts")
---
 tools/perf/util/stat-shadow.c | 38 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index cf573ff3fa84..10b452792037 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -355,11 +355,12 @@ static void print_nsecs(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
-static int prepare_metric(struct evsel **metric_events,
-			  struct metric_ref *metric_refs,
+static int prepare_metric(const struct metric_expr *mexp,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
 {
+	struct evsel * const *metric_events = mexp->metric_events;
+	struct metric_ref *metric_refs = mexp->metric_refs;
 	int i;
 
 	for (i = 0; metric_events[i]; i++) {
@@ -403,7 +404,7 @@ static int prepare_metric(struct evsel **metric_events,
 			if (!aggr)
 				break;
 
-                        if (!metric_events[i]->supported) {
+			if (!metric_events[i]->supported) {
 				/*
 				 * Not supported events will have a count of 0,
 				 * which can be confusing in a
@@ -436,18 +437,18 @@ static int prepare_metric(struct evsel **metric_events,
 }
 
 static void generic_metric(struct perf_stat_config *config,
-			   const char *metric_expr,
-			   const char *metric_threshold,
-			   struct evsel **metric_events,
-			   struct metric_ref *metric_refs,
-			   char *name,
-			   const char *metric_name,
-			   const char *metric_unit,
-			   int runtime,
+			   struct metric_expr *mexp,
+			   struct evsel *evsel,
 			   int aggr_idx,
 			   struct perf_stat_output_ctx *out)
 {
 	print_metric_t print_metric = out->print_metric;
+	const char *metric_name = mexp->metric_name;
+	const char *metric_expr = mexp->metric_expr;
+	const char *metric_threshold = mexp->metric_threshold;
+	const char *metric_unit = mexp->metric_unit;
+	struct evsel * const *metric_events = mexp->metric_events;
+	int runtime = mexp->runtime;
 	struct expr_parse_ctx *pctx;
 	double ratio, scale, threshold;
 	int i;
@@ -462,7 +463,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
+	i = prepare_metric(mexp, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -497,18 +498,18 @@ static void generic_metric(struct perf_stat_config *config,
 				print_metric(config, ctxp, color, "%8.2f",
 					metric_name ?
 					metric_name :
-					out->force_header ?  name : "",
+					out->force_header ?  evsel->name : "",
 					ratio);
 			}
 		} else {
 			print_metric(config, ctxp, color, /*unit=*/NULL,
 				     out->force_header ?
-				     (metric_name ? metric_name : name) : "", 0);
+				     (metric_name ?: evsel->name) : "", 0);
 		}
 	} else {
 		print_metric(config, ctxp, color, /*unit=*/NULL,
 			     out->force_header ?
-			     (metric_name ? metric_name : name) : "", 0);
+			     (metric_name ?: evsel->name) : "", 0);
 	}
 
 	expr__ctx_free(pctx);
@@ -523,7 +524,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, aggr_idx) < 0)
+	if (prepare_metric(mexp, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
@@ -625,10 +626,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 
 		if ((*num)++ > 0)
 			out->new_line(config, ctxp);
-		generic_metric(config, mexp->metric_expr, mexp->metric_threshold,
-			       mexp->metric_events, mexp->metric_refs, evsel->name,
-			       mexp->metric_name, mexp->metric_unit, mexp->runtime,
-			       aggr_idx, out);
+		generic_metric(config, mexp, evsel, aggr_idx, out);
 	}
 
 	return NULL;
-- 
2.44.0.rc1.240.g4c46232300-goog

