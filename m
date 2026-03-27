Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F282459ED;
	Fri, 27 Mar 2026 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576871; cv=none; b=KdVaThP5KgmCdwxv+qKMXnTd4OvISXC2UMFo3yEfYMJ8gAtCRJrctKdPCdeLvNmBMba2eBSpQda7tW3k0hrzXpIZlekYHVMGgRCrqHWzbStcck0YqAwiw+Lx5uhfWpA+qSsXQgo12r2yhu0YixFhkpg80NxFBOANRITZt1eYA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576871; c=relaxed/simple;
	bh=lm4GgxybwwidOqLkbYnIhl2+Y52RYXiGaq9QVQYmpSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwC4RhpvauHovClAKkzYUh6E43OHj480D5T/XoGjufGbKVkfrULFtYwGw18xo2gGhO+wv1Q2NO8jIICopDzPeD+vNY9KaGc4Bn6HGNxs4eR3kZBXs9RrnDbRRexORpZtjwpy+eB+A6/PC1VHKPZwlNgQaJ0aINsTQpDdKr4t/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX+hEYfM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX+hEYfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774576869; x=1806112869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lm4GgxybwwidOqLkbYnIhl2+Y52RYXiGaq9QVQYmpSA=;
  b=JX+hEYfMjZqon6bumcXhRjW400+G8+lmK0wo3CYwWv2ybysJUMaWXLUr
   zXXS82plBrCbUC6qDZ3C5zDkJz90y9KosdHG+WczvcgcB8GaxrsBesQKx
   y6F2oNywlSZTqwEm00o4Az36+yQQOBdMBE0XTlxivo0s3ExoJiLkxC6Qi
   XlhGjRtwI/QNgTJhula+EjVLuPsD1LVfAHfnylJ7fhcz8nH+zWZhOORwY
   hyNQ/yyyReItpZJTPuVRBSimA+Q19CVBpI62Ue85ebn57lbNPbNanOY1z
   jT87P/QUJFKLgdvPqGtMQ+jVDC8fDxkyJmLM20yrcSiHa3IMFS/EF0SfQ
   Q==;
X-CSE-ConnectionGUID: CGLg3qCeTgmM6nOY/vHOFw==
X-CSE-MsgGUID: pHxZWyL3Qe2jbLz1XigNdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75847834"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75847834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 19:01:08 -0700
X-CSE-ConnectionGUID: yAVhJ9jjSaeOK15NuR/Jnw==
X-CSE-MsgGUID: aVzYuVZwTRaIQ5z5hVzSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="263085708"
Received: from vverma7-desk1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 19:01:06 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v3] tools/perf: Fix ratio_to_prev event parsing test
Date: Thu, 26 Mar 2026 20:59:27 -0500
Message-ID: <20260327015927.223999-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
References: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test__ratio_to_prev() assumed the first event in a group is the leader,
which is not the case when the event is expanded into two event groups
on hybrid PMU's with auto counter reload support. Instead, iterate over the
event group generated for each core PMU. Also update "wrong leader" test to
check that the subordinate event has the correct leader instead of checking
that it is not the group leader. Finally, do not exit immediately if a PMU
without auto counter reload support is found.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and regression tests")
---
v3: Fixed early loop termination if PMU without auto counter reload support is
    encountered first, suggested by Ian Rogers
https://lore.kernel.org/all/CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com/

v2: made changes suggested by Dapeng Mi
https://lore.kernel.org/all/997b6291-7429-4eaa-8467-1fd88e100616@linux.intel.com/
---

 tools/perf/tests/parse-events.c | 49 +++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 1d3cc224f..05c3e899b 100644
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
-			return TEST_OK;
-
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
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel != evsel__leader(evsel) ||
+		    !perf_pmu__has_format(evsel->pmu, "acr_mask")) {
+			continue;
 		}
+		leader = evsel;
+		/* cycles */
+		TEST_ASSERT_VAL("wrong config2", 0 == leader->core.attr.config2);
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
2.51.0

