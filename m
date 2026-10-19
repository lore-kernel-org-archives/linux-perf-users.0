Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC73469FA;
	Mon, 19 Oct 2026 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394198; cv=none; b=UoUtNgnl/9GionE5Dici+9hcDl1tsql04nNeOciIuhatQzAXnmbia7vWnI9VReaFplC4j1Jf0d5bhThFdAkhauCzhE9uZfG3m/KzeQRg2KsLLYZaHMGNECJIT+kLS5qWxTCI0lYyD290uXbaplj2SVnIKz+wH15P4dxjkydytho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394198; c=relaxed/simple;
	bh=4WgwU9shtUU+fE4j68GsBLuuELuvCZdWuT88IOOcqEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+afxJKo4KlLD8/FupS1hdZ7vdZZh1kPE4OtpftEak0bwGXI1A3ZXopU6RWSbblIClfSrIvCLSIL3eznpuiRQ2MeU1cQP/XhvuHhHdE1s3fyj/lli5bpr4U+WAMjF7Z7a8iTmv3oxLppF9yr0KNTv52MBMomZeDahETkZUizXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4Fz8hFi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4Fz8hFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792394197; x=1823930197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4WgwU9shtUU+fE4j68GsBLuuELuvCZdWuT88IOOcqEo=;
  b=m4Fz8hFiE5PFqimM+104Tp65wnY8WA5qo8dBDPdE6zEmWaiO1vnmaP4L
   wr0nafpejcV3gWnb8CVpAM2R8hHEMjxdp0/U0Bx0hErtkU8vS5RhcpidY
   ARwWM9NzH4saewSe87GQYIhJtKt4AxeSrfTMpbao1lBM60X1QX/r0rdO0
   OhoLD0y4qDNFRGJfJ70sesRz8FhBtr3GU7dBUXHisjwzmRkwW0wkr3lAf
   9UXrGepDTvE1x2qPK9OddAI1J0pxyMlG9PkuQU5Hk+5xGVC27VP5M1q9J
   7bmXzUxxCoEB8oyRUkY07IuS31TvLGeiiHWAetf5BcaAXiPOmtZN5u22B
   Q==;
X-CSE-ConnectionGUID: PB/Kz5kkTQ22NbJhFQLEPQ==
X-CSE-MsgGUID: +AJpZQmMQpK0hSRtqTov1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1085674"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1085674"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:16:36 -0700
X-CSE-ConnectionGUID: RiVP1Ei0SKqmxh7tLgjD2w==
X-CSE-MsgGUID: f8IRIGV2RIeUkTK2PHv/Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2807228"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 19 Oct 2026 00:16:31 -0700
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
Subject: [Patch v3 0/4] perf/x86: Limit branch snapshots to valid entries
Date: Mon, 19 Oct 2026 15:08:32 +0800
Message-Id: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported that the vendor-specific branch snapshot callbacks
used by bpf_get_branch_snapshot() copy up to x86_pmu.lbr_nr entries
from cpuc->lbr_entries[], regardless of how many valid entries the
last LBR read produced. This makes BPF programs read stale or invalid
branch records. Patch 1 addresses AMD and patch 2 addresses Intel.

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
v2: https://lore.kernel.org/all/cover.1792064123.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/20261007181002.4005262-1-sandipan.das@amd.com/

Dapeng Mi (3):
  perf/x86: Clamp x86_pmu.lbr_nr to MAX_LBR_ENTRIES
  perf/x86/intel/lbr: Reset the cached LBR stack in
    intel_pmu_lbr_reset()
  perf/x86/intel/lbr: Limit branch snapshots to valid entries

Sandipan Das (1):
  perf/x86/amd/lbr: Limit branch snapshots to valid entries

 arch/x86/events/amd/core.c   |  2 +-
 arch/x86/events/amd/lbr.c    |  4 +++-
 arch/x86/events/core.c       |  2 ++
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/lbr.c  | 14 +++++++++++---
 5 files changed, 18 insertions(+), 6 deletions(-)


base-commit: f5a78ecccd98a04c47cea1cd63c2a2fdce8a4b48
-- 
2.34.1

