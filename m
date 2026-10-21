Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792559668;
	b=KR6VBFukv5bz3tI35PYPNeHUuzEz+VuQpG6pTmWP36cu1LKYY+bsTmMZfW+45LJOzzOf
	 b9kK86qgqFiDUvLuqZfAKU1oAeur/gA6mDEABf88rpNfzns0c4qOlwYB9oBaAsZnBUUdn
	 dTk1NoQi5ZpEO7hSVfrLI6VIJQnWR+vGyFkJMYwiCySowhMIofj2qwUdD2dYAUvescg0a
	 OX1CUSCr6jBdsN9MJYVlbhn7rDDx0nAhvgj2sNKAJd2zzVjGxBu6WEy8Ct+ZANzJglBZs
	 ZnW/Bet+xYOqBdt+mN9LGxWnB36EB7nTgr9M96zS6HaNs5VdctmB/wL1FNUGijtoi0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559668;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HGhqz+6jGv9mts8LxCfHA4tZcirjemCco6HqrDaX3HY=;
	b=ovhmi9slI8CBbEOptjw/u9HzXTTAjDUeGVq4p6Wxih2paPcKzNgBtPDbwhO4mSx7Rr+n
	 qkTURL2xiXs0Hj83c77GnY7BdY0IdEAJrcBHoW+4J9dq9b+GdVaILl3p75gEQzO1oVVa+
	 bDdBqNLiqeF/jW56a5Sw/bsDTCh55H3+3b8o3tIGMG4FGTRPHjaduZ5TAPAvFP/w5TBmp
	 0ruWJfkv4QgAdIRTMtTpdhFBTl6xDCVix2BYO0bApzhzaeBVpaV8kKtpOHUcSEzbzojAS
	 JWbmVDPSBBLXyY5mTGOYsnBBKfciyIVOjotxLBdxkstOU6wf6NkKRjZEc9e7KjPMG7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KDdv5Mzg;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0AF606A319;
	Wed, 21 Oct 2026 05:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0AF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KDdv5Mzg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792559668; x=1824095668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=teMU07WGBpqrvDeDqgeYEvqhHGQgB+waO627OeWqOSc=;
  b=KDdv5Mzgqmg6412/uI6oH0uk8aOtMD9CcgfvRRIf2PrMDi1gRVVXofx+
   xmuQX0Socy7taNGjvLU628jZK8xfFK46PpTCQO/Jnie2PhcGKb0pwcq1d
   djwd1DjFkBL7v70KEFTupuh5exqfWk1mQmAYtmgRxjuB+l+S/7B9+/8If
   P5xmFZ2JcWYRCCvx/aiegxeD21SzEpdNhBnyMmDUfhIFGegWgsngi+ENa
   vIi4QsHkFJJ594pn8c089hIx9hp9SFcA2IGGPzH79xS0N3ftwidO2erKT
   XCiDv6CMmAEtYHGe64EW68y84tN3rDQ80VDvFNtTfvVIj7Fc99I+XexVF
   Q==;
X-CSE-ConnectionGUID: KLIYupM2SR+CDOskzzwx4g==
X-CSE-MsgGUID: Euwf5dXJSqKqb7nFqTSVyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1149143"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1149143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 22:14:27 -0700
X-CSE-ConnectionGUID: MQvJP9+JRKyGBhvk2juoLQ==
X-CSE-MsgGUID: 31Wi+4JHR0aqWU7kFyHSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2947631"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2026 22:14:23 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 0/5] perf/x86: Limit branch snapshots to valid entries 
Date: Wed, 21 Oct 2026 13:07:06 +0800
Message-Id: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported that the vendor-specific branch snapshot callbacks
used by bpf_get_branch_snapshot() copy up to x86_pmu.lbr_nr entries
from cpuc->lbr_entries[], regardless of how many valid entries the
last LBR read produced. This makes BPF programs read stale or invalid
branch records. Patch 1 addresses AMD and patch 2 addresses Intel.

Changes in v4:
- Patch 01: Disable LBR if parsed x86_pmu.lbr_nr exceeds
  MAX_LBR_ENTRIES (Sashiko).
- Patch 05: New patch, which always snapshots live hardware LBR stack
  for BPF path (Sashiko).

Changes in v3:
- Patch 01: A new patch to ensure x86_pmu.lbr_nr not to exclude
  MAX_LBR_ENTRIES (Internal Sashiko).
- Patch 03: Clean cached LBR stack when reseting hardware LBR registers,
  which prevents stale LBR stack leakage.
- Patch 04: Don't reset cached LBR stack if all LBR events are PEBS
  events. This ensures PEBS captured LBR stack isn't cleared (Sashiko).

Changes in v2:
- Include a fix for Intel LBR.
- Add Tested-by from Dapeng to the Intel fix.
  https://lore.kernel.org/all/eb6c7bda-0dcf-4fac-ad69-9f5b24abc21b@linux.intel.com/

History:
v3: https://lore.kernel.org/all/20261019070836.2972403-1-dapeng1.mi@linux.intel.com/
v2: https://lore.kernel.org/all/cover.1792064123.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/20261007181002.4005262-1-sandipan.das@amd.com/

Dapeng Mi (4):
  perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES
  perf/x86/intel/lbr: Reset the cached LBR stack in
    intel_pmu_lbr_reset()
  perf/x86/intel/lbr: Limit branch snapshots to valid entries
  pef/x86/intel: Always snapshot live hardware LBR state for BPF path

Sandipan Das (1):
  perf/x86/amd/lbr: Limit branch snapshots to valid entries

 arch/x86/events/amd/core.c   |  2 +-
 arch/x86/events/amd/lbr.c    |  4 +++-
 arch/x86/events/core.c       |  6 +++++
 arch/x86/events/intel/core.c | 45 +++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/lbr.c  | 19 +++++++--------
 5 files changed, 62 insertions(+), 14 deletions(-)


base-commit: f5a78ecccd98a04c47cea1cd63c2a2fdce8a4b48
-- 
2.34.1

