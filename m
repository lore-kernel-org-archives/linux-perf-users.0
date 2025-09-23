Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBD31DDBB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666848; cv=none; b=OagUzswQVDf8OFDBEmaFG9LpJWia4Ya83xJ0Xf3XrORCblyzaYeKX3Ieh6H6IHs4hu9TadoS863ypmiZXUJ8qcabryDHIjHSJgLYxZ0uDIbiaxd6qWv++UNIKJjjySekjUgIKFITRZYPzzyWmDsbtUrWE+B3zbtdAScwX9KLmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666848; c=relaxed/simple;
	bh=Hg7n2W3MJbXr4yfAW1QWep8g55Ur5qoksqjE5SLxwwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VozBH0W8lNsaxXEZnkgoe06a39D/aNglTI5DHDtJmw2QxcBm4cvaF+Xe4uDp429hlaKGCEr7W/qeqItUs2B7gToAeTvICr7El0Yd9QnmhUHh3SYEd5GBabrbMrXLlvQDfu5W1EVC1I5ztat9tCJAycoSgzU4w7tGI34t722FB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4z6/omB; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4z6/omB"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-34550533bd1so1055074fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666845; x=1759271645; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyWQosyRoXQiD370+GSPM6BLBnVE6gaC8yLvDCPltkQ=;
        b=K4z6/omBORmB5lUAwkHs8nr2kZ5yH2c5va+uEKxzYaCPZ2z3X+mGI0zdx5mznAwNPk
         vtKmiFfk53oHqOXWmQE52FYzHsIRMlM0SFkMy2Cr5iExMnaPBy3yh3VhVPwhZw7FxU9U
         eAZUDvhwq209MASiiN+2wzF87TVHIeQ+nj8qG4M9D5AzkK0fxf67YXA9MZ6EjYV3ZD1s
         4n3tuSDR/b+ojuynpPOJgWuoTQ99Cp0itEYmdP1kXn6cYGsfmPL8JHW81SmwZ7ko5bOE
         pEqCO9N3n91WLJ6zaDLrtNmqwxiE40nPgpAlpqEW1LZxgaEWDCz5jbGVSmveNvpVPu4G
         Wp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666845; x=1759271645;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyWQosyRoXQiD370+GSPM6BLBnVE6gaC8yLvDCPltkQ=;
        b=d6xls4ly6q/Y5E7jMg7QK5a1v/mby4MbavPaygB4Po8j4kKbm14mu+yjeYjvs+k2tS
         vhFAS1BADVjkcpUawzLEVtsd1jKkATXKg2VNM8kl2Qnj9r+3tiIJ3ksH8vxXZHg3ZsKb
         8YZyFIMCgJCUSAolVyv/Yj6Oezths4mR3ovK9f94M7E2T8Al0WMqjtcFFCla3geKCPGp
         TXH4xI8ZDr08VQRHII14U49oRKQsgAF07u/QHv4/AFNJ+e2gObfULkXwGEL7xHf8PRcj
         ZQ5Yn+y1Jn7bBhc+bQaK8t/qY6KXohjlJF7BPNqMhaRFtydpwAfyOjomBJycWWC3ADK8
         mXFg==
X-Forwarded-Encrypted: i=1; AJvYcCV1ErrwULJ+qjxVHmyeDcVUH3ojY/E0+Or305tMJbVBz9sfxtBtEnpzGJnWCSjSoxzDl1fwYzXBzWil7gcKqGSA@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNDAh9rhUFk1T6lU5uZUE8u269HMiQMpIqzHImuQBdH1WS7Wn
	UWkMkm/edSpLEM5pgE8lMkMBeljhKMV6Oer1TahYpx8VNaR8o6iN1QJOKx1muZmNOY9UVwxOnMq
	eiW+8jlSn4g==
X-Google-Smtp-Source: AGHT+IEOFTeTWfpE428BTSTuXTO+cfNig+FsqxDm9y1ZeU/ZRquxlNKecZEG8XtX4QBC6EFuHojYS49v2Pd1
X-Received: from oabhp17.prod.google.com ([2002:a05:6870:9a91:b0:34a:7a4c:d100])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:330d:b0:31d:8b8b:27d7
 with SMTP id 586e51a60fabf-34c7a3cd842mr2578039fac.20.1758666844743; Tue, 23
 Sep 2025 15:34:04 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:08 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-25-irogers@google.com>
Subject: [PATCH v6 24/28] perf test parse-events: Remove cpu PMU requirement
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
index 32981a1e4042..0fb338bf2848 100644
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
@@ -2108,26 +2112,23 @@ static const struct evlist_test test__events[] = {
 
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
@@ -2142,158 +2143,132 @@ static const struct evlist_test test__events_pmu[] = {
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
@@ -2383,15 +2358,30 @@ static int combine_test_results(int existing, int latest)
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
2.51.0.534.gc79095c0ca-goog

