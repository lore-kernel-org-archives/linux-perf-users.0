Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310A1547FF
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085288; cv=none; b=RGbTJTAE/dAv9uNQWdX7SpDrQLGGGdk4cLBaJ7kN+U98ATOEheFBNj0YNtowBF7SHHRaa9PbArdhrPdSn+VVDxEF4WO2WPC7/wQoV53/HAOibn6jSLrTpjIKnCgPSIIIjK3YTz6iGpaKipqh5zbsOgClXRh/+qSNKXa2OVj+WRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085288; c=relaxed/simple;
	bh=7YzPNdfRKmQE5AyBfLbiel6HIbKbkuhCRQOwkDiYmMs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=S5LQrfIPmGezg5MMbrA7npeNk9RcSxlpbmSfMSk0h1YVJCrTb0MWKR6qod9bHxcpvcSZKTjfSydhvCkbif/U9yt5Kyh3+Y2bgG9msp3QNlFx2PKPc5Ld1BnFsD8ixj9slEgAqroJCmDpCfNqwYJWsqzluoS6P7Cml+E0m+QUhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZY1j/ot; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZY1j/ot"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so3991086276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085286; x=1728690086; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQkv9fq9wprz1BlFu3d+/+F0yxiSVkXzoaXCWnFh2GM=;
        b=1ZY1j/othi3Vs86Fmq0id5DA7kwh+ExOXu5og8Z35iFiSsm/gaSY2bDXv4nZjgQGZq
         AyTv5SfsYY+Xd8GryVV0fgcZKgeTMd76PQl2JLeNe/meYt+E9QOLvpx47+Lmk08G6zEl
         lzIVsYV0Jk02RYogEfuHaPFwYA8jBNHy9G8mxbYcTjwqnNikU7cnG7l/mOfNW4nlAZzv
         trnO+yBUj29A6S3QaUoF6REkmOLpFgPDh4FERXwczJX+SExWUP7GoiEJHKZ9fmzO4evQ
         i1TxbHrXhtjThjWZ9UhFV3sZm9C5FpOmCqS1t7xnYPbExry1vwJk4+sQ0fnvHwl/E2Mk
         fQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085286; x=1728690086;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQkv9fq9wprz1BlFu3d+/+F0yxiSVkXzoaXCWnFh2GM=;
        b=ImAbA0mFPD+CkZcIoLYLg35FzVJkRg3ElPBJSr3KEJgd+XC2lKrPqWrpeFvH2dImyL
         6kApem06R97wv5N9LvbB9OZcwGRRgFG8DBI5DFIYODb+F9Nb2v/fY4GszB9/BY5EHQY3
         SfDylpQtoYLTnMZGgtFcrGsoM7572yg0kl7K+W514TN/mB4m18wNlBZPrzsoyXjUy/ZK
         Ly5WwtwaIR0m9Mn0+VIUesGEzxCCyykWkMmA2sYVcKprQ9RHe3RlWkvkaQ8gRL+qJQCi
         TMaXjgqu+626n1yrQDsk+YV4fB7Y2zh4PuIrQDQfxKbmyhsej8v1dBls7JaxP6UQtfcr
         yXjw==
X-Forwarded-Encrypted: i=1; AJvYcCX5FXsm8D+SkaOiSh2RFn2KHMBsSt4XLwTD9u7q0fpHOuFWLQrQT8BfaYK99dg9akBKz2R0QAYFYApIVLiV6OKL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tZ2IyLmlt9GxY0JN5p7Q/uKmvFQdRnjVj2vIwcaJk/ClSgdk
	yoX6JaGmFGoMFUB3c9sz76n9w8C9F60/iyfDE18W4MA38XBRFoJCIoXi7e3Iia3A8KeIxONhOai
	NILCUIA==
X-Google-Smtp-Source: AGHT+IGlEKle8bj4uC7Fk9+NrqsNKgHk2R6etU8mknZVSWapNMofmaSq9gzdVRDfZrk08YvvCqAearFgxaDA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:aa72:0:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e289395e704mr8524276.11.1728085285646; Fri, 04 Oct 2024 16:41:25
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:13 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 1/8] perf color: Add printf format checking and resolve issues
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

Add printf format checking to vararg printf routines in
color.h. Resolve build errors/bugs that are found through this
checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c        | 2 +-
 tools/perf/builtin-trace.c        | 2 +-
 tools/perf/util/arm-spe.c         | 2 +-
 tools/perf/util/color.h           | 9 +++++----
 tools/perf/util/intel-bts.c       | 2 +-
 tools/perf/util/intel-pt.c        | 2 +-
 tools/perf/util/s390-cpumsf.c     | 2 +-
 tools/perf/util/s390-sample-raw.c | 6 +++---
 8 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index fdf979aaf275..99bfc3ad71e2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1739,7 +1739,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	}
 
 	if (sched->map.comp && new_cpu)
-		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
+		color_fprintf(stdout, color, " (CPU %d)", this_cpu.cpu);
 
 	if (proceed != 1) {
 		color_fprintf(stdout, color, "\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f6e847529073..c16023bc5553 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1873,7 +1873,7 @@ static int trace__process_event(struct trace *trace, struct machine *machine,
 	switch (event->header.type) {
 	case PERF_RECORD_LOST:
 		color_fprintf(trace->output, PERF_COLOR_RED,
-			      "LOST %" PRIu64 " events!\n", event->lost.lost);
+			      "LOST %" PRIu64 " events!\n", (u64)event->lost.lost);
 		ret = machine__process_lost_event(machine, event, sample);
 		break;
 	default:
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 138ffc71b32d..edd93450cafd 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -118,7 +118,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 		else
 			pkt_len = 1;
 		printf(".");
-		color_fprintf(stdout, color, "  %08x: ", pos);
+		color_fprintf(stdout, color, "  %08zx: ", pos);
 		for (i = 0; i < pkt_len; i++)
 			color_fprintf(stdout, color, " %02x", buf[i]);
 		for (; i < 16; i++)
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 01f7bed21c9b..72a4cf2a81a8 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_COLOR_H
 #define __PERF_COLOR_H
 
+#include <linux/compiler.h>
 #include <stdio.h>
 #include <stdarg.h>
 
@@ -37,12 +38,12 @@ int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 int color_vsnprintf(char *bf, size_t size, const char *color,
 		    const char *fmt, va_list args);
 int color_vfprintf(FILE *fp, const char *color, const char *fmt, va_list args);
-int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
-int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...);
+int color_fprintf(FILE *fp, const char *color, const char *fmt, ...) __printf(3, 4);
+int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...) __printf(4, 5);
 int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
 int value_color_snprintf(char *bf, size_t size, const char *fmt, double value);
-int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...);
-int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, ...);
+int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...) __printf(3, 4);
+int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, ...) __printf(3, 4);
 int percent_color_fprintf(FILE *fp, const char *fmt, double percent);
 const char *get_percent_color(double percent);
 
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 27d9b5c9fec8..3ea82d5e8d2e 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -100,7 +100,7 @@ static void intel_bts_dump(struct intel_bts *bts __maybe_unused,
 		else
 			sz = len;
 		printf(".");
-		color_fprintf(stdout, color, "  %08x: ", pos);
+		color_fprintf(stdout, color, "  %08zx: ", pos);
 		for (i = 0; i < sz; i++)
 			color_fprintf(stdout, color, " %02x", buf[i]);
 		for (; i < br_sz; i++)
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fd2597613f3d..3fe67bf652b6 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -249,7 +249,7 @@ static void intel_pt_dump(struct intel_pt *pt __maybe_unused,
 		else
 			pkt_len = 1;
 		printf(".");
-		color_fprintf(stdout, color, "  %08x: ", pos);
+		color_fprintf(stdout, color, "  %08zx: ", pos);
 		for (i = 0; i < pkt_len; i++)
 			color_fprintf(stdout, color, " %02x", buf[i]);
 		for (; i < 16; i++)
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 73846b73d0cf..30638653ad2d 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -345,7 +345,7 @@ static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
 	}
 	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
 		      " dsdes:%d Overflow:%lld Time:%#llx\n"
-		      "\t\tC:%d TOD:%#lx\n",
+		      "\t\tC:%d TOD:%#llx\n",
 		      pos,
 		      te->f ? 'F' : ' ',
 		      te->a ? 'A' : ' ',
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 53383e97ec9d..d07a94242905 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -98,12 +98,12 @@ static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
 	te.res2 = be32_to_cpu(tep->res2);
 
 	color_fprintf(stdout, color, "    [%#08zx] Trailer:%c%c%c%c%c"
-		      " Cfvn:%d Csvn:%d Speed:%d TOD:%#llx\n",
+		      " Cfvn:%d Csvn:%d Speed:%d TOD:%#lx\n",
 		      offset, te.clock_base ? 'T' : ' ',
 		      te.speed ? 'S' : ' ', te.mtda ? 'M' : ' ',
 		      te.caca ? 'C' : ' ', te.lcda ? 'L' : ' ',
 		      te.cfvn, te.csvn, te.cpu_speed, te.timestamp);
-	color_fprintf(stdout, color, "\t\t1:%lx 2:%lx 3:%lx TOD-Base:%#llx"
+	color_fprintf(stdout, color, "\t\t1:%lx 2:%lx 3:%lx TOD-Base:%#lx"
 		      " Type:%x\n\n",
 		      te.progusage1, te.progusage2, te.progusage3,
 		      te.tod_base, te.mach_type);
@@ -205,7 +205,7 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
 			char *ev_name = get_counter_name(ce.set, i, pmu);
 
 			color_fprintf(stdout, color,
-				      "\tCounter:%03d %s Value:%#018lx\n", i,
+				      "\tCounter:%03zd %s Value:%#018lx\n", i,
 				      ev_name ?: "<unknown>", be64_to_cpu(*p));
 			free(ev_name);
 		}
-- 
2.47.0.rc0.187.ge670bccf7e-goog

