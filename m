Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE735CBC3;
	Fri, 15 May 2026 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825803; cv=none; b=ebXpE64HhiBHljWsNE6fM4Oc/YICZLkXoBmKj7SoNAmD0GhS3TYu8iaLyCXIkIUz218JXpETp7iHHJkHPrNzBWANbrsI048apQKZ9zogTq25ICmGflKRez9vQVyuX2d+0RrHLzHdf8CbRJQHxXSwcyE0APw42ptMv/QwwCW6kbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825803; c=relaxed/simple;
	bh=24S2EQ/7ZrPq5yB0PxtAOr1GGGKoMnQMAp7KqGI1TYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rn+xTQeL7zUADI4JVAUUyycPGO6Oq2vKQR62cxM3Y1fCSwBqX/03dCZyPONvvJL6Fw+MQ9Mm9TO4w4+X/BrU0cMknTut8IouPfjxXpLhe++cW/4Ve3z/XV3nuDdcXB/1n48cd+DSfn0s3Ob0nj17CkioOZF0RZ48bZkwraPFAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avIqP8jZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avIqP8jZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825801; x=1810361801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=24S2EQ/7ZrPq5yB0PxtAOr1GGGKoMnQMAp7KqGI1TYA=;
  b=avIqP8jZC8Q3PNOfPNM+jxTEnRWiXAnJUJqixk3eRuAZRMWELDOgUVUd
   uFYDpe59Lcpp/VqcizdzBpMHYEginNFfGpt69ZGh2jYIU+kTUySbzY+Vz
   Xpx+z0ICMJSt4O+ADF8DVo1afmp29k4FPlbPnL4jGHxS/TXzG5XBr42Jk
   84TBQ+ICfMrVWPn3XRLdzXr3cgV0/Dz86rXnD8Frd1jgmcfVHpva7phjw
   Vh0LTHXGBcwUSkJKpus0yL/5T5H1wVtMcVnQX6mC2EpDWO+q+jI6nIElB
   5F2HNkpMt64h9rbjYoxtzwkmgQgIF3K9bugM7YSumvdq5X3RmW/6bYP24
   Q==;
X-CSE-ConnectionGUID: HZPPnz8fRvuaqFz6XY++VQ==
X-CSE-MsgGUID: 6q6rAzJCRBSiKd13w9Cl7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635897"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635897"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:16:41 -0700
X-CSE-ConnectionGUID: ZcNPhLEAR+aTqe/s7P+hEg==
X-CSE-MsgGUID: smLObyjvTCGCPXMTnVeliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968389"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:16:37 -0700
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
Subject: [PATCH 00/11] perf/x86/intel: Fix inaccurate hard-coded event configurations 
Date: Fri, 15 May 2026 14:11:32 +0800
Message-Id: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the Intel perf code defines several hard-coded event
configurations for each platform. These configurations include event
constraints, extra MSR settings, and predefined extra MSR values for
certain cache events.

For example, the following five hard-coded event configurations are
defined for Sapphire Rapids:
- intel_glc_event_constraints[]: Non-PEBS event constraints.
- intel_glc_pebs_event_constraints[]: PEBS event constraints.
- intel_glc_extra_regs[]: Event-to-extra MSR mapping for events requiring
  extra MSR access.
- glc_hw_cache_event_ids[]: Cache event IDs.
- glc_hw_cache_extra_regs[]: Extra MSR values for L3 and node events,
  mainly for OCR/OMR events.

However, these hard-coded configurations can become outdated or incorrect
as perfmon events are continuously updated
(see: https://github.com/intel/perfmon). This can result in events being
scheduled on incorrect hardware counters, leading to inaccurate counts,
especially for legacy cache events such as llc-load-misses and
llc-store-misses. While these legacy events are less commonly used since
the introduction of JSON-based cache events, it is still important to keep
them accurate.

This patchset addresses all identified mismatches on mainstream platforms,
including server platforms (ICX, SPR, EMR, GNR, DMR, SRF, and CWF) and
client platforms (ADL, MTL, LNL, ARL, PTL, and NVL).

Note: Due to issues in the 7.1-rc2 release that cause boot-up hangs on
Intel hybrid platforms, this patchset was developed and tested against the
7.0 release.

Testing:
All tests below were run on the platforms mentioned above, with no issues
found:
1. Perf counting test:
   $perf test 114
2. Perf sampling test:
   $perf test 148
3. Legacy LLC cache events counting test:
   $perf stat -e llc-loads,llc-load-misses,llc-stores,llc-store-misses -a

Dapeng Mi (11):
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    ICX
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    SPR
  perf/x86/intel: Update event constraints for DMR
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    ADL
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    MTL
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    LNL
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    ARL
  perf/x86/intel: Update event constraints for PTL
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    NVL
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    SRF
  perf/x86/intel: Update event constraints and cache_extra_regs[] for
    CWF

 arch/x86/events/intel/core.c | 476 +++++++++++++++++++++++++++++------
 arch/x86/events/intel/ds.c   |  23 +-
 arch/x86/events/perf_event.h |   4 +-
 3 files changed, 421 insertions(+), 82 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.34.1

