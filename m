Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9931D39A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666845; cv=none; b=Ajl8Bq8vsk6F87xcmvdDMxV3sJHNIAvkf1cbQz9VA+3+qSkUyxdfOdGNJfX6uT42FXk7gfvf0mLM8jm7d1r0ufuHNQlxvRIU4xJ9szMUwfVhdjLgiofneQwALDEDPTsQ7Iu2JyaQwp/9FPjfmEPdRiGuyl0NVwS2tnCJnhxQFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666845; c=relaxed/simple;
	bh=tiWZCYYxARhFlflX9gneYHYq1ndN45QYaRl9OxqYSss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hIxoZumkyA9EGQ13u+mUlAm2PLKgBhE7XN7+i5NxLR8bqRlyxE5k0owSbmSgaM+tk98KF6HumL72te8rfxGpQOxCw24GpnkOhot5+BZ6ZlH1zv8zRiYYg981sCToD7gTMtccLY8HIfMGMaJuUNtsOYloJwvTM+Mvk1rhQFr6Vno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6O5bavI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6O5bavI"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33274f8ff7cso3957741a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666843; x=1759271643; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAJoI+cyj2/WQZx/UQN66Kq9JhNBF6jZceW/gXQediQ=;
        b=V6O5bavIn/ONew0nb9ChhX0akcDWR5oGYWc2urzg6UAoSOeScAEk9KdPvr+oy1zvbE
         gVlgtOW/nyEV3Bm+3Xl2iMjSM+6q5y+YQEx4r/pG8FkYooup+84xJsN2fdFIWNnm1bI3
         8WHq+qkqYOQDmR7teTQkLa6ErqtpuHxiow0RdNxdEKB4b2roebPgWi31colqJa7gN2co
         CTEzkD3kyOEpIRf3b7q8NCSpkG5x+pKunccwadwLWkll8qLkLdDCtF2J0x0IN5ezPK8Z
         ytkt6udC1IieMi+fAEK6C+oC9mb+rF5fqWqbDXwpzXnM2J73WeLr9GWjlX+IA2KcNClN
         FGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666843; x=1759271643;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAJoI+cyj2/WQZx/UQN66Kq9JhNBF6jZceW/gXQediQ=;
        b=NCIxc3Jj4zccMr3OdX+uxzYkaYMHpkvsljca+sTRRJEo5qIBMnHLpdPc3zyxl08Btu
         QoIu1uhIhQ7jlLNVGnIMOqtjggCW/H8qlVrTfkcKPYPM9dScVZcBWaVOY/xIHdmYBs54
         EghNnQaIG/mczC1zOrdX2sYuptMbNd55ZhXX0L2aajadl8jxyrostJIuP/ISeI9YvnLu
         vXidjZVJvDvtzBq/25kshbMH/Dq5RasbGF4wRezJR6Uo4r34EvI33fxfHgRtdNYQh32P
         UspfDnMzqUv2pfMcgbBsOtmaEMxsTbvM6rJ5mNDh99AGqUuLqgQmz8YSchmkC1mcH88C
         BeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFOH+WhYtLNHkWOkVdGvlLMFGz1aMxCgJHEtXOIKQiy1SMMGB2uxlq+uQncWgrcvLkaJVYCLtvR2LrPiAB7fyF@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbNNwBZv+TRQQ6J92+TT1umZsNhRlEq5kWAHo/7wp+slARF+o
	NMBl5ppGnWPCF8tug/xKtmKOrTcb9qU1eew+E7ctUflaBkbIu9N5CiWgSvd2sIa8Se2ph/kLZMO
	P5NRf/rxeeg==
X-Google-Smtp-Source: AGHT+IGW2+etZYDdjrmmVI9zDIVzK4Ak2FxXUmMiPP/1sV7xNBhsKnRImqMfzxq0a83LUqEMjCQoJUossTvX
X-Received: from pjbta8.prod.google.com ([2002:a17:90b:4ec8:b0:330:6513:c709])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c8:b0:32d:f4cb:7486
 with SMTP id 98e67ed59e1d1-332a95e8e19mr4862342a91.19.1758666842731; Tue, 23
 Sep 2025 15:34:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:07 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-24-irogers@google.com>
Subject: [PATCH v6 23/28] perf test parse-events: Without a PMU use cpu-cycles
 rather than cycles
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
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
index d0f1e05139ac..32981a1e4042 100644
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
@@ -1604,7 +1609,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong complex name parsing",
 			evsel__name_is(evsel,
-				       "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks"));
+				       "COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks"));
 	return TEST_OK;
 }
 
@@ -1741,7 +1746,7 @@ static const struct evlist_test test__events[] = {
 		/* 4 */
 	},
 	{
-		.name  = "cycles/period=100000,config2/",
+		.name  = "cpu-cycles/period=100000,config2/",
 		.check = test__checkevent_symbolic_name_config,
 		/* 5 */
 	},
@@ -1856,27 +1861,27 @@ static const struct evlist_test test__events[] = {
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
@@ -1886,27 +1891,27 @@ static const struct evlist_test test__events[] = {
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
@@ -1921,7 +1926,7 @@ static const struct evlist_test test__events[] = {
 		/* 0 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:D",
+		.name  = "{cpu-cycles,cache-misses,branch-misses}:D",
 		.check = test__pinned_group,
 		/* 1 */
 	},
@@ -1959,7 +1964,7 @@ static const struct evlist_test test__events[] = {
 		/* 6 */
 	},
 	{
-		.name  = "task-clock:P,cycles",
+		.name  = "task-clock:P,cpu-cycles",
 		.check = test__checkevent_precise_max_modifier,
 		/* 7 */
 	},
@@ -1990,17 +1995,17 @@ static const struct evlist_test test__events[] = {
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
@@ -2010,17 +2015,17 @@ static const struct evlist_test test__events[] = {
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
@@ -2121,7 +2126,7 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 2 */
 	},
 	{
-		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
+		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.valid = test__pmu_cpu_event_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
-- 
2.51.0.534.gc79095c0ca-goog

