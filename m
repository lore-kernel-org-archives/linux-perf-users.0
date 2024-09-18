Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB71CB53D
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696918; cv=none; b=s7hNfRnOB9iMysDGjB0jmG20zI69QZDKyDqzNFTpelCiXSXQCZ0JOrFVXGfJ3KMOe9r6gd+qpVjjtNaZoI2VT4bHAAetfV5pQZKpwNFsf4NeiDVrw4mHaNpV3Qbp75JyHBspW11U+Ia2rTJwyROgod8eVlUvHnmc1Jn9DW3bI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696918; c=relaxed/simple;
	bh=0HmX3+oDarBi9YsEUyCZhTasjdJ8E7Vq2wgPDApLjP8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oozP3RWZGCgNn7smq/XYKbToh7LmF2uzT78+UzMG91dvPOCJzQ45rArAkpDQGYt8R6/iPIq+F1fCUL+hzZHk3CDacFqD3Qo5B7YWz8cfnweZO5T4TnI6i7YAj4Ez/TGJ6VVCmHZPJsqyAeoIhBnWRermMhjinsu5NixlCY1lHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mk7ahGZZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mk7ahGZZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e202577a7efso445549276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726696916; x=1727301716; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcM+VU+CnvqLlwnAxi53/iARGP0HqFfg/cKQ7ZCX6g4=;
        b=mk7ahGZZUqh2tK4Ie+OcZx47JFujrBSP+fnUI0Ks/0wm3D05K0ckcVBCbYgHcEkf2B
         9KxxM4ds9kFUGcjzB+9AeXcoJxZJeGPF900R/l00UnM1Hjlgnl9vFVi1OR6+WTke3FGv
         91Sznm/zyj/VtZ+oOMzds/DdStgSumpnOgTwfq2LEMCfJaaUENRkb3l54ulLZqoH3f/3
         Gsi50m3A9ctar0bp6M4uS7rs7u60SalEYb13+Ov3k96/bLo1mzvahqD/2avXUru+df+e
         MM0R3Due0HLr/JAaBMCVFAH+hTvs8b2BYZcfG9bI7uoTesdaQ98H7Ri8VSoxxqxR2XMw
         sU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726696916; x=1727301716;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcM+VU+CnvqLlwnAxi53/iARGP0HqFfg/cKQ7ZCX6g4=;
        b=idVjXMrtoNlB7A089fGkkS9zXR1qvYgrun9T1QmSYAfCLAwAuXJfq/aLhl4rleZgZD
         RDYUhgr/XGt6jxL4dwookt+zdLUpW/bnvGvqxGmQmToFT5DWseApAExprJwzJk21WSki
         RkJQubWP2mAXEo2v1UUxevfnXxRYy2hfQSIzyJ8oiXSJ5Ve/H4SGizuZZJpr3IxVXxB6
         5gyT4MeL1o1YgIZ21k+xD2REk6lsrbezq9vYRNZvGDDIEmXek2GMDQI5lWCCjQKbQpmG
         MQmd1QuVdDU3p1H97hzptvp6vK92SJjTnHuGnZzfYDnL1oufR5xOWU4UQgnKxICUJu7s
         Sh7w==
X-Forwarded-Encrypted: i=1; AJvYcCW7deGPAuAFvazYpBvuE4Kx9Ynu84wsKZ+Cjh9xUp/xpJyCdIraQHspBz11bvPcgLwzyneZ5pI6pC67tSyPnYWm@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWlyhj+nRDJx2/qOeJn26IkF3dpN5ReetqRrqSrEURX/gTxhY
	VcKq7oRbTwh22idIYgUUNjLrgLGfEJ7mx07qTPOYw1MmXwm/CtIgzxflhpHIF3sEzLUEJIFPZi1
	RCVzFRg==
X-Google-Smtp-Source: AGHT+IHmgM+Bh5rGiZ5/+XTrkIvNyuS76NKjY1Cy+4xkAJ6JRB0yVCQnlNFZ0Erd2sOSpjTf0arogTVX/3Gh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cb6b:1e62:cfd8:bd50])
 (user=irogers job=sendgmr) by 2002:a25:ab8e:0:b0:e11:5b8c:f9c with SMTP id
 3f1490d57ef6-e1dafd96ef0mr48042276.0.1726696915876; Wed, 18 Sep 2024 15:01:55
 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:01:33 +0200
In-Reply-To: <20240918220133.102964-1-irogers@google.com>
Message-Id: <20240918220133.102964-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918220133.102964-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v3 3/3] perf parse-events: Add "cpu" term to set the CPU an
 event is recorded on
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
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

CPU0              368,647      instructions/cpu=0/              #    0.26  insn per cycle
CPU4        <not counted>      instructions/cpu=0/
CPU5        <not counted>      instructions/cpu=0/
CPU8        <not counted>      instructions/cpu=0/
CPU0        <not counted>      l1d-misses [cpu]
CPU4              203,377      l1d-misses [cpu]
CPU5              138,231      l1d-misses [cpu]
CPU8        <not counted>      l1d-misses [cpu]
CPU0        <not counted>      cpu/cpu=8/
CPU4        <not counted>      cpu/cpu=8/
CPU5        <not counted>      cpu/cpu=8/
CPU8              943,861      cpu/cpu=8/
CPU0            1,412,071      cycles
CPU4           20,362,900      cycles
CPU5           10,172,725      cycles
CPU8            2,406,081      cycles

       0.102925309 seconds time elapsed
```

Note, the event name of inst_retired.any is missing, reported as
cpu/cpu=8/, as there are unmerged uniquify fixes:
https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |  9 ++++
 tools/perf/util/evsel_config.h         |  1 +
 tools/perf/util/parse-events.c         | 71 ++++++++++++++++++++++----
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/pmu.c                  |  1 +
 6 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..e0cd9bb8283e 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -274,6 +274,15 @@ Sums up the event counts for all hardware threads in a core, e.g.:
 
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
index aee6f808b512..9630c4a24721 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -47,6 +47,7 @@ struct evsel_config_term {
 		u32	      aux_sample_size;
 		u64	      cfg_chg;
 		char	      *str;
+		int	      cpu;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 017d31d51ea4..63c31cfdd79b 100644
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
+			cpus = perf_cpu_map__merge(cpus, cpu);
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
@@ -469,11 +490,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
@@ -487,7 +509,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 						   parsed_terms,
 						   perf_pmu__auto_merge_stats(pmu));
 			if (ret)
-				return ret;
+				goto out_err;
 			continue;
 		}
 
@@ -507,20 +529,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
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
-				/*cpu_list=*/NULL) == NULL)
-			return -ENOMEM;
+				cpus) == NULL)
+			ret = -ENOMEM;
 
 		free_config_terms(&config_terms);
+		if (ret)
+			goto out_err;
 	}
+out_err:
+	perf_cpu_map__put(cpus);
 	return found_supported ? 0 : -EINVAL;
 }
 
@@ -835,6 +864,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -864,6 +894,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -1007,6 +1038,15 @@ do {									   \
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
@@ -1133,6 +1173,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1264,6 +1305,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1317,6 +1359,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1371,6 +1414,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name, *metric_id;
+	struct perf_cpu_map *cpus;
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
@@ -1392,9 +1436,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
+	cpus = get_config_cpu(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
 			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
+			cpus) ? 0 : -ENOMEM;
+	perf_cpu_map__put(cpus);
 	free_config_terms(&config_terms);
 	return ret;
 }
@@ -1461,6 +1507,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
+	struct perf_cpu_map *term_cpu = NULL;
 
 	if (verbose > 1) {
 		struct strbuf sb;
@@ -1552,10 +1599,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
+	term_cpu = get_config_cpu(&parsed_terms);
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
+			    &config_terms, auto_merge_stats, term_cpu);
+	perf_cpu_map__put(term_cpu);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 10cc9c433116..2532c81d4f9a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -79,7 +79,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_CPU,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 5a0bcd7f166a..635d216632d7 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -331,6 +331,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 61bdda01a05a..4f68026a97bb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1738,6 +1738,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"percore",
 		"aux-output",
 		"aux-sample-size=number",
+		"cpu=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.46.0.662.g92d0881bb0-goog

