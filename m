Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1B25C6EE;
	Tue, 20 May 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765034; cv=none; b=J0eRhjhNsnKhajlGUnvRTKu87IFEJFWdpvxWSlJQh3HTp5XduU+xBm3pCC9BKIoTl86Obt9EpjK1G/0CYJY1E16/mHed/UdrgKeT7rZ5qiV9v5He5RiLBOdaQ5OLdFivKjiN346CGY8arZO4+DafdgQ7DTDS8xUXMtHlSAWhPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765034; c=relaxed/simple;
	bh=LiGSznwfHLmlZyrkMeJ7xe9lmKUKXlsLL9kcCHQt1+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NYT/bAK63k+e0b6xZ82GiNn88q50O7QrVmg+QITDUOfDVfz4uwecwp1gGj3XWzND9uu+iKaujVHM6MOWK3PworSNbi6cEXU2G0XYDoz8Jr+VpmXzDdWqFlP3UCQ/6mwmGqcMoWQjd3inBNScbFSyFNMWJbAKe1NxEZpZbQx0YYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHqAZzbP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHqAZzbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765033; x=1779301033;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LiGSznwfHLmlZyrkMeJ7xe9lmKUKXlsLL9kcCHQt1+Q=;
  b=FHqAZzbP9GFCxHeQZv2GeFIKvnOmUWh8TmY8tjDpDSCaWe/GP40aLlM7
   O+DHrgDJYLSaHgDPgT93+t7H/XSYndVAvqNU3au2nCP8yowrNbpJT81ZF
   cZ80HPUxjW1qydjVO4TAQeg13dd1dAWWzYXzlKuBOyh2u3QUiG50PRgNQ
   VvbgKHMmdVkpOCjOhV/pBaijeFxos9ZN7PXj/Oyj5na7Zp8Ou+zG/eA8v
   GFVEQHNGDjqNfRse5AyjKOGfTwB6jOkddEEZhYV/mwQTJHwgFyscprrdu
   VHz95Ye122gbZErJipnJBXSQB4n6/P72iaMsJDUapqRq2VkSxciYd9BTd
   A==;
X-CSE-ConnectionGUID: 3ApVnJDMR0uVygkc4QEi9g==
X-CSE-MsgGUID: nTKgZmkxSdWl7St8dbDLXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847936"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847936"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:12 -0700
X-CSE-ConnectionGUID: VCWLyY67R/mTSodmR9ORyA==
X-CSE-MsgGUID: 9jhj8W1xQGart9nULCpNBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514703"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:12 -0700
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
Subject: [PATCH V4 00/16] perf: Fix the throttle logic for group
Date: Tue, 20 May 2025 11:16:28 -0700
Message-Id: <20250520181644.2673067-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- Add a new patch to only dump the throttle log for the leader
- Apply the perf_event_unthrottle() in event_sched_in() as well
- Not include the cleanup patch since it has been merged
- Add Acked-by from Vineet

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
  perf: Fix the throttle logic for a group
  perf: Only dump the throttle log for the leader
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
 kernel/events/core.c                 | 68 ++++++++++++++++++++--------
 25 files changed, 79 insertions(+), 87 deletions(-)

-- 
2.38.1

