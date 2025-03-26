Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6501BC07B
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743033082; cv=none; b=ioeNp74hMW+AV08g67LqaWLHcPtT+DsxnVhBDyAPYPQznfAyFIejGrvMR0Gsn0O/cGnbiBuCyTZ5ZiDL6xXv6B81nA1UmgvXbNXBgmwRsEWIZZ6uf+7xhrvYX5Mq44VQqy9PPnjpwo7uzwtb4/QLKKdmRPclBWhaNc6YiAQU1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743033082; c=relaxed/simple;
	bh=t2tWu2D0c3sfj5y4zl1G5sLxdKr+9guWjcJcmYZfRBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YpHJDjNlkYcd7QjiUt32q6Yn4h+RoMfRURAe5snGIc49Lg1G6dCY2pGXA2Koh+LT0UotZCtsvEsqX76FErTV37lbcCOopnvwf9+gcqtPcmGAQ0ZmocIMsUIrlAQpViavKNmaERdC3+75HjZW+XSduLRxHL2FiNbaQ6rFerYIkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXe6juLx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXe6juLx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-301bbe9e084so828728a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743033079; x=1743637879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q30bX9+I8GcSOpo9Y0hBVw3mvYTN2XWDyBYM467aSpE=;
        b=NXe6juLx8s4LMC0UCrDsgxmj2LsJSqnn26ANdTEJMc6vItgjRy8/tw24C9yaZvY1Ac
         hLDRu2N2xJaKT9qx7gzn/5LRxtV/E6zC3e5EtnyxhY4TOnFkyS0FySVPBKWOdr2FpVy8
         NW/urTKXYMM0xO5VRo2OT2rt2AcflJIwQ/RmcLZ+Z3Q0qt/SOm4SqQkaiX9RZY8GK7eP
         WrWs/2EB5qTXIszHYplrpxvNZhDdrSNqna9rJ9NzQYq52nwJdwtnCUQoAGKxTWGwVURJ
         43cxyYmWOmBts8/+fI0T5NhKHPnccJBki5vQfecJU4o+h16mxObSFenuq5zENmk/oSgz
         yWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743033079; x=1743637879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q30bX9+I8GcSOpo9Y0hBVw3mvYTN2XWDyBYM467aSpE=;
        b=MDijMVe7am+SGVE3ldQO8oVH2syGPwX6G9QYy186FSJ8yOxnXshJeM0T/oKdMVfcP1
         7rdKSh5en6RgpqB6G0RnQJQQUOF4Jpu95jCwF16wP0qeWJcKPZkY5w7yeuBbaqYjRcer
         Zu4qVjNCX9SEm5a7euYz0Opzm6sWhwhB9waLHdXzkna/6O88bFnXCBVQPfZcWE11yWbL
         zFCBCSHGcxoh/6zYuNUlksVPfVQpJQvdBQ4QwsJk+Yiu1FByIBGP+zNSjvzmmx0En70O
         WaW1JOVSxNiZuaxnEd8xdF1R2Hqq37qbsCdCipc6MrYH9+tEps8p3ZEhszh6jWADZPUI
         nfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSY/ZzeM3tpDjjOJaRVFCV3vQpNHR9B4L/QfcKzTwMIr7xAXTfLhIw21HkDF/oUPtoisrK51IVbjqFpX+0rUs5@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwupduCGD/pn9l0BUXvTKvMcjW0S9oPzF2lYpN5KRXOQ3TEOt
	3834CuTUvYgYlv0sSBKIpNr1izukygpK97SfMAE/8c+U2aFXIqPJrBzhaIhDsXGGBZQkyLrMol3
	X/w==
X-Google-Smtp-Source: AGHT+IGfyPL45x0WkucqFEcKaMvnBC0INnO/xWDuB/tJf1TPWrD/Zzf3B+xVfs4YQ4rwfKtCPqDwABIiBE0=
X-Received: from pjbnw9.prod.google.com ([2002:a17:90b:2549:b0:301:1bf5:2f07])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c84:b0:2ee:b2e6:4276
 with SMTP id 98e67ed59e1d1-303a9171a7dmr2246014a91.27.1743033079593; Wed, 26
 Mar 2025 16:51:19 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:42:35 -0700
In-Reply-To: <20250326234758.480431-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326234758.480431-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250326234758.480431-2-ctshao@google.com>
Subject: [PATCH v1 1/2] perf evlist: Make uniquifying counter names consistent
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ak@linux.intel.com, howardchu95@gmail.com, 
	asmadeus@codewreck.org, yeoreum.yun@arm.com, linux@treblig.org, 
	james.clark@linaro.org, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ian Rogers <irogers@google.com>

From: Ian Rogers <irogers@google.com>

perf stat has different uniquification logic to perf record and perf
top. In the case of perf record and perf top all hybrid event
names are uniquified. Perf stat is more disciplined respecting
name config terms, libpfm4 events, etc. Perf stat will uniquify
hybrid events and the non-core PMU cases shouldn't apply to perf
record or perf top. For consistency, remove the uniquification for
perf record and perf top and reuse the perf stat uniquification,
making the code more globally visible for this.

Fix the detection of cross-PMU for disabling uniquify by correctly
setting last_pmu. When setting uniquify on an evsel, make sure the
PMUs between the 2 considered events differ otherwise the uniquify
isn't adding value.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-record.c    |   7 +-
 tools/perf/builtin-top.c       |   7 +-
 tools/perf/util/evlist.c       |  66 ++++++++++-----
 tools/perf/util/evlist.h       |   3 +-
 tools/perf/util/evsel.c        | 113 +++++++++++++++++++++++++
 tools/perf/util/evsel.h        |   4 +
 tools/perf/util/stat-display.c | 149 +--------------------------------
 7 files changed, 176 insertions(+), 173 deletions(-)

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
index c1a04141aed0..a28ab52e7d85 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2552,34 +2552,56 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
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
+		last_pmu = counter->pmu;
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
index 1974395492d7..f00cfff119aa 100644
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
+		if (evsel == counter || evsel->merged_stat || evsel->pmu == counter->pmu)
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
2.49.0.472.ge94155a9ec-goog

