Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42368299AAA
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688724; cv=none; b=cs6ZzpmsDw/WO4KxL0T7xkmmDXCA7iK++lOKR+NcIOL4s3A3a5LLb9VM91YkKsVjsc/hB5llLx0GDhYiDpN2RM6dfYGdty+e7iL0k4i0qxjPTzAMyUn5gaV477L8VG945oBBW8BEOlQsbA+4dCaw2zQHo5RyD7OUZuSBfwSvqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688724; c=relaxed/simple;
	bh=qMjIbwYMAuOeeb3lZC984a5F6vCSE2V08joJ6sCxp7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QlALkXGUNT/bQqbhMSSZ+ql5cFMABZOa1F21b2wEXC61ioUWHNScqM6mSve3kBKAXdMTzecrKA6UAojQSL9CEwzekQ1cmVyD5iDuIM66s/4U35rRQcfFV0SBrAERbuSCdq3OttTm2xUC91BST6SbLvMjgZFPFem1ZCxSVZ7krnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkdnQv6e; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkdnQv6e"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee214108cso92234825ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688722; x=1760293522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJhsW1hGYJW72QWRZReISG89bcn0FqU0RmaVC7Uf79w=;
        b=XkdnQv6ejHnwjn2P7jTsjmkGkNFkjEsHhh1m/a6l6RZHLssHi/kiBIc8RiXYUYWNwP
         dWp0t5puKyltD/v5ghCdmn2vXdL9PuTCIgIzO/zyVcvRFFMiYunIAxqmOCKqSQxH0bHK
         k8VHwYqVMiesg8pQxM0qwJXDGmIhkcQHr0rCdSHZXJsFb3E6Cy3fpFnwh5vBDoMRw1+R
         bCDAdkR1oG6dGeZaL74OKJd4f6xBoNn9p4i58Ztajjlge640Sfw2bwfvPIkdR9pYcPnQ
         UUYW73H2ppcsuaIugpmaVUEY/qpFar2pD+JoVcpxQJPQ5QfCmAAtvq/fNMBhUio7lvKa
         tkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688722; x=1760293522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJhsW1hGYJW72QWRZReISG89bcn0FqU0RmaVC7Uf79w=;
        b=lhpd5j9uxTw4dc0qF3N3lETI+YKOJXOnvK086Of5yfoB3T1oeUtdQ8fn2WlZ2Mstx7
         guymPyN/LRQDQ8rxxr1tkEWmPhT8NBFJPE/1SUeGLAyY6r5Qtl+Cx+EEY1bZ9nyBkUJ4
         hU4yAIRZIo4tZyffHpA/8J/8A5hrlg7yML6BN97hVLJjj3F2qHBqEfmqc9JjVJZG3i0q
         GsFTb9eSkzMOKO1+3J82QiwexE4nzjgTpYL8f223T7ee55Tk6jjh8HuoPdte0GraHLcd
         ANJFH+5wCoaclgxA4xPDyPuAqZ44RbTfZoUJV6RoIM+Zq1LOIBHjcHtX5nWbh9pGbjJf
         zrvA==
X-Forwarded-Encrypted: i=1; AJvYcCUnmcwEcDGjHm3bKs6t5SVyBI3+YqfEtJEVNKkWmKFCNynpp8ncZa1g9s9jpJ32Cvvfahs1+eqY4+vfPsnuZU30@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFVQwAoDWegk6OD/5TnEP41WWERj9cd1buNGHTSMJewx96kSr
	ORV+VfUAld5tH92m9mnVhWH/dmcEyyN+hcTkTWF+aO0Mg40EtL95J5V4CtO0Fbs0LaTDfur34Uj
	0PRxizgkVAw==
X-Google-Smtp-Source: AGHT+IGmD2E2S0sufuWwBotiMffQlv0OpCpHb4j0ySHRaSIu/JATasNHLEWkm3pwMUXOyJTNQByKnp3Fa6lE
X-Received: from plbbj2.prod.google.com ([2002:a17:902:8502:b0:28e:807f:b050])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244a:b0:25d:37fc:32df
 with SMTP id d9443c01a7336-28e9a6be280mr137674515ad.47.1759688721729; Sun, 05
 Oct 2025 11:25:21 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:25 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-23-irogers@google.com>
Subject: [PATCH v7 22/27] perf test parse-events: Without a PMU use cpu-cycles
 rather than cycles
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

Without a PMU perf matches an event against any PMU with the
event. Unfortunately some PMU drivers advertise a "cycles" event which
is typically just a core event. Switch to using "cpu-cycles" which is
an indentical legacy event but avoids the multiple PMU confusion
introduced by the PMU drivers. Note, on x86 cpu-cycles is also a sysfs
event but cycles isn't.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 61 ++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index f6cd994f75cf..23f3e265e2a1 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -585,9 +585,10 @@ static int test__checkevent_pmu(struct evlist *evlist)
 {
 
 	struct evsel *evsel = evlist__first(evlist);
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",    test_config(evsel, 10));
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
@@ -646,17 +647,18 @@ static int test__checkevent_list(struct evlist *evlist)
 static int test__checkevent_pmu_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	/* cpu/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=2/u"));
 
@@ -666,10 +668,11 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
@@ -681,7 +684,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
@@ -697,12 +700,14 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 static int test__checkevent_pmu_events(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 <= evlist->core.nr_entries);
 
 	evlist__for_each_entry(evlist, evsel) {
-		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
-					      strcmp(evsel->pmu->name, "cpu"));
+		TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type ||
+				!strncmp(evsel__name(evsel), evsel->pmu->name,
+					 strlen(evsel->pmu->name)));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1650,7 +1655,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong complex name parsing",
 			evsel__name_is(evsel,
-				       "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks"));
+				       "COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks"));
 	return TEST_OK;
 }
 
@@ -1787,7 +1792,7 @@ static const struct evlist_test test__events[] = {
 		/* 4 */
 	},
 	{
-		.name  = "cycles/period=100000,config2/",
+		.name  = "cpu-cycles/period=100000,config2/",
 		.check = test__checkevent_symbolic_name_config,
 		/* 5 */
 	},
@@ -1902,27 +1907,27 @@ static const struct evlist_test test__events[] = {
 		/* 7 */
 	},
 	{
-		.name  = "{instructions:k,cycles:upp}",
+		.name  = "{instructions:k,cpu-cycles:upp}",
 		.check = test__group1,
 		/* 8 */
 	},
 	{
-		.name  = "{faults:k,branches}:u,cycles:k",
+		.name  = "{faults:k,branches}:u,cpu-cycles:k",
 		.check = test__group2,
 		/* 9 */
 	},
 	{
-		.name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
+		.name  = "group1{syscalls:sys_enter_openat:H,cpu-cycles:kppp},group2{cpu-cycles,1:3}:G,instructions:u",
 		.check = test__group3,
 		/* 0 */
 	},
 	{
-		.name  = "{cycles:u,instructions:kp}:p",
+		.name  = "{cpu-cycles:u,instructions:kp}:p",
 		.check = test__group4,
 		/* 1 */
 	},
 	{
-		.name  = "{cycles,instructions}:G,{cycles:G,instructions:G},cycles",
+		.name  = "{cpu-cycles,instructions}:G,{cpu-cycles:G,instructions:G},cpu-cycles",
 		.check = test__group5,
 		/* 2 */
 	},
@@ -1932,27 +1937,27 @@ static const struct evlist_test test__events[] = {
 		/* 3 */
 	},
 	{
-		.name  = "{cycles,cache-misses:G}:H",
+		.name  = "{cpu-cycles,cache-misses:G}:H",
 		.check = test__group_gh1,
 		/* 4 */
 	},
 	{
-		.name  = "{cycles,cache-misses:H}:G",
+		.name  = "{cpu-cycles,cache-misses:H}:G",
 		.check = test__group_gh2,
 		/* 5 */
 	},
 	{
-		.name  = "{cycles:G,cache-misses:H}:u",
+		.name  = "{cpu-cycles:G,cache-misses:H}:u",
 		.check = test__group_gh3,
 		/* 6 */
 	},
 	{
-		.name  = "{cycles:G,cache-misses:H}:uG",
+		.name  = "{cpu-cycles:G,cache-misses:H}:uG",
 		.check = test__group_gh4,
 		/* 7 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:S",
+		.name  = "{cpu-cycles,cache-misses,branch-misses}:S",
 		.check = test__leader_sample1,
 		/* 8 */
 	},
@@ -1967,7 +1972,7 @@ static const struct evlist_test test__events[] = {
 		/* 0 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:D",
+		.name  = "{cpu-cycles,cache-misses,branch-misses}:D",
 		.check = test__pinned_group,
 		/* 1 */
 	},
@@ -2005,7 +2010,7 @@ static const struct evlist_test test__events[] = {
 		/* 6 */
 	},
 	{
-		.name  = "task-clock:P,cycles",
+		.name  = "task-clock:P,cpu-cycles",
 		.check = test__checkevent_precise_max_modifier,
 		/* 7 */
 	},
@@ -2036,17 +2041,17 @@ static const struct evlist_test test__events[] = {
 		/* 2 */
 	},
 	{
-		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
+		.name  = "cpu-cycles/name='COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks'/Duk",
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
 	{
-		.name  = "cycles//u",
+		.name  = "cpu-cycles//u",
 		.check = test__sym_event_slash,
 		/* 4 */
 	},
 	{
-		.name  = "cycles:k",
+		.name  = "cpu-cycles:k",
 		.check = test__sym_event_dc,
 		/* 5 */
 	},
@@ -2056,17 +2061,17 @@ static const struct evlist_test test__events[] = {
 		/* 6 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:e",
+		.name  = "{cpu-cycles,cache-misses,branch-misses}:e",
 		.check = test__exclusive_group,
 		/* 7 */
 	},
 	{
-		.name  = "cycles/name=name/",
+		.name  = "cpu-cycles/name=name/",
 		.check = test__term_equal_term,
 		/* 8 */
 	},
 	{
-		.name  = "cycles/name=l1d/",
+		.name  = "cpu-cycles/name=l1d/",
 		.check = test__term_equal_legacy,
 		/* 9 */
 	},
@@ -2174,7 +2179,7 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 2 */
 	},
 	{
-		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
+		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.valid = test__pmu_cpu_event_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
-- 
2.51.0.618.g983fd99d29-goog

