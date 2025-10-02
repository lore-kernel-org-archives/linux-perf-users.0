Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854342C08D5;
	Thu,  2 Oct 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448615; cv=none; b=Iz9ekUKbUTK1FY0Uj/FQik+ED1pk86GvA6EEy/jQF0t93Nqm4dNrlcN8apyOVRkCQXwTsmE416IVYTRjs773RdB583CbJatGCQAU8Ywc4Z+8vVrhgLdQxhL4Sye/JxFMdyE9vccBqTyzT0+5P7KDBLsO/tqFUBSlfpQleYrnDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448615; c=relaxed/simple;
	bh=53y8mTKwYGU9EQpfzk/NGpruUlqMD9aiccI+mmERdBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDltKTB3Vphl5kkzSZbCY5dQ0eg025kAooXyuCrC7BBT5elDTJgeCY14RCy3SvHompV6qwrX8NQLxO9+OREJpaEJ/etnkLjyrJ2YfrnI/qlGG0+d1a/N3oQ7FoiUXS+SSzvO77HlGxPutzf4UpMwUUrR6f5uREkgHq2kv5JSfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6cxv/B0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6cxv/B0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759448614; x=1790984614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53y8mTKwYGU9EQpfzk/NGpruUlqMD9aiccI+mmERdBg=;
  b=X6cxv/B0eed+7jj82xh4eNcAav310t96jVLvio6XARHMSWVetz/HI9am
   JWm4WLmI1pfv6evWswgrYUemavVWfpdPYm6grZLufud0TSimCNhSYppx+
   Pges+PXWx/D+iivM1chhwIWDyJzgvDZPVoOmFo2XVzXPQbNC98mk2Bre/
   Y2MdJwIkBpVcsnUrABp0z+s5lH8g7bjqwEtO0PvSI1LjmmX891jVQi3UV
   FD1Ugfbb1merMdPAC1IRz4soqI97HG0V3++BV/HGBjgqQJs7FQaGdUdSf
   HGUsi43cMqilTUz6sKQ9LDrPHwBL2J4VTD3boIChOvLRlsr74k4PqkBKW
   g==;
X-CSE-ConnectionGUID: mltELkH8TwqieYu98yrnlA==
X-CSE-MsgGUID: GFcz0VFLQTG/YwWSWTNRvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="60948401"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="60948401"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 16:43:33 -0700
X-CSE-ConnectionGUID: TWYbA5FgRiaf6JbFs5CK/A==
X-CSE-MsgGUID: kyvZrzOsTO2S42W5shpXwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="178444545"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.53])
  by orviesa010.jf.intel.com with ESMTP; 02 Oct 2025 16:43:32 -0700
From: thomas.falcon@intel.com
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
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [Patch v3 2/2] perf record: Add auto counter reload parse and regression tests
Date: Thu,  2 Oct 2025 18:43:06 -0500
Message-ID: <20251002234308.64218-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002234308.64218-1-thomas.falcon@intel.com>
References: <20251002234308.64218-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Falcon <thomas.falcon@intel.com>

Include event parsing and regression tests for auto counter reload
and ratio-to-prev event term.

Reviewed-by: Ian Rogers <irogers@google.com>
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

