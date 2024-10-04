Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52B15572E
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085290; cv=none; b=LBjrMpxfom5jb1D/5hvCZiTZKC9AGd2GDdJbn0Rp137yCgTVNsZTldJq2f84DhjqNnTKAi/KGFES2g2yovnwwKmKDvnTq/b4CHAQ/JQmq4c9oTjcx3TXoCtIL/AqaGj9FD4EKEztZhclLiDP79YtsFTCnXdDWC20mQ4eT20877E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085290; c=relaxed/simple;
	bh=LvLeqWxdA2TeKOaDt4auOtFHYmifqW5hHzjxgLb+wnk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fvLVFLGcaLmA+YL4yUJW2VY8bMOxRwVtS4GZfJ1ojFo/s/avAUzQ8dKDQb+NzFyWoul2VQInBqcBBEKgcdKXPlayfbwf9S9cw/hB1dIv0X5Yi0ZpE+yqCWODBNUVsg0E348jqs4wMVkoyBZM9qnWKc5dBFI/DzotOi5MNC+sks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8cCcljZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8cCcljZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e26ba37314so41994697b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085288; x=1728690088; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6CcUNAGP79XtjWuaAPJ4OrijNFqcGuc6YFaoXPXPNs=;
        b=D8cCcljZtKRLLHmas+tud6Ndo+kDepmj+wMKt05ZgcUA2BLD/R5ks/Y5tHkplX9sEU
         viIJ4X/KNCnNe0/c5b3oFbe0RwAL/k5AOZjg82uuKFOM+8l8Jl1EE7GBeLBWeawViqV7
         R/YQWPIiiGAQ5nCaF6iXLO/fjSyJt3T35fO9ybrGooFtMK2Ew/J1DzcK+IlZMzjSfQxG
         z4F/nyczaaFkhStKgs3Wcy/ForEKv2NObqbygXqRthxnbUelXWBSuFOaoPz2UpR1iFWf
         MiyKuWbe4+yf28PB/3Ep2DY7Aq9anVzXSJ5l5Rz0stkyVDNIwyxUuJOp/6pk7/HiVkjT
         6wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085288; x=1728690088;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6CcUNAGP79XtjWuaAPJ4OrijNFqcGuc6YFaoXPXPNs=;
        b=IpRf/4d02SFIJ1fc/LXFVsrKSs8heZLNkyPwIDmHehx4/NE+mnWjJfVukGfDD5ASPN
         C31B+9bxxUE2QVs8enZZvin+MXbFrU2YZR3O3LUIhhz6awe/AeGP/5HZcVQHKSyEC0Yo
         XPJMykig/3zJ/ImKCbS9i+b2lRv0+rGTw/d3K0JodlJyAEma2BHFD5MpYZyqf68egJJJ
         K5tP5vVtu6mTjhm7x/EDSs2+y8OzmsMTMkzuoQsnhj0v4We1CtzAXf6qkPNclStkn7d4
         aOqvEOFn/S2iiQ6NwIRAQqHedOfyrXVvwbhOU4VFKZ+nFV4SInOmB4dwO9Awiz7SDBuh
         Bx6g==
X-Forwarded-Encrypted: i=1; AJvYcCWHsHTiGHnvPYwcYzsbymodzoSdbZwX8J3xJRvzAbYtUwTbhDuTGfjKRUEdUC0nrNCxGLHgT1WFFFb8IalevX2G@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJiaxmgGS5pm70Ei90AB9aA95aOKJObRJzYt/RDkgrcib5fWa
	2SYUF8JLd3Bovh0cjIfE0NaQCaqZXK8Fpy1rf2O1IaxdFZ/fo4HruY0Xvp9I9JIBwHmcmSs+Xvj
	dMz8FgA==
X-Google-Smtp-Source: AGHT+IFqw6htDoHPrP52f8AD6FsGc60YnuQl8LA6+s9ft64QucdGHglRTtYEDtHIDvGu9pa6YkRbuCsaTeHC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a05:690c:6686:b0:6db:da20:fa12 with SMTP
 id 00721157ae682-6e2c6e90bb5mr215817b3.0.1728085287901; Fri, 04 Oct 2024
 16:41:27 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:14 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 2/8] perf stat: Fix/add parameter names for print_metric
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
2.47.0.rc0.187.ge670bccf7e-goog

