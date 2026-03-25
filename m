Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B77330B10
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463466; cv=none; b=ulbqZ0kTIT1E7veDcuPk5LpRlKKUM9HhlCMm1EsMIHEXl0Wr1oTFu2LTxueY3h76q+g5SSNXj3fcXs3eGRsiJPbC+CQ08r2nTghcwkFyE8uyjHo8lo6AQHedA0k8+z77W9fFiQTQ4Nq5XRR2Dc6QmVXneN/aodIggbISHzOyMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463466; c=relaxed/simple;
	bh=RxLyGj0p40q7qMnq7YnB2EZn0Eju2U32g7F/XeWxLKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Xks70DN+ZB3t29t0AmJ+Ume7Fi7xuM9jRB7Vz+uqO/mJ5rZmvO1z9Z4SWH0t/8e40dvevYTexgh7TM4UqYtJ7FfiHBx6XXqKOgKnjvHPB22M7JGnS0QDQCDN0s4DJEsHqopV3CJ1UYfYHWyulKgi5UAN6r0sIiCcBGfkJc03HRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jR6Bp4Hx; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jR6Bp4Hx"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0bddb9196so102025eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774463464; x=1775068264; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8qJxJ/GHSQvGo2ujlSRyJ41ufgIK9jW7P1k0RAfVag=;
        b=jR6Bp4HxpZrYIOVU4mtmUffACdDE7/jBsWiYwfbJUKlUL6cfA4PnxqP8pe8jMZnMdM
         CzUHZLOoXK/+0ZppiaCcOy1xxmdMx8anGUsqSHzWN68d2i+vFZ3AMZ0NAZ9eLTdkzqxU
         G/LeP3DwuX6WI7gKn6bKaZffuEgtVZF+liEQAr8SMz80j6u7+uecpqcy9EHaWv17Ynkx
         VHuRmv+94lRiWHwObMduZXy1k6j6F7UZkHdL1Pn9Sv0I47IrMP2l8nlQRzpm/DilmTnK
         c2ZKmKPGCiUukMI0aWVP26RQfA3+vBYaJuBoq5Rk3LJZFbCOljrihD2kFBYVPVdgZ/wi
         4wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463464; x=1775068264;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8qJxJ/GHSQvGo2ujlSRyJ41ufgIK9jW7P1k0RAfVag=;
        b=NLlJ1VWzScRwUuFoe5AU9zqFjS66UEbhSps5zH07kAGGSpK0c5MTLYk+MEbcDf65Ib
         b8PWW9aL4CB9y7Ak88nzewbmNG5EznQKtCFcpKebmb68MbxOEsreHwDxJ/AXIBV+9JDQ
         Gs1LnR9zw5/iJUcFH89855wihO7A1VD2qPSXOyuqVw3AIjNyiDT7Qc4/vS5LUxYBX0Og
         Wlg8fbgkBUlX2iCrrOlIIFr/VsukxLJohxRW8wiy+f3JHMwHEuYMDdU8MNvd9klF6v1c
         tSoI4sTgkirkqTe8D7LRD/qdNCTsMfqaKR6i6ZubJj53UFXNEkSbo+O1/iqit5TWIIQR
         1mJg==
X-Forwarded-Encrypted: i=1; AJvYcCUVAQqlBgp03MeIakfYKDNoAwLlPHiSvZmf36TFenpNN78o8IxzKSGXBdVi+T+sUHZrKWk0eQH40R8yvJPwYthT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5cCzA7H+LGPK/n9BHHfqhJL3WfdRoOPvLpS4oFlH0W+B1AKa
	/Yqeyq07c6QsZC/rOWnV6zHLWv1oaINFaz/sGV4mTK0kFKHnvYOXfYuFU+GF9pbuKuLTvio6uJm
	UdeyqgeKuvQ==
X-Received: from dyz3.prod.google.com ([2002:a05:693c:4083:b0:2c0:ff82:5859])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:b505:b0:2ba:a60a:15e6
 with SMTP id 5a478bee46e88-2c15d3db165mr2395259eec.16.1774463463485; Wed, 25
 Mar 2026 11:31:03 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:30:45 -0700
In-Reply-To: <20260325183045.1229502-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325183045.1229502-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325183045.1229502-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf arch x86 tests: Add test for topdown event sorting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, German Gomez <german.gomez@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test to capture the comment in
tools/perf/arch/x86/util/evlist.c. Test that slots and
topdown-retiring get appropriately sorted with respect to instructions
when they're all specified together. When the PMU requires topdown
event grouping (indicated by the pressence of the slots event) metric
events should be after slots, which should be the group leader.

Add a related test that when the slots event isn't given it is
injected into the appropriate group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/topdown.c | 137 +++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 3ee4e5e71be3..aca7faa16fc7 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -75,4 +75,139 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
-DEFINE_SUITE("x86 topdown", x86_topdown);
+static int test_sort(const char *str, int expected_slots_group_size,
+		     int expected_instructions_group_size)
+{
+	struct evlist *evlist;
+	struct parse_events_error err;
+	struct evsel *evsel;
+	int ret;
+
+	evlist = evlist__new();
+	if (!evlist)
+		return TEST_FAIL;
+
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	if (ret) {
+		pr_debug("parse_events failed for %s\n", str);
+		goto out_err;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_group_leader(evsel)) {
+			if (strstr(evsel->name, "slots")) {
+				/*
+				 * Slots as a leader means the PMU is for a perf
+				 * metric group as the slots event isn't present
+				 * when not.
+				 */
+				TEST_ASSERT_EQUAL("slots group size", evsel->core.nr_members,
+						  expected_slots_group_size);
+				if (expected_slots_group_size == 3) {
+					struct evsel *next = evsel__next(evsel);
+					struct evsel *next2 = evsel__next(next);
+
+					TEST_ASSERT_VAL("slots second event is instructions",
+							strstr(next->name, "instructions")
+							!= NULL);
+					TEST_ASSERT_VAL("slots third event is topdown-retiring",
+							strstr(next2->name, "topdown-retiring")
+							!= NULL);
+				} else if (expected_slots_group_size == 2) {
+					struct evsel *next = evsel__next(evsel);
+
+					TEST_ASSERT_VAL("slots second event is topdown-retiring",
+							strstr(next->name, "topdown-retiring")
+							!= NULL);
+				}
+			} else if (strstr(evsel->name, "instructions")) {
+				TEST_ASSERT_EQUAL("instructions group size", evsel->core.nr_members,
+						  expected_instructions_group_size);
+				if (expected_instructions_group_size == 2) {
+					/*
+					 * The instructions event leads a group
+					 * with a topdown-retiring event,
+					 * neither of which need reordering for
+					 * perf metric event support.
+					 */
+					struct evsel *next = evsel__next(evsel);
+
+					TEST_ASSERT_VAL("instructions second event is topdown-retiring",
+							strstr(next->name, "topdown-retiring")
+							!= NULL);
+				}
+			} else if (strstr(evsel->name, "topdown-retiring")) {
+				/*
+				 * A perf metric event where the PMU doesn't
+				 * require slots as a leader.
+				 */
+				TEST_ASSERT_EQUAL("topdown-retiring group size",
+						  evsel->core.nr_members, 1);
+			} else if (strstr(evsel->name, "cycles")) {
+				TEST_ASSERT_EQUAL("cycles group size", evsel->core.nr_members, 1);
+			}
+		}
+	}
+
+	evlist__delete(evlist);
+	parse_events_error__exit(&err);
+	return TEST_OK;
+
+out_err:
+	evlist__delete(evlist);
+	parse_events_error__exit(&err);
+	return TEST_FAIL;
+}
+
+static int test__x86_topdown_sorting(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
+{
+	if (!topdown_sys_has_perf_metrics())
+		return TEST_OK;
+
+	TEST_ASSERT_EQUAL("all events in a group",
+			  test_sort("{instructions,topdown-retiring,slots}", 3, 2), TEST_OK);
+	TEST_ASSERT_EQUAL("all events not in a group",
+			  test_sort("instructions,topdown-retiring,slots", 2, 1), TEST_OK);
+	TEST_ASSERT_EQUAL("slots event in a group but topdown metrics events outside the group",
+			  test_sort("{instructions,slots},topdown-retiring", 2, 1), TEST_OK);
+	TEST_ASSERT_EQUAL("slots event and topdown metrics events in two groups",
+			  test_sort("{instructions,slots},{topdown-retiring}", 2, 1), TEST_OK);
+	TEST_ASSERT_EQUAL("slots event and metrics event are not in a group and not adjacent",
+			  test_sort("{instructions,slots},cycles,topdown-retiring", 2, 1), TEST_OK);
+
+	return TEST_OK;
+}
+
+static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unused,
+					     int subtest __maybe_unused)
+{
+	if (!topdown_sys_has_perf_metrics())
+		return TEST_OK;
+
+	TEST_ASSERT_EQUAL("all events in a group",
+			  test_sort("{instructions,topdown-retiring}", 3, 2), TEST_OK);
+	TEST_ASSERT_EQUAL("all events not in a group",
+			  test_sort("instructions,topdown-retiring", 2, 1), TEST_OK);
+	TEST_ASSERT_EQUAL("event in a group but topdown metrics events outside the group",
+			  test_sort("{instructions},topdown-retiring", 2, 1), TEST_OK);
+	TEST_ASSERT_EQUAL("event and topdown metrics events in two groups",
+			  test_sort("{instructions},{topdown-retiring}", 2, 1), TEST_OK);
+	TEST_ASSERT_EQUAL("event and metrics event are not in a group and not adjacent",
+			  test_sort("{instructions},cycles,topdown-retiring", 2, 1), TEST_OK);
+
+	return TEST_OK;
+}
+
+static struct test_case x86_topdown_tests[] = {
+	TEST_CASE("topdown events", x86_topdown),
+	TEST_CASE("topdown sorting", x86_topdown_sorting),
+	TEST_CASE("topdown slots injection", x86_topdown_slots_injection),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__x86_topdown = {
+	.desc = "x86 topdown",
+	.test_cases = x86_topdown_tests,
+};
-- 
2.53.0.1018.g2bb0e51243-goog

