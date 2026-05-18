Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46941382299
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779078716; cv=none; b=Ngpbc+EnRcLqriO8ljqz1B8GZnFrYN+4Up/ei7t9WhE0H2CdYTQXQq8OaYk+pPo7x/icGkuWU63DRfwgyFAS59QZoMGIPS64QOi3UbdzBs9n1wgsc6iR1atzpBPm8OAmMs1z6FpLQwx4fDwhXv82yK4eLv7tlIlKZLCXOo+1AOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779078716; c=relaxed/simple;
	bh=3g9O2Yw3w3xaXapO32wDQKH9lNWe5WACrGuWp7AIlYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flMfMzKE5l+bRo4OshOfHYKQHbC8uKWHJYPE53CseUwjtVtgIgojd9i/q6aPpYj+57wUH7guxlsyhFUa9cUs8QMWWYbhfJYGevQYDDmF7pQFNPUaQ69wLVBMR+HtOqYiyh9Aw+V3wibZ0fOwqksPnR4skZbB9DEIsGD4+gw6oKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOcWUnnn; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOcWUnnn"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so1476983eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779078711; x=1779683511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5egDoittCoF2sloPTEbRjge2u/Al3G2t4aOQQynxZU=;
        b=sOcWUnnnGzceOZpL13M278bU9F+XNGXIe0j/fi7L42zZE04rTupjt6jFjGNz3tBPGH
         dZmKIE7ZUdulii1OdMv7z4PdaGQoxHfiHF1xSyGtnd5eEMf2P+EROy8yW3qRkiFx/LMz
         uN5iAh/DMGa89BTCORE04mhTAheKKB30U1l+xDdw9EHJMAEwVOeJsfvyulXdk+z6Xetc
         YjrZOHYujKkrP4iB75UiBb0FCX7BP75U8CN9X/1tee8vQoxk0IR8XU8B2LxSlBmDjsED
         I3KY0kGu8x6qEWyx/CMfgKPp/1UfPmXCyxFxChzK0Ye5CR3A7/YWO4PYl8u4Urpg8XUf
         u22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779078711; x=1779683511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5egDoittCoF2sloPTEbRjge2u/Al3G2t4aOQQynxZU=;
        b=WTY7mEQU1RAK9sDlbKP3J8HWXy9907QW2USnVOwvC7jwdSaSR7rVDshcJrP7ApwizV
         Yt+3KlIerwnIDr5Rp3e3jdTZ7lYAJ+iZfcM1kczDVIoxOnpryRtzalf7JSFL+xB8zDRo
         4SMIQvSrVNG+nBgxuKCvxxtAlpiPLrIajpqsFhZI+oWmnomHny6LYviHuj7g9eDKbPMB
         phzmXiwFGs7h2VghaksTF56Rx4d5refHu6GYkeNnKc+b5Yy2zQFxRg/dNJPKxMeWme8X
         MWqPXrflcE22KhCqdoiaDvva1f4dcObmMT1eDmVVmiq7932mnziU9X1+2r5qbvOE+tOj
         EkjA==
X-Forwarded-Encrypted: i=1; AFNElJ8srD7D3gitgmdcrvbGN15axNJiDd+8q99PauzvXbME9mUdI9qKlgaeFztyqCNlB1IjESkoloSUQk6bv7Ytnwfd@vger.kernel.org
X-Gm-Message-State: AOJu0YxmF/3rOlwDgYqLN9fVEV3/AVkwFRXu1VEq8pYSn3iRmyxrCpbx
	M2ajN5fHxeqs9YCmeYbcZxn1quAg+ddaR59eXKus9pZMC7obM/LkWMhntO9KT66T3UnQDThMa1h
	ag5uFJWH1AQ==
X-Received: from dycnr6-n1.prod.google.com ([2002:a05:7300:e9c6:10b0:2da:2af9:bfe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7885:b0:2c1:82c2:bc31
 with SMTP id 5a478bee46e88-3026197f5b2mr7305963eec.10.1779078710839; Sun, 17
 May 2026 21:31:50 -0700 (PDT)
Date: Sun, 17 May 2026 21:31:40 -0700
In-Reply-To: <20260518043140.2522141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518023225.2472122-1-irogers@google.com> <20260518043140.2522141-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518043140.2522141-3-irogers@google.com>
Subject: [PATCH v7 2/2] perf arch x86 tests: Add test for topdown event sorting
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
 tools/perf/arch/x86/tests/topdown.c | 166 +++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 3ee4e5e71be3..221f2c4bbb61 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -75,4 +75,168 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
-DEFINE_SUITE("x86 topdown", x86_topdown);
+#define CHECK_COND(cond, text)					\
+do {								\
+	if (!(cond)) {						\
+		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
+		ret = TEST_FAIL;				\
+		goto out_err;					\
+	}							\
+} while (0)
+
+#define CHECK_EQUAL(val, expected, text)			\
+do {								\
+	if ((val) != (expected)) {				\
+		pr_debug("FAILED %s:%d %s (%d != %d)\n",	\
+			 __FILE__, __LINE__, text, (val), (expected)); \
+		ret = TEST_FAIL;				\
+		goto out_err;					\
+	}							\
+} while (0)
+
+static int test_sort(const char *str, int expected_slots_group_size,
+		     int expected_instructions_group_size)
+{
+	struct evlist *evlist = NULL;
+	struct parse_events_error err;
+	struct evsel *evsel;
+	int ret = TEST_FAIL;
+	bool slots_seen = false;
+
+	parse_events_error__init(&err);
+
+	evlist = evlist__new();
+	if (!evlist)
+		goto out_err;
+
+	if (parse_events(evlist, str, &err)) {
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
+			CHECK_EQUAL(evsel->core.nr_members, expected_slots_group_size,
+				    "slots group size");
+			if (expected_slots_group_size == 3) {
+				struct evsel *next = evsel__next(evsel);
+				struct evsel *next2 = evsel__next(next);
+
+				CHECK_COND(strstr(evsel__name(next), "instructions") != NULL,
+					   "slots second event is instructions");
+				CHECK_COND(strstr(evsel__name(next2), "topdown-retiring") != NULL,
+					   "slots third event is topdown-retiring");
+			} else if (expected_slots_group_size == 2) {
+				struct evsel *next = evsel__next(evsel);
+
+				CHECK_COND(strstr(evsel__name(next), "topdown-retiring") != NULL,
+					   "slots second event is topdown-retiring");
+			}
+		} else if (strstr(evsel__name(evsel), "instructions")) {
+			CHECK_EQUAL(evsel->core.nr_members, expected_instructions_group_size,
+				    "instructions group size");
+			if (expected_instructions_group_size == 2) {
+				/*
+				 * On Intel hybrid CPUs (e.g., Alder Lake/
+				 * Raptor Lake), E-cores (cpu_atom) do not
+				 * support/enforce the slots event. When
+				 * parsing event groups containing slots
+				 * across all PMUs, slots is automatically
+				 * filtered out from cpu_atom, leaving
+				 * {cpu_atom/instructions/,
+				 *  cpu_atom/topdown-retiring/}. On cpu_atom,
+				 * instructions correctly leads this group of
+				 * 2 without slots reordering.
+				 */
+				struct evsel *next = evsel__next(evsel);
+
+				CHECK_COND(strstr(evsel__name(next), "topdown-retiring") != NULL,
+					   "instructions second event is topdown-retiring");
+			}
+		} else if (strstr(evsel__name(evsel), "topdown-retiring")) {
+			/*
+			 * A perf metric event where the PMU doesn't require
+			 * slots as a leader.
+			 */
+			CHECK_EQUAL(evsel->core.nr_members, 1, "topdown-retiring group size");
+		} else if (strstr(evsel__name(evsel), "cycles")) {
+			CHECK_EQUAL(evsel->core.nr_members, 1, "cycles group size");
+		}
+	}
+	CHECK_COND(slots_seen, "slots seen");
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
+	int ret;
+
+	if (!topdown_sys_has_perf_metrics())
+		return TEST_OK;
+
+	ret = test_sort("{instructions,topdown-retiring,slots}", 3, 2);
+	TEST_ASSERT_EQUAL("all events in a group", ret, TEST_OK);
+	ret = test_sort("instructions,topdown-retiring,slots", 2, 1);
+	TEST_ASSERT_EQUAL("all events not in a group", ret, TEST_OK);
+	ret = test_sort("{instructions,slots},topdown-retiring", 2, 1);
+	TEST_ASSERT_EQUAL("slots event in a group but topdown metrics events outside the group",
+			  ret, TEST_OK);
+	ret = test_sort("{instructions,slots},{topdown-retiring}", 2, 1);
+	TEST_ASSERT_EQUAL("slots event and topdown metrics events in two groups",
+			  ret, TEST_OK);
+	ret = test_sort("{instructions,slots},cycles,topdown-retiring", 2, 1);
+	TEST_ASSERT_EQUAL("slots event and metrics event are not in a group and not adjacent",
+			  ret, TEST_OK);
+
+	return TEST_OK;
+}
+
+static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unused,
+					     int subtest __maybe_unused)
+{
+	int ret;
+
+	if (!topdown_sys_has_perf_metrics())
+		return TEST_OK;
+
+	ret = test_sort("{instructions,topdown-retiring}", 3, 2);
+	TEST_ASSERT_EQUAL("all events in a group", ret, TEST_OK);
+	ret = test_sort("instructions,topdown-retiring", 2, 1);
+	TEST_ASSERT_EQUAL("all events not in a group", ret, TEST_OK);
+	ret = test_sort("{instructions},topdown-retiring", 2, 1);
+	TEST_ASSERT_EQUAL("event in a group but topdown metrics events outside the group",
+			  ret, TEST_OK);
+	ret = test_sort("{instructions},{topdown-retiring}", 2, 1);
+	TEST_ASSERT_EQUAL("event and topdown metrics events in two groups",
+			  ret, TEST_OK);
+	ret = test_sort("{instructions},cycles,topdown-retiring", 2, 1);
+	TEST_ASSERT_EQUAL("event and metrics event are not in a group and not adjacent",
+			  ret, TEST_OK);
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

