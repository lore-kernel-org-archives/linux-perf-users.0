Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38743B71D3;
	Thu, 17 Sep 2026 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669245; cv=none; b=sN9zsifc8GSaM5JOj//7bPwfBPlhc+aG+PuEmS962tbkO4p+CFz2FqGu79vIn3ULX46RIb2LlSI1e0ynbu+gNZgMjFtCBLlXJADDtT56hT6VhzS5l1kk4Iv0UmxH+JiXLN/Gkf8kLExdhYs0ezRpeye1GrMuOvxoS0MCtB7gQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669245; c=relaxed/simple;
	bh=vvfHoDaghB5jOIUHhmJ4dMJxk8nxK5NWiOJsN3T0Fnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MU2PRP8cJYw4dpPxwUGFTUL0mIBzTRc3L1yiqDw5658aGE9RhE0h+Sgp/5CmUJuHzWvluRNUMI6NTptbb4XHqFj7o1TggJZwTDkQkYCXSzmnQeGLoaXHlsHxNBQFbvKIPxkUEYFRULS5wJV8RJ4qZIbz4NX6hA5c7fsGw649QO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKDDSC8/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKDDSC8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789669244; x=1821205244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vvfHoDaghB5jOIUHhmJ4dMJxk8nxK5NWiOJsN3T0Fnk=;
  b=QKDDSC8/iiF1fOc4ywXnTVaK8V+4BLSMqmiASUEbUaR0CjvUItguOXOx
   MzwC0Co9nYV0KZcF0kXkQk55OmIRvkOktaVHDkrBlcQSVnbcZnw084FG8
   HuwWcyG+JabZSAR5OWA9tmdiVx6wJ0DFSSEInUEbOLMpoG4NpEGRPV4P4
   Zp0UKtCc5jcYyuU5x37iwsYMyjql+SZ0QDd4sk+UaLEgLGaKGUBePgUwy
   PjV6m/cT48K1iv+MEyZOk3mRT2ytYUa6jqdvXq/JQAOcEvclHQNX9wyle
   J4EcbgB312g/VMkuIcKk0WAKlSN1HqeoOXuseKSivcPGw8193YKRu6sdq
   Q==;
X-CSE-ConnectionGUID: c3q66Hy/TVqXiKtIlV2rqA==
X-CSE-MsgGUID: HhO1U04QSFKOH49NlKzhog==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115658923"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115658923"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:20:42 -0700
X-CSE-ConnectionGUID: chz2lMONQJKUYleHV7KFkQ==
X-CSE-MsgGUID: PNq84K0hRX+sXE+wIpomjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279195620"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:20:41 -0700
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
Date: Thu, 17 Sep 2026 11:10:16 -0700
Message-ID: <20260917181016.381994-1-zide.chen@intel.com>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
v2: include stdio.h and string.h for musl compatibility.
---
 tools/perf/arch/x86/tests/topdown.c | 30 +++++++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.c  |  3 +--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 2b6f47ce4932..520075329c37 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <stdio.h>
+#include <string.h>
 #include "arch-tests.h"
 #include "../util/topdown.h"
 #include "debug.h"
@@ -229,10 +231,38 @@ static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unu
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

