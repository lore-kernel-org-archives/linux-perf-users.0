Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0FC1755A;
	Wed, 26 Jun 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413724; cv=none; b=DgFxdGg9vwzi3t6NrfjKwrrVdN6ZdJctBfJ+LEE/XaKNxZqI/QvcN5Ox6/s83vurXfUi2bpOj4UgOQyoETErw7jaqglfUcQXg1Zm0l52qVdYxLmgmuDcvXAbo2pn1iT1wzen4sGpqbUmYPLGzXJGZeVXyCCTUJMRqTtov3o0ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413724; c=relaxed/simple;
	bh=fjANHNvY+xvOjk7zCTH+6WPmIzWFkUzFb3xWhgvj8G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CwEedbzjtOC6zuSWNiMtHOsYPECmNDjm8UFLVc+0o20eHElVurj/p0ErrLOO3Q163DiqHYB1apek3xXxgfWIm6UyTSN2DYUowZ902YlYbcgGMlDNo7q7L6E/kpTXHc5OEFeECEsu7MpM+fpSkwyHUzRXylwMDJbBhqUlnKLZkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4368D367;
	Wed, 26 Jun 2024 07:55:46 -0700 (PDT)
Received: from e127643.cambridge.arm.com (e127643.arm.com [10.1.33.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 222ED3F73B;
	Wed, 26 Jun 2024 07:55:18 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: robin.murphy@arm.com,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf pmu: Restore full PMU name wildcard support
Date: Wed, 26 Jun 2024 15:54:45 +0100
Message-Id: <20240626145448.896746-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626145448.896746-1-james.clark@arm.com>
References: <20240626145448.896746-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic
pmu events") gives the following example for wildcarding a subset of
PMUs:

  E.g., in a system with the following dynamic pmus:

        mypmu_0
        mypmu_1
        mypmu_2
        mypmu_4

  perf stat -e mypmu_[01]/<config>/

Since commit f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()"), only
"*" has been supported, removing the ability to subset PMUs, even though
parse-events.l still supports ? and [] characters.

Fix it by using fnmatch() when any glob character is detected and add a
test which covers that and other scenarios of
perf_pmu__match_ignoring_suffix().

Fixes: f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/pmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  |  2 +-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 201df4446f7c..40132655ccd1 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -453,12 +453,90 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
 	return TEST_OK;
 }
 
+/**
+ * Test perf_pmu__match() that's used to search for a PMU given a name passed
+ * on the command line. The name that's passed may also be a filename type glob
+ * match.
+ */
+static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_pmu test_pmu;
+
+	test_pmu.name = "pmuname";
+	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
+	TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
+	TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),	     false);
+
+	test_pmu.name = "pmuname_10";
+	TEST_ASSERT_EQUAL("Diff suffix_", perf_pmu__match(&test_pmu, "pmuname_2"),  false);
+	TEST_ASSERT_EQUAL("Sub suffix_",  perf_pmu__match(&test_pmu, "pmuname_1"),  true);
+	TEST_ASSERT_EQUAL("Same suffix_", perf_pmu__match(&test_pmu, "pmuname_10"), true);
+	TEST_ASSERT_EQUAL("No suffix_",   perf_pmu__match(&test_pmu, "pmuname"),    true);
+	TEST_ASSERT_EQUAL("Underscore_",  perf_pmu__match(&test_pmu, "pmuname_"),   true);
+	TEST_ASSERT_EQUAL("Substring_",   perf_pmu__match(&test_pmu, "pmuna"),      false);
+
+	test_pmu.name = "pmuname_ab23";
+	TEST_ASSERT_EQUAL("Diff suffix hex_", perf_pmu__match(&test_pmu, "pmuname_2"),    false);
+	TEST_ASSERT_EQUAL("Sub suffix hex_",  perf_pmu__match(&test_pmu, "pmuname_ab"),   true);
+	TEST_ASSERT_EQUAL("Same suffix hex_", perf_pmu__match(&test_pmu, "pmuname_ab23"), true);
+	TEST_ASSERT_EQUAL("No suffix hex_",   perf_pmu__match(&test_pmu, "pmuname"),      true);
+	TEST_ASSERT_EQUAL("Underscore hex_",  perf_pmu__match(&test_pmu, "pmuname_"),     true);
+	TEST_ASSERT_EQUAL("Substring hex_",   perf_pmu__match(&test_pmu, "pmuna"),	 false);
+
+	test_pmu.name = "pmuname10";
+	TEST_ASSERT_EQUAL("Diff suffix", perf_pmu__match(&test_pmu, "pmuname2"),  false);
+	TEST_ASSERT_EQUAL("Sub suffix",  perf_pmu__match(&test_pmu, "pmuname1"),  true);
+	TEST_ASSERT_EQUAL("Same suffix", perf_pmu__match(&test_pmu, "pmuname10"), true);
+	TEST_ASSERT_EQUAL("No suffix",   perf_pmu__match(&test_pmu, "pmuname"),   true);
+	TEST_ASSERT_EQUAL("Underscore",  perf_pmu__match(&test_pmu, "pmuname_"),  false);
+	TEST_ASSERT_EQUAL("Substring",   perf_pmu__match(&test_pmu, "pmuna"),     false);
+
+	test_pmu.name = "pmunameab23";
+	TEST_ASSERT_EQUAL("Diff suffix hex", perf_pmu__match(&test_pmu, "pmuname2"),    false);
+	TEST_ASSERT_EQUAL("Sub suffix hex",  perf_pmu__match(&test_pmu, "pmunameab"),   true);
+	TEST_ASSERT_EQUAL("Same suffix hex", perf_pmu__match(&test_pmu, "pmunameab23"), true);
+	TEST_ASSERT_EQUAL("No suffix hex",   perf_pmu__match(&test_pmu, "pmuname"),     true);
+	TEST_ASSERT_EQUAL("Underscore hex",  perf_pmu__match(&test_pmu, "pmuname_"),    false);
+	TEST_ASSERT_EQUAL("Substring hex",   perf_pmu__match(&test_pmu, "pmuna"),	false);
+
+	/*
+	 * 2 hex chars or less are not considered suffixes so it shouldn't be
+	 * possible to wildcard by skipping the suffix. Therefore there are more
+	 * false results here than above.
+	 */
+	test_pmu.name = "pmuname_a3";
+	TEST_ASSERT_EQUAL("Diff suffix 2 hex_", perf_pmu__match(&test_pmu, "pmuname_2"),  false);
+	/*
+	 * This one should be false, but because pmuname_a3 ends in 3 which is
+	 * decimal, it's not possible to determine if it's a short hex suffix or
+	 * a normal decimal suffix following text. And we want to match on any
+	 * length of decimal suffix. Run the test anyway and expect the wrong
+	 * result. And slightly fuzzy matching shouldn't do too much harm.
+	 */
+	TEST_ASSERT_EQUAL("Sub suffix 2 hex_",  perf_pmu__match(&test_pmu, "pmuname_a"),  true);
+	TEST_ASSERT_EQUAL("Same suffix 2 hex_", perf_pmu__match(&test_pmu, "pmuname_a3"), true);
+	TEST_ASSERT_EQUAL("No suffix 2 hex_",   perf_pmu__match(&test_pmu, "pmuname"),    false);
+	TEST_ASSERT_EQUAL("Underscore 2 hex_",  perf_pmu__match(&test_pmu, "pmuname_"),   false);
+	TEST_ASSERT_EQUAL("Substring 2 hex_",   perf_pmu__match(&test_pmu, "pmuna"),	  false);
+
+	test_pmu.name = "pmuname_5";
+	TEST_ASSERT_EQUAL("Glob 1", perf_pmu__match(&test_pmu, "pmu*"),		   true);
+	TEST_ASSERT_EQUAL("Glob 2", perf_pmu__match(&test_pmu, "nomatch*"),	   false);
+	TEST_ASSERT_EQUAL("Seq 1",  perf_pmu__match(&test_pmu, "pmuname_[12345]"), true);
+	TEST_ASSERT_EQUAL("Seq 2",  perf_pmu__match(&test_pmu, "pmuname_[67890]"), false);
+	TEST_ASSERT_EQUAL("? 1",    perf_pmu__match(&test_pmu, "pmuname_?"),	   true);
+	TEST_ASSERT_EQUAL("? 2",    perf_pmu__match(&test_pmu, "pmuname_1?"),	   false);
+
+	return TEST_OK;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
 	TEST_CASE("PMU event names", pmu_event_names),
 	TEST_CASE("PMU name combining", name_len),
 	TEST_CASE("PMU name comparison", name_cmp),
+	TEST_CASE("PMU cmdline match", pmu_match),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c94a91645b21..97d74fe6d816 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2150,7 +2150,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
 {
 	const char *name = pmu->name;
-	bool need_fnmatch = strchr(tok, '*') != NULL;
+	bool need_fnmatch = strisglob(tok);
 
 	if (!strncmp(tok, "uncore_", 7))
 		tok += 7;
-- 
2.34.1

