Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9A3A3828
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983271; cv=none; b=S3E7lzXID4ZxG030wfoXi7a6G3hFfMAWC/3W3c1kBCUNSx3y803IZ4/fvGCrqg47NcYUxhQdBdc7kbgxNeH3OPriPf9vMoPA8Qu+ye8f8BTr5/7Y2V5L/oUq8tmgFk1K/+m6F7WyNy6Fq2V7on87O5RE7W0Qpv1JdfVocQbZFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983271; c=relaxed/simple;
	bh=45QNLeveR6hV9ooJHtAv/VJa9ZQTISr+4DDJPzh7Dfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=phusLn7LWcOIbfESNMIec3xlrEUuAHuNSfUAURjAIH4VCPtUPqpJ6GEq2/Oe8DsgQ2YrEFsLFl+T0/HMWGOXBTI6u8JFyaVXmPLy6HPDdJ31vstfc0uSxRYhoRV8H7lh2UkzP9aOMKwnlJPh8KQr9gF21+pJN3dnWwrYxJGjXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsPmEUcs; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsPmEUcs"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so2552976c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774983269; x=1775588069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVCvwsUDkDX9TvXMe8OObLDA8K8Zh9a+KE7olL3gLpo=;
        b=FsPmEUcshDGSVifE0VxtsDoiyWDoH4mpY164LOcHzCnTvS1k4e38AaPJg0aMoAoxfw
         Z+1grdvBRYEtDXRGN5hrYTprkCepty3jQMYhmkLdEh76Jd7t6g+74xPC3oIpqxNgRn/I
         IeO/Fa8Zx52N5Hz4qOpdelJaDUM8t59YQJhzGLT3EqmCSdoLKEL2Lg2Pze4es36uUuYx
         +rJnBNS0/siwC/fLb+huU4z1F/SRBm0Gvp8rrRbhNARhUDkM4pCDB9TEQ71z6L0WV+NY
         0B6LuO578XQWYrjFWOOi+ELaLBeGE+erMGQSN1sl5Ai+73hhLgNk4BLWzrJTSqN6MiPU
         5Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774983269; x=1775588069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVCvwsUDkDX9TvXMe8OObLDA8K8Zh9a+KE7olL3gLpo=;
        b=H3VKD+Hm7P/9DyfabX+ms3fU5O4RFmw4RaKxbHiEjgbMUlnZu1Kxj+U6W/Onf8elvE
         7LHO0wcB1fnhvMB7BQWjW+J2OBwcRofCRdhF3VrXj+tpIySrlAJqPlhS7fUSorkBmD7R
         TvQDtWrWfHbQzWtotHrR9/XJydaRJBECfJB8nzQGTO/vZnsQRzeicqx3ncW1E+FE7k+M
         09sfl3u7k2v5gdEhXCUR/SyM8tgy9LiZUO1Bgfy0IPPxECOr6gNEeRKFGbCBxkAXPcuS
         Yt857kPeOoiY8lx6KsnqnUTxVe6+RUbUspd31aNb18w823IcLORttG8/RzqNzXCVxADh
         ElBA==
X-Forwarded-Encrypted: i=1; AJvYcCWpUNakz61uoJ/+dQWvqKc6jElvRdG51v9N7l8MXNWeq9BOde+gGaeIjsl8M7+WWhvLbtEuL2N13QW1MBpFHID6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/W5rFaMzORig6gtXV6E8GIcblAm4cnQF45mlXTo42PWX7t0mx
	/v4TEUZJf1oqp8pM6cDYvD7AWymconeUZczIge20IJiZ5aKdErAc1C6VfHh0FWJJ3+cYw5rWuwq
	/Dm9jmpn2zw==
X-Received: from dlbrl3.prod.google.com ([2002:a05:7022:f503:b0:12a:6c72:daa3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e01:b0:12a:6c7e:befa
 with SMTP id a92af1059eb24-12be63fc54emr408363c88.2.1774983268531; Tue, 31
 Mar 2026 11:54:28 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:54:19 -0700
In-Reply-To: <20260331185419.4085479-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331165207.4016392-1-irogers@google.com> <20260331185419.4085479-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331185419.4085479-3-irogers@google.com>
Subject: [PATCH v3 2/2] perf arch x86 tests: Add test for topdown event sorting
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, 9erthalion6@gmail.com, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	collin.funk1@gmail.com, german.gomez@arm.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	zide.chen@intel.com
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
2.53.0.1118.gaef5881109-goog

