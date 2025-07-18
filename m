Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E2213E89
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823077; cv=none; b=A14HE8G+V9/fI17MuDTFZaJgLt4JuvELgYXqBg/LgV41WsdnbXZCgGdqHseyzHSrwvx+eJ7diK17jNntO3ey1n7hwacJb2xshVVbytzLYHw6jrqxZB6DcvxHVVx9c6Dt1pF5iVyMvhM9kiX1tp1kLh/j2psSWPks81dlD/bWsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823077; c=relaxed/simple;
	bh=oqTzwaqzgvf42h1VQHWNrVQpUoVtNFEZkJNJruy19/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kEzM4F61+cxXxM6FxZ6Zmfzm8SW7S7lW3i8IvtXaktmMG9SJn/Z+4fVNoSH4VbHzysbx0UerYW47x/Y3kj5RAECU11AwJyMA5BdREqCNNpmAVny5rJ583DhvdGgvb8TOGqLJ3fQY1GzUFqVIvm14xgSAgTcZ35U7vaKtNbeXS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAvmtFQy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAvmtFQy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so1481906a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752823074; x=1753427874; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rz5DoXaGATOxniDvDWOJulitXArUoT7hv0M4lLLJnoc=;
        b=PAvmtFQy3y1HKq43JKWTx5BuRlP05VUuuqFIx0ntEAtu7FSxkQDxQEWZuEC2EN/lEE
         IThuBdXzOWOWMtitO/1CIIp7iatIBnq800DPknc35H2gUxSm3eHUDu9RwptIHG9eNIyE
         GL1F1ieNjKP6/1HCtNjwGsvSLo8c8tO1POibmz3IR05ki3zCmDsUtarY5KO8EScnBpx9
         f+slgOb+tmhAfCpTcNlI6brtfbo8woOgYs4CtxKo1tGVueaUilpethGPqYCXKvC/GtXV
         PwToVTiMEd/1zFMBppv4enRQcxezzhXjKKLN5FA0tq6xHRTLcxUiEmq0I1Im8usoKt8o
         114Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823074; x=1753427874;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz5DoXaGATOxniDvDWOJulitXArUoT7hv0M4lLLJnoc=;
        b=P7oT9HUAsbAzaiaBRxD2cylio1eQeEERGykq2I+OciGi48zk9UvwjMTGiHWamCljYI
         tp/y4yfx+ql3MkeEJoozIo41BZ0S7diQSl2mNOSA/gkgCXl/jIK8EX9CWNe7xCa0svgA
         Z1l8xYVpIF5HKKYEjlzAGJKNsynADCHt3kQi031y1sTTSkKZ3lHaaF9dtmTCKHyb1EEB
         V/2NSHcOsuXDo2AeTnuPkncOep5M7W4n869ydTTP3zqqHNVG8ldAdx7j+jAYJtzklKMZ
         ea8dl1NeTgSs6zV3TErXJNva8+S8MGlZeyY7i+w/UagGbfbUuYGxsjie/S7LOCtfT4aQ
         qjyA==
X-Forwarded-Encrypted: i=1; AJvYcCXqLkUZCnKCu90K7zsVN4iyRu+s4R9f7QtXzvjvHP3VDVRlHvTe+o1jl4bh8273EIa3bwsILI5iOAzFMv9aHg2K@vger.kernel.org
X-Gm-Message-State: AOJu0YyQicD6SWp4deCeljFyjtHXCm+a2W/Z2Ixq3zFHvFVrFkaH+T7/
	zw/IXTqljC2sX/dea6yWXD+9FoB0PyfmUySTzEu4PXWe8elcVo+nEvsndwWY9oP0m1Sqc9OWjO3
	arPifnyUkGg==
X-Google-Smtp-Source: AGHT+IHqp0DxAifPOnBVYFRjA2bskWkSjDRES27IFxrPapK9aQ+nwQVa46x54ICmCUXQGpw93txKb0z1CVZU
X-Received: from pjbsh18.prod.google.com ([2002:a17:90b:5252:b0:312:f88d:25f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:254d:b0:312:2bb:aa89
 with SMTP id 98e67ed59e1d1-31c9f4c46c8mr13225426a91.20.1752823074515; Fri, 18
 Jul 2025 00:17:54 -0700 (PDT)
Date: Fri, 18 Jul 2025 00:17:34 -0700
In-Reply-To: <20250718071734.1444891-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718071734.1444891-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718071734.1444891-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf parse-events: Fix missing slots for Intel topdown
 metric events
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
 tools/perf/arch/x86/util/topdown.c | 27 +++++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  2 ++
 tools/perf/tests/parse-events.c    | 24 ++++++++++++------------
 tools/perf/util/evlist.h           |  1 +
 tools/perf/util/parse-events.c     | 10 ++++++++++
 6 files changed, 76 insertions(+), 12 deletions(-)

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
index 66b231fbf52e..5d53e3d59c0c 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -77,3 +77,30 @@ bool arch_topdown_sample_read(struct evsel *leader)
 
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
+	evsel->core.own_cpus = perf_cpu_map__get(metric_event->core.own_cpus);
+	evsel->core.is_pmu_core = true;
+	evsel->pmu = metric_event->pmu;
+	evsel->name = strdup("slots");
+	evsel->precise_max = metric_event->precise_max;
+	evsel->sample_read = metric_event->sample_read;
+	evsel->weak_group = metric_event->weak_group;
+	evsel->bpf_counter = metric_event->bpf_counter;
+	evsel->retire_lat = metric_event->retire_lat;
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
index a59ae5ca0f89..01dab5dd3540 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2132,6 +2132,11 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
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
@@ -2143,6 +2148,11 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
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

