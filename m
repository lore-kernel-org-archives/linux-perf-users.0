Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573B428462
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975937; cv=none; b=Jz2c5BmwsnH9jyw7INiimHXzVZExdjzxXq3FWbX0s+LAJfx1ztKmQSmVBMJGcwFuu0D7u9vdqfVHDSWS2mtT6h+BN9ik/uLeYw39LxNlr9xASbw7Ablw3vzcjqW+kRH4q+9L0uK7nAT+nG4A6IbfGH7XmuIoyJEH6iF0ffZqRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975937; c=relaxed/simple;
	bh=zmjzq2yRJHz70iMViN8W2LnoOVsMO1Yye6Py2LDRzHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koGHoD55kq9q5qyzzrn6LPDsvw0UHmk9a7A29VfuG4j6Er3xMpDteQzJBGKXSxsyBYX4nk4uxSR1lE6Xd+fHifWMZvlNe2Y0X9yVQy6Bq7cMsrc5FC1tMWQeNB2e5vCD2gV6hOzLQU17mZgxUytbvKc5ROuxBtBXED3ej9tJECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lEB7ecuR; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEB7ecuR"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127337c8e52so6450609c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774975935; x=1775580735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8z4JT/34XEU8ppT7K0VUUfyQ1wwVr4Kah+ibuGvBE0=;
        b=lEB7ecuRfcwmzRKfJI2zVRIuIKYwEIHJBDnk4Xiu+spAaTVO3HASjfo3IuzCcO8LpW
         zBSvMIkJMfhl8UPqCPgb6CRPUQ4RLjqwwdWa7abpjYwdINKYpnE33vAALciEqNyCq/bs
         3toANY1O531PuiZQo+8qimrKt0y2zuCDJpJ+cDTaxkLPov5gNRZ9aZqBFpyKghsyqOBb
         tSrow4yE56qly1zNpb1v+IVY2CYvedSAe4BM4eBJxQsaVqR1zqyrTHGm2wcxq17tDZJx
         PsGpOs+duGbkULbakquNMHPVIA3/Ro3GLO22uPAw525cQpFq+43JdkvXFk57DW+OKEPC
         NJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975935; x=1775580735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8z4JT/34XEU8ppT7K0VUUfyQ1wwVr4Kah+ibuGvBE0=;
        b=WSysjgjImCS0eiJXbj37SB13ENBKthLpJ9wG1D8VjQQ3ybjAPsnXJt6S+3v+1E115G
         BY/bIdJ4gomRvLTSw5fwwlGIpxsn9iFwHQpTjBbai1vNYdD3Fanu4wG33AuaF2AldxWS
         gNz1PxDWV06XJpYthrALD0chrBzYkUabEqUi/P0yRdHQenibnlHVovmvA4Xszjv/AgpG
         Z1w1TICjwAh27ti4yDCrTQucXPiCz/Yevih0x2R6Kmx7Hd5SA2fh5QX270Tpi62PzPhX
         Etx8T1zY2mXIW+ghgKshDDnjrR2JpL1sOAPG4m4LwzA2XezBpg6o+9q4K3XHHBDcr1Zc
         sMQg==
X-Forwarded-Encrypted: i=1; AJvYcCX27DPndmzAe4aoyExXCBmr6NayC3BRHiWFZDlq6+OzRIXMAZM+w7h3JvHkfmhimBXbLiUGkCoM4sQnHZXbx0TU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4niuxpHSkoFrWrqB71VbaGmQbX8CW70KhVScjLUJrXPEM2pW0
	F6jToy20X8vPi7V6aqdYzWNtx8Fc/UGbPYBa+k/f0SpR0TK2gYlittLe3wdgk0x9XcB3EHIxbkf
	Bnh9ECkn57w==
X-Received: from dlam4-n1.prod.google.com ([2002:a05:701b:2084:10b0:12a:c3c1:4ace])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2387:b0:124:8d7d:2d63
 with SMTP id a92af1059eb24-12be65999c2mr93786c88.35.1774975934722; Tue, 31
 Mar 2026 09:52:14 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:52:07 -0700
In-Reply-To: <20260331165207.4016392-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <acs6txqcncbwCFZA@google.com> <20260331165207.4016392-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331165207.4016392-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf arch x86 tests: Add test for topdown event sorting
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com, 
	german.gomez@arm.com, irogers@google.com, james.clark@linaro.org, 
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
 tools/perf/arch/x86/tests/topdown.c | 129 +++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 3ee4e5e71be3..b1a9fa28bdfd 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -75,4 +75,131 @@ static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest
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
+		if (strstr(evsel->name, "slots")) {
+			/*
+			 * Slots as a leader means the PMU is for a perf metric
+			 * group as the slots event isn't present when not.
+			 */
+			TEST_ASSERT_EQUAL("slots group size", evsel->core.nr_members,
+					expected_slots_group_size);
+			if (expected_slots_group_size == 3) {
+				struct evsel *next = evsel__next(evsel);
+				struct evsel *next2 = evsel__next(next);
+
+				TEST_ASSERT_VAL("slots second event is instructions",
+						strstr(next->name, "instructions")
+						!= NULL);
+				TEST_ASSERT_VAL("slots third event is topdown-retiring",
+						strstr(next2->name, "topdown-retiring") != NULL);
+			} else if (expected_slots_group_size == 2) {
+				struct evsel *next = evsel__next(evsel);
+
+				TEST_ASSERT_VAL("slots second event is topdown-retiring",
+						strstr(next->name, "topdown-retiring") != NULL);
+			}
+		} else if (strstr(evsel->name, "instructions")) {
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
+						strstr(next->name, "topdown-retiring") != NULL);
+			}
+		} else if (strstr(evsel->name, "topdown-retiring")) {
+			/*
+			 * A perf metric event where the PMU doesn't require
+			 * slots as a leader.
+			 */
+			TEST_ASSERT_EQUAL("topdown-retiring group size", evsel->core.nr_members, 1);
+		} else if (strstr(evsel->name, "cycles")) {
+			TEST_ASSERT_EQUAL("cycles group size", evsel->core.nr_members, 1);
+		}
+	}
+
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
2.53.0.1018.g2bb0e51243-goog

