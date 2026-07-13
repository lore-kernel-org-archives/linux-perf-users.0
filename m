Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978413B27D1;
	Mon, 13 Jul 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931611; cv=none; b=vCfygr+FGFSFRph6ne1uSk6SqaA7EEORirwe2C6FFeJESYgZ4Z40LFsHm84HQ3vthlEaOts9aaBdt9W4XZD8G8GEZtFtwkVpTW2JFsYzjAsp7JvCBT1lFMJcLN0vVfpk0lYlhZb8U//YHoZvZRWU+7eXQEXKBU5dplUy+0DW0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931611; c=relaxed/simple;
	bh=DcOI7EZ0TTJBDSjx6kp1rzsC4VDAXCxgLjZlrTLAFcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lT7CjdD5BhwZrEgCizY0cFm8L+fmc6aTeGi6krniw6TDN7iABnSdMWiPrMGJ3xUh1J+5w/jfsKQXht0EFYXbKwL9o1ISzu8wdq4rDJsoawnYTCVuFjMP4KJLgYU5jgS6iYTjzG1+VYTpsTRLlHHetb/Gxyz8/TrKz0mtLi2jZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exBDXJdL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exBDXJdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783931606; x=1815467606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DcOI7EZ0TTJBDSjx6kp1rzsC4VDAXCxgLjZlrTLAFcc=;
  b=exBDXJdLHa1K9vCWY3N2TWkSL7Cuz0MFRhC5J0TodLyLN2mSut4Pc6hu
   zOyeY0UqPsFpci5X5k6TEOVD3FudhqGRlg8TQfMKIU+Ed25T7+sDWdSC9
   bZ2nofJhuQ27PLXUmBQ+32eWGeX1v3MEsMNYbpZngEquZT/KHL1ylvq/x
   bgMWlrAK7tBaALrvt89w/Gp3LbgGmjz8UzgnCGqbs1uxRwD5ut7cK7f8I
   svkjVvp728iQZ+9DVv4QcYbO9cX2lxEelz3UIMU73yGrVm7PPv/M1YkCI
   YcgbzKTHU3RfOtJaoTa12MX8dgL7/IXjA0y46/WCyB1q4h3YzefJOkto7
   g==;
X-CSE-ConnectionGUID: EAPHmlZJRWmDkl8ZZMjPzA==
X-CSE-MsgGUID: OfK/1MjYSDuWs/NYnszlew==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390069"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390069"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 01:33:23 -0700
X-CSE-ConnectionGUID: hj3JmzqeSjqqQEYkyya8ng==
X-CSE-MsgGUID: jJ3z3F0ESziM2CcIA2iL9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255560733"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 01:33:20 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 0/7] perf/x86: Miscellaneous PMU bug fixes and optimizations
Date: Mon, 13 Jul 2026 16:27:27 +0800
Message-Id: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Patch 3/7: Ensure cpuc->pmu is not the static pmu before calling
  hybrid_pmu(cpuc->pmu) in intel_pmu_cpu_dead() (Sashiko).

This series fixes recently found x86 core PMU bugs. Most of bugs are
found by Sashiko in reviewing the "Support SIMD/eGPRs/SSP registers 
sampling for perf" patch-set, e.g.,
https://lore.kernel.org/all/20260706022123.480411F000E9@smtp.kernel.org/
https://lore.kernel.org/all/20260706021852.DE2ED1F000E9@smtp.kernel.org/

The last patch 7/7 optimizes ACR handling in match_prev_assignment() and
mitigate the performance overhead.

Tests:
Below test cases are run on Diamonds and Novalake. No issues are found.
- Perf stat test
  $ perf test 119
- Perf record tests 
  $ perf test 155
- Perf record LBR tests
  $ perf test 156

History:
v1: https://lore.kernel.org/all/20260710065128.1799838-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (7):
  perf/x86: Unregister PMI handler on PMU init failure
  perf/x86: Free hybrid state on PMU init failure
  perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
  perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
  perf/x86: Remove stale fixed counter helper and fix hybrid PMU access
  perf/x86/intel: Fix intel_cap handling on hybrid PMUs
  perf/x86: Optimize ACR handling in match_prev_assignment()

 arch/x86/events/core.c       | 45 +++++++++++++++++++-------
 arch/x86/events/intel/core.c | 61 ++++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h | 12 ++-----
 3 files changed, 81 insertions(+), 37 deletions(-)


base-commit: edda9051e267b7390c7ce24b1b71434414ad156e
-- 
2.34.1

