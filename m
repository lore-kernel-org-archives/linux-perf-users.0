Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE44DAF87;
	Wed, 16 Sep 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591086; cv=none; b=J+Frpk2L9JW36M472CzJUS5rniddLjl+WsFFythfb61Rtg5jzgqhMfbopSmehG8TFcx0obpfDReKD24kQQzrm4lllGA93vP0ExHTSL1WcMQk/tiLjA2DT0E9LfOgb5jI3+8lRPhrWkcO1R5rbn6nE2FJbjpzTlWWk/Hve7BjMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591086; c=relaxed/simple;
	bh=ay5/0symFws9XMwCKMYAdNh2eKNS2sl33H+ddFWjN4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3aJFIb6JLK6Kfi/+1ZnWUyIvrMxfVKsmqN9Zxp30OOt6uu2+fvrmP7k6IZcpDosbZbobI+ugcVTj2eUqDJ0FN6EfqHEE1lb1B7vpqCFvCtKILDltpytfVzYI3nLPmHaBJi94IM7KLxtLXhaYVUWDPzv0hZn3n+/mZ6dWC2n/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mogBdBb9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mogBdBb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789591073; x=1821127073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ay5/0symFws9XMwCKMYAdNh2eKNS2sl33H+ddFWjN4o=;
  b=mogBdBb9+cRejapQK2b8dY+CP+TRHe+QlUnAaZmfQx6WMTSWYgphS0rp
   adl3doXIAcv0B4T+AlkCJJr/9onUua6FIu+5y4nuGyz3XWcHX0fexkitF
   JkQ9KiCxe7PJMXKst0dNhKeaOE0fgN4p6t+/Rfq0RpoFJCCe9HDxmWVSD
   4EPJUj6hlRPt3yk1xC2wY4pihdFTSkKsRgsA2VjtZXyorWpcj2QZM3QGc
   hlZsSTUGSqYvszIzo9YgToe2u4Ks1l1N/9xvr8A0MzkYUbk//F97qCKOD
   bbk8DS95AlfWMG6taxUrmKNIWES9pez4yS/EElDfGD5YpoIXVn6bNbSJL
   A==;
X-CSE-ConnectionGUID: iVfMy9svQa60T8XKpXZ10A==
X-CSE-MsgGUID: +arf3sJMRwaWjDdK+NsK2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100574713"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100574713"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 13:37:47 -0700
X-CSE-ConnectionGUID: 3DPbwcs4TrqCt5vPk+XoJw==
X-CSE-MsgGUID: u9hG+TBVQqafGplgqyBNVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="278674100"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 13:37:46 -0700
From: Zide Chen <zide.chen@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	thomas.falcon@intel.com,
	dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] perf topdown: Don't require config1==0 for a slots event
Date: Wed, 16 Sep 2026 13:27:40 -0700
Message-ID: <20260916202740.257376-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_is_topdown_slots() requires config1 == 0, so it misidentified
"cpu/slots,metrics_clear=1/" as not being the slots event, and an
additional slots event gets inserted, which fails event scheduling
since the group now needs two fixed counter 3.

  $ perf stat -e "{cpu/slots,metrics_clear=1/,cpu/topdown-retiring/}" -- sleep 1
  WARNING: events were regrouped to match PMUs
       <not counted>      slots
     <not supported>      cpu/slots,metrics_clear=1/
       <not counted>      cpu/topdown-retiring/

Drop the config1 == 0 check from arch_is_topdown_slots(). This is
safe: config1 has no bearing on the event's identifying config value
(TOPDOWN_SLOTS, 0x0400).

The attr.type == PERF_TYPE_RAW check is what actually matters: only the
core PMU is registered with PERF_TYPE_RAW, and on x86, 0x400 is
guaranteed to be slots event on core CPU.

arch_is_topdown_metrics() keeps its own config1 == 0 check, since
genuine metrics events have no "metrics_clear" and config1 remains 0.

Add a test verifying that an explicit "slots,metrics_clear=1" event in
a group does not trigger an extra slots event injection.

Fixes: 5b546de9cc17 ("perf topdown: Use attribute to see an event is a topdown metic or slots")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/perf/arch/x86/tests/topdown.c | 28 ++++++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.c  |  3 +--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 2b6f47ce4932..b1ce9f83db00 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unu
 	return TEST_OK;
 }
 
+/*
+ * An explicit "slots,metrics_clear=1" event is still the slots event and
+ * must not cause an extra slots event to be injected into the group.
+ */
+static int test__x86_topdown_metrics_clear(struct test_suite *test __maybe_unused,
+					   int subtest __maybe_unused)
+{
+	struct perf_pmu *pmu;
+	char event_str[128];
+	int ret;
+
+	if (!topdown_sys_has_perf_metrics())
+		return TEST_OK;
+
+	pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
+	if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
+		return TEST_OK;
+
+	snprintf(event_str, sizeof(event_str),
+		 "{%s/slots,metrics_clear=1/,%s/topdown-retiring/}",
+		 pmu->name, pmu->name);
+	ret = test_sort(event_str, 2, 1);
+	TEST_ASSERT_EQUAL("explicit metrics_clear slots event isn't duplicated", ret, TEST_OK);
+
+	return TEST_OK;
+}
+
 static struct test_case x86_topdown_tests[] = {
 	TEST_CASE("topdown events", x86_topdown),
 	TEST_CASE("topdown sorting", x86_topdown_sorting),
 	TEST_CASE("topdown slots injection", x86_topdown_slots_injection),
+	TEST_CASE("topdown metrics_clear no extra slots", x86_topdown_metrics_clear),
 	{ .name = NULL, }
 };
 
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index bafd285119d7..64bc64e335a2 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -37,8 +37,7 @@ bool topdown_sys_has_perf_metrics(void)
 bool arch_is_topdown_slots(const struct evsel *evsel)
 {
 	return evsel->core.attr.type == PERF_TYPE_RAW &&
-	       evsel->core.attr.config == TOPDOWN_SLOTS &&
-	       evsel->core.attr.config1 == 0;
+	       evsel->core.attr.config == TOPDOWN_SLOTS;
 }
 
 bool arch_is_topdown_metrics(const struct evsel *evsel)
-- 
2.55.0

