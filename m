Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506392BAE5
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523304; cv=none; b=kRBKeBs7xCnRN9Q3+9+80PDGzmhT2AoP3JkrpA3lSCjfme9Aa4ZRZc71F9CIsJAyeaX6sXV40FdmTu+a8KUX+D7om/Vbw86CX9i8tko6RVZ6CFCyejFUgp2j1RU8x/7tAdEbAu3+A81kYRUB4flK4t1ey6MOjJnYGI9RA42Nbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523304; c=relaxed/simple;
	bh=3lKt0oaqmDsW092qxJwDO5cQ+pCz5Lb/SsuDsjRIV98=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iOYciIFQvvBOyKx4T/FKUmcYexh4hG2mdIXLF0rSPOHNyoHazAG60PGi8kHbDYbFrM4p+FeAny49rG1EeFWrBhqyhtTEVeryGYGvw8+uUn3viXMJpo2082JsFsHru0JkCc1PiYJTWu3ooUuFFOdlxT2wSvwOgBkRXKrFJ3qK9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0epW9VXx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0epW9VXx"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32b43e053so6990417b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523300; x=1729128100; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmTMc5jqBFJBcDF3mkh+k4RYYzumHew93r4OVEgMB6I=;
        b=0epW9VXxx4ftAm0bCxzmqIhndStQBhZHYzea2ZtM/ObEOyfz5yD951br5RdfH5riLn
         pUDhxiu5UJF6r84be6pbVT9YNxxZpF/Hl0WDy2HHRzFwcrGhcfhu5bEqFp82lai4or8p
         s0IsVdcuzcN05xr0TjcNYImFwBQcq6aFdMfq0Xw0qW/5WUkxax8RylGhys+PtSdsPASZ
         3nfZaBqojNC8QFWWYH/gY8KOQ6WkpB/lT9Uv9jQCuO7Nfi7PLeAaucjAx5091dGUFSKc
         TTjjrrpPMymGSxFUI7y1xme3/5fXhPFRgR+N9aMRLoTc08FEZ+bUNkOggHMEZzNb1JYb
         X3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523300; x=1729128100;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmTMc5jqBFJBcDF3mkh+k4RYYzumHew93r4OVEgMB6I=;
        b=RUJjrb9lRPAvN5wPWp4x3jR33wnzGVGP1HADt0LQZM0uBIRf/1CmvlNnJieDXiREGa
         r4osd4irCJJXVygEX3GMqk4ke1L3V605GLzG37l9dSd3iMF8iLNGZtxKw0opxHRwkEjP
         taCcTQNlF8pyx1q8vcEzDy+VWL7Zidil/s4iS9tW92gpIRuA/VWoG9Y9qizUGcih8Vjt
         vkecTR1yN02tmD3C6AO7EPUpT8c3+ckSshHZh6XmH0WDoHj6xYb1bnnrNR7Mev2J+lCw
         oFbMFx7cC+NTmOwden9UEc4+SQuN6quUIFD/Hu/9ths8iEt8hSS82RTQrZa4IbargwE9
         qr8A==
X-Forwarded-Encrypted: i=1; AJvYcCUV9Y9Ryk6Z4N2y4d7nLXcHUgCW9StqWuRcz5QOg+mW9BhbrQOXCHKZrNZhQJzKlUEhLKO/5ve8gJhatTGLxKcX@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgCCnz0QV3he4+nBpSJeTnLOxyRG68QFS4/LOMyUVVFv702G6
	GR7Y3FTRJ4HGkj7+BfmpA3/Xdm4/q7ANyZyiUQJAI4dWOOHPHVjslIcOYG87Yx+HdaZPmXoQP5f
	ogkyuiQ==
X-Google-Smtp-Source: AGHT+IH2tGryGXwcR6Gfyf6O77ntcn+H4rPnIjlJQ3zIGUfcBK6k9krmihZyezLVDnLlFHg3Nxr8kFMzhCyA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a81:b511:0:b0:62c:ea0b:a447 with SMTP id
 00721157ae682-6e3221791fdmr512367b3.2.1728523300267; Wed, 09 Oct 2024
 18:21:40 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:27 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 1/8] perf color: Add printf format checking and resolve issues
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
index 0b30297b4ecb..748b061f8678 100644
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
index 13fd2c8afebd..fd0d793ecad8 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -122,7 +122,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
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
2.47.0.rc1.288.g06298d1525-goog

