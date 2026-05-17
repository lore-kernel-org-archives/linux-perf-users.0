Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C230DED1
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060547; cv=none; b=uB0KEpzcGZ98x5CWH1ryEgBAT1Q0Dx3zoXFTQEG3gP/JI+h943UWbCMBmmO644OcwJnLwv7HATOOz0+ub23N9lEeelg8wODL2Dw4P82izwq5oSyQgJRT8Qv6eXAIjrB5ix0lT6c3w/gC20hi3QtvY8uqYQd3lSIvxkBsVGBCa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060547; c=relaxed/simple;
	bh=mis3v7PktaXEWXDP6UoQ/eJUDrGuOT96eMWy8N40sUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rr7Lynk+4+Qot/Efyy7TPrvQrrx0wIuawSkTaA+abnLjeDkn70nBX72lTV5r2/RWcuS2MlLS8TpVxUG++BvqdwMhMPsBEOe0GFtRuZioGiq1LYyIJO8AMhuYH9Q/t6uykAJG+ia0ynEGzLy+ZtLDsGY8SKoaoR/3kDE8NVjgxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3mwxyYW; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3mwxyYW"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdd327d970so811275eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 16:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779060544; x=1779665344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsvruVIdomRrid0laLE4Uy6uL1baI4Tg0pAKLnvTtbc=;
        b=k3mwxyYWJ1w7iGUcU3oeMaGQUXjQcEw387ZBMNCyPYb8hpnANp/KqEDfjA1uIXQC2u
         Y1gRIfxsWX5mlR4hZvGZynzN1zJfuuCLi5xehjAf2Ahid2UsBo4SJnwuVzs1rl3nsPnA
         PFOFCHOLJgqhD7NlWSfl+tiaVKljUXmBHyuthferKP8H/mdwyBNafzFmOX4hPoHwZTF+
         3yKSW54nCr6wRhjDJ0mCsP9aM4ZELJxdK1tUq9b6TjzaGPFYe8Mm11SwdMyVfjh44h8O
         2aJTSsWaa94naQC+OQ9ecO00wES9YAP6KHiVRGn8F0u3Y7HaI1lleTH/rq0afGdfUhtU
         7MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060544; x=1779665344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsvruVIdomRrid0laLE4Uy6uL1baI4Tg0pAKLnvTtbc=;
        b=Turdt+tOs2oilgF/dktJr3dIo07KFkVbBfIjfJ4Mc0wKmoNkvE4h9c6XLJdnWPNp/A
         ugHCO3zyFcD1FZBlt/Synyumg0UVNBxLCxfDgioVKSEcS/ZSMyLrG/DnsDBGbkUJGjT+
         jB0BYHajfFnHxrWu2Tao0XajJIvoXPRDXnOJBT2RtSIaA2jolPDY5615AemEFeMCEVle
         VrJnqIHsAlkzmna1RmBHlt4Y8IcT6rH+kD5vA3aQ3ybrVVQPHP17xSVPzhkw85fURVXw
         qKFHFZ5KPkGhThntaVsZAsF9AZw3mt2jIcVkBsrSeav0y/7gDdkwT0EFMmf8lfBacw6F
         00Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/GNq2f24wa19VJ+4h88+qcflUZLGGwwTXmjQpwkCwHT9ps5fmXPj1DnE0cSlNEs3XEdXM9K8MCiK3xPp58NkqT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9l2k7ox9jjIzrU4Y/MuXnUz3r3IxnAW65349a6G1nZi+gKiD
	Ozc7NSpFsRpd9Kz6D/0T9yii9oQxqyJirfoEgtxQ7w623iRPnHchFOoQsKrbylZUvYlmid9Tozp
	k+ZYxmElECw==
X-Received: from dyr13.prod.google.com ([2002:a05:693c:400d:b0:2f9:af7:5051])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd16:b0:2de:e194:5fb1
 with SMTP id 5a478bee46e88-30397897781mr4855118eec.7.1779060544211; Sun, 17
 May 2026 16:29:04 -0700 (PDT)
Date: Sun, 17 May 2026 16:28:49 -0700
In-Reply-To: <20260517232849.2391357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331185419.4085479-1-irogers@google.com> <20260517232849.2391357-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260517232849.2391357-3-irogers@google.com>
Subject: [PATCH v4 2/2] perf arch x86 tests: Add test for topdown event sorting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com, 
	german.gomez@arm.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, zide.chen@intel.com
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
Tested-by: Zide Chen <zide.chen@intel.com>
---
 tools/perf/arch/x86/tests/topdown.c | 134 +++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 3ee4e5e71be3..ee8d673a0e7b 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -75,4 +75,136 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
-DEFINE_SUITE("x86 topdown", x86_topdown);
+static int test_sort(const char *str, int expected_slots_group_size,
+		     int expected_instructions_group_size)
+{
+	struct evlist *evlist;
+	struct parse_events_error err;
+	struct evsel *evsel;
+	int ret = TEST_FAIL;
+	bool slots_seen = false;
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
+		if (!evsel__is_group_leader(evsel))
+			continue;
+
+		if (strstr(evsel__name(evsel), "slots")) {
+			/*
+			 * Slots as a leader means the PMU is for a perf metric
+			 * group as the slots event isn't present when not.
+			 */
+			slots_seen = true;
+			TEST_ASSERT_EQUAL("slots group size", evsel->core.nr_members,
+					expected_slots_group_size);
+			if (expected_slots_group_size == 3) {
+				struct evsel *next = evsel__next(evsel);
+				struct evsel *next2 = evsel__next(next);
+
+				TEST_ASSERT_VAL("slots second event is instructions",
+						strstr(evsel__name(next), "instructions")
+						!= NULL);
+				TEST_ASSERT_VAL("slots third event is topdown-retiring",
+						strstr(evsel__name(next2), "topdown-retiring")
+						!= NULL);
+			} else if (expected_slots_group_size == 2) {
+				struct evsel *next = evsel__next(evsel);
+
+				TEST_ASSERT_VAL("slots second event is topdown-retiring",
+						strstr(evsel__name(next), "topdown-retiring")
+						!= NULL);
+			}
+		} else if (strstr(evsel__name(evsel), "instructions")) {
+			TEST_ASSERT_EQUAL("instructions group size", evsel->core.nr_members,
+					  expected_instructions_group_size);
+			if (expected_instructions_group_size == 2) {
+				/*
+				 * The instructions event leads a group with a
+				 * topdown-retiring event, neither of which need
+				 * reordering for perf metric event support.
+				 */
+				struct evsel *next = evsel__next(evsel);
+
+				TEST_ASSERT_VAL("instructions second event is topdown-retiring",
+						strstr(evsel__name(next), "topdown-retiring")
+						!= NULL);
+			}
+		} else if (strstr(evsel__name(evsel), "topdown-retiring")) {
+			/*
+			 * A perf metric event where the PMU doesn't require
+			 * slots as a leader.
+			 */
+			TEST_ASSERT_EQUAL("topdown-retiring group size", evsel->core.nr_members, 1);
+		} else if (strstr(evsel__name(evsel), "cycles")) {
+			TEST_ASSERT_EQUAL("cycles group size", evsel->core.nr_members, 1);
+		}
+	}
+	TEST_ASSERT_VAL("slots seen", slots_seen);
+	ret = TEST_OK;
+out_err:
+	evlist__delete(evlist);
+	parse_events_error__exit(&err);
+	return ret;
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
2.54.0.563.g4f69b47b94-goog

