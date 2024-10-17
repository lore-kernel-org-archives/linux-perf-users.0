Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BEB1DFDB4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187646; cv=none; b=YUZcuM+yDZFWG3KraiuDC7xZKlip48X11Qq2xReHkl3hRNKEwdXvsqvmnALzCPAB0/PSJujm62f7g3Dhal610d9PgFjkaRQ+jppx9jYLf12mfXa/UgxaiDM82B8JS/OEf9K+cw3E0zEFcuOdVj7mH7EZEMFr8oGO6+wQkKohP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187646; c=relaxed/simple;
	bh=JHZeSmkWIrj8EFARpnwwv3ZxZXRwxkO0vkOgH6dtkac=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H8hcaJswy+9mFQA2j17Z0YAT0/Bu7dk204VbALT6o/ayL6eyhLwzBkoV0NxoHAltUlNOAXDGMAtJv6RAtjORRAZilnxl2VSqwgm8VxFb7UGGEV/rWQMAaaznOHbTZbc4DPKTarrdrgQ55zormnx27KxbaGFCdCochoqMgbhcvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoIlyL0t; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoIlyL0t"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so18556447b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187644; x=1729792444; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2gIFyt42nntsnGaIcEwttdqpxaZNfusYx2zy+lIpHc=;
        b=QoIlyL0tBLLfEwdePreiKV/41rOpxPdkWGVW3dbfC40Oont4rjxMm6zeu5bDMmvrdp
         W+ADQknoDgpRzKdzbtu7F3OBOSB9JOg9oQnpoR4B5vxOL8t0g6rTbd8v9UOj1aRvPNfk
         2ZqGNe9hjVS9ADnv30Yz+cJeQRdyDhKh4by/pc25eQyP9cAM7shPohV74mSpCcSRPqZG
         hQ5Z2dvIIfumsqw1n+2uOi7ya3XSNdpTyZkO5y4dRvhc6Ia3sFDYqhD5sO/Qp8vIYdto
         99+7/NBERu8IZTvCCq6VGYwHWh+XTqGwCPHuMN0SkCQBJJ3vver4KSXQqlYOE4yw1WuN
         AhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187644; x=1729792444;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2gIFyt42nntsnGaIcEwttdqpxaZNfusYx2zy+lIpHc=;
        b=p2BYm+9BQUpd3/mcr/Km2aYBslPs4AxoJkoeikpoiac5DKp+BgSIL4+KRBUzzPYhwC
         P6Qnuj1xZVozBkRMqjrRVYpEJW8C3kywrTek+tUzWAvk6uv430zM+75I6iUBu+QtDKYo
         XidDXjGJ4VGHQwlED/5qnYh8F8/9WM7/Q4MblUmad3/C+DDc/ptH67b0Sr0XefDIR/b0
         1wha1x7De/4m+L8cbIKvHS1rzQ/58fBz254xBCsnibQYzUurz4wJ/EwKmYjuWmmRPpLc
         9HCpHUjcAUh8b6t/BzhjX7B6nF6fHdJ4u44ow186n6UmuK1qUFpkSQ4lPzffRfoxGlMR
         l0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWkS6YGHza/RSRr+w/yyODcgrYYskzfKkr/L3m0HCh7p2DzaOOgM3oKC0jJK4/pMSVCLuRVuiIW8ZxGPF8N3y8O@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9lMFeIcTvkX4hCBeC2hO4cOPSjtEO39bFBecqiQPFPP7ASbn
	3ca3I+baJW+G8j33tzJ5woVKFPLP5fpQRaUBfMjLKzAuRpM8VGLBsvPPdHjhcPWovOefXWx65wG
	EAn4cBQ==
X-Google-Smtp-Source: AGHT+IFOb7Ly95ignRrZpM2eJffAbLiYBD5BXqW5NZZKWGFTAymVVA4fkRvwEwltD1JaiD5Sx3sRyDuUmgkk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:d8b:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6e3d41e6b49mr1223917b3.7.1729187643820; Thu, 17 Oct 2024
 10:54:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:50 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 1/7] perf color: Add printf format checking and resolve issues
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
 tools/perf/util/s390-sample-raw.c | 8 ++++----
 8 files changed, 15 insertions(+), 14 deletions(-)

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
index aecf56dae73f..b2f37de305f6 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_COLOR_H
 #define __PERF_COLOR_H
 
+#include <linux/compiler.h>
 #include <stdio.h>
 #include <stdarg.h>
 
@@ -37,11 +38,11 @@ int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 int color_vsnprintf(char *bf, size_t size, const char *color,
 		    const char *fmt, va_list args);
 int color_vfprintf(FILE *fp, const char *color, const char *fmt, va_list args);
-int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
-int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...);
+int color_fprintf(FILE *fp, const char *color, const char *fmt, ...) __printf(3, 4);
+int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...) __printf(4, 5);
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
index 53383e97ec9d..335217bb532b 100644
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
+				      "\tCounter:%03zd %s Value:%#018"PRIx64"\n", i,
 				      ev_name ?: "<unknown>", be64_to_cpu(*p));
 			free(ev_name);
 		}
@@ -260,7 +260,7 @@ static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
 
 		ev_name = get_counter_name(evsel->core.attr.config,
 					   pai_data.event_nr, evsel->pmu);
-		color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#018lx\n",
+		color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#018"PRIx64"\n",
 			      pai_data.event_nr, ev_name ?: "<unknown>",
 			      pai_data.event_val);
 		free(ev_name);
-- 
2.47.0.105.g07ac214952-goog

