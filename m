Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D552FC23
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401260; cv=none; b=bZf+CsuI+8icnhYD5KQOG1T5nPKG58pjqBZb1fNxgr9eF3DZkmGdMxFvoG8G6CbPY4kAppKQJlgK2/XFptjNGtuCYJg5T/HpeXWF4PS1UCpIcjglWg+O+dU4o9zNbDdiyaxmnh3BE2i1VjKkBIoW33WnsefmV1qdo3Cwqag4WSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401260; c=relaxed/simple;
	bh=0Q1o22ELJeWhsTZHY7Uv/A5YG9+vQYjPRNQ0hIJkPHQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=T0/hB3HBYYiXITWyR0Jj3cNUeqdw/KncD+XaM+COSLF0jNMmi/nEVdqaxVDfAZYqcLAFdmhz17tXrmUTbLDYNhDP4CP6QZ9KABGMRhNE78hcnx6S03liSVgntSJqfsBkMr02u0rYgp0n6VC2AzbndlfTBxvOz8VPdq1JuF+Ci0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9AlJjfO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9AlJjfO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so7941249a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742401258; x=1743006058; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CmOOBUdKcBV4QLV+u0HYjq2hj+rXMOzyFOvOOndFngc=;
        b=v9AlJjfOFmTcHOfmjSb39Mf/jRJxn9wuboDMseHu7TcozQojEiiX/4tjEZWZ7aj/ld
         As136iKhWs15W3qcPE7tboCJW9zCtmfG02Fupf6qHN3uztRyAhEmB/A79SMQJo+u0nTZ
         iizRrv9/7MZUtfyFAnrtO9JLI+qafrxJpPjItFEPYs5lYz+HG1a3kcCU3IMmWEJtoNU4
         MKEta7Ze2uPCe8YOOp0Wr6aei6O5LwyJRJV3w0rJlrG1zKTu4/HwMpQPvMQEpZD4GIYQ
         7kbaqtqQqtIwRnoUPC9xFfbuUTNmyPOfNKWm326TldwExjGYduahnbNxAAi0HYY5SHs7
         mRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401258; x=1743006058;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmOOBUdKcBV4QLV+u0HYjq2hj+rXMOzyFOvOOndFngc=;
        b=d7kvveFXqSGMRgVHJxssmR/wacvwSsYixpIxFTut3Gmsf/CpdYTsVKocMqtLkvs6L9
         ss4hwuNeQicrbUQk6X0+NNmhBxX6kmp3+JQq5Lp0h9awRAX5Mdfs38ST+gHzEJb8escD
         xAIJIeRRy6jiFVo7/3Pb2/ogFEl5jJM6uySD9AQRtDRzyTMcqZT/413Vg0QnFHnWO3VI
         IzrD6nrnvDARJSXDU1jALlSPLXtj891u5XiWjS04uGI0vWaiiys6sgn3RXgSnHkx2wZx
         jx6ywO4L1Gn2FI4QgBFqqHYS8G2IqZw5UwjMba/d+bfuWq6WeRjw+IpVPWzdhHbxXs+m
         TH3w==
X-Forwarded-Encrypted: i=1; AJvYcCUz5vv3XmA+aLlnuVTXZqVS1Pf+N7Ym3t9398OJkAKdCeqoE9O+aIXVROIfKJCE9adr7GPHdCfS0evlJ1ihSaMF@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVJgEOkHk5BHlz17ozCfsH5SVYfxC3HHNS+5+8ACiP4M5/qpv
	Rs6qvkBUtoDZv7R8AKSz3nVpbzKbPDcWcZ5/QmE+H08bmEBXNXQoHnOhYlRPMtPiK0AFkcfoXDD
	nczsqDw==
X-Google-Smtp-Source: AGHT+IGRBetIfbs9yFp7ojoVXbSAGnBD+kto5JDEyfGNYvlYKDP/geGo+PVvRpA1r3x5zbSJdgZ2PiTUrYLR
X-Received: from pgbdo13.prod.google.com ([2002:a05:6a02:e8d:b0:af2:8474:f67e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9a:b0:1f5:5b2a:f641
 with SMTP id adf61e73a8af0-1fbece4181emr5937576637.28.1742401257773; Wed, 19
 Mar 2025 09:20:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:20:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319162053.915284-1-irogers@google.com>
Subject: [PATCH v1] perf evlist: Make uniquifying counter names consistent
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf stat has different uniquification logic to perf record and perf
top. In the case of perf record and perf top all hybrid event names
are uniquified. Perf stat is more disciplined respecting name config
terms, libpfm4 events, etc. Perf stat will uniquify hybrid events and
the non-core PMU cases shouldn't apply to perf record or perf top. For
consistency, remove the uniquification for perf record and perf top
and reuse the perf stat uniquification, making the code more globally
visible for this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c    |   7 +-
 tools/perf/builtin-top.c       |   7 +-
 tools/perf/util/evlist.c       |  65 +++++++++-----
 tools/perf/util/evlist.h       |   3 +-
 tools/perf/util/evsel.c        | 113 +++++++++++++++++++++++++
 tools/perf/util/evsel.h        |   4 +
 tools/perf/util/stat-display.c | 149 +--------------------------------
 7 files changed, 175 insertions(+), 173 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..83f8f9728e12 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -26,6 +26,7 @@
 #include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
+#include "util/stat.h"
 #include "util/symbol.h"
 #include "util/record.h"
 #include "util/cpumap.h"
@@ -2483,7 +2484,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		pr_warning("WARNING: --timestamp-filename option is not available in pipe mode.\n");
 	}
 
-	evlist__uniquify_name(rec->evlist);
+	/*
+	 * Use global stat_config that is zero meaning aggr_mode is AGGR_NONE
+	 * and hybrid_merge is false.
+	 */
+	evlist__uniquify_evsel_names(rec->evlist, &stat_config);
 
 	evlist__config(rec->evlist, opts, &callchain_param);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1061f4eebc3f..b7c8ecafa2f2 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -35,6 +35,7 @@
 #include "util/mmap.h"
 #include "util/session.h"
 #include "util/thread.h"
+#include "util/stat.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/top.h"
@@ -1309,7 +1310,11 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
-	evlist__uniquify_name(top->evlist);
+	/*
+	 * Use global stat_config that is zero meaning aggr_mode is AGGR_NONE
+	 * and hybrid_merge is false.
+	 */
+	evlist__uniquify_evsel_names(top->evlist, &stat_config);
 	ret = perf_top__start_counters(top);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 49e10d6981ad..e9961823e307 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2551,34 +2551,55 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 	perf_cpu_map__put(user_requested_cpus);
 }
 
-void evlist__uniquify_name(struct evlist *evlist)
+/* Should uniquify be disabled for the evlist? */
+static bool evlist__disable_uniquify(const struct evlist *evlist)
 {
-	char *new_name, empty_attributes[2] = ":", *attributes;
-	struct evsel *pos;
+	struct evsel *counter;
+	struct perf_pmu *last_pmu = NULL;
+	bool first = true;
 
-	if (perf_pmus__num_core_pmus() == 1)
-		return;
+	evlist__for_each_entry(evlist, counter) {
+		/* If PMUs vary then uniquify can be useful. */
+		if (!first && counter->pmu != last_pmu)
+			return false;
+		first = false;
+		if (counter->pmu) {
+			/* Allow uniquify for uncore PMUs. */
+			if (!counter->pmu->is_core)
+				return false;
+			/* Keep hybrid event names uniquified for clarity. */
+			if (perf_pmus__num_core_pmus() > 1)
+				return false;
+		}
+	}
+	return true;
+}
 
-	evlist__for_each_entry(evlist, pos) {
-		if (!evsel__is_hybrid(pos))
-			continue;
+static bool evlist__set_needs_uniquify(struct evlist *evlist, const struct perf_stat_config *config)
+{
+	struct evsel *counter;
+	bool needs_uniquify = false;
 
-		if (strchr(pos->name, '/'))
-			continue;
+	if (evlist__disable_uniquify(evlist)) {
+		evlist__for_each_entry(evlist, counter)
+			counter->uniquified_name = true;
+		return false;
+	}
+
+	evlist__for_each_entry(evlist, counter) {
+		if (evsel__set_needs_uniquify(counter, config))
+			needs_uniquify = true;
+	}
+	return needs_uniquify;
+}
 
-		attributes = strchr(pos->name, ':');
-		if (attributes)
-			*attributes = '\0';
-		else
-			attributes = empty_attributes;
+void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_config *config)
+{
+	if (evlist__set_needs_uniquify(evlist, config)) {
+		struct evsel *pos;
 
-		if (asprintf(&new_name, "%s/%s/%s", pos->pmu ? pos->pmu->name : "",
-			     pos->name, attributes + 1)) {
-			free(pos->name);
-			pos->name = new_name;
-		} else {
-			*attributes = ':';
-		}
+		evlist__for_each_entry(evlist, pos)
+			evsel__uniquify_counter(pos);
 	}
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index edcbf1c10e92..7cfdaf543214 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -19,6 +19,7 @@
 struct pollfd;
 struct thread_map;
 struct perf_cpu_map;
+struct perf_stat_config;
 struct record_opts;
 struct target;
 
@@ -433,7 +434,7 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
-void evlist__uniquify_name(struct evlist *evlist);
+void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_config *config);
 bool evlist__has_bpf_output(struct evlist *evlist);
 bool evlist__needs_bpf_sb_event(struct evlist *evlist);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7..1bc81aa604a7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3939,3 +3939,116 @@ void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
 		leader->core.nr_members--;
 	}
 }
+
+bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config)
+{
+	struct evsel *evsel;
+
+	if (counter->needs_uniquify) {
+		/* Already set. */
+		return true;
+	}
+
+	if (counter->merged_stat) {
+		/* Counter won't be shown. */
+		return false;
+	}
+
+	if (counter->use_config_name || counter->is_libpfm_event) {
+		/* Original name will be used. */
+		return false;
+	}
+
+	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
+		/* Unique hybrid counters necessary. */
+		counter->needs_uniquify = true;
+		return true;
+	}
+
+	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
+		/* Legacy event, don't uniquify. */
+		return false;
+	}
+
+	if (counter->pmu && counter->pmu->is_core &&
+	    counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
+		/* A sysfs or json event replacing a legacy event, don't uniquify. */
+		return false;
+	}
+
+	if (config->aggr_mode == AGGR_NONE) {
+		/* Always unique with no aggregation. */
+		counter->needs_uniquify = true;
+		return true;
+	}
+
+	/*
+	 * Do other non-merged events in the evlist have the same name? If so
+	 * uniquify is necessary.
+	 */
+	evlist__for_each_entry(counter->evlist, evsel) {
+		if (evsel == counter || evsel->merged_stat)
+			continue;
+
+		if (evsel__name_is(counter, evsel__name(evsel))) {
+			counter->needs_uniquify = true;
+			return true;
+		}
+	}
+	return false;
+}
+
+void evsel__uniquify_counter(struct evsel *counter)
+{
+	const char *name, *pmu_name;
+	char *new_name, *config;
+	int ret;
+
+	/* No uniquification necessary. */
+	if (!counter->needs_uniquify)
+		return;
+
+	/* The evsel was already uniquified. */
+	if (counter->uniquified_name)
+		return;
+
+	/* Avoid checking to uniquify twice. */
+	counter->uniquified_name = true;
+
+	name = evsel__name(counter);
+	pmu_name = counter->pmu->name;
+	/* Already prefixed by the PMU name. */
+	if (!strncmp(name, pmu_name, strlen(pmu_name)))
+		return;
+
+	config = strchr(name, '/');
+	if (config) {
+		int len = config - name;
+
+		if (config[1] == '/') {
+			/* case: event// */
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
+		} else {
+			/* case: event/.../ */
+			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
+		}
+	} else {
+		config = strchr(name, ':');
+		if (config) {
+			/* case: event:.. */
+			int len = config - name;
+
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
+		} else {
+			/* case: event */
+			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
+		}
+	}
+	if (ret > 0) {
+		free(counter->name);
+		counter->name = new_name;
+	} else {
+		/* ENOMEM from asprintf. */
+		counter->uniquified_name = false;
+	}
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index aae431d63d64..76ccb7c7e8c2 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -16,6 +16,7 @@
 struct bpf_object;
 struct cgroup;
 struct perf_counts;
+struct perf_stat_config;
 struct perf_stat_evsel;
 union perf_event;
 struct bpf_counter_ops;
@@ -542,6 +543,9 @@ void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel);
 
+bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config);
+void evsel__uniquify_counter(struct evsel *counter);
+
 /*
  * Macro to swap the bit-field postition and size.
  * Used when,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e852ac0d9847..d427e0ca98a1 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -929,61 +929,6 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	}
 }
 
-static void evsel__uniquify_counter(struct evsel *counter)
-{
-	const char *name, *pmu_name;
-	char *new_name, *config;
-	int ret;
-
-	/* No uniquification necessary. */
-	if (!counter->needs_uniquify)
-		return;
-
-	/* The evsel was already uniquified. */
-	if (counter->uniquified_name)
-		return;
-
-	/* Avoid checking to uniquify twice. */
-	counter->uniquified_name = true;
-
-	name = evsel__name(counter);
-	pmu_name = counter->pmu->name;
-	/* Already prefixed by the PMU name. */
-	if (!strncmp(name, pmu_name, strlen(pmu_name)))
-		return;
-
-	config = strchr(name, '/');
-	if (config) {
-		int len = config - name;
-
-		if (config[1] == '/') {
-			/* case: event// */
-			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
-		} else {
-			/* case: event/.../ */
-			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
-		}
-	} else {
-		config = strchr(name, ':');
-		if (config) {
-			/* case: event:.. */
-			int len = config - name;
-
-			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
-		} else {
-			/* case: event */
-			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
-		}
-	}
-	if (ret > 0) {
-		free(counter->name);
-		counter->name = new_name;
-	} else {
-		/* ENOMEM from asprintf. */
-		counter->uniquified_name = false;
-	}
-}
-
 /**
  * should_skip_zero_count() - Check if the event should print 0 values.
  * @config: The perf stat configuration (including aggregation mode).
@@ -1069,8 +1014,6 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	if (counter->merged_stat)
 		return;
 
-	evsel__uniquify_counter(counter);
-
 	val = aggr->counts.val;
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
@@ -1650,96 +1593,6 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_metric_end(config, os);
 }
 
-/* Should uniquify be disabled for the evlist? */
-static bool evlist__disable_uniquify(const struct evlist *evlist)
-{
-	struct evsel *counter;
-	struct perf_pmu *last_pmu = NULL;
-	bool first = true;
-
-	evlist__for_each_entry(evlist, counter) {
-		/* If PMUs vary then uniquify can be useful. */
-		if (!first && counter->pmu != last_pmu)
-			return false;
-		first = false;
-		if (counter->pmu) {
-			/* Allow uniquify for uncore PMUs. */
-			if (!counter->pmu->is_core)
-				return false;
-			/* Keep hybrid event names uniquified for clarity. */
-			if (perf_pmus__num_core_pmus() > 1)
-				return false;
-		}
-	}
-	return true;
-}
-
-static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config)
-{
-	struct evsel *evsel;
-
-	if (counter->merged_stat) {
-		/* Counter won't be shown. */
-		return;
-	}
-
-	if (counter->use_config_name || counter->is_libpfm_event) {
-		/* Original name will be used. */
-		return;
-	}
-
-	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
-		/* Unique hybrid counters necessary. */
-		counter->needs_uniquify = true;
-		return;
-	}
-
-	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
-		/* Legacy event, don't uniquify. */
-		return;
-	}
-
-	if (counter->pmu && counter->pmu->is_core &&
-	    counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
-		/* A sysfs or json event replacing a legacy event, don't uniquify. */
-		return;
-	}
-
-	if (config->aggr_mode == AGGR_NONE) {
-		/* Always unique with no aggregation. */
-		counter->needs_uniquify = true;
-		return;
-	}
-
-	/*
-	 * Do other non-merged events in the evlist have the same name? If so
-	 * uniquify is necessary.
-	 */
-	evlist__for_each_entry(counter->evlist, evsel) {
-		if (evsel == counter || evsel->merged_stat)
-			continue;
-
-		if (evsel__name_is(counter, evsel__name(evsel))) {
-			counter->needs_uniquify = true;
-			return;
-		}
-	}
-}
-
-static void evlist__set_needs_uniquify(struct evlist *evlist, const struct perf_stat_config *config)
-{
-	struct evsel *counter;
-
-	if (evlist__disable_uniquify(evlist)) {
-		evlist__for_each_entry(evlist, counter)
-			counter->uniquified_name = true;
-		return;
-	}
-
-	evlist__for_each_entry(evlist, counter)
-		evsel__set_needs_uniquify(counter, config);
-}
-
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts,
 			    int argc, const char **argv)
@@ -1751,7 +1604,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		.first = true,
 	};
 
-	evlist__set_needs_uniquify(evlist, config);
+	evlist__uniquify_evsel_names(evlist, config);
 
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
-- 
2.49.0.rc1.451.g8f38331e32-goog

