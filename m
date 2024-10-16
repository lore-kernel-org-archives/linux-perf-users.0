Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785871D363A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115520; cv=none; b=TBDotChzEfXRCSSD2quUuFxOnQ8jIbRh/IAbAE3bsFz5Qij/AFFJ8xUBCou/Smpx/+DiBTK6vDC/cBtEitGOTRUHFQJ8dcT+exR5LxEDgUY5bu81RIvoiMHuHVaSOLM/tdRYvi3vRHzkj4yqARp41xsNxdVYncUKHCoW+XEfGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115520; c=relaxed/simple;
	bh=WUodcAb4TVW2yeFy1LDOu4j2dnFFiTlcHPQcWZN06qw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=or74ZYNLgy1x2ESNx4+7thNHccFXJaRbRUsil0s0y5FjOLYJ8EOAXdhUm+zFCqSaYQOE/dcQji7GDRqpvkZf1SSe34ByKfVXoYQTpUPPfiwyjMHUV5Z7XWKc5MHRkKKhvOJh9pGUMdCingqbt4PagiKv4PybpvwpS2HoiCQStkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECO/QGd0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECO/QGd0"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e376aa4586so9574947b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115517; x=1729720317; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvCFzl8c1PGWsh4EV+hkwTVYrXNfM9i5AC+z8XoTGw0=;
        b=ECO/QGd0zbpWI8Cu296VyStTzTD7kpLFDePAAhqIGOZ38K01HJRzWpz6K6hubdx0rG
         nAdZTiQujiDxlDHzFT9TjfvLe2vn3UJwgSVJypAgTMIQuxU97Kk77z7zhCFPgxhtGooC
         j7pZtBC5YO43w6XzM/KMVPrE3qDM3v4S7g6/sghPi2FKn9PAw9Fp53mXOBj+Pu+K7elM
         DdMuSRwrHfV4+0m+38E8gUYx1tRYxTGtShpyBGafCiY0qddLhDyiBvEevXhwX41pGQLX
         WrnOp3gpqGvgchZzYT4LsJVuRFwCA/Mfd6I1TAKpjuLm4tO8NWlbEPweihw/Wk+selup
         Sz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115517; x=1729720317;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvCFzl8c1PGWsh4EV+hkwTVYrXNfM9i5AC+z8XoTGw0=;
        b=CxguCjuHegKKKj0vl/tLJRctjG8IqCiwxLkFyrNe97cOd8PWR67GKiJy9UYKphY5i0
         PlMLmTX2wP7ELnPVsWbYg5rLCuQtLcHfwy+OKZiO+9PpevZafb3cePlNiwQW2gll4YlJ
         sfdH2+uV4wfx2dL1CqxxcdvWuMuY0q4R3Bg11KcwBBLDm18CADy0EzfqFiCnHjbIxM0a
         Rat+1AEO3VYCKbU/+vvnU7+4yBtARS03jUtco+ue6ryUuZZTjRUKv2g5G71WbfU+fSKa
         t+WpuSpT2OnM9/5Jzk0oMiBpmwe8elzQns60E6aA5qs30K49FLaCEz3+22HRhoXCwuBJ
         wMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXmJSA++8lNbgOYDS/bpecidtJUt6f4yats283g3Jz/nyKdyiCDaCeTHp1J26UUoM1yzfySn8QJBdXgePsYJzw7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yrvJn/xBJl1AoO5nM7ccE9EqUdMlLP1j87U2TjaqkncMqk+W
	bE2vCuRBmi0z/GR/p1nQ89INtdFSdRoRXp7nCWypMDvyQKKsFaK37pclzB/T3gxUZ6UMb51NWEe
	omF9WmA==
X-Google-Smtp-Source: AGHT+IF+KF71BkYq4wOBn0ecxwWR7LcsJubPFlGD1z2qvk5vl0Vi4Ey1q4uQj5of/dkOlYE8ndNhvSV0pSsr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6781:b0:6e3:b08:92cb with SMTP id
 00721157ae682-6e3d3bec4bemr1502517b3.0.1729115517488; Wed, 16 Oct 2024
 14:51:57 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:33 -0700
In-Reply-To: <20241016215139.212939-1-irogers@google.com>
Message-Id: <20241016215139.212939-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016215139.212939-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 2/7] perf stat: Fix/add parameter names for print_metric
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

