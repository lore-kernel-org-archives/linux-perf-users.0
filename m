Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6682BD5AF
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688723; cv=none; b=A/crfz3q761KWKWmH+7ERDy0wwLKbdGRrN9MxKY3E7SZzsTEXLiBsRtadL+eNWZDKWIRd9IboLcWB+wZQ9OkURv0TzuEuxQXcBAV5YzaHTdALLFccvbREEO0YYolmm+Ml5Y1kRoIAXGxHktgIkNxW4yTnOcADetycwmvscLGFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688723; c=relaxed/simple;
	bh=owA6Dul8xuC7liXoWhhYtUEG1P4QsUcK4S5KKArIyR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lIhqjjscueSF2FaBwUwTz4xQ0LBQp1R78hlazjPpyGO3FEamVrsP7KlCN75yByhuN69SVfBZPc4BeWMnQLPuRiXdL6yy5shOFPXSbGpCKkSgnzquyW7dS5ycB7XkZAsA9ya6F+tHSFsCQ2GsnkQG5OQGbc28SWtRJRfnHEoPgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkZh2peW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkZh2peW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eeb9730d9so43040425ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688720; x=1760293520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7qNK5iIDpNPKKxVeNdUCEZsA+mwQ+oJdAT5gU/Wb8E=;
        b=PkZh2peW2uy5FQV84zrJesazGeNKfEjB4DRWzAzWF2rqdqx47R2Np46wpLzuAhovqb
         Cmj2Safp/RD8rjPAARw3CF1Ti2TxbQD+6ElZFQ4gOAX7OzUsUKzAwXgOBE3NbmZI0gj3
         HLYqO08dQCTe2gQGKpAolGK172Ru2YRN0DFG1jStaKddGZkIIo4+UGbI2lYr3g2jvUOQ
         dZrTX/5dP0n5fEBydzkBQlsLJhERs9faKh4zl3g0NrYMrqfEnvVrsjS+yY7QAqI24pF5
         uf5ImYPvZnLNWFhsvaoQMtYuDzGDvP9XzkUrGfF+Yph7L3nezeu2A2gXEtUtvWoitpbv
         dC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688720; x=1760293520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7qNK5iIDpNPKKxVeNdUCEZsA+mwQ+oJdAT5gU/Wb8E=;
        b=bRTsq+rYf0BxVIPJUZei+MvrwRQLyYTzVWCuRQvi5gXWWtO91nCx6hf7c1WlNOwtsg
         CVW17kS3NmeKmIJR9P+6ROTgVuLeqMVq8Osp0s8ep+0jdfJxqDOmsYz6qNjaksTgUpzS
         bJJzs0c6y+RUvcWtWsEbW3sJQpHrN5NritskaJluNVkl2IZSODlJa/o+8K4sILuaKuGX
         k2bWGq6ImceZ7mdIuJFk04UWX0ogHJVVA/BvNw1d7NRut0n/z5giJYDilKAGgcGSVOUh
         uj3RKGZlTgA3C2K4tKt5OeEWsVsDEkaXXcOSc06Th1vHYuYa8ZWL4JKIn7aykcph/Kz6
         RwMg==
X-Forwarded-Encrypted: i=1; AJvYcCXRm4V4DiEvwYtEf8TZg+O++Ki5oRAK/bsTX/Vm/VYbwV1ljGsw2Ln2ZLr7eGKjgpmE5fsIcu/JQEZ+q3v7o2NW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiyf3ktrKIG+ukdzNUxra8WSZKPEe3LqFzL0KTCAFNKARSIBu4
	HzKAL8gDlnpFH8K1pIaOvFBaQVWO/Ief3tZdjwebUQiy3i3GXVvkihLP1XTwCOQFeEx8A6WHDYa
	Tl28jdERnxA==
X-Google-Smtp-Source: AGHT+IG3KGj1URQ3+t4KcGrErnRLkbLPAiEbVPHcN8t7u0pQskOL7LpOgK6xBFzk3xlTrSWNryj81hlzW3OV
X-Received: from plblw4.prod.google.com ([2002:a17:903:2ac4:b0:248:7db1:3800])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f8b:b0:26b:5346:5857
 with SMTP id d9443c01a7336-28e9a5a8788mr123575145ad.24.1759688719756; Sun, 05
 Oct 2025 11:25:19 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:24 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-22-irogers@google.com>
Subject: [PATCH v7 21/27] perf test parse-events: Use evsel__match for legacy events
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

Switch from the test's assert_hw/test_config to the common
evsel__match code that appropriately handles events with both legacy
and sysfs/json encoding.

For tests asserting that a config value matches that placed in the
perf_event_attr just directly compare the config values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 299 ++++++++------------------------
 1 file changed, 74 insertions(+), 225 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 13c1e4c45ea2..f6cd994f75cf 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -155,60 +155,38 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	return TEST_OK;
 }
 
 
-static int assert_hw(struct perf_evsel *evsel, enum perf_hw_id id, const char *name)
-{
-	struct perf_pmu *pmu;
-
-	if (evsel->attr.type == PERF_TYPE_HARDWARE) {
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, id));
-		return 0;
-	}
-	pmu = perf_pmus__find_by_type(evsel->attr.type);
-
-	TEST_ASSERT_VAL("unexpected PMU type", pmu);
-	TEST_ASSERT_VAL("PMU missing event", perf_pmu__have_event(pmu, name));
-	return 0;
-}
-
 static int test__checkevent_symbolic_name(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
-	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		int ret = assert_hw(evsel, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-
-		if (ret)
-			return ret;
-	}
+	evlist__for_each_entry(evlist, evsel)
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 
 	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
-	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		int ret = assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-		if (ret)
-			return ret;
+	evlist__for_each_entry(evlist, evsel) {
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		/*
 		 * The period value gets configured within evlist__config,
 		 * while this test executes only parse events method.
 		 */
-		TEST_ASSERT_VAL("wrong period", 0 == evsel->attr.sample_period);
-		TEST_ASSERT_VAL("wrong config1", 0 == evsel->attr.config1);
-		TEST_ASSERT_VAL("wrong config2", 1 == evsel->attr.config2);
+		TEST_ASSERT_VAL("wrong period", 0 == evsel->core.attr.sample_period);
+		TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
+		TEST_ASSERT_VAL("wrong config2", 1 == evsel->core.attr.config2);
 	}
 	return TEST_OK;
 }
@@ -218,8 +196,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
+	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS));
 	return TEST_OK;
 }
 
@@ -242,7 +219,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
@@ -256,7 +233,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", default_breakpoint_len() == evsel->core.attr.bp_len);
@@ -270,7 +247,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -285,7 +262,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -300,7 +277,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type",
 		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -633,7 +610,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	/* r1 */
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT != evsel->core.attr.type);
 	while (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
-		TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+		TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 		TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
 		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
 		TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
@@ -657,7 +634,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	/* 1:1:hp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -673,14 +650,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	/* cpu/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
+	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=2/u"));
 
 	return TEST_OK;
@@ -693,7 +670,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -705,7 +682,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
+	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -855,7 +832,7 @@ static int test__checkterms_simple(struct parse_events_terms *terms)
 
 static int test__group1(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (num_core_entries() * 2));
@@ -863,14 +840,9 @@ static int test__group1(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* instructions:k */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -884,10 +856,7 @@ static int test__group1(struct evlist *evlist)
 
 		/* cycles:upp */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -914,13 +883,9 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	evlist__for_each_entry(evlist, evsel) {
-		int ret;
-
-		if (evsel->core.attr.type == PERF_TYPE_SOFTWARE) {
+		if (evsel__match(evsel, SOFTWARE, SW_PAGE_FAULTS)) {
 			/* faults + :ku modifier */
 			leader = evsel;
-			TEST_ASSERT_VAL("wrong config",
-					test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -933,8 +898,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 			continue;
 		}
-		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS)) {
+		if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS)) {
 			/* branches + :u modifier */
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -948,10 +912,7 @@ static int test__group2(struct evlist *evlist)
 			continue;
 		}
 		/* cycles:k */
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -967,7 +928,6 @@ static int test__group2(struct evlist *evlist)
 static int test__group3(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *group1_leader = NULL, *group2_leader = NULL;
-	int ret;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus() + 2));
@@ -998,8 +958,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 			continue;
 		}
-		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_CPU_CYCLES)) {
+		if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 			if (evsel->core.attr.exclude_user) {
 				/* group1 cycles:kppp */
 				TEST_ASSERT_VAL("wrong exclude_user",
@@ -1042,7 +1001,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		}
 		if (evsel->core.attr.type == 1) {
 			/* group2 1:3 + G modifier */
-			TEST_ASSERT_VAL("wrong config", test_config(evsel, 3));
+			TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1055,10 +1014,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 			continue;
 		}
 		/* instructions:u */
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1073,7 +1029,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 
 static int test__group4(struct evlist *evlist __maybe_unused)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (num_core_entries() * 2));
@@ -1081,14 +1037,9 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 			num_core_entries() == evlist__nr_groups(evlist));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles:u + p */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1103,10 +1054,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 
 		/* instructions:kp + p */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1123,7 +1071,6 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 static int test__group5(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel = NULL, *leader;
-	int ret;
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == (5 * num_core_entries()));
@@ -1133,10 +1080,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles + G */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1151,10 +1095,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 
 		/* instructions + G */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1168,10 +1109,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles:G */
 		evsel = leader = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1186,10 +1124,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 
 		/* instructions:G */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1202,10 +1137,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	for (int i = 0; i < num_core_entries(); i++) {
 		/* cycles */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1227,14 +1159,9 @@ static int test__group_gh1(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles + :H group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1248,10 +1175,7 @@ static int test__group_gh1(struct evlist *evlist)
 
 		/* cache-misses:G + :H group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1274,14 +1198,9 @@ static int test__group_gh2(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles + :G group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1295,10 +1214,7 @@ static int test__group_gh2(struct evlist *evlist)
 
 		/* cache-misses:H + :G group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1321,14 +1237,9 @@ static int test__group_gh3(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles:G + :u group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1342,10 +1253,7 @@ static int test__group_gh3(struct evlist *evlist)
 
 		/* cache-misses:H + :u group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1368,14 +1276,9 @@ static int test__group_gh4(struct evlist *evlist)
 			evlist__nr_groups(evlist) == num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles:G + :uG group modifier */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1389,10 +1292,7 @@ static int test__group_gh4(struct evlist *evlist)
 
 		/* cache-misses:H + :uG group modifier */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1413,14 +1313,9 @@ static int test__leader_sample1(struct evlist *evlist)
 			evlist->core.nr_entries == (3 * num_core_entries()));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1433,10 +1328,7 @@ static int test__leader_sample1(struct evlist *evlist)
 
 		/* cache-misses - not sampling */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1448,10 +1340,8 @@ static int test__leader_sample1(struct evlist *evlist)
 
 		/* branch-misses - not sampling */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1473,14 +1363,9 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 			evlist->core.nr_entries == (2 * num_core_entries()));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* instructions - sampling group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1493,10 +1378,8 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 
 		/* branch-misses - not sampling */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1536,14 +1419,9 @@ static int test__pinned_group(struct evlist *evlist)
 			evlist->core.nr_entries == (3 * num_core_entries()));
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 		/* TODO: The group modifier is not copied to the split group leader. */
@@ -1552,18 +1430,13 @@ static int test__pinned_group(struct evlist *evlist)
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 		/* branch-misses - ditto */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 	}
 	return TEST_OK;
@@ -1590,14 +1463,9 @@ static int test__exclusive_group(struct evlist *evlist)
 			evlist->core.nr_entries == 3 * num_core_entries());
 
 	for (int i = 0; i < num_core_entries(); i++) {
-		int ret;
-
 		/* cycles - group leader */
 		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 		/* TODO: The group modifier is not copied to the split group leader. */
@@ -1606,18 +1474,13 @@ static int test__exclusive_group(struct evlist *evlist)
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_CACHE_MISSES, "cache-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CACHE_MISSES));
 		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
 		/* branch-misses - ditto */
 		evsel = evsel__next(evsel);
-		ret = assert_hw(&evsel->core, PERF_COUNT_HW_BRANCH_MISSES, "branch-misses");
-		if (ret)
-			return ret;
-
+		TEST_ASSERT_VAL("unexpected event",
+				evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES));
 		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 	}
 	return TEST_OK;
@@ -1628,7 +1491,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
@@ -1643,7 +1506,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
+	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
@@ -1671,8 +1534,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries",
 			evlist->core.nr_entries == 1 + num_core_entries());
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_TASK_CLOCK));
+	TEST_ASSERT_VAL("wrong type/config", evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK));
 	return TEST_OK;
 }
 
@@ -1751,7 +1613,6 @@ static bool test__acr_valid(void)
 static int test__ratio_to_prev(struct evlist *evlist)
 {
 	struct evsel *evsel;
-	int ret;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_core_pmus() == evlist->core.nr_entries);
 
@@ -1764,16 +1625,16 @@ static int test__ratio_to_prev(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-			ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+			TEST_ASSERT_VAL("unexpected event",
+					evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 		} else {
 			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
 			TEST_ASSERT_VAL("wrong leader", !evsel__is_group_leader(evsel));
 			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 0);
 			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-			ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
+			TEST_ASSERT_VAL("unexpected event",
+					evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS));
 		}
-		if (ret)
-			return ret;
 		/*
 		 * The period value gets configured within evlist__config,
 		 * while this test executes only parse events method.
@@ -1799,18 +1660,15 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
 	return TEST_OK;
 }
 
 static int test__sym_event_slash(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	return TEST_OK;
 }
@@ -1818,11 +1676,8 @@ static int test__sym_event_slash(struct evlist *evlist)
 static int test__sym_event_dc(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	return TEST_OK;
 }
@@ -1830,11 +1685,8 @@ static int test__sym_event_dc(struct evlist *evlist)
 static int test__term_equal_term(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
 	return TEST_OK;
 }
@@ -1842,11 +1694,8 @@ static int test__term_equal_term(struct evlist *evlist)
 static int test__term_equal_legacy(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
-	int ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
-
-	if (ret)
-		return ret;
 
+	TEST_ASSERT_VAL("unexpected event", evsel__match(evsel, HARDWARE, HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") == 0);
 	return TEST_OK;
 }
-- 
2.51.0.618.g983fd99d29-goog

