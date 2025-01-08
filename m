Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9B1A83E7
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314495; cv=none; b=WplDixqHuwRGpeS4izMiEBbMFTVs0VqLmHLTjv/fQZuxgNZYrIGwe0tHaIvs/u7GaNXTufvhybPdwwTykvRa86FZsUTsTsEdWoMMCorLJe+JyZF6Xz0QGvU5Jqmv8A5oiZV0z9apHn2WNB1FHgjvRI2+EA8YD7EZbx4CEMEBj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314495; c=relaxed/simple;
	bh=ywjvsWJNxLmzM3YIwbYYswpNEHZxKvufAxgc8RsNSbc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jpnQOXWppVYaUKtMopM81y4hFZFTuCQevhIXwC+ENX1LAbxFcJsF7GPz3WsZEXtRL9livlTjA6aeEfT0/6ddgOEvBVagOuMQrXyBQpASC9aEjganBe0RLbM3KeQaAcOi1i4BCkuIc0cVwVddJIy0HMl2yxA5Kw7crkkGuKiisII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHShGJIV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHShGJIV"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so30407821276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 21:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736314493; x=1736919293; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcjD+oXNLY7oywMEC3LvBmYCeG/3kMVQ1vWw9hGSJM0=;
        b=gHShGJIVO0PMSPbryqkCyPOs2pWEZizw06AbyAsV02oiZngRSaMVq0XpPi54TjJiUE
         xDEC2TLIj2h9j3ZF5z3ljBYbp11AGLN4yrpoaNaREfetB4dntcKuVHmmeOufsomR9yeh
         K+lWCSt12rKR8qUeR82FS6TpBd4RAIBFJr64nbr6clu5vfTGr/B1/BMzvG3R1Tn30gV+
         dmFCw+/ntc8xJiw18nSbvys1+Ye9G6SoyctCUVVI+ERZKsrDcMevnCtTEtlGxA0IGC+3
         5PvcBi4oBOXJP9zkQ4HZmHi6x0ZnLRoqILqFD92p2WQ03lOVcG5PrRP9Rd6bMJhppfPR
         F++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314493; x=1736919293;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcjD+oXNLY7oywMEC3LvBmYCeG/3kMVQ1vWw9hGSJM0=;
        b=KoamMXIrJZdOfFeGcIPu2aPwhmxMFqLE6KtjcnJpGKeaefnAvclZP9kablEjUDUNBi
         n5p6prHfhZLjf2lqrVJ8PTT2mJQw4XaVqxAPk8QEynX+OA9kp4uI2btAjsT+nGlZCBrx
         uM/KMcCYuHtbMYMWSArHcqJMklIDhorBWoO621ujcRKZAJkF6gdk1VJq7I/SzLLfWWrn
         L5xdT8C0ng10isVlgNoDlZQcDHvkKoJ4oB2jNwBYs7L4GhhS5AUbulkikws2/AJk8Mhb
         ioRi/zVMao9npbh55uTeVgy2dcDhTCTaYO8AFRPdvBzzUbVJ3NoskLPhyObSpT1gMK/U
         mnTw==
X-Forwarded-Encrypted: i=1; AJvYcCXSYqdornCKT4dxmBEwPs9CqE+FyHq4lf0nuGsICEyzYQl+RPjLNkpv4TP1FTLizHvZz9WlJHKLw8yvaQOozzr/@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZj+TWVqw5782HQJ6GEejLVq7kVPpQZm1WNIagJ2O4IAd8cT3
	wJR43sFLsktY+nv5HAYYFXrm8uEooPYPqXYW2LEFOvWNDWQpUM/Bwq6tDay5Nfl/zn/3G50YOQ0
	sMHaoUA==
X-Google-Smtp-Source: AGHT+IEW9+WqALHzqTdZt6mmp40Bu6OzzY4Eg/OXgZx1NeC6753KkNiIRxAOLHlol1lIM4PvLR54hHNmI92D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a5b:642:0:b0:e39:6fdc:5567 with SMTP id
 3f1490d57ef6-e54eddd285bmr4357276.0.1736314492910; Tue, 07 Jan 2025 21:34:52
 -0800 (PST)
Date: Tue,  7 Jan 2025 21:34:28 -0800
In-Reply-To: <20250108053428.1724490-1-irogers@google.com>
Message-Id: <20250108053428.1724490-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108053428.1724490-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 4/4] perf parse-events: Add "cpu" term to set the CPU an
 event is recorded on
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
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
index d0c65fad419a..d98de9adc515 100644
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
index 4bda4141e9e7..ec8429f0cf6d 100644
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
@@ -178,6 +179,26 @@ static char *get_config_name(const struct parse_events_terms *head_terms)
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
@@ -441,11 +462,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
@@ -460,7 +482,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 						   perf_pmu__auto_merge_stats(pmu),
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 			if (ret)
-				return ret;
+				goto out_err;
 			continue;
 		}
 
@@ -480,21 +502,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
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
 
@@ -808,6 +836,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -837,6 +866,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -984,6 +1014,15 @@ do {									   \
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
@@ -1111,6 +1150,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1245,6 +1285,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1299,6 +1340,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1343,6 +1385,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name, *metric_id;
+	struct perf_cpu_map *cpus;
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
@@ -1364,10 +1407,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 
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
@@ -1427,6 +1471,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
+	struct perf_cpu_map *term_cpu = NULL;
 
 	if (verbose > 1) {
 		struct strbuf sb;
@@ -1521,11 +1566,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
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
index bf7f73548605..14bff6f9731c 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -324,6 +324,7 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6206c8fe2bf9..cffb4eb2696b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1400,7 +1400,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_CPU:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1775,6 +1775,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-output",
 		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
+		"cpu=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.47.1.613.gc27f4b7a9f-goog

