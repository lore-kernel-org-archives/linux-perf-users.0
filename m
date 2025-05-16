Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5B27D766;
	Fri, 16 May 2025 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420162; cv=none; b=B/Iv7FSOG/ZoeFalIXlViLpYoS1hB4k3dRZosiA1Ew89O2+SojI7HCM0y33xE6ZfK/qfwrndlvi2Dv7sGtnAzx2vngXAijubTWdtSjAW/fqV77twaSPGLVOP4eAElsP1X26kiKeM3vb6rY6IlmUy88//k9fAf5M4PCuDvogJ7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420162; c=relaxed/simple;
	bh=F5v+X75TI1z2DmZCu4oTc6EMB0xD1BlN+j0QoXwycsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MxKdTKutHk5NMkg/6ym8VmEXLguNs9G/ofePphWrb7kZ5NYRzMzNvWtO7VRXFKcfTurA7PgrWwVfBZxMUIXWrKuNC24FJMCv9JjQ1HCFO4CpuR0ZOjNUTuXRuqwbxsdJHPx8DCBY6tMgvCOXY+E0SoeFck8FWT6N69PJ0bSmJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrjIupDX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrjIupDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420161; x=1778956161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F5v+X75TI1z2DmZCu4oTc6EMB0xD1BlN+j0QoXwycsA=;
  b=KrjIupDXmJHpqVyrAfKQixWix4XhGZ6SgZiQCdnXfJzALmLn9AkVDMIS
   FH8xABSpUKteDUoEpsm85MPWw3dq3WBJwWChryhzXrDQ6GcX64WzZOgyr
   fQpfVZDBVW4YDY3C2DBu7E9xI6fXRVeKXmPmj1nju/7EWYL9fm0D7oA1k
   CiGI8koWeNzbpkp4AmkslEy3VxLkR1v2HcXMwgkygHSWuy4vw2+9INDhH
   UqZrGEi6orq3MzmWgWHUQbTWYtAblgc5Fy5mYM+LHIyQf4aIizeVA8r6G
   drLfHU0B0J2PxZNXUaTyI+yhyL+O8P0G6PHBqbtOhhZWuJBihQ+53QDoZ
   A==;
X-CSE-ConnectionGUID: F+uLjmaHRnuFfiMcjGtxMw==
X-CSE-MsgGUID: SmdcqjQbRz+NHBwCOQtX1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328788"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:20 -0700
X-CSE-ConnectionGUID: bkyRZkbbRpmBiYV5WyKIIw==
X-CSE-MsgGUID: 4YmH+m5pR8WCBM/6eDB5Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802595"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:19 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 00/16] perf: Fix the throttle logic for group
Date: Fri, 16 May 2025 11:28:37 -0700
Message-Id: <20250516182853.2610284-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Add a cleanup patch to check if an event is in freq mode
- Rename the parameter of the perf_event_unthrottle_group()
- Add Tested-by from Leo and Thomas
- Add Acked-by from Guo Ren

Changes since V1:
- Apply the suggested throttle/unthrottle functions from Peter.
  The MAX_INTERRUPTS and throttle logs are applied to all events.
- Update the description and comments accordingly
- Add Reviewed-by from Ravi and Max

The sampling read doesn't work well with a group.
The issue was originally found by the 'Basic leader sampling test' case
failed on s390.
https://lore.kernel.org/all/20250228062241.303309-1-tmricht@linux.ibm.com/

Stephane debugged it and found it was caused by the throttling logic.
https://lore.kernel.org/all/CABPqkBQzCMNS_PfLZBWVuX9o8Z55PovwJvpVWMWzyeExFJ5R4Q@mail.gmail.com/

The throttle logic is generic and shared by all ARCHs.
It also impacts other ARCHs, e.g., X86.

On an Intel GNR machine,
$ perf record -e "{cycles,cycles}:S" ...

$ perf report -D | grep THROTTLE | tail -2
            THROTTLE events:        426  ( 9.0%)
          UNTHROTTLE events:        425  ( 9.0%)

$ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
... sample_read:
.... group nr 2
..... id 0000000000000327, value 000000000cbb993a, lost 0
..... id 0000000000000328, value 00000002211c26df, lost 0

The patch set tries to provide a generic fix for the group throttle
support. So the buggy driver-specific implementation can be removed.

The patch set is verified on newer Intel platforms (Kan), ARM (Leo Yan),
and s390 (Thomas Richter).

Kan Liang (16):
  perf: Clean up event in freq mode check
  perf: Fix the throttle logic for a group
  perf/x86/intel: Remove driver-specific throttle support
  perf/x86/amd: Remove driver-specific throttle support
  perf/x86/zhaoxin: Remove driver-specific throttle support
  powerpc/perf: Remove driver-specific throttle support
  s390/perf: Remove driver-specific throttle support
  perf/arm: Remove driver-specific throttle support
  perf/apple_m1: Remove driver-specific throttle support
  alpha/perf: Remove driver-specific throttle support
  arc/perf: Remove driver-specific throttle support
  csky/perf: Remove driver-specific throttle support
  loongarch/perf: Remove driver-specific throttle support
  sparc/perf: Remove driver-specific throttle support
  xtensa/perf: Remove driver-specific throttle support
  mips/perf: Remove driver-specific throttle support

 arch/alpha/kernel/perf_event.c       | 11 ++---
 arch/arc/kernel/perf_event.c         |  6 +--
 arch/csky/kernel/perf_event.c        |  3 +-
 arch/loongarch/kernel/perf_event.c   |  3 +-
 arch/mips/kernel/perf_event_mipsxx.c |  3 +-
 arch/powerpc/perf/core-book3s.c      |  6 +--
 arch/powerpc/perf/core-fsl-emb.c     |  3 +-
 arch/s390/kernel/perf_cpum_cf.c      |  2 -
 arch/s390/kernel/perf_cpum_sf.c      |  5 +-
 arch/sparc/kernel/perf_event.c       |  3 +-
 arch/x86/events/amd/core.c           |  3 +-
 arch/x86/events/amd/ibs.c            |  4 +-
 arch/x86/events/core.c               |  3 +-
 arch/x86/events/intel/core.c         |  6 +--
 arch/x86/events/intel/ds.c           |  7 ++-
 arch/x86/events/intel/knc.c          |  3 +-
 arch/x86/events/intel/p4.c           |  3 +-
 arch/x86/events/zhaoxin/core.c       |  3 +-
 arch/xtensa/kernel/perf_event.c      |  3 +-
 drivers/perf/apple_m1_cpu_pmu.c      |  3 +-
 drivers/perf/arm_pmuv3.c             |  3 +-
 drivers/perf/arm_v6_pmu.c            |  3 +-
 drivers/perf/arm_v7_pmu.c            |  3 +-
 drivers/perf/arm_xscale_pmu.c        |  6 +--
 kernel/events/core.c                 | 73 ++++++++++++++++++++--------
 25 files changed, 84 insertions(+), 87 deletions(-)

-- 
2.38.1

