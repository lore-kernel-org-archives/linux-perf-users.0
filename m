Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAD2673B0
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709444; cv=none; b=CbnAqeM3Ca99Ehsu3RB9zs4LE2CxBDCANF3WNZWnq8TRYxNpqB9408SLE/Pe+/rVfPphoXSI4wgERE6WP9PWUf+CrKhRUfKuvBwfuabRbfA5eTqHSRaHkOi7gJ63l71aBs07gi3eLTVgwEjUJO06d4ucKngOXfis69kENDFAvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709444; c=relaxed/simple;
	bh=Hb1LH8MWDKh/SBlCFGDKsTyfayTGu9osHdVeQkub7DA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TMxVk1/4z1/UR8TNbIDeEtrBr7vkweNaVRMrh0KHiQ3IdrjJfvY/W1o2F9XXx1V0GQPGEBk0D+AwKxTSa818ukLsKnvN6mN81/Arz29UnfZbaPAO2oXXm4XUqU664i5p3vg1SeyLEfltyLOtjlLZzPiL0DgaRbJcEXGnd0m9rMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NyQA+zko; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyQA+zko"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-3feb1dce9ceso421968b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743709440; x=1744314240; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBxUwTOgMQg7WWu2qDeWBrbygHx0f5AF8t2eYtXUGLw=;
        b=NyQA+zkoEaw1WjMYk/kx4GPmD5qDoN9sU1dLTudfg+r5A4eGhafUpwxb5RQRxOijmB
         40DuBpiXWi/AdgN0d7rYruIIL7n39vwsq+TcH0fQvvF2IuD1JISo4w2YXx/T2fNs258Z
         yx5SWOJE+P+3ThNeLH/UIsXmKz6umcmWiramYj0UwToaNCj/ajaC0rK/Dl58Gx/cbq3V
         sJbMC37SjicNLhoEXtpzVxf5mHctbAyidZCxRpYbdxsbAHZ6J+wUt11bJyTJpfmRxk+V
         vbHhyGnfwHDAuEp05SsUEiz9P+mpRShKM+liWsqqX3ZuPlmzZbEw+3oaSb6opgGJVbA5
         QHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709440; x=1744314240;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBxUwTOgMQg7WWu2qDeWBrbygHx0f5AF8t2eYtXUGLw=;
        b=rbTKIQHT7Jox8LLjma4nXeRMFPVBL1KgFM8dZ7s+N1pNWakzs9NSQey1SrQVYVv6Ii
         mRew4cZEUKfoRTv2epKNEo9GPHRfxfkRxyXp3XdsxJTeVzCwN9I7xGn817qtbBP2C+ku
         w7W0AoH57LzgMwlVVWTXjimAmOPunDHzRVdoamELuxcNQ8TI96hTELFL/yyeFQEE4Cj9
         XfnTj0nYZkk8HoX7nD97NooVtVZpJwtCvhC/9XeMlI/A7ISbtXKN3kbTSWx16xrb5hid
         6O+srEdd5fK7LJDU+zh6Bhhz7pYQA1vVRRhu8ZeE+JDvhbPzEzdGxxudnjjVHTTDk3Dh
         GJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKK/+abfBrBjd63nQnn7e09ZNlGRr2o21l3LRXjQa3l7V/JWxfK8O+ZpKAGMj7h0cJwqx56iyIjnjaOVYOY+mM@vger.kernel.org
X-Gm-Message-State: AOJu0YxrENEDyX1cImrfVCczz33aN+vUKjFB/nz359LkRIhbjnhjZi9/
	dRto5WjmyD/KJvyNv6f/JhIEctV+uoZcIelrk3sS0oeprNZjnafTOGCsSbt/9c24w4shebVAqCB
	U8Bgwag==
X-Google-Smtp-Source: AGHT+IGUJjNn+0SbWkVSjzPIxGq3rhm0m6MVrbcZaSE78IEupPzoHmRZEuq9Rf3qB5Am6SeFV807TECIhxOE
X-Received: from oabpb6.prod.google.com ([2002:a05:6870:1e86:b0:2b8:ed65:d4c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:4e0c:b0:29e:76d1:db3b
 with SMTP id 586e51a60fabf-2cc9e51de4cmr426200fac.5.1743709440581; Thu, 03
 Apr 2025 12:44:00 -0700 (PDT)
Date: Thu,  3 Apr 2025 12:43:37 -0700
In-Reply-To: <20250403194337.40202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403194337.40202-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403194337.40202-5-irogers@google.com>
Subject: [PATCH v6 4/4] perf parse-events: Add "cpu" term to set the CPU an
 event is recorded on
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The -C option allows the CPUs for a list of events to be specified but
its not possible to set the CPU for a single event. Add a term to
allow this. The term isn't a general CPU list due to ',' already being
a special character in event parsing instead multiple cpu= terms may
be provided and they will be merged/unioned together.

An example of mixing different types of events counted on different CPUs:
```
$ perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0            6,979,225      instructions/cpu=0/              #    0.89  insn per cycle
CPU4               75,138      cpu/l1d-misses/
CPU5            1,418,939      cpu/l1d-misses/
CPU8              797,553      cpu/inst_retired.any,cpu=8/
CPU0            7,845,302      cycles
CPU4            6,546,859      cycles
CPU5          185,915,438      cycles
CPU8            2,065,668      cycles

       0.112449242 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |  9 +++
 tools/perf/util/evsel_config.h         |  1 +
 tools/perf/util/parse-events.c         | 76 +++++++++++++++++++++-----
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/pmu.c                  |  3 +-
 6 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 8914f12d2b85..ce0735021473 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -289,6 +289,15 @@ Sums up the event counts for all hardware threads in a core, e.g.:
 
   perf stat -e cpu/event=0,umask=0x3,percore=1/
 
+cpu:
+
+Specifies the CPU to open the event upon. The value may be repeated to
+specify opening the event on multiple CPUs:
+
+
+  perf stat -e instructions/cpu=0,cpu=2/,cycles/cpu=1,cpu=2/ -a sleep 1
+  perf stat -e data_read/cpu=0/,data_write/cpu=1/ -a sleep 1
+
 
 EVENT GROUPS
 ------------
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index af52a1516d0b..94a1e9cf73d6 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -48,6 +48,7 @@ struct evsel_config_term {
 		u32	      aux_sample_size;
 		u64	      cfg_chg;
 		char	      *str;
+		int	      cpu;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 783177c5f140..0a57af03db5e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <sys/ioctl.h>
 #include <sys/param.h>
+#include "cpumap.h"
 #include "term.h"
 #include "env.h"
 #include "evlist.h"
@@ -179,6 +180,26 @@ static char *get_config_name(const struct parse_events_terms *head_terms)
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
 
+static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head_terms)
+{
+	struct parse_events_term *term;
+	struct perf_cpu_map *cpus = NULL;
+
+	if (!head_terms)
+		return NULL;
+
+	list_for_each_entry(term, &head_terms->terms, list) {
+		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
+			struct perf_cpu_map *cpu = perf_cpu_map__new_int(term->val.num);
+
+			perf_cpu_map__merge(&cpus, cpu);
+			perf_cpu_map__put(cpu);
+		}
+	}
+
+	return cpus;
+}
+
 /**
  * fix_raw - For each raw term see if there is an event (aka alias) in pmu that
  *           matches the raw's string value. If the string value matches an
@@ -442,11 +463,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
 	const char *metric_id = get_config_metric_id(parsed_terms);
+	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms);
+	int ret = 0;
 
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
-		int ret;
 
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
@@ -461,7 +483,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 						   perf_pmu__auto_merge_stats(pmu),
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 			if (ret)
-				return ret;
+				goto out_err;
 			continue;
 		}
 
@@ -481,21 +503,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		if (parsed_terms) {
 			if (config_attr(&attr, parsed_terms, parse_state->error,
-					config_term_common))
-				return -EINVAL;
-
-			if (get_config_terms(parsed_terms, &config_terms))
-				return -ENOMEM;
+					config_term_common)) {
+				ret = -EINVAL;
+				goto out_err;
+			}
+			if (get_config_terms(parsed_terms, &config_terms)) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
 		}
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
 				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-				/*cpu_list=*/NULL,
-				/*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
-			return -ENOMEM;
+				cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
+			ret = -ENOMEM;
 
 		free_config_terms(&config_terms);
+		if (ret)
+			goto out_err;
 	}
+out_err:
+	perf_cpu_map__put(cpus);
 	return found_supported ? 0 : -EINVAL;
 }
 
@@ -814,6 +842,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -843,6 +872,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -990,6 +1020,15 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_CPU:
+		CHECK_TYPE_VAL(NUM);
+		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("too big"),
+						NULL);
+			return -EINVAL;
+		}
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1117,6 +1156,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1251,6 +1291,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1305,6 +1346,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1349,6 +1391,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name, *metric_id;
+	struct perf_cpu_map *cpus;
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
@@ -1370,10 +1413,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
+	cpus = get_config_cpu(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
-			  metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-			  /*cpu_list=*/NULL, /*alternate_hw_config=*/PERF_COUNT_HW_MAX
-		) == NULL ? -ENOMEM : 0;
+			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+			cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) ? 0 : -ENOMEM;
+	perf_cpu_map__put(cpus);
 	free_config_terms(&config_terms);
 	return ret;
 }
@@ -1433,6 +1477,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
+	struct perf_cpu_map *term_cpu = NULL;
 
 	if (verbose > 1) {
 		struct strbuf sb;
@@ -1527,11 +1572,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
+	term_cpu = get_config_cpu(&parsed_terms);
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
-			    alternate_hw_config);
+			    &config_terms, auto_merge_stats, term_cpu, alternate_hw_config);
+	perf_cpu_map__put(term_cpu);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e176a34ab088..ab242f671031 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -80,7 +80,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_CPU,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7ed86e3e34e3..4af7b9c1f44d 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -335,6 +335,7 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b7ebac5ab1d1..721a900b3c1d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1429,7 +1429,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1804,6 +1804,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-output",
 		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
+		"cpu=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.49.0.504.g3bcea36a83-goog

