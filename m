Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642051DB365;
	Wed, 14 May 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235659; cv=none; b=I4d27WNIcCaatwZMaztTkwE6AcxQxIxYiKiqMzx8VGBaoQ0qymSM1I6IDLEnO//x0bfqM7kGbq92llDlRLalZPy1osGLmVCkxd84jOWYUKr3oO3BTbZt9b0rbbXaxGhwd/w3523EQB8y3xnG0YH0xBPBUYIT+SXyvz31AEV6Z8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235659; c=relaxed/simple;
	bh=s3Kbfha29uTtuQf1ul9OkbTJBIWdt3PNF9s6Q1vdBOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCXTsbaiQCjXp0uAaC9lniVD/jWoW2MTxTquMpSxbXUzSk7HiDfAWqg9gRmEL63s7Hv8Pt4tHhRIkZBkhXnhIQTTE3GPSzzPXppvmRr/fa0ktlgZB83q1opHAaownyer8BjU+GJ+BJYT6BNtX2Tqj1LSegIS34Y9RrGXbbK3hPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHwwPK5Z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHwwPK5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235657; x=1778771657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s3Kbfha29uTtuQf1ul9OkbTJBIWdt3PNF9s6Q1vdBOU=;
  b=nHwwPK5ZC0g6+8zOM3+qqOTwgquE6akBnjRt/CX9szeIlkhwy9GQCiG3
   FY4Ixz82haFsJc6t3msCwynO0re63BY33QIrEAQPzAmAyz18+DXxTdGCv
   8eiaLDrn71b28WByarPX+4mjFBC7sRNatwOdSJbqGsFthWv0DZProZGy4
   FxDGSQWXHhvrmFntgWL3FWyNcGK4hKI0bYshIKNup0knCTYyIVnvLJB9S
   7hCgKaUWkMKjsNR6r9ogdZkq5vOWzzToqb168HuYR8zsuSRLskFFyfqAh
   UGLWQtGyhwhCAh5Oz4oHHlrx5y97da1cUbktWFU0+XacpQqxEEfaEIdnI
   Q==;
X-CSE-ConnectionGUID: OGED4BcmSGWbBsJrvNRytA==
X-CSE-MsgGUID: 5ZZolu+tRomB0Cy8FKxudQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072686"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072686"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:16 -0700
X-CSE-ConnectionGUID: +ekvycXjRbu3uXq9xn1AGQ==
X-CSE-MsgGUID: EgQAwr/7RdiUiZ5cjMz0MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939094"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:16 -0700
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 00/15] perf: Fix the throttle logic for group
Date: Wed, 14 May 2025 08:13:46 -0700
Message-Id: <20250514151401.2547932-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

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

The patch set is only verified on newer Intel platforms.

Kan Liang (15):
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

 arch/alpha/kernel/perf_event.c       | 11 ++----
 arch/arc/kernel/perf_event.c         |  6 +--
 arch/csky/kernel/perf_event.c        |  3 +-
 arch/loongarch/kernel/perf_event.c   |  3 +-
 arch/mips/kernel/perf_event_mipsxx.c |  3 +-
 arch/powerpc/perf/core-book3s.c      |  6 +--
 arch/powerpc/perf/core-fsl-emb.c     |  3 +-
 arch/s390/kernel/perf_cpum_cf.c      |  2 -
 arch/s390/kernel/perf_cpum_sf.c      |  5 +--
 arch/sparc/kernel/perf_event.c       |  3 +-
 arch/x86/events/amd/core.c           |  3 +-
 arch/x86/events/amd/ibs.c            |  4 +-
 arch/x86/events/core.c               |  3 +-
 arch/x86/events/intel/core.c         |  6 +--
 arch/x86/events/intel/ds.c           |  7 ++--
 arch/x86/events/intel/knc.c          |  3 +-
 arch/x86/events/intel/p4.c           |  3 +-
 arch/x86/events/zhaoxin/core.c       |  3 +-
 arch/xtensa/kernel/perf_event.c      |  3 +-
 drivers/perf/apple_m1_cpu_pmu.c      |  3 +-
 drivers/perf/arm_pmuv3.c             |  3 +-
 drivers/perf/arm_v6_pmu.c            |  3 +-
 drivers/perf/arm_v7_pmu.c            |  3 +-
 drivers/perf/arm_xscale_pmu.c        |  6 +--
 kernel/events/core.c                 | 58 +++++++++++++++++++++-------
 25 files changed, 75 insertions(+), 81 deletions(-)

-- 
2.38.1

