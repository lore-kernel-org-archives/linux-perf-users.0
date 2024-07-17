Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040376F1B
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256472; cv=none; b=SPDpPdoTRoXYdPfnUDcQbfxqMqZ6XBXqmpqzFfUvatWJeAzt9lVmV2jmVQEveT4m9sAbZD8SJ0UmIrHuq+OcknGn/0v9HeRmhzhB2DB+Dv9wGWm0ctX8dacAAafYGEYMviapACIIjkEa7HLVSzSOM4reRnFjYRoQoL62eukCLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256472; c=relaxed/simple;
	bh=qBZwJYtPOcxIBCuP7ed5zdH2CrVwWXLQho9fyByEv+Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HwyAdlGqZyx/mXpVjbi5pblXIDZNZfRk0z/hhGJ5D0ikw2QQir0AwXQrf5D+TQSRl/0QpEz0mIFhIIObaeAUO16v5XWI6MpIHsvX9CD4noFz9hzEXz6+tyO0HusT1udLdZVdjre9XuqVDtobFqOJcTn703rEjvCcpMXwfFW2qNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgAKtOqV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgAKtOqV"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66480c1a6b5so4246297b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256469; x=1721861269; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTtg53qw4tgJTmr6Us6eL046MbK+xI+ua5J9nAvmPjM=;
        b=OgAKtOqVuSHhc2nBzoWacpfrTreWd2SPsiwvSSgHYNb4H9o8aBkTPp+yTiyCYbdXkE
         wg7omM9dbqcemwKjavKx92Wu8ouyZlqjhklPQRcDcFWQB+MOrHCgeCyPPISo5eHoxCpd
         RmvqkSx2A2WI4jcywr5sRDuItCJhXDRa38sxaY8BTOrSJ+wkIAOogJGy+lx8kFRO12JT
         XDQHfWkEZwXtFCdzro2IRnTjZQs+VDyfqdxisow2oF2vT4YOI3B7BTD1E2ufqqZkDwdD
         xxntwx62oIRdGGbFsm6tPCrMUWGFa0ylVEmqUZmaxWESt7drXGrqbbTBf1OR5RYOeQVB
         Y2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256469; x=1721861269;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTtg53qw4tgJTmr6Us6eL046MbK+xI+ua5J9nAvmPjM=;
        b=PzfO09q93w7hf3Ep4yCLGUJF59UjdaAvN0SrgDpSVQpAJt3LVMdqxWHTglV5d91WdZ
         NkfoR876XQowmKK1IejM3Ydh/oTfRAyoa8+yWYlKwtaRclll6IUp/LozaGtYnL9CytNO
         UfpsLwiA+0hw6+auCMNlaHYdBGNq+H/9J1U0aDi8gBZIVwLSTxyU+ylfKmeHOBTj1qw4
         D5zE3RoXR1c4VTgGCFXZgVTTqonhXhp907IiD841nHqzJDYAg3EN4fc+Lb6CtgIHydyZ
         ecUjxMJAfNY7nnm6viL9d192VLmXCS35Hc7JgqLzGjEmgGB4t086t7SL/yEq+ioYDc7C
         l1nA==
X-Forwarded-Encrypted: i=1; AJvYcCUJopmkW16i37JFyemcwgsZMpTmVdBwunsm2b488SvqE60Ew5UNDxVBj23yZhnPY+Z5+0pG886fjX/8EOh9zcKk7lKBan5Im9jgem6qALEqVg==
X-Gm-Message-State: AOJu0YxAFpUZc/eNJ6sI5/vA6PqNXGFxrjOoX7dtb5QD2suez7ZPldC4
	Wo/Jzd/tHZNOeAvR/khV54wqxniYfzrv3Oh97jz7NrUzXGmY7PrQ+gxR0aocLDrNcvsBf2dDPDQ
	9LhaB3w==
X-Google-Smtp-Source: AGHT+IHSSm/ii+Q0fgt4XLFitdB1ypO5rslVKkP/tfVh0SU4SEkUts8F4aIanL2ZyIAoPo/haz2HT5H/KQUa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:102:b0:62f:f535:f41 with SMTP id
 00721157ae682-666042bc655mr690957b3.9.1721256469548; Wed, 17 Jul 2024
 15:47:49 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:32 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 6/6] perf parse-events: Add "cpu" term to set the CPU an
 event is recorded on
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

The -C option allows the CPUs for a list of events to be specified but
its not possible to set the CPU for a single event. Add a term to
allow this. The term isn't a general CPU list due to ',' already being
a special character in event parsing.

An example of mixing different types of events counted on different CPUs:
```
$ perf stat -A -C 0,4,8 -e "instructions/cpu=0/,l1d-misses/cpu=4/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0              419,426      instructions/cpu=0/              #    0.25  insn per cycle
CPU4        <not counted>      instructions/cpu=0/
CPU8        <not counted>      instructions/cpu=0/
CPU0        <not counted>      l1d-misses [cpu]
CPU4               45,574      l1d-misses [cpu]
CPU8        <not counted>      l1d-misses [cpu]
CPU0        <not counted>      cpu/cpu=8/
CPU4        <not counted>      cpu/cpu=8/
CPU8              164,073      cpu/cpu=8/
CPU0            1,689,993      cycles
CPU4            5,204,403      cycles
CPU8              668,986      cycles
```

An example of spreading uncore overhead across two CPUs:
```
$ perf stat -A -e "data_read/cpu=0/,data_write/cpu=1/" -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=0/
CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=0/
CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=1/
CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=1/
CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=1/
CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=1/
```

Note, the event names are missing as there are unmerged uniquify fixes
like:
https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.com/

Manually fixing the output should be:
```
CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cpu=0/
CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cpu=0/
CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,cpu=1/
CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,cpu=1/
```

That is data_read from 2 PMUs was read on CPU0 and data_write was read
on CPU1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |  7 +++
 tools/perf/util/evsel_config.h         |  1 +
 tools/perf/util/parse-events.c         | 67 ++++++++++++++++++++++----
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/pmu.c                  |  1 +
 6 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 6bf2468f59d3..abbff01665eb 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -273,6 +273,13 @@ Sums up the event counts for all hardware threads in a core, e.g.:
 
   perf stat -e cpu/event=0,umask=0x3,percore=1/
 
+cpu:
+
+Specifies the CPU to open the event upon:
+
+
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
index 8c0c33361c5e..86d074aa6c9a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <sys/ioctl.h>
 #include <sys/param.h>
+#include "cpumap.h"
 #include "term.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -177,6 +178,20 @@ static char *get_config_name(const struct parse_events_terms *head_terms)
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
 
+static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head_terms)
+{
+	struct parse_events_term *term;
+
+	if (!head_terms)
+		return NULL;
+
+	list_for_each_entry(term, &head_terms->terms, list)
+		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU)
+			return perf_cpu_map__new_int(term->val.num);
+
+	return NULL;
+}
+
 /**
  * fix_raw - For each raw term see if there is an event (aka alias) in pmu that
  *           matches the raw's string value. If the string value matches an
@@ -468,11 +483,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
@@ -486,7 +502,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 						   parsed_terms,
 						   perf_pmu__auto_merge_stats(pmu));
 			if (ret)
-				return ret;
+				goto out_err;
 			continue;
 		}
 
@@ -506,20 +522,27 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
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
 
@@ -814,6 +837,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -843,6 +867,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
@@ -986,6 +1011,15 @@ do {									   \
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
@@ -1112,6 +1146,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_CPU:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1243,6 +1278,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1296,6 +1332,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
 		}
@@ -1350,6 +1387,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name, *metric_id;
+	struct perf_cpu_map *cpus;
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
@@ -1371,9 +1409,11 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 
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
@@ -1440,6 +1480,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
+	struct perf_cpu_map *term_cpu = NULL;
 	int ret = 0;
 
 	if (verbose > 1) {
@@ -1531,6 +1572,12 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		goto out_err;
 	}
 
+	term_cpu = get_config_cpu(&parsed_terms);
+	if (!perf_cpu_map__is_empty(term_cpu)) {
+		perf_cpu_map__put(info.cpus);
+		info.cpus = term_cpu;
+		term_cpu = NULL;
+	}
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e13de2c8b706..b03857499030 100644
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
index 16045c383ada..e06097a62796 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -330,6 +330,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 280b2499c861..27e2ff23799e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1767,6 +1767,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"percore",
 		"aux-output",
 		"aux-sample-size=number",
+		"cpu=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.45.2.1089.g2a221341d9-goog

