Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7520276027;
	Fri, 28 Feb 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772438; cv=none; b=Rvqbd8xCvnjCLTtmCM51AHKDkdvI7XATt437tztTRMi2iv8w5LIGqcN8evSy76S+vEIuHpFXHOC5ZQeHss4gMvcBwvphExu/11Qj1txw2pbqB961g9/GY7oR2KuKt6U09F8l0Uy3Dy4wCJQrwZTDq0sl+YExjQJnp5DfV9XV2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772438; c=relaxed/simple;
	bh=/XH79EmqZl8K0OrxFZw/WEPOCqQyhyfy8x5Gy0s2Ggk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niIOOcLtSquwbcAWuMaj62i8FWBLPIZ8yqHklxtD9wRsSit2vgg0mimAEW3uGlwAm0wpJRWe38atqQVbGZtd2d1rRWGwpT8ZU2J3al+8EdfhV8hTpc+2+wJBoSkXAqkcMGc7m8zqv4xuG2HnxB8Sd7Cg2yPI+p72/ctr5CNi5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ywy/lHFD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ywy/lHFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740772437; x=1772308437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/XH79EmqZl8K0OrxFZw/WEPOCqQyhyfy8x5Gy0s2Ggk=;
  b=Ywy/lHFD6+27KBChViFakYLBoSjMGPpOJ/czhtp3gVsvPLWKPycjfFfN
   7pW78st+ZWJw8sOO4TxMXX4pOw32QsxHA/BJhdV7i1EGPCxMbQnbULbKs
   7KEM4L+i41bvfjY6E2t5UtEePHtcg/Hk9/ulXBbmwgdi5Yt59kWepU9BV
   92WSYoucokCaiiR02BRhT2LhMAxDHzbqGxMvtYGz8fWGIcycVMEdM5VYi
   419MISbavjBqYPCyDG5uN8Jpskdc2wa5qgIl7Q4x3VY3uc5kxCTvw734A
   jTLsy1eJ6Og6KxrvM2CiCYCjwaCPzsWLEOzNjZSW863BY8uVBqJL/FXgi
   Q==;
X-CSE-ConnectionGUID: zffUTvGCRuK3dG6wrC2EQg==
X-CSE-MsgGUID: jiH0pbQOSGm5Tum2EocQvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41633140"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41633140"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 11:53:56 -0800
X-CSE-ConnectionGUID: L7IzgDXOTIiV0GiWviUL/g==
X-CSE-MsgGUID: ghGfT8WBTBShlKN3tlKBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121553798"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.30])
  by fmviesa003.fm.intel.com with ESMTP; 28 Feb 2025 11:53:54 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf stat: Fix uniquify for hybrid systems
Date: Fri, 28 Feb 2025 13:53:51 -0600
Message-ID: <20250228195351.1160071-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, perf stat is omitting the pmu name for legacy events
on hybrid systems. git bisect indicated commit 357b965deba9 as the cause:

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[357b965deba9fb71467413e473764ec4e1694d8d] perf stat: Changes to event
name uniquification

Include an additional check for hybrid architectures when determining
whether to uniquify legacy events.

Before:

$ sudo ./perf stat -e cycles -a sleep 1

 Performance counter stats for 'system wide':

       173,903,751      cycles
       666,423,950      cycles

       1.006615048 seconds time elapsed

After:

$ sudo ./perf stat -e cycles -a sleep 1

 Performance counter stats for 'system wide':

       841,496,603      cpu_atom/cycles/
     3,308,929,412      cpu_core/cycles/

       1.002483283 seconds time elapsed

Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/stat-display.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e65c7e9f15d1..df9f68080ec9 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1676,6 +1676,7 @@ static bool evlist__disable_uniquify(const struct evlist *evlist)
 
 static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config)
 {
+	bool hybrid = (!config->hybrid_merge && evsel__is_hybrid(counter));
 	struct evsel *evsel;
 
 	if (counter->merged_stat) {
@@ -1688,7 +1689,8 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
 		return;
 	}
 
-	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
+	if (!hybrid && counter->core.attr.type < PERF_TYPE_MAX &&
+		counter->core.attr.type != PERF_TYPE_RAW) {
 		/* Legacy event, don't uniquify. */
 		return;
 	}
@@ -1705,7 +1707,7 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
 		return;
 	}
 
-	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
+	if (hybrid) {
 		/* Unique hybrid counters necessary. */
 		counter->needs_uniquify = true;
 		return;
-- 
2.48.1

