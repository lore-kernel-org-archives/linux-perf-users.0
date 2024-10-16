Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E1212F13
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101239; cv=none; b=CkdebGJ3kuiS+C4HWOyXGjy95uTjxNtceMHVWf3fJQB8c5GUBg5mrjwc5G5r/veTR0rogv5cusSGeXruqLA9tAW4pmuSyZM+B/jwQ5mr+6QCmO6zRLPResF/9t2sBQYsFNLC9zNT5HWJY5qJl2JZ7RBG3s6Ju+JOHBNSrRjeQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101239; c=relaxed/simple;
	bh=hIfcHkHzDrh7Kl0V0epeaWp/DUbuxIY5GC52UGsnaoo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Kv3LhL80tLZFT+1t2xJp+R+bIpOdeHVS9i+pBf7dCEFVNi972m8QPgvaAQhFemTILoXc+JxTFWXqeyX48B6NcKtUqxaysMB6TQ/rltu04SFf3P8WFunPUO6BLaqQUVoLzlgc4uPCRU8w6eLcAtu5LuKO4I+wsJZvKym38fBqxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zwXe7FCQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zwXe7FCQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so1376337b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101235; x=1729706035; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkjT0g4MiHoVVvClTypMTgAC9u7lo6APGb+q2prEWZ0=;
        b=zwXe7FCQhPwOTA56IGILK3xgFFG7YQEK6DFVV7i1g85Vc8XcTMVrBoFnTq/b0exTV4
         1gygAzBXy7hW12WdX2rDtcAXCVOMbH8m07sPD7PegJxQsNqZqSdQ15E4hJRHDn+P+EsT
         y4oM+c9OyyYAv4TWIqWWox32yNtuWAMVIxkM1s1zmr/h/HToBr60SJSvBDO/M7m0ODPE
         EzhaiF2upcvndqOpx8TOQX4TMGrPAUR0jTZKLUI2ve+Lp9UHt2Ts1VUs1f9N1AGC/jUg
         QiTjo553UpmQI3Qj8FnPnPGZncRJnRTpNSek8grMrJfOltq2hn/VdVOy1MhGxA1/0Obf
         NxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101235; x=1729706035;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkjT0g4MiHoVVvClTypMTgAC9u7lo6APGb+q2prEWZ0=;
        b=jAJ9gyHstt2XNeK3MxolRDvRWPbRcdorDMjmabn9GjH9v0rXXgtKu9VQoNyEokJW7b
         W05d0HSQOXz6E60qphWud47pFxqcLzbZ5f6dxGFCwkgvDeEEs/N5gu+FWc29NBD1eG3v
         Dcrp6f0lE6kxNiQn6KN9OhaOyfGbfMzqAzWsQEauI72x/gUne5pV2gvIER+ekbXn/Tpf
         3g7LV6iJbJ58QJz1Dyj36m8T2sypzvfvtlvU+xWG8DYSzkhdJ2YYOsHm2XfMEvE42Pwa
         XXq56I9QqC5/VT/ZYIITFxLVD4lK0HsebDTw6W80Irq57xuo2TfiWHJ55c7ZZoExO0/V
         I80Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzpKzkQW3KT4DA+6W56SlQJ+7moRUZxWlSZVhfQlh3ik3moZk7JhpjyloJhzjgoPlfn7lNEVdVKly4yzbJe8c0@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhiiWfL5uu440t/D0qDVGm7aRwaOlVfhdLo8vSZPaLgy/8wnL
	s8vaKiLdXizB7yimkFmaQUKkcZCfXYPeDuyYRyy5an4tJ/rlEoIpXNS8jl5o7vfyBOkgQ48buF5
	xfF8zsw==
X-Google-Smtp-Source: AGHT+IHghdnDabAVtg4aQluzkItxsQJIbOBN1RLFr1KgdtLOjqOCkNjfC6nVzxxiGf+wQIsF2t40LHHATwkW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:480b:b0:6e3:ad3:1f19 with SMTP id
 00721157ae682-6e5a3d7052cmr29347b3.3.1729101235651; Wed, 16 Oct 2024 10:53:55
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:43 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 1/8] perf color: Add printf format checking and resolve issues
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
2.47.0.105.g07ac214952-goog

