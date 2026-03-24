Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F03B0AFE;
	Tue, 24 Mar 2026 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391130; cv=none; b=pwKbwgKQKXdFCl+KtmWYxLB5LJ2sZZ5s5Oqm6yJ/Les5alLh1C8B0HYjL4kWbfA8vauJYSUv3ZGCc3ZkYN4hf7O5IKo3TwptZ/NLLadlEg4I1A3qiZA1fCeJnFWv6kCRIP3rq5QpYYbHt89WNzIRZW9xHpWyIzcS68DTa4krnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391130; c=relaxed/simple;
	bh=jKw8Cc7gfw8vp1xmCKHsP5qaU76SThffgNIQhBf3nhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcSUs1rX+uFNJluVmUqfMjWp2K3+0dtPybUCvWUrIXlzZNlHMMctuuCPGOyjqXYKMmYxSiQaSlkfYQa9NfUUyqi3hBxb+m1POCvG78qj1o+xRYkB+KxwsfoF7gi4MuiJ1ZtQqTf9zuDi38FzeA/7dqRy5etOhm1xe33YhjwPqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYJMxgHX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYJMxgHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774391128; x=1805927128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jKw8Cc7gfw8vp1xmCKHsP5qaU76SThffgNIQhBf3nhI=;
  b=cYJMxgHXwfBljjI+JVG0azgpkVAm4+gqH0Fr84hqRnqx24638VJUSJlU
   zc7mrQXVA9bySOntUHpxYxupjrlPpZO9KOZ334T3qaVSmuC0AFeNgeuG6
   V1z0gWhPaDS0jxknamtSRaMEuAp2T5NsViYdzuzJFgvLF3vuviFgA643e
   FEL1ColBrPtEAfQtmWedsPo2HaECM/Dev6CBKHtm5brLXVyG/gkGKPJyD
   BeWWGkc9hZ6YZvn/q0DD+2fx5TYUMFsyroBgkjvSJMhMrOtF+NaZyBLV8
   rA5KiHVS4KRxawrQ8CSKruMlq2lbrgKR1xMNTtQ0wdkC/pvNTaUcc0O+O
   g==;
X-CSE-ConnectionGUID: paT8CLaOTGStlw9ZjbkMQg==
X-CSE-MsgGUID: Vt7vnZMOT5+EmI8c2BSUEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74602140"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="74602140"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:25:26 -0700
X-CSE-ConnectionGUID: K3HC3Fq7QQqsQ3CC3yDCGA==
X-CSE-MsgGUID: tQgWyHfURoGEvea3m/DKBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="220073034"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.133])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:25:25 -0700
From: thomas.falcon@intel.com
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] tools/perf: Fix ratio_to_prev event parsing test
Date: Tue, 24 Mar 2026 17:25:17 -0500
Message-ID: <20260324222517.18848-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Falcon <thomas.falcon@intel.com>

test__ratio_to_prev() assumed the first event in a group is the leader,
which is not the case when the event is expanded into two event groups
on hybrid PMU's with auto counter reload support. This patch updates the
test to iterate over the event group generated for each core PMU. Also
update "wrong leader" test to check that the subordinate event has the
correct leader instead of checking that it is not the group leader.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and regression tests")
---
 tools/perf/tests/parse-events.c | 45 +++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 1d3cc224fbc2..cd48e6b2bb57 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1796,31 +1796,38 @@ static bool test__acr_valid(void)
 
 static int test__ratio_to_prev(struct evlist *evlist)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_core_pmus() == evlist->core.nr_entries);
 
-	 evlist__for_each_entry(evlist, evsel) {
+	for (int i = 0; i < num_core_entries(evlist); i++) {
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
 		if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
 			return TEST_OK;
 
-		if (evsel == evlist__first(evlist)) {
-			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
-			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-			TEST_ASSERT_EVSEL("unexpected event",
-					evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
-					evsel);
-		} else {
-			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
-			TEST_ASSERT_VAL("wrong leader", !evsel__is_group_leader(evsel));
-			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 0);
-			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-			TEST_ASSERT_EVSEL("unexpected event",
-					evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
-					evsel);
-		}
+		/* cycles */
+		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_CPU_CYCLES),
+				  evsel);
+		/*
+		 * The period value gets configured within evlist__config,
+		 * while this test executes only parse events method.
+		 */
+		TEST_ASSERT_VAL("wrong period", 0 == evsel->core.attr.sample_period);
+
+		 /* instructions/period=200000,ratio-to-prev=2.0/ */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 0);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS),
+				  evsel);
 		/*
 		 * The period value gets configured within evlist__config,
 		 * while this test executes only parse events method.
-- 
2.43.0

