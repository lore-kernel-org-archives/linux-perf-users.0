Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481145D5D9;
	Mon, 28 Sep 2026 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581837; cv=none; b=G8gPPbND1ScsJzVyCbIxV9Nabenz8Mfsc+84kOI/hbDtxAinypw7QYedD+kON0cwJozbNYn9mTAvw2fbAOSagM9eKVcLxOvuv6eW4UMeDaQ6A4GQIm26S8lORAWPekwFhrnTjc8B87ChXKGecRx3/ls56UaZd84FlOSZI9lr68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581837; c=relaxed/simple;
	bh=QdpPkamy9BthX/PDJO1JCiWxyjOHL9SY5wj6a3XCLIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIYjDI7UWXJzm8Ds+em4KIJQyP9qYMwQnARtJj4UhJjxa8WvSmZEeFAnW3gu0T8ABaNGiLVsNljOqOADVa4CFfsfXOHiiSh5LMSGOz9BO5tkcZV/W51ycQyJHID70fUurYROkuUXQLl6EPeBiqz08ZZQyHm8nX3/OJpt985S5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDyxp2Ov; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDyxp2Ov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581835; x=1822117835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QdpPkamy9BthX/PDJO1JCiWxyjOHL9SY5wj6a3XCLIY=;
  b=QDyxp2OvZQKsT9d7X42rV1j8DZyGtbFMgN2BWk/kAHpoVIREuPCInjYE
   Xt6hwz6NPGohMshEagX6zuNrjtI3hqGXmQXebZx7ACpFEJ9pWb1Vedc1y
   gb8mBeqzUN++x6AaRH7DtS3r0FGyFNHJsr229yAtOB5TiAZXhNJIDEbwZ
   ukVuqz4cLlgdqFuJSxsd6Al6BljB29dkfQLqedsIaxZ1WSnl/XI9zkn7i
   +enkDe85AJjj3UHDtkWPdVK2yZ2skqiuplOVk8sK8/olyD9G7iKGQYilO
   ZBEK/vkzEGTjMcZi6lE69RfEEmhhmLt0bj7R5kzApC3ReR1ZZlsNC4oSW
   Q==;
X-CSE-ConnectionGUID: IYWC/B4KRcmOXQqcB7/dIQ==
X-CSE-MsgGUID: pbypY+s3SEaiLOFfMu5JJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141372"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141372"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:34 -0700
X-CSE-ConnectionGUID: ubw6ekcwRsajQU7a5uFFYA==
X-CSE-MsgGUID: REzxWCdpQXuzjMvZp8x9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024845"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:30 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 00/15] perf/x86: Fix sampling bugs and relax slots-event grouping
Date: Mon, 28 Sep 2026 15:42:54 +0800
Message-Id: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several recently discovered sampling issues:
- a warning about a missing ctx->mutex hold during LBR counter event
  initialization.
- PEBS sampling failures after CPU offline/online for both legacy PEBS
  and arch-PEBS.
- invalid counts reported by non-PEBS ACR events in SAMPLE_READ mode.
- stale or incorrect counts reported by PEBS events without counter
  snapshot support.
- incorrect event counts are seen when multiple PEBS events are active
  in a group.

It also relaxes the slots-event restriction for topdown event groups:
the slots event no longer has to be the group leader, which makes
sampling for groups containing topdown metric events more flexible.

Patch layout:
- patch 01: fix the warning triggered by for_each_sibling_event() while
  iterating LBR counter events.
- patches 02-04: fix PEBS sampling failures after CPU offline/online for
  both legacy PEBS and arch-PEBS.
- patches 05-06: fix minor PEBS handler issues.
- patch 07: fix invalid counts reported by non-PEBS ACR events in
  SAMPLE_READ mode.
- patch 08: fix stale counts reported by PEBS events without counter
  snapshot support.
- patches 09-11: refactor PEBS handlers to remove duplicated code and
  fix incorrect counts when multiple PEBS events are active in group.
- patch 12: make ACR static_call updates architectural to avoid
  model-specific updates on every platform
- patch 13: add is_x86_event() checks before testing for
  slots/topdown/mem-loads events
- patches 14-15: allow a slots event to be a non-group leader, making 
  sampling for groups containing topdown metric events more flexible.

Dapeng Mi (15):
  perf/x86/intel: Guard leader sibling walk on nr_siblings
  perf/x86/intel: Reset active_fixed_ctrl_val on CPU teardown
  perf/x86/intel: Reset active_pebs_data_cfg on CPU teardown
  perf/x86/intel: Reset cached acr_cfg_b[] and cfg_c_val[] on CPU
    teardown
  perf/x86/intel: Pass correct PEBS counter mask to no-drain update path
  perf/x86/intel: Limit PEBS counter iteration to valid array bounds
  perf/x86/intel: Reject SAMPLE_READ for no-counter-snapshot ACR events
  perf/x86/intel: Fix stale PEBS count without counter-group support
  perf/x86/intel: Refactor intel_pmu_drain_arch_pebs()
  perf/x86/intel: Refactor intel_pmu_drain_pebs_icl()
  perf/x86/intel: Fix invalid PEBS counts with counter-group support
  perf/x86/intel: Make ACR static_call update architectural
  perf/x86: Validate event type before topdown/mem-loads classification
  perf/core: Add event_caps dependency flags
  perf/x86/intel: Allow Topdown metrics with a non-leader slots event

 arch/x86/events/intel/core.c | 216 +++++++++++++++++--
 arch/x86/events/intel/ds.c   | 390 ++++++++++++++++++++++++-----------
 arch/x86/events/perf_event.h |  14 +-
 include/linux/perf_event.h   |   8 +
 kernel/events/core.c         |  52 ++++-
 5 files changed, 535 insertions(+), 145 deletions(-)


base-commit: 6350de8671b94afb7691d110f63bcda42f658a69
-- 
2.34.1

