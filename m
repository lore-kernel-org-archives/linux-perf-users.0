Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92481365
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497933; cv=none; b=AjpEI+/M6hejB7kr9GC0KF+MqgiYgK/McR1joUY4PdvSFtIlghvvAT2kd2vheSNmn1Npd5619G17DHGriA4f6Gwah9oWRXym0G3pKvT+xkwWJGIoHk3MHNrD6qLcaap8V/IkRbKahkqkuIH0KPRA2HZGoNJVIS3XzrOWKSKMBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497933; c=relaxed/simple;
	bh=Vctcg2i0KcfuRuGiF34q8FKyaNU+WFLIoo1taHhTiGA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=iyBKMu50ObvjAse66GX22ruKgVFVH55N0vTh2sxyhLZx0326lLAVs4VMacysKvhF8Qya/3n3S5vpDmj1H9ePNGFcMQsRbUYekANDZf29u27PrgzIErQhLMnQQ5apBo3TprnjVHyEu+5q1vXqrrNGsYOZdVhGt15jOVbG4zzRNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBhQP58N; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBhQP58N"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so5794480276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 22:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708497930; x=1709102730; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjKYmJzQl8F9/gAiKS0z/bm1yBfw+nAatzaAOGPVP0k=;
        b=FBhQP58NRwd1yBJeVqRM+xpj6OxfCDLKxyPC5i7cndR11vjnLz1RPNJSvMtpvb7lbi
         5pE7fYyeuT/gdg+bPboMnkEOGtqv3DaGZuv24+8MsiwrETBWhF1L0Q3PJVQK0aENDOyY
         soIyPd6Rhk6FX2OxaFCJGHKAkeNHRmaDjG6J1WMWlPw2IeUxWlP9ylmhFCC4NXbRVy4X
         J8cIqIk3BfPMqpFAm2KqeB5wZ0HX6ywaFj/PmkmB4qqczSbNUSWZgtuE5HyrptcAWeQH
         hYH8iGFxPkhJrmVqjmo5ff42JVd5D3+81bbm+kGCGoEWWwxOYmquP8NWViXncb9gx91N
         ekCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497930; x=1709102730;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjKYmJzQl8F9/gAiKS0z/bm1yBfw+nAatzaAOGPVP0k=;
        b=hwR5RqqKMALB7H9TF/vNa7Q3O1uuBFc1Df7yRDMbunjlWCZGT8VLgM0dglkLymWwsf
         Fy7ELKjR720kSrEpf+8VWegm4e2/7G4sPvnNkYTi7G4Hu3zOKhfSBu3hcP3FQFDOavgr
         Vxg4kc/FJpSWFTh8VxHssKHbvnqP7DspNc57iBaksrII6JuiUKg5e8Vg7c8E8MkTBnql
         OXVlhecR2EcKXc8FkwnencPoJXX4ugh3Hq76lYtrPuEFvp8nMw6e2x0iqjSIDbtVmIzz
         /Wbg7glQw59GQ6tCqA0uAiAMCJIVj86/AK00yiQigsjVBws86zKzc5SsjH1I3UNFoXnw
         h2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWRHJoIXeU10nUhmiOvnGmi7KXINe/GN6aZTwfjunvm8zmZcEacPIVZUe24rSqDi2Gq1+htbr8yWXeF/5ZCcpasGWkLZt1IO4ZUsnDEKZfQDQ==
X-Gm-Message-State: AOJu0YxsZ/WmzE/VqQ/laQosPolLOBDtiVLP9pDaahLlJeRXZ4M2Aqlo
	kgE0sF35RaNGTVeGValBJ5jXSQ8L27Dt8xy6+IkKWExL5uFnh1fuAu7fuH7/flia2Tvl63PqQWX
	WDDfCwA==
X-Google-Smtp-Source: AGHT+IErgek7Kgr7Qh+HAKx6rhClJue5n+B3yY7ppgGbqxhtIfZLsovYIalBTJkT2C2mm8wmjSuiWkDPhJcS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:dc7:6f13:61d9 with SMTP id
 k4-20020a056902070400b00dc76f1361d9mr667105ybt.4.1708497930543; Tue, 20 Feb
 2024 22:45:30 -0800 (PST)
Date: Tue, 20 Feb 2024 22:45:24 -0800
Message-Id: <20240221064527.4157979-1-irogers@google.com>
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

