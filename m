Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18E1A682A;
	Thu, 26 Mar 2026 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548097; cv=none; b=hEqmQKxh2Bl3BQhK/RC+zaThPBLL/4DDceX48sI9zBg9kZnjWSLjfuorjdzfoK83I3selrZ2+K+N8fGUl7dWmAq2v7DEbkB5voOK/qru+VvcoIeDzboG9bo7THzkgGop/qDq1hEDmx8VfGVSh7xfSwCgV2yk5ftvHr9eZ/Ajg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548097; c=relaxed/simple;
	bh=w+uWFNXtN9jPl1oaA8L37NXapdUI1FmQ+AdozvoTib8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVNo6wQt8zpE6VlSF3UC2vGaSazLTCInS3gHFUwGkSPuXHlm6PUuyS40MZyl9RipRr3nyllcy/GBWaCMappdYOEhHwYbiZTqcCu8Pl/GyKx0Gi3ynbfYA3XYkF9SCd10QL5zipRa1+jm0QW7wsPM+wRbVP3GhxErckfLGecPMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDVtkwSe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDVtkwSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774548095; x=1806084095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w+uWFNXtN9jPl1oaA8L37NXapdUI1FmQ+AdozvoTib8=;
  b=EDVtkwSebOG8eQyRc/UK1+yteDom8LHrdR+2eMB6/gOaeQF3Z3rkkvqU
   KWxBN2vIC9qIt3hWZJxnfbgyY7QZUG1vFY9DXmLQxurDMRVDeer/9xzfJ
   g4bU6m/bDvjbqJt1NXjH4ZFNH66EMxDPNyYPGteVKQhKzBNhP13gHct1b
   dycO1oHGm030F8cXbD0t2k3zfeS5P83GxtYfdW1cjHE3tSeeXBhpuCMai
   xknpNgESwZc3YBqCxckha5ydM22Rkic9vluvzl+IlQajNhYausJsafkeA
   1tPpmUfETECxc6PSPqkW3KRidwxNKKgLkjz2E7NASMDmnatFDdWhkg7+l
   w==;
X-CSE-ConnectionGUID: gZ6QF7r1R0yUqjYSMvwy7w==
X-CSE-MsgGUID: EaPgBoo+ScORHsyvPSlisQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74800279"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74800279"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:01:32 -0700
X-CSE-ConnectionGUID: wdT7pRvWRmO+CkrRagiv8Q==
X-CSE-MsgGUID: cTMY24xVTCi1C2GY4yKGTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="220218890"
Received: from vverma7-desk1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.1])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:01:30 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2] tools/perf: Fix ratio_to_prev event parsing test
Date: Thu, 26 Mar 2026 13:01:25 -0500
Message-ID: <20260326180125.168536-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test__ratio_to_prev() assumed the first event in a group is the leader,
which is not the case when the event is expanded into two event groups
on hybrid PMU's with auto counter reload support. This patch updates the
test to iterate over the event group generated for each core PMU. Also
update "wrong leader" test to check that the subordinate event has the
correct leader instead of checking that it is not the group leader.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and regression tests")
---
v2: made changes suggested by Dapeng Mi
https://lore.kernel.org/all/997b6291-7429-4eaa-8467-1fd88e100616@linux.intel.com/
---
 tools/perf/tests/parse-events.c | 47 +++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 1d3cc224fbc2..4487508c5658 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1796,31 +1796,38 @@ static bool test__acr_valid(void)
 
 static int test__ratio_to_prev(struct evlist *evlist)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_core_pmus() == evlist->core.nr_entries);
 
-	 evlist__for_each_entry(evlist, evsel) {
-		if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
+	for (int i = 0; i < num_core_entries(evlist); i++) {
+		leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		if (!perf_pmu__has_format(leader->pmu, "acr_mask"))
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
+		TEST_ASSERT_VAL("wrong config2", 0 == leader->core.attr.config2);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(leader));
+		TEST_ASSERT_VAL("wrong core.nr_members", leader->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(leader) == 0);
+		TEST_ASSERT_EVSEL("unexpected event",
+				  evsel__match(leader, HARDWARE, HW_CPU_CYCLES),
+				  leader);
+		/*
+		 * The period value gets configured within evlist__config,
+		 * while this test executes only parse events method.
+		 */
+		TEST_ASSERT_VAL("wrong period", 0 == leader->core.attr.sample_period);
+
+		 /* instructions/period=200000,ratio-to-prev=2.0/ */
+		evsel = evsel__next(leader);
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

