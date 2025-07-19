Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9120ADF8
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894361; cv=none; b=pnoKvbV4Iwg5E8G6RXsTlk7rGZeh2jhouBe07mmPsJUIl6ZfvKGMhekkRlHnnTXUWQTyDEHFsro5meXNEtfyYL2e2faR81O1XUQtx8y1K1i1V6/dQVTK7L+nkxHfZVqc2qdeTaGkSieGLdZnV7sNIggo32m9GkhNgZQ7t1G8jGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894361; c=relaxed/simple;
	bh=gnUVsnOcV/XtpgO/L2imjrh4swAc/StdCtllv4r2d8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Dqxkfy2/FP4MAjkdi8XY4qIL+lupAC6qlM0a2VeH+B1TLyCMkG1VkhrQ8WGQjkCoKrolF5b7Isxd0ygfvA24W6bx9UyiM9kBtBPO933xhYKRq3e0PnKXojAL3g/GoaOPWCrgnnYeQgPjEea89KP3sr+vxZBZ6iAdC7WnppibX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSqgKl1m; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSqgKl1m"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so2671285b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894359; x=1753499159; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmgRc//yvu8C/2TPTG7gdgWNTTZ5mY9hqNAERparZN8=;
        b=NSqgKl1mGVNlT2kIuAiTy9OhB3bZq7Sqct8Vnqoq4uiablBFgW99WdrO0deCOcLuLq
         KML1HC6TGohOSoFfi7hxPmEP+2O4nPMmlxzmQTa0fjLDlSwTtHMmNsWokViK9QQsEjI8
         wAXICrEKo1DxL4qbyhTpSgnkcZokeZTzb1wMyX24DANkycRDV9ag9LVVJjXDMTRmhVQl
         QNnmNHefHFfAv7umNFGkrUcIifUMaGirQ0wh0K8uo9jaGDhweNXmj8GrqpAmBRBWRq2Q
         D6URjIzFws2fPUROIcSJuxgL9nNeb8LS87yIN3EXXLyJlJpanZYWEwnqpy6/XbILaKgE
         YuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894359; x=1753499159;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmgRc//yvu8C/2TPTG7gdgWNTTZ5mY9hqNAERparZN8=;
        b=gsuYZOQEiUyhYCHQvEPxMONBFKuAuGdUM+LMVP67XRK6EBYzXdh6HbrElycu1C+ajv
         8fKIcWwBau16z9Dy5h829m3enRjpRXQZL7gLbSqODm5phNTp/5vuckrMM6tVpXGPT03a
         HL6hqCFdD6IhmcLYRVD1vf1p2zmQn9gfq34/bxqwg2EWNBkoD1DsY8I5Jb4L3j/5RY2z
         Fn3SCbMTaSTpyprXIPUnURZBG8eb1baN8wpXUG27HasNFb2IyCqxPvz4NKa+DqDecT7+
         8WL3ciNVOoTiCAB1WcnJ8QzPj4VmWfgR47SrfcLqGxCtUTkzSRTkvdqozJX7ifh5PDqK
         ZLcw==
X-Forwarded-Encrypted: i=1; AJvYcCVrLmaGocaURExIidtcOAD5WVmdEFXLya2nYJ6kAA81BCtqYhJbAGTfDhyyluVjilvg+EsIgRWkDU5eCFbZllYL@vger.kernel.org
X-Gm-Message-State: AOJu0YzRskW/OzOl8VNVTlTHwiKX8FmrjVgRts+FxhObxB8DqUkIsp40
	A3WTeCUyE7EcAcTOhc2jfwqKsuYs6lvE275wJzcikZWNQEk9GTNEzzb90MtC1NHQcIzVE5fi3zG
	VvVFHyOhAiQ==
X-Google-Smtp-Source: AGHT+IG4YDUB4lx+V+i8TajjW6vMqT0pjd6tqiud9nGrVufXkeQRNx06qqxAraYwENxoI7aztNJ+KmaqZCxN
X-Received: from pfbdh2.prod.google.com ([2002:a05:6a00:4782:b0:746:fd4c:1fcf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e23:b0:748:e150:ac5c
 with SMTP id d2e1a72fcca58-759ae1e7120mr7877546b3a.23.1752894359467; Fri, 18
 Jul 2025 20:05:59 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:16 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-15-irogers@google.com>
Subject: [PATCH v3 14/15] perf parse-events: Fix missing slots for Intel
 topdown metric events
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Topdown metric events require grouping with a slots event. In perf
metrics this is currently achieved by metrics adding an unnecessary
"0 * tma_info_thread_slots". New TMA metrics trigger optimizations of
the metric expression that removes the event and breaks the metric due
to the missing but required event. Add a pass immediately before
sorting and fixing parsed events, that insert a slots event if one is
missing. Update test expectations to match this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c  | 24 ++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.c | 28 ++++++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  2 ++
 tools/perf/tests/parse-events.c    | 24 ++++++++++++------------
 tools/perf/util/evlist.h           |  1 +
 tools/perf/util/parse-events.c     | 10 ++++++++++
 6 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 1969758cc8c1..75e9d00a1494 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -81,3 +81,27 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	/* Default ordering by insertion index. */
 	return lhs->core.idx - rhs->core.idx;
 }
+
+int arch_evlist__add_required_events(struct list_head *list)
+{
+	struct evsel *pos, *metric_event = NULL;
+	int idx = 0;
+
+	if (!topdown_sys_has_perf_metrics())
+		return 0;
+
+	list_for_each_entry(pos, list, core.node) {
+		if (arch_is_topdown_slots(pos)) {
+			/* Slots event already present, nothing to do. */
+			return 0;
+		}
+		if (metric_event == NULL && arch_is_topdown_metrics(pos))
+			metric_event = pos;
+		idx++;
+	}
+	if (metric_event == NULL) {
+		/* No topdown metric events, nothing to do. */
+		return 0;
+	}
+	return topdown_insert_slots_event(list, idx + 1, metric_event);
+}
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 66b231fbf52e..0d01b662627a 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -77,3 +77,31 @@ bool arch_topdown_sample_read(struct evsel *leader)
 
 	return false;
 }
+
+/*
+ * Make a copy of the topdown metric event metric_event with the given index but
+ * change its configuration to be a topdown slots event. Copying from
+ * metric_event ensures modifiers are the same.
+ */
+int topdown_insert_slots_event(struct list_head *list, int idx, struct evsel *metric_event)
+{
+	struct evsel *evsel = evsel__new_idx(&metric_event->core.attr, idx);
+
+	if (!evsel)
+		return -ENOMEM;
+
+	evsel->core.attr.config = TOPDOWN_SLOTS;
+	evsel->core.cpus = perf_cpu_map__get(metric_event->core.cpus);
+	evsel->core.pmu_cpus = perf_cpu_map__get(metric_event->core.pmu_cpus);
+	evsel->core.is_pmu_core = true;
+	evsel->pmu = metric_event->pmu;
+	evsel->name = strdup("slots");
+	evsel->precise_max = metric_event->precise_max;
+	evsel->sample_read = metric_event->sample_read;
+	evsel->weak_group = metric_event->weak_group;
+	evsel->bpf_counter = metric_event->bpf_counter;
+	evsel->retire_lat = metric_event->retire_lat;
+	evsel__set_leader(evsel, evsel__leader(metric_event));
+	list_add_tail(&evsel->core.node, list);
+	return 0;
+}
diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
index 2349536cf882..69035565e649 100644
--- a/tools/perf/arch/x86/util/topdown.h
+++ b/tools/perf/arch/x86/util/topdown.h
@@ -5,9 +5,11 @@
 #include <stdbool.h>
 
 struct evsel;
+struct list_head;
 
 bool topdown_sys_has_perf_metrics(void);
 bool arch_is_topdown_slots(const struct evsel *evsel);
 bool arch_is_topdown_metrics(const struct evsel *evsel);
+int topdown_insert_slots_event(struct list_head *list, int idx, struct evsel *metric_event);
 
 #endif
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5ec2e5607987..bb8004397650 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -719,20 +719,20 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 
 static int test__checkevent_pmu_events(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
-				      strcmp(evsel->pmu->name, "cpu"));
-	TEST_ASSERT_VAL("wrong exclude_user",
-			!evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel",
-			evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
-	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+	TEST_ASSERT_VAL("wrong number of entries", 1 <= evlist->core.nr_entries);
 
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
+					      strcmp(evsel->pmu->name, "cpu"));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+	}
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index fac1a01ba13f..1472d2179be1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -111,6 +111,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry);
 void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
+int arch_evlist__add_required_events(struct list_head *list);
 
 int evlist__add_dummy(struct evlist *evlist);
 struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fe2073c6b549..01fa8c80998b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2190,6 +2190,11 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
 	return arch_evlist__cmp(lhs, rhs);
 }
 
+int __weak arch_evlist__add_required_events(struct list_head *list __always_unused)
+{
+	return 0;
+}
+
 static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 {
 	int idx = 0, force_grouped_idx = -1;
@@ -2201,6 +2206,11 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	struct evsel *force_grouped_leader = NULL;
 	bool last_event_was_forced_leader = false;
 
+	/* On x86 topdown metrics events require a slots event. */
+	ret = arch_evlist__add_required_events(list);
+	if (ret)
+		return ret;
+
 	/*
 	 * Compute index to insert ungrouped events at. Place them where the
 	 * first ungrouped event appears.
-- 
2.50.0.727.gbf7dc18ff4-goog

