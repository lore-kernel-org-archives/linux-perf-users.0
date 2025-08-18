Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BB253F03;
	Mon, 18 Aug 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537253; cv=none; b=Sy8yIhrHrpRfNZRLvYBif4fQd9EgPHLh2xy5WrWR55sMoMYG6fH0PUtzoAwUSLoPvtS9jg2xh4jAGz6SUs75cyBhWqoXFzTqu3DoztpyTZCsmSrkuFACB/9/YDzWdQ1wLLrfJdsS0E6GGUZq2WDQVeitJ2P22S4b5b0RYsvaeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537253; c=relaxed/simple;
	bh=Ao1u5mWLcffmdlkohbo84IUaqTvWkpqLbl0RYa+WiHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ikc92tOtRyDAsJcNYL/oVdTczW2z1q8gzQN3KE5dOoVRliPLXV8DuTXqp3YVVE6BkpG5q1psIgXUemLV6BuPbIfJUlnglImst/jECGd2lNd6uKrO7kYbwoOYsTYTLRvELpuZnk5urFGTQ/M22s596wMaYJ6f7PRKeL/oa2dCDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfKgnjrT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfKgnjrT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755537252; x=1787073252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ao1u5mWLcffmdlkohbo84IUaqTvWkpqLbl0RYa+WiHc=;
  b=OfKgnjrTFIV9cgV/2vI0hUltF1bkN3EFnoHXuWYtAzcNN0nrQyNrEilD
   uVPIDqFrOygdZ2VWU1xsgXc2uXBmmPjlZWx94fiy0TyoDB7A2Pba+kdYZ
   CAuYPkbMaS0ndyPRrxKq2wzkamZ+LEIaRhDyqlRTymWjrfUP5Geh5SIBk
   vqZMoheGPenm7R3APB9avGZ2Al3W9YjBGzNqXKIiul9FGQL2m3IJRCffh
   fiE0wTUsrYgmq0/91hSacec0UrbkOA1egUjjPhbzGFUBkIRn2hyFfWyUe
   XP6qdCuvRvvlgg/+KaHD4wCen0pjCWMt6scKTsWQqpxtgefQ/fGNP4m8/
   w==;
X-CSE-ConnectionGUID: M+GnqwjDQqCNkgFLXCcwKg==
X-CSE-MsgGUID: yT/GCQ70STWosxEc2UvsRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="80350278"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="80350278"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:14:12 -0700
X-CSE-ConnectionGUID: SEv656NRRASwgJI3Lj1gAQ==
X-CSE-MsgGUID: qsC6eq+/RnukgGXF7wLICg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167137052"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.125.108.14])
  by fmviesa007.fm.intel.com with ESMTP; 18 Aug 2025 10:14:10 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	ak@linux.intel.com,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH v2 2/2] perf record: Add auto counter reload parse and regression tests
Date: Mon, 18 Aug 2025 12:13:55 -0500
Message-ID: <20250818171358.332331-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818171358.332331-1-thomas.falcon@intel.com>
References: <20250818171358.332331-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include event parsing and regression tests for auto counter reload
and ratio-to-prev event term.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/tests/parse-events.c  | 54 ++++++++++++++++++++++++++++++++
 tools/perf/tests/shell/record.sh | 40 +++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index bb8004397650..67550cc60555 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1736,6 +1736,53 @@ static int test__intel_pt(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static bool test__acr_valid(void)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (perf_pmu__has_format(pmu, "acr_mask"))
+			return true;
+	}
+
+	return false;
+}
+
+static int test__ratio_to_prev(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	int ret;
+
+	TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_core_pmus() == evlist->core.nr_entries);
+
+	 evlist__for_each_entry(evlist, evsel) {
+		if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
+			return TEST_OK;
+
+		if (evsel == evlist__first(evlist)) {
+			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
+			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+			ret = assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cycles");
+		} else {
+			TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
+			TEST_ASSERT_VAL("wrong leader", !evsel__is_group_leader(evsel));
+			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 0);
+			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+			ret = assert_hw(&evsel->core, PERF_COUNT_HW_INSTRUCTIONS, "instructions");
+		}
+		if (ret)
+			return ret;
+		/*
+		 * The period value gets configured within evlist__config,
+		 * while this test executes only parse events method.
+		 */
+		TEST_ASSERT_VAL("wrong period", 0 == evsel->core.attr.sample_period);
+	}
+	return TEST_OK;
+}
+
 static int test__checkevent_complex_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -2249,6 +2296,13 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_tracepoint,
 		/* 4 */
 	},
+	{
+		.name  = "{cycles,instructions/period=200000,ratio-to-prev=2.0/}",
+		.valid = test__acr_valid,
+		.check = test__ratio_to_prev,
+		/* 5 */
+	},
+
 };
 
 static const struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index b1ad24fb3b33..0f5841c479e7 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -388,6 +388,45 @@ test_callgraph() {
   echo "Callgraph test [Success]"
 }
 
+test_ratio_to_prev() {
+  echo "ratio-to-prev test"
+  if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
+     true 2> /dev/null
+  then
+    echo "ratio-to-prev [Skipped not supported]"
+    return
+  fi
+  if ! perf record -o /dev/null -e "instructions, cycles/period=100000,ratio-to-prev=0.5/" \
+     true |& grep -q 'Invalid use of ratio-to-prev term without preceding element in group'
+  then
+    echo "ratio-to-prev test [Failed elements must be in same group]"
+    err=1
+    return
+  fi
+  if ! perf record -o /dev/null -e "{instructions,dummy,cycles/period=100000,ratio-to-prev=0.5/}" \
+     true |& grep -q 'must have same PMU'
+  then
+    echo "ratio-to-prev test [Failed elements must have same PMU]"
+    err=1
+    return
+  fi
+  if ! perf record -o /dev/null -e "{instructions,cycles/ratio-to-prev=0.5/}" \
+     true |& grep -q 'Event period term or count (-c) must be set when using ratio-to-prev term.'
+  then
+    echo "ratio-to-prev test [Failed period must be set]"
+    err=1
+    return
+  fi
+  if ! perf record -o /dev/null -e "{cycles/ratio-to-prev=0.5/}" \
+     true |& grep -q 'Invalid use of ratio-to-prev term without preceding element in group'
+  then
+    echo "ratio-to-prev test [Failed need 2+ events]"
+    err=1
+    return
+  fi
+  echo "Basic ratio-to-prev record test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -404,6 +443,7 @@ test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
 test_callgraph
+test_ratio_to_prev
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.50.1

