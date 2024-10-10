Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21573CF58
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523305; cv=none; b=JNmLKEtAz56t+s3fNnLAX8S0qvKEdPOq2UusL6eE+sdGXcae0Y1mbZzuDkDwz8bS49xGAle9vvIUy+dPUYGSGGAyIC6ZeP3TMKaR2vFhJmtzwS45cBrlqgftLw6r7OjQtdSDJqK2WiSqlzBjEmnLgCYatm4nXTaKEfNrkO+kfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523305; c=relaxed/simple;
	bh=9mfIJcC0HJSEWZzG9Ykal5rxE97ZbtmZRtRyHou+jpQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ufLmFcL/36vm2aHMgsGKT2v95xlSgByGFEWqLnlAPQA5pTjAYGA/LzDezguw58IlEG8QpS/htpnuNA6Bke6ru/IHj632zeJJs7YT9bFTxjqEC87vEIRrxNx22WpC+2X18QVH4PFHVBsH1U36iPHRriWlJStlxCHhZ7vQDrJs7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bT5QYezy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bT5QYezy"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3204db795so9387727b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 18:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523302; x=1729128102; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vk61ddLBPHHKenKN2gCI30GmxdQHp5UrYWcIorCWcs=;
        b=bT5QYezyFUTWyL3EXMZFlx5BduO1zQ2iE4hnEd0vES/W94bItmbap8ZecDxnwq+BVP
         zo/1tEGMFFx5x1Jwu8BBiP+6sBNr6ANDdi+OgY5zy0efNcqtl5n+wezoOC1TrhoGG5Wq
         e10FWOdKJNXwpAlozrjvraWSWcDGHHnNxlimelbUiB4ladGX/iCpLWmeFbwhgpMmUQVM
         ULvBzv+Wsp2/gzBY2430GPQI+wYZ2cA1YL/T0BeveL1wKioY9UB+JAsAo5E8ckhKKqv+
         txJhcIl63vmSVazpCQoXFL+37XzhwirA/YlF/u4socwArtS/x3e1DKJPVw0L5s5I9pNQ
         7pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523302; x=1729128102;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vk61ddLBPHHKenKN2gCI30GmxdQHp5UrYWcIorCWcs=;
        b=U4sFuobQsm1a/mqgz4GWrICyc1zRNhlVNUK4Xd+TvwMcKWFc+wuJ5T26ySFxZcyV5z
         xocwnSR0tRAtsmyW3sOYiGfWvuGCQTpExTxCTOcUkzztWrwMkj9xpzMm/bSJBizzYuib
         w24BaiA8+ejoDage7Kgd1tEMSnwwfKeCd2JkD66lgr36yrCYhWbUUCa9q+jmqEwEmsWv
         Tg7aOIkzjwHJh8vnV3Wzgc84BhVjFmv+XgK5CNMCbxxhk2Dw6IS9AcQsEigELdonpB5+
         0WSL79SPRVAIaiobDrE40xXjiX+4MPpmTj3rMIgZR5Vxuiny9HrM8fGKHZLnpAzdRi9I
         jPLg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Rf34NHiFXnCYQEFPT2b4rSYocHJm/YiYkQoe4tLqHb15lfizXHs7az3BRGfDZ9dbP+egxxThhTujUccCwRJx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7v/nfhoVUhww2ACKHm5cIZQ/BIklkRmboI2XlGdWXF8hCR4Ng
	5cRnHK01vNveV16GlX/Qi17SRsRheT8qYjSXTdl/dWKRtkq+Tp4JzWrxAg/RrR6UYxDg020Aoog
	Rxw4cuA==
X-Google-Smtp-Source: AGHT+IGNYW5VacBNBnZbd14bsq5eq+YibUATRXo0FoLK5s00A442U40Oj8rE+WhlaqZ+zAH+mCd7AEzQiBxN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a25:c2c1:0:b0:e22:5bdf:39c1 with SMTP id
 3f1490d57ef6-e28fe45b504mr2879276.10.1728523302373; Wed, 09 Oct 2024 18:21:42
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:28 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 2/8] perf stat: Fix/add parameter names for print_metric
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

The print_metric parameter names were rearranged, fix and add comments
in the stat-shadow callers to ensure they are correct.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 55 ++++++++++++++++++++---------------
 tools/perf/util/stat.h        |  6 ++--
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3ce756b8ede5..1e6ba6bf244a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -195,17 +195,21 @@ static void print_ratio(struct perf_stat_config *config,
 			const struct evsel *evsel, int aggr_idx,
 			double numerator, struct perf_stat_output_ctx *out,
 			enum stat_type denominator_type,
-			const double color_ratios[3], const char *unit)
+			const double color_ratios[3], const char *_unit)
 {
 	double denominator = find_stat(evsel, aggr_idx, denominator_type);
+	double ratio = 0;
+	const char *color = NULL;
+	const char *fmt = NULL;
+	const char *unit = NULL;
 
 	if (numerator && denominator) {
-		double ratio = numerator / denominator * 100.0;
-		const char *color = get_ratio_color(color_ratios, ratio);
-
-		out->print_metric(config, out->ctx, color, "%7.2f%%", unit, ratio);
-	} else
-		out->print_metric(config, out->ctx, NULL, NULL, unit, 0);
+		ratio = numerator / denominator * 100.0;
+		color = get_ratio_color(color_ratios, ratio);
+		fmt = "%7.2f%%";
+		unit = _unit;
+	}
+	out->print_metric(config, out->ctx, color, fmt, unit, ratio);
 }
 
 static void print_stalled_cycles_front(struct perf_stat_config *config,
@@ -319,14 +323,15 @@ static void print_instructions(struct perf_stat_config *config,
 				find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_BACK));
 
 	if (cycles) {
-		print_metric(config, ctxp, NULL, "%7.2f ", "insn per cycle",
-			instructions / cycles);
-	} else
-		print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
+		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "insn per cycle",
+			     instructions / cycles);
+	} else {
+		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "insn per cycle", 0);
+	}
 
 	if (max_stalled && instructions) {
 		out->new_line(config, ctxp);
-		print_metric(config, ctxp, NULL, "%7.2f ", "stalled cycles per insn",
+		print_metric(config, ctxp, /*color=*/NULL, "%7.2f ", "stalled cycles per insn",
 			max_stalled / instructions);
 	}
 }
@@ -341,9 +346,10 @@ static void print_cycles(struct perf_stat_config *config,
 	if (cycles && nsecs) {
 		double ratio = cycles / nsecs;
 
-		out->print_metric(config, out->ctx, NULL, "%8.3f", "GHz", ratio);
-	} else
-		out->print_metric(config, out->ctx, NULL, NULL, "GHz", 0);
+		out->print_metric(config, out->ctx, /*color=*/NULL, "%8.3f", "GHz", ratio);
+	} else {
+		out->print_metric(config, out->ctx, /*color=*/NULL, /*fmt=*/NULL, "GHz", 0);
+	}
 }
 
 static void print_nsecs(struct perf_stat_config *config,
@@ -356,10 +362,11 @@ static void print_nsecs(struct perf_stat_config *config,
 	double wall_time = avg_stats(&walltime_nsecs_stats);
 
 	if (wall_time) {
-		print_metric(config, ctxp, NULL, "%8.3f", "CPUs utilized",
+		print_metric(config, ctxp, /*color=*/NULL, "%8.3f", "CPUs utilized",
 			nsecs / (wall_time * evsel->scale));
-	} else
-		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
+	} else {
+		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, "CPUs utilized", 0);
+	}
 }
 
 static int prepare_metric(const struct metric_expr *mexp,
@@ -532,12 +539,12 @@ static void generic_metric(struct perf_stat_config *config,
 					ratio);
 			}
 		} else {
-			print_metric(config, ctxp, color, /*unit=*/NULL,
+			print_metric(config, ctxp, color, /*fmt=*/NULL,
 				     out->force_header ?
 				     (metric_name ?: evsel->name) : "", 0);
 		}
 	} else {
-		print_metric(config, ctxp, color, /*unit=*/NULL,
+		print_metric(config, ctxp, color, /*fmt=*/NULL,
 			     out->force_header ?
 			     (metric_name ?: evsel->name) : "", 0);
 	}
@@ -708,9 +715,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 				if (unit != ' ')
 					snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
-				print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
-			} else
+				print_metric(config, ctxp, /*color=*/NULL, "%8.3f",
+					     unit_buf, ratio);
+			} else {
 				num = 0;
+			}
 		}
 	}
 
@@ -718,7 +727,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 						  &num, NULL, out, metric_events);
 
 	if (num == 0)
-		print_metric(config, ctxp, NULL, NULL, NULL, 0);
+		print_metric(config, ctxp, /*color=*/NULL, /*fmt=*/NULL, /*unit=*/NULL, 0);
 }
 
 /**
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index fd7a187551bd..a5f3d7d00101 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -155,8 +155,10 @@ extern struct stats walltime_nsecs_stats;
 extern struct rusage_stats ru_stats;
 
 typedef void (*print_metric_t)(struct perf_stat_config *config,
-			       void *ctx, const char *color, const char *unit,
-			       const char *fmt, double val);
+			       void *ctx, const char *color,
+			       const char *fmt,
+			       const char *unit,
+			       double val);
 typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
 
 /* Used to print the display name of the Default metricgroup for now. */
-- 
2.47.0.rc1.288.g06298d1525-goog

