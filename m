Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9B23AB81;
	Wed, 20 Aug 2025 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657093; cv=none; b=jT3yo8leEos/5Kmm/B2QoNfgQGmhDdsiX+PlJsiY+84n2IJxBnbxWtL2siz1F80FQNmIN+QH88RAxbSimvHgBwlalOVjfEUBJGCsmBuaiX4Px9WZjqCIP+TmS250xKUutJQa9Q8qCJe1Jp5NENAFMwjvIZfJm7b+VPHlHS04M1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657093; c=relaxed/simple;
	bh=ya0zmDcFvNi2I50AfYu4NFeHWr8hhrqjQpzBwIfFagQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAg338Q2M6JoxRxNNtZSyba/LCln8FdUoo/nJ/FwKfENF50j9T8kdwx+KSdDXMYdAPpc8mkYGlesrlsOt1X2GXEDo5x2jayQPb/U+oM1lqkDsLcw6Nb2M51xbLwZkXkjFQ1aiNIrwz9DDCt9JUeIN9UdJ7l04/I7hRO1+xZW4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q37oU/7s; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q37oU/7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657092; x=1787193092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ya0zmDcFvNi2I50AfYu4NFeHWr8hhrqjQpzBwIfFagQ=;
  b=Q37oU/7sW8Lpk5c/59bYpsq3gp3WIcYIe8ERU3N4X6MKxNRMH+ocv6sq
   99FtgCGzri/fI34YF90q/fMyoZnoBIOo6YHMtoAqBNJJvGvFn4AYgW5Iu
   KilYFlue/oazxzbWCBP8x5X/6g8CjkS2lUbfS0VyNYF7i7hoaxJSgzpDy
   7hH2iAsrl/IsfRB+HWW8N2BQP4oMzmNF2U+a+I0ywR6dyiBofHByDEilb
   MKvf737AtMpXgBuW17sFh4X2vA3dA0TUannYC5c9907EuARvalmkCoHHf
   vegM6Liv0Ssx8phrInEJSo+wS6J5khS//qKR/z5jYoxKlSYkboCqElzzs
   A==;
X-CSE-ConnectionGUID: 8G+cN0tERAOpaUtU+7hTCA==
X-CSE-MsgGUID: dkbqrs1tQ7+hFumpQzm1aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625428"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625428"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:31 -0700
X-CSE-ConnectionGUID: Y8/uN0vMTbewZZQKWDj4wQ==
X-CSE-MsgGUID: 7r4TXjKsQkOiWJLzv3O7TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167628983"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:28 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 0/7] x86 perf bug fixes and optimization
Date: Wed, 20 Aug 2025 10:30:25 +0800
Message-Id: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
  v2 -> v3:
  * Rebase to latest tip perf/core tree.
  * Rewrite commit message to explain why NULL access happens and
    refine code (Patch 3/7)
  * Refine commit message of patch 6/7
  * Dump counters bitmap instead of absolute counter in boot message
    (patch 7/7)

  v1 -> v2:
  * Rebase to 6.17-rc1.
  * No code changes.

Tests:
  * Run perf stats/record commands on Intel Sapphire Rapids platform, no
    issue is found.

History:
  v2: https://lore.kernel.org/all/20250811090034.51249-1-dapeng1.mi@linux.intel.com/ 
  v1:
  * Patch 1/6: https://lore.kernel.org/all/20250606111606.84350-1-dapeng1.mi@linux.intel.com/
  * Patch 2/6: https://lore.kernel.org/all/20250529080236.2552247-1-dapeng1.mi@linux.intel.com/
  * Patch 3/6: https://lore.kernel.org/all/20250718062602.21444-1-dapeng1.mi@linux.intel.com/
  * Patches 4-6/6: https://lore.kernel.org/all/20250717090302.11316-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (7):
  perf/x86/intel: Use early_initcall() to hook bts_init()
  perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
  perf/x86: Check if cpuc->events[*] pointer exists before accessing it
  perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
  perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to
    BIT_ULL(48)
  perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
    INTEL_FIXED_BITS_MASK
  perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()

 arch/x86/events/core.c                 | 16 +++++++++-------
 arch/x86/events/intel/bts.c            |  2 +-
 arch/x86/events/intel/core.c           | 21 +++++++++------------
 arch/x86/events/intel/ds.c             | 10 ++++++++++
 arch/x86/include/asm/msr-index.h       | 14 ++++++++------
 arch/x86/include/asm/perf_event.h      |  8 ++++++--
 arch/x86/kvm/pmu.h                     |  2 +-
 tools/arch/x86/include/asm/msr-index.h | 14 ++++++++------
 8 files changed, 52 insertions(+), 35 deletions(-)


base-commit: 448f97fba9013ffa13f5dd82febd18836b189499
-- 
2.34.1

