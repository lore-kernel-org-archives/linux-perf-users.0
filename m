Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9712BE05E
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688727; cv=none; b=iky6gB7eDUKknrKu30x75r3fG9fgU+p6XhOQMZR0nLiNf8FRM7YqTaqODyOTq3HPo26YVgnY89OvfNAQjA/3y/iLbNyqCN2oxOfQmZUU/5rRbyNA87pi3UHpH5ORyKOdJ8GeyU7aHuNawCLzz8WXi183i4fMmLFwDzT8SbK2HWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688727; c=relaxed/simple;
	bh=uwNsvy1F00VwK4L921PJrGelX2It82/w3H9RpiCFMZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QQxSbXRprvPdMDpkGY05ZDG+elkAH7lxJ+CjXkjEokHNXbXOIpOb3aviuJER2LWe0JlxUea9/OiX03OmbZko6wtSt8vVQYsuEj3CUncqysD/Oh2YEFTwCWi4apF3txvmRVM9+32XAtCpbOKKAZTC7lHn4KvG+fvj9z9V4cs2sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2SfvXIo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2SfvXIo"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc08so7138932a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688724; x=1760293524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xeqf0FC6Rbstt0vQq1XdhtrR/aNogclupoL2fXVa550=;
        b=N2SfvXIooktyh16gjBKQsNmZV3nEqECvM4jBvogTC6zoxPOvlse2zZ2B8bhRmSFpWI
         LilmIuEJ+3m3I37tEMvUV8sJiBZEPLUWBOXjC4DpAYkYZJaYVMTlC33MwRiUPGuuIDWW
         RYuSHzn+JS428pQzSoSf0uNkMRo3udg9YXY78k44hsFPxtbnRk5f3jbE5i0xUvRQP0/t
         NGmZBFa/wHCDBoCB1RBJPb0TP1NaIZnyWyKH5xQdKy/+MEHwMHsEEj3UnT+gc+LjLjiy
         a6pxlIBkrVsguA9aYRwke+oe/9PtmfjuWeJBmGYyRzh4UN+ZaZLri1znzw3OqScQW+jx
         iWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688724; x=1760293524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xeqf0FC6Rbstt0vQq1XdhtrR/aNogclupoL2fXVa550=;
        b=SbwnhWoOwzBTenFEKxzN9rl5KWdjbR5/qxy1E2eP67SGeVSqCpKaQu+zFgxoQ0Swrb
         X436hWcKkv1lqwnArQYUWnnXzBp1mRq+RxLaEmi4o8G6XkiMICf1dPHbey3GfXh/rzbW
         1tXNTujyU3VwRfw7z1m13+YmCWHHBtQMHXN/JJTsY9pQKIfvX6H105qp+d67tmTybt9g
         IXFe2icIjni8l0jqOaJxRayS9I9cyEC/uYdgfWvwznd0JMWHuVA2TuJfNkTO/u0Xxgme
         eMFgphoJcyUJFeXdSJhS23OpFP4M/0wfB9o/WAMdjKsk2nzGfGqs6oA+UkXFxc/nf7ye
         tg6w==
X-Forwarded-Encrypted: i=1; AJvYcCVVlqvSji1LuqRRb4ltpvgWsg8CEHYfdUcMr6vdb0GgxbYSuVMmis2c3Oa8W4WHQHPB7saGwYy3r/6Yp0VHKIl3@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8MSUXnM/ukf/M5s0hxlxfwZrXym9IcWJJeOlV40UoWNsQDwL
	LQIpqdIj6VBcSkX1qpJMGLxmh/RAwMZUayr9JLq2dBYjfKjanRl25L1oRwva2ZJkehJOOZMUVRE
	59/fhTroeRg==
X-Google-Smtp-Source: AGHT+IEUtOzMV1bG2JwZSTOHgBKTjSc41VFkkFrYxUO1OVivUbK51FX1GU04iUcwyeOJAmPPIX6IQ3hAhOp/
X-Received: from pjbok5.prod.google.com ([2002:a17:90b:1d45:b0:330:49f5:c0a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b49:b0:335:2d4:8b3d
 with SMTP id 98e67ed59e1d1-339c27bda3emr11728223a91.31.1759688723931; Sun, 05
 Oct 2025 11:25:23 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:26 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-24-irogers@google.com>
Subject: [PATCH v7 23/27] perf test parse-events: Remove cpu PMU requirement
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In the event parse string, switch "cpu" to "default_core" and then
rewrite this to the first core PMU name prior to parsing. This enables
testing with a PMU on hybrid x86 and other systems that don't use
"cpu" for the core PMU name. The name "default_core" is already used
by jevents. Update test expectations to match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 230 +++++++++++++++-----------------
 1 file changed, 110 insertions(+), 120 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 23f3e265e2a1..5dd2f03e952d 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -20,17 +20,24 @@
 #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
 
-static int num_core_entries(void)
+static int num_core_entries(struct evlist *evlist)
 {
 	/*
-	 * If the kernel supports extended type, expect events to be
-	 * opened once for each core PMU type. Otherwise fall back to the legacy
-	 * behavior of opening only one event even though there are multiple
-	 * PMUs
+	 * Returns number of core PMUs if the evlist has >1 core PMU, otherwise
+	 * returns 1.  The number of core PMUs is needed as wild carding can
+	 * open an event for each core PMU. If the events were opened with a
+	 * specified PMU then wild carding won't happen.
 	 */
-	if (perf_pmus__supports_extended_type())
-		return perf_pmus__num_core_pmus();
+	struct perf_pmu *core_pmu = NULL;
+	struct evsel *evsel;
 
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->pmu->is_core)
+			continue;
+		if (core_pmu != evsel->pmu && core_pmu != NULL)
+			return perf_pmus__num_core_pmus();
+		core_pmu = evsel->pmu;
+	}
 	return 1;
 }
 
@@ -345,7 +352,7 @@ static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 	struct perf_evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == num_core_entries());
+			evlist->core.nr_entries == num_core_entries(evlist));
 
 	perf_evlist__for_each_entry(&evlist->core, evsel) {
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
@@ -648,19 +655,21 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
+	char buf[256];
 
-	/* cpu/config=1,name=krava/u */
+	/* default_core/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
 
-	/* cpu/config=2/u" */
+	/* default_core/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=2/u"));
+	snprintf(buf, sizeof(buf), "%s/config=2/u", core_pmu->name);
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, buf));
 
 	return TEST_OK;
 }
@@ -670,7 +679,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
-	/* cpu/config=1,call-graph=fp,time,period=100000/ */
+	/* default_core/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
@@ -682,7 +691,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
 
-	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
+	/* default_core/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
@@ -740,7 +749,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 	}
-	/* cpu/pmu-event/u*/
+	/* default_core/pmu-event/u*/
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", evsel__find_pmu(evsel)->is_core);
 	TEST_ASSERT_VAL("wrong exclude_user",
@@ -840,11 +849,11 @@ static int test__group1(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (num_core_entries() * 2));
+			evlist->core.nr_entries == (num_core_entries(evlist) * 2));
 	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries());
+			evlist__nr_groups(evlist) == num_core_entries(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* instructions:k */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
@@ -880,7 +889,7 @@ static int test__group2(struct evlist *evlist)
 	struct evsel *evsel, *leader = NULL;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries() + 1));
+			evlist->core.nr_entries == (2 * num_core_entries(evlist) + 1));
 	/*
 	 * TODO: Currently the software event won't be grouped with the hardware
 	 * event except for 1 PMU.
@@ -1037,11 +1046,11 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (num_core_entries() * 2));
+			evlist->core.nr_entries == (num_core_entries(evlist) * 2));
 	TEST_ASSERT_VAL("wrong number of groups",
-			num_core_entries() == evlist__nr_groups(evlist));
+			num_core_entries(evlist) == evlist__nr_groups(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:u + p */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1078,11 +1087,11 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (5 * num_core_entries()));
+			evlist->core.nr_entries == (5 * num_core_entries(evlist)));
 	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == (2 * num_core_entries()));
+			evlist__nr_groups(evlist) == (2 * num_core_entries(evlist)));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + G */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1111,7 +1120,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 	}
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G */
 		evsel = leader = evsel__next(evsel);
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1139,7 +1148,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	}
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles */
 		evsel = evsel__next(evsel);
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1159,11 +1168,11 @@ static int test__group_gh1(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries()));
+			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
 	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries());
+			evlist__nr_groups(evlist) == num_core_entries(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + :H group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1198,11 +1207,11 @@ static int test__group_gh2(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries()));
+			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
 	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries());
+			evlist__nr_groups(evlist) == num_core_entries(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles + :G group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1237,11 +1246,11 @@ static int test__group_gh3(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries()));
+			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
 	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries());
+			evlist__nr_groups(evlist) == num_core_entries(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G + :u group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1276,11 +1285,11 @@ static int test__group_gh4(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries()));
+			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
 	TEST_ASSERT_VAL("wrong number of groups",
-			evlist__nr_groups(evlist) == num_core_entries());
+			evlist__nr_groups(evlist) == num_core_entries(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles:G + :uG group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1315,9 +1324,9 @@ static int test__leader_sample1(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (3 * num_core_entries()));
+			evlist->core.nr_entries == (3 * num_core_entries(evlist)));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1365,9 +1374,9 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (2 * num_core_entries()));
+			evlist->core.nr_entries == (2 * num_core_entries(evlist)));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* instructions - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
@@ -1403,9 +1412,9 @@ static int test__checkevent_pinned_modifier(struct evlist *evlist)
 	struct evsel *evsel = NULL;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == num_core_entries());
+			evlist->core.nr_entries == num_core_entries(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -1421,9 +1430,9 @@ static int test__pinned_group(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == (3 * num_core_entries()));
+			evlist->core.nr_entries == (3 * num_core_entries(evlist)));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1465,9 +1474,9 @@ static int test__exclusive_group(struct evlist *evlist)
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == 3 * num_core_entries());
+			evlist->core.nr_entries == 3 * num_core_entries(evlist));
 
-	for (int i = 0; i < num_core_entries(); i++) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
@@ -1538,7 +1547,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			evlist->core.nr_entries == 1 + num_core_entries());
+			evlist->core.nr_entries == 1 + num_core_entries(evlist));
 	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK));
 	return TEST_OK;
 }
@@ -1575,14 +1584,9 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	return test__checkevent_genhw(evlist);
 }
 
-static bool test__pmu_cpu_valid(void)
+static bool test__pmu_default_core_event_valid(void)
 {
-	return !!perf_pmus__find("cpu");
-}
-
-static bool test__pmu_cpu_event_valid(void)
-{
-	struct perf_pmu *pmu = perf_pmus__find("cpu");
+	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
 
 	if (!pmu)
 		return false;
@@ -2161,26 +2165,23 @@ static const struct evlist_test test__events[] = {
 
 static const struct evlist_test test__events_pmu[] = {
 	{
-		.name  = "cpu/config=10,config1=1,config2=3,period=1000/u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/config=10,config1=1,config2=3,period=1000/u",
 		.check = test__checkevent_pmu,
 		/* 0 */
 	},
 	{
-		.name  = "cpu/config=1,name=krava/u,cpu/config=2/u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/config=1,name=krava/u,default_core/config=2/u",
 		.check = test__checkevent_pmu_name,
 		/* 1 */
 	},
 	{
-		.name  = "cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/config=1,call-graph=fp,time,period=100000/,default_core/config=2,call-graph=no,time=0,period=2000/",
 		.check = test__checkevent_pmu_partial_time_callgraph,
 		/* 2 */
 	},
 	{
-		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
-		.valid = test__pmu_cpu_event_valid,
+		.name  = "default_core/name='COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
+		.valid = test__pmu_default_core_event_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
@@ -2195,158 +2196,132 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 5 */
 	},
 	{
-		.name  = "cpu/L1-dcache-load-miss/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/L1-dcache-load-miss/",
 		.check = test__checkevent_genhw,
 		/* 6 */
 	},
 	{
-		.name  = "cpu/L1-dcache-load-miss/kp",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/L1-dcache-load-miss/kp",
 		.check = test__checkevent_genhw_modifier,
 		/* 7 */
 	},
 	{
-		.name  = "cpu/L1-dcache-misses,name=cachepmu/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/L1-dcache-misses,name=cachepmu/",
 		.check = test__checkevent_config_cache,
 		/* 8 */
 	},
 	{
-		.name  = "cpu/instructions/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/",
 		.check = test__checkevent_symbolic_name,
 		/* 9 */
 	},
 	{
-		.name  = "cpu/cycles,period=100000,config2/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles,period=100000,config2/",
 		.check = test__checkevent_symbolic_name_config,
 		/* 0 */
 	},
 	{
-		.name  = "cpu/instructions/h",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/h",
 		.check = test__checkevent_symbolic_name_modifier,
 		/* 1 */
 	},
 	{
-		.name  = "cpu/instructions/G",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/G",
 		.check = test__checkevent_exclude_host_modifier,
 		/* 2 */
 	},
 	{
-		.name  = "cpu/instructions/H",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/H",
 		.check = test__checkevent_exclude_guest_modifier,
 		/* 3 */
 	},
 	{
-		.name  = "{cpu/instructions/k,cpu/cycles/upp}",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/instructions/k,default_core/cycles/upp}",
 		.check = test__group1,
 		/* 4 */
 	},
 	{
-		.name  = "{cpu/cycles/u,cpu/instructions/kp}:p",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/u,default_core/instructions/kp}:p",
 		.check = test__group4,
 		/* 5 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/G}:H",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/G}:H",
 		.check = test__group_gh1,
 		/* 6 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/H}:G",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/H}:G",
 		.check = test__group_gh2,
 		/* 7 */
 	},
 	{
-		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/G,default_core/cache-misses/H}:u",
 		.check = test__group_gh3,
 		/* 8 */
 	},
 	{
-		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:uG",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/G,default_core/cache-misses/H}:uG",
 		.check = test__group_gh4,
 		/* 9 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:S",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/,default_core/branch-misses/}:S",
 		.check = test__leader_sample1,
 		/* 0 */
 	},
 	{
-		.name  = "{cpu/instructions/,cpu/branch-misses/}:Su",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/instructions/,default_core/branch-misses/}:Su",
 		.check = test__leader_sample2,
 		/* 1 */
 	},
 	{
-		.name  = "cpu/instructions/uDp",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/uDp",
 		.check = test__checkevent_pinned_modifier,
 		/* 2 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:D",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/,default_core/branch-misses/}:D",
 		.check = test__pinned_group,
 		/* 3 */
 	},
 	{
-		.name  = "cpu/instructions/I",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/I",
 		.check = test__checkevent_exclude_idle_modifier,
 		/* 4 */
 	},
 	{
-		.name  = "cpu/instructions/kIG",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/kIG",
 		.check = test__checkevent_exclude_idle_modifier_1,
 		/* 5 */
 	},
 	{
-		.name  = "cpu/cycles/u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles/u",
 		.check = test__sym_event_slash,
 		/* 6 */
 	},
 	{
-		.name  = "cpu/cycles/k",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles/k",
 		.check = test__sym_event_dc,
 		/* 7 */
 	},
 	{
-		.name  = "cpu/instructions/uep",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/uep",
 		.check = test__checkevent_exclusive_modifier,
 		/* 8 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:e",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/,default_core/branch-misses/}:e",
 		.check = test__exclusive_group,
 		/* 9 */
 	},
 	{
-		.name  = "cpu/cycles,name=name/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles,name=name/",
 		.check = test__term_equal_term,
 		/* 0 */
 	},
 	{
-		.name  = "cpu/cycles,name=l1d/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles,name=l1d/",
 		.check = test__term_equal_legacy,
 		/* 1 */
 	},
@@ -2436,15 +2411,30 @@ static int combine_test_results(int existing, int latest)
 static int test_events(const struct evlist_test *events, int cnt)
 {
 	int ret = TEST_OK;
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	for (int i = 0; i < cnt; i++) {
-		const struct evlist_test *e = &events[i];
+		struct evlist_test e = events[i];
 		int test_ret;
+		const char *pos = e.name;
+		char buf[1024], *buf_pos = buf, *end;
+
+		while ((end = strstr(pos, "default_core"))) {
+			size_t len = end - pos;
+
+			strncpy(buf_pos, pos, len);
+			pos = end + 12;
+			buf_pos += len;
+			strcpy(buf_pos, core_pmu->name);
+			buf_pos += strlen(core_pmu->name);
+		}
+		strcpy(buf_pos, pos);
 
-		pr_debug("running test %d '%s'\n", i, e->name);
-		test_ret = test_event(e);
+		e.name = buf;
+		pr_debug("running test %d '%s'\n", i, e.name);
+		test_ret = test_event(&e);
 		if (test_ret != TEST_OK) {
-			pr_debug("Event test failure: test %d '%s'", i, e->name);
+			pr_debug("Event test failure: test %d '%s'", i, e.name);
 			ret = combine_test_results(ret, test_ret);
 		}
 	}
-- 
2.51.0.618.g983fd99d29-goog

