Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9B199EAD
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779064649; cv=none; b=H1ugLG4XbRLHGiqNGAOFDFgDiwu1gEksLRVEAW4L0sMq1a3AhnkN43CKPXR3+wTCAV0TPgonZJhnH+2K8yGowuUHEz+xBmo/ZflSILjQgXE3H+pP35OK198KkY1x4f89bVm+2NrDU/MGQJYaidwQzmW3EcXFgKkzBKWxMH7rJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779064649; c=relaxed/simple;
	bh=T45GdiKKExPuBl1H+XdRaA5uP4mOQH8oYUffimt+6mY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dSwClMQ10yUmkwvhWghBb1faoUTM/eTffUHNQ0994arDwyA/YJ/XT5y9E5Q/2vYqAwDphRKBHiWm3jvNX08i2zRgF9FFqQGfs7HD3U41qJAxnQXrMrRndeETf3yaj/t0OuASUU2UDRJQFjUdYRjRq4xiIO8chtXmh//0meRG+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhDLTF0O; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhDLTF0O"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eebb099efbso5354669eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779064647; x=1779669447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3RU8hZgHzO5hjPt3hcU8ZlfNOPZsff4Xy49G8OPcj4=;
        b=GhDLTF0OJOoNjQTnKKvxJOhXfICClwSrbQBM42OX1OHEDnLP59WJ0bX5b0EKrc3mPv
         WLjcgVtHbgTNuDc4Fz1SkRJP2ZMo9MiPhZ0X3iCVpMLuWySLjNLVr/VGm5w+clZP+mcF
         l9/MB3BZVfIDFgydCll3QCNB0tocZno+luJrw8nBV9wnXivZVeX8gt4U6+bxx8WK5gK5
         K1F6wzKW1GSULAGBZcsZ02woJy0y+v25Ftnv8knPiEJFBC0lhilSne3rURbMiKKrkUeR
         14LKn3QazvDRyzziWxn/HTXg8jtdgaF4DxnAMyS36XEOBqHMqbXZ1WlFSwvrdqcVu7rW
         W7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779064647; x=1779669447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3RU8hZgHzO5hjPt3hcU8ZlfNOPZsff4Xy49G8OPcj4=;
        b=LLf+jG66j65eeqU+soakgCplJhHxGJia+NdLMk5Tlh7OcCT8GmlhYPsE2um+bpwbst
         xGLpZpTfH3LIysqVPqHozk9c+G5j5wv6ou1AXbtJQnJKw4vD3iLFsea5p0IJsc94kBei
         KgV+7KubG//KUtKlQ2pnn2RroeEPZ+0a0yuM923QJdqs3at5AtZ4JWwdMKBkBYqnmne/
         iTdnMkX2vYffFDV+eLgRkV28hsDIbIhL0SSJA/fVBKBWi/hohxsvr5iPjdCoLEASTvIf
         PlThWP5hQF8ykbVu2SZsL8MtU4dY9CMnwZLwOIegYE8V6SOm2MG4XugkmecusR/lWAjB
         eLlA==
X-Forwarded-Encrypted: i=1; AFNElJ9Sh8NSPeGy/YQx9lsQGaaIyexngBSBi58YeALl7vehyMdfPr/VrKh6/Hms1V6GSGXpG8fLhX/0mdajKS9DzKcX@vger.kernel.org
X-Gm-Message-State: AOJu0YykslA+Mzhfi7KakBmH5sKjGg+SPrP+00UGgoPMKYfG3dfrL4Ti
	CBhzeyxuspBTi0nOZMC+n+FgqmqwoD0d4y7TcScTQuzT3Injw6qUSCx63z1OmHf43V3so02PIlt
	WVUSrHf6WDg==
X-Received: from dycmq15.prod.google.com ([2002:a05:7301:78f:b0:2df:75ae:2719])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1001:b0:2ce:f3d7:221
 with SMTP id 5a478bee46e88-303986770c9mr6091903eec.17.1779064646363; Sun, 17
 May 2026 17:37:26 -0700 (PDT)
Date: Sun, 17 May 2026 17:37:04 -0700
In-Reply-To: <20260518003704.2434308-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260517232849.2391357-1-irogers@google.com> <20260518003704.2434308-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518003704.2434308-3-irogers@google.com>
Subject: [PATCH v5 2/2] perf arch x86 tests: Add test for topdown event sorting
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
 tools/perf/arch/x86/tests/topdown.c | 148 +++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 3ee4e5e71be3..9e9dbea7998d 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -75,4 +75,150 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
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
+				 * The instructions event leads a group with a
+				 * topdown-retiring event, neither of which need
+				 * reordering for perf metric event support.
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

