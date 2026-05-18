Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC537AA66
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071556; cv=none; b=b1LuCkE3RjIKJfO69Z/Ua21z8y6bcrdkVosHmYAyiy/0oyX4BbZD9s6X4uKYmQisa5B0lToj8OcCruV8r8cUm2ENopw8OcvlK0VFka5+3oXxjbZ6rSV/W/IVNilUd6FFakyeO38R3hOQMfCNUryDUB6CmVRccRyZm3Nhnhsa028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071556; c=relaxed/simple;
	bh=eZ4xQVVU1O5AZm2IG6c7jujiI6Gsuu2YQxBkMask9cE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tebhYKh5tMx5ZCfdYY6iiYoGW8DDsDNjErxflqhyFdA7z7fu5+ksyOEpA6ufAe229WgGBkRGVRsvQQS4Bw/If9hLRKDjqHq5NrmoPl/4xrBvkZVKLqpYZiK43o26u/1czdOpXc5IWwFuLe3VnM4MW7N0nfmqDGWBPz1lEHd8QDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fz4Xorux; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fz4Xorux"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee34588671so2006875eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 19:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779071553; x=1779676353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2PfCFgFm9W6LUyGogy0Zkx8RpqhHQD/EGHq4TR1zoI=;
        b=fz4Xorux7kX4Nhz/KfR+uUn2oUgX+CDQmNP3OfIX6b6lVJya8588PY5/a7IzGSc0mr
         IeJ7w9xCeeEKFG8mbRkZ37wcnJRvCPl8VN+f9bh/+Wblv16+A3jsQebmX7KCFVvRdXra
         UgweGdLUYbxHrxo0fJR8HnkGTz8MUU/mIgaGGiZzKal/yJdz7tNBGd1idtv59i4Q40RV
         IpgP3GVyalTGnmwTbW/FuLAQT+LYgYcyGtGpcF7EMdRfK6He3xIu7CiG0LifShdlie/g
         ei4fnUOLvwb9jOJF/pBn7VYUb+UdYr5CeRvhcthrqezUhHRT8XmM9H8dudfpcGSnX4a5
         +4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071553; x=1779676353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2PfCFgFm9W6LUyGogy0Zkx8RpqhHQD/EGHq4TR1zoI=;
        b=dMmsbQTKLxdhgf6SMQBu+VvgLWVmQm4L13aVed0vrpCiF05BXpsu9miS0U9hyb/SaN
         1AlAktA+Q3j/l8F8qAD/JqiZpX/R6OrdciMFk5pHm7xKjo2ZU67nmCzHIS7oLkwQZa4C
         OpepL9g1JF4qxVGVc8UHZ2/mKDMA9TYHQAXvZI2thqogXi6U6slZSF0I15tiUVaB/NEf
         +qfRqLZPraM8v+v6goviEeMeIOIpXxVnkK3tofphzWbHPYQGn9dDhZX0xDyIuLtYDUdP
         Fubg/z04VA67Odekhf7gX/vUty9PIu2CmZZGL+j7ZmegRa2grbi42G2hJSMAsjtjrhee
         Oa1g==
X-Forwarded-Encrypted: i=1; AFNElJ8yWsZBvoFVG+j/btJxChuBxLJOb8NA96zHjniDao577YdL/tBqPJewj8oElxm3t2/2aATAR/LJWks6LqX3aGlv@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnNi5VVTQooKUxf6rnlyAc+ew5MvqNqEZzVh29oEdcijORQU3
	fu5zInujPS+gEAQ0GIH73ps5thMwic+3xGLgG7CV0yc7WHMe7JD638th4J3XVp74fn3be5VkhK1
	ut4UW6HUGXw==
X-Received: from dycol5.prod.google.com ([2002:a05:7301:db85:b0:2f3:d7f7:5ac6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7c0b:b0:2ef:2878:7ade
 with SMTP id 5a478bee46e88-303984dd06amr6305545eec.15.1779071553293; Sun, 17
 May 2026 19:32:33 -0700 (PDT)
Date: Sun, 17 May 2026 19:32:25 -0700
In-Reply-To: <20260518023225.2472122-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518003704.2434308-1-irogers@google.com> <20260518023225.2472122-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518023225.2472122-3-irogers@google.com>
Subject: [PATCH v6 2/2] perf arch x86 tests: Add test for topdown event sorting
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
 tools/perf/arch/x86/tests/topdown.c | 159 +++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 3ee4e5e71be3..dbee32bf973e 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -75,4 +75,161 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
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

