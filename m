Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5CE1F5413;
	Tue,  6 May 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550092; cv=none; b=bMi4fdn2U+BlLVxC80ArlRGGsLdjkXF/c53+zPlalYA80JS0odiAjIkHHPA4uR+kDiM1T8cMrgo7dbx4ZLRCR1dx0PEpS2JL539szidt7iyRZVODDMabWKR/0pj/3QrR+2DLXT0V2EYraGClIu411gttINTjLmFk90fcona6gmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550092; c=relaxed/simple;
	bh=/vA/W0ge9rKqpbsH459YA2wj7NWmN4XuzwtqiBKOpWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXCW4Nhb2dplRzB9olw+OXIy/9G9VsA81TeY27BfYfI1Jx5xbQUSrnxu3PsJhaa0cCIhks/y3GYBToaI0UyuNQby5lEVJcOej9iWJTMX/fk0wrnSrm/Cy1JqROx0374BkU2Ij5NYQr3GaBCaoKImRleCX0oPX+2K66RC1TbT7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iI3NN5K+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI3NN5K+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550091; x=1778086091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/vA/W0ge9rKqpbsH459YA2wj7NWmN4XuzwtqiBKOpWk=;
  b=iI3NN5K+U2aiHbHYxw4/K4Rp4rLM/OL27q/TjoeLexjV2P/e7fODva2s
   ywIQYpRRrEPkkrTmRuApRdAi6CRaa6nDGyLR/SIlXi3Cykk0cYDm6b2nE
   R76ZCOvCtMGcwtQXMCDD3Qog8KOov67dnlyzFmqg/kdSD07FPdJmAOmRL
   7oUdMwSmdTYkSz/JgMLZGenBOUEtAF/BvfylOrSnMZss1gQL3N3eq3J43
   6eZYo4ZviOF751iLWL+xrP0BRaQ8Qpgbi/YxWpT/Fs6qrKpCVg7zMsDAL
   vqcz5VvDDQbIlQBgZUsFnrrMWthZY2Ro6OCIQv8PRlTDxQ/SpOVjAz6z0
   w==;
X-CSE-ConnectionGUID: d/VUvsHaTK658GM6CFKEUQ==
X-CSE-MsgGUID: tWI7P0aSQ4qabz2U0uSAQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595210"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595210"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:10 -0700
X-CSE-ConnectionGUID: sB8JdmLHQHe529Dz5tKspQ==
X-CSE-MsgGUID: pirZnOART9Sk0A3zFacPMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674833"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:09 -0700
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
Subject: [RFC PATCH 00/15] perf: Fix the throttle logic for group
Date: Tue,  6 May 2025 09:47:25 -0700
Message-Id: <20250506164740.1317237-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

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
 kernel/events/core.c                 | 55 +++++++++++++++++++++-------
 25 files changed, 72 insertions(+), 81 deletions(-)

-- 
2.38.1

