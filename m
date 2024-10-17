Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90B1DFD8A
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187648; cv=none; b=gBBabCMEBT97NtsGqXuyOQJsKZ0rklkWCswG1sybc2WsQ86eT26g62V3CBcmT4PgCiLSfOTB1gbNmbmsEqQxtB0vYv5pt1XsDe4/ThfjhuGN/rvwPG3RqyH+aJ1ei+P6UIyCenltf3vljj+evURmMFbppjALgTyUIFJuhMf0Aus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187648; c=relaxed/simple;
	bh=WUodcAb4TVW2yeFy1LDOu4j2dnFFiTlcHPQcWZN06qw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X9jF+gbiiI/gH/rOUJ0JfhLUHAPoKAQHE3tBORCWGw4rURlrRDFsoZU898ETXa3KibfM/y7ULjG9YuRxkVK8Pn+cr+q0uhcQkn9fSqlx9ksEp019n/vYHY9MzcvQPm/Nj7lzMu9O3iPWaAmqBrTqc3dqoLLDMX0aO7NLGqs+A8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pth671ox; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pth671ox"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so14637447b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187646; x=1729792446; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvCFzl8c1PGWsh4EV+hkwTVYrXNfM9i5AC+z8XoTGw0=;
        b=Pth671oxxtcIlNon0+FEUMyhymRyo2nEh/6RaSJa28IIb2FECju+8tcV8kH5Ygpbj+
         0fOLF+zX7ulmy/safBqzNN5c6llSesiNpsb0ezURFyrtIjNOwARHIjITkYokAByQixhi
         VF5SbRiFcp+lLNBAQOxKqZbK6Y1M7G1salw/u8192C6NYYKMespaC7rHHwgPbp666QQV
         +8yS67Kw6vmmBbLhaMrAaB/QFZ4yfWK9K/QlpJ/0ig8A/g2InLpDgXzBXsGoeNxLkDHA
         iwwgZUqExdoPMkcDPceqKcT0UxhLlP7bmd5uNZezQ5SfYPbpSPeEI2LW2JsAyZXVwgqT
         Uwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187646; x=1729792446;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvCFzl8c1PGWsh4EV+hkwTVYrXNfM9i5AC+z8XoTGw0=;
        b=RcFyfPZ5YMkJgE4Yo20WZPEj7WpQqriyU+yWpae+yl7XwbpVEoURHiTYzl3foMm2KI
         5Bvzhry4Mn9N/4Q3oM4Xjua//lI2W0GeauSmhAyijIiVkz5yd8uRz+NroHtZIA/A9CeD
         5V0xsr3+j8NWX3tNWbXrvqM1eSF38RIxg3ij4ITan/3ly2bV2OK9pZes+7ILIBKF271a
         eUH5DLDqTqV+JAbLfYrcamY1CNcAmTN3WF7zbf8StnqfBZxU734Ejk5hvqKjYCNLsTt/
         GI3w0as+lWSBzJo1mWWhEOF4/VhIMbDsdXqgepjt8A3z92Zsz9rN4GDfL7OfdwHuZrFu
         BgcA==
X-Forwarded-Encrypted: i=1; AJvYcCWhakcg3K3VFKdBNd8OkIqU/SS/dil3CU+NbnCknwVawsoNk1DdOPCSEabnbipgFgE5Et+sumkoZYldWR6eEmt4@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMmTCfpm/gCmYU/7eRQ1BG5Nl4mnnwz80/4KlAgikGRyR2mjK
	SOKfE93dW7ZgQbJ+g8343gSelpX1MHvJGRmpGQEP9IREinPGuTxckWQfBqaLtYYXOVfVcPSoItW
	PFCdA2A==
X-Google-Smtp-Source: AGHT+IFlmA1tf2B1a5er6bTub7GvcxLouK/2eBonblCcnbTWMLGRQp2J49vwfdT3KnR075GkZWCQGOMeiBp8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:670a:b0:6db:e464:addc with SMTP
 id 00721157ae682-6e5a3d922c2mr1475937b3.4.1729187646038; Thu, 17 Oct 2024
 10:54:06 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:51 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 2/7] perf stat: Fix/add parameter names for print_metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
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
index 6227de848083..512890d50b69 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -196,17 +196,21 @@ static void print_ratio(struct perf_stat_config *config,
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
@@ -320,14 +324,15 @@ static void print_instructions(struct perf_stat_config *config,
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
@@ -342,9 +347,10 @@ static void print_cycles(struct perf_stat_config *config,
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
@@ -357,10 +363,11 @@ static void print_nsecs(struct perf_stat_config *config,
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
@@ -542,12 +549,12 @@ static void generic_metric(struct perf_stat_config *config,
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
@@ -718,9 +725,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
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
 
@@ -728,7 +737,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
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
2.47.0.105.g07ac214952-goog

