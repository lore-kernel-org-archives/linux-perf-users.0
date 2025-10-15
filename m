Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213D303CA4;
	Wed, 15 Oct 2025 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510776; cv=none; b=aCIq0HwzGDCe+DDqgGRAPZp3OAnvZn/W4amsh9mgNcSbOa9k1tERLrO2k6Gq776MGFe9pG4Dib1mKAhjFk2dQWPSkpLN/pDb/Q2Fj9Ezger4kjKC7CRl0ZVCnW75i6NxGMcGtD8TDBNIxX1EIyPErKChMoDH+3iCzzVt/sYKgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510776; c=relaxed/simple;
	bh=iwp4PIwHHvVvq/xh0/d6dCqML8i8PNGxZm0jY6Ccb44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L037A3SL1SpPr+fs5ccA5+ur/9E+IexEMu2cO+xGy5YCUhHq8VkQNTGukC2/GG7ee9W+oPNXkfYTD/vyAsBVH2986maEHoVuITgIgL0DKmp4wp5CDY+v3chHKx48Pd4neS9avZHRekmWy5gsMg1mQVRP5YekerOcOpcp3OwR3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7qxdPAA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7qxdPAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760510774; x=1792046774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iwp4PIwHHvVvq/xh0/d6dCqML8i8PNGxZm0jY6Ccb44=;
  b=U7qxdPAAeJjfPkfYFGN6Kcg6J3Yv6sI6Bu0mPZQvKmjPKE6GQr27lBzD
   vnCD37ItHtop+eMW6ydApefbRhHgxX3grNFRkOu9rJQY5X981BP/6NHXN
   X/+39CUQKXtry8l+QO0sIfA2nNodQhpeRQEy1zX+iUCtnfCfw2Dszc44H
   SWCxquMyeHQNFR9JfA9yNcuqQ8vwZq3DYKIpwu0Ups1WTyu8NT/n5vVeJ
   H6wmUt7izg6y9kWutLzJ0HGZ2YmVZNNN5V4MDnMpRa9CFhFJXmFetvrcq
   FTclNUxzNkGUyX4GmLojg8oNe54E0ivz9n1QRkAWL6s51BbVJSo8C219+
   A==;
X-CSE-ConnectionGUID: LyEHyyJlQruCKtFqcmwBwg==
X-CSE-MsgGUID: CJUufqziRAusdG8oE2OHIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50242437"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50242437"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:46:13 -0700
X-CSE-ConnectionGUID: EHfnuvhUQ2uEbg3IJqpRJw==
X-CSE-MsgGUID: 7cKFJrJnTjiEGUn2nFodzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182029856"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 23:46:07 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 00/12] arch-PEBS enabling for Intel platforms 
Date: Wed, 15 Oct 2025 14:44:10 +0800
Message-Id: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
v7 -> v8:
  * Fix the warning reported by Kernel test robot (Patch 02/12)
  * Rebase code to 6.18-rc1.

v6 -> v7:
  * Rebase code to last tip perf/core tree.
  * Opportunistically remove the redundant is_x86_event() prototype.
    (Patch 01/12)
  * Fix PEBS handler NULL event access and record loss issue.
    (Patch 02/12)
  * Reset MSR_IA32_PEBS_INDEX at the head of_drain_arch_pebs() instead
    of end. It avoids the processed PEBS records are processed again in
    some corner cases like event throttling. (Patch 08/12)

v5 -> v6:
  * Rebase code to last tip perf/core tree + "x86 perf bug fixes and
    optimization" patchset
 
v4 -> v5:
  * Rebase code to 6.16-rc3
  * Allocate/free arch-PEBS buffer in callbacks *prepare_cpu/*dead_cpu
    (patch 07/10, Peter)
  * Code and comments refine (patch 09/10, Peter)


This patchset introduces architectural PEBS support for Intel platforms
like Clearwater Forest (CWF) and Panther Lake (PTL). The detailed
information about arch-PEBS can be found in chapter 11
"architectural PEBS" of "Intel Architecture Instruction Set Extensions
and Future Features".

This patch set doesn't include the SSP and SIMD regs (OPMASK/YMM/ZMM)
sampling support for arch-PEBS to avoid the dependency for the basic
SIMD regs sampling support patch series[1]. Once the basic SIMD regs
sampling is supported, the arch-PEBS based SSP and SIMD regs
(OPMASK/YMM/ZMM) sampling would be supported in a later patch set.

Tests:
  Run below tests on Clearwater Forest and Pantherlake, no issue is
  found.

  1. Basic perf counting case.
    perf stat -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}' sleep 1

  2. Basic PMI based perf sampling case.
    perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}' sleep 1

  3. Basic PEBS based perf sampling case.
    perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles}:p' sleep 1

  4. PEBS sampling case with basic, GPRs, vector-registers and LBR groups
    perf record -e branches:p -Iax,bx,ip,xmm0 -b -c 10000 sleep 1

  5. User space PEBS sampling case with basic, GPRs and LBR groups
    perf record -e branches:p --user-regs=ax,bx,ip -b -c 10000 sleep 1

  6. PEBS sampling case with auxiliary (memory info) group
    perf mem record sleep 1

  7. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1

  8. Perf stat and record test
    perf test 100; perf test 131


History:
  v7: https://lore.kernel.org/all/20250828013435.1528459-1-dapeng1.mi@linux.intel.com/
  v6: https://lore.kernel.org/all/20250821035805.159494-1-dapeng1.mi@linux.intel.com/ 
  v5: https://lore.kernel.org/all/20250623223546.112465-1-dapeng1.mi@linux.intel.com/
  v4: https://lore.kernel.org/all/20250620103909.1586595-1-dapeng1.mi@linux.intel.com/
  v3: https://lore.kernel.org/all/20250415114428.341182-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (12):
  perf/x86: Remove redundant is_x86_event() prototype
  perf/x86/intel: Fix NULL event access and potential PEBS record loss
  perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
  perf/x86/intel: Correct large PEBS flag check
  perf/x86/intel: Initialize architectural PEBS
  perf/x86/intel/ds: Factor out PEBS record processing code to functions
  perf/x86/intel/ds: Factor out PEBS group processing code to functions
  perf/x86/intel: Process arch-PEBS records or record fragments
  perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
  perf/x86/intel: Update dyn_constranit base on PEBS event precise level
  perf/x86/intel: Setup PEBS data configuration and enable legacy groups
  perf/x86/intel: Add counter group support for arch-PEBS

 arch/x86/events/core.c            |  21 +-
 arch/x86/events/intel/core.c      | 268 ++++++++++++-
 arch/x86/events/intel/ds.c        | 632 ++++++++++++++++++++++++------
 arch/x86/events/perf_event.h      |  41 +-
 arch/x86/include/asm/intel_ds.h   |  10 +-
 arch/x86/include/asm/msr-index.h  |  20 +
 arch/x86/include/asm/perf_event.h | 116 +++++-
 7 files changed, 963 insertions(+), 145 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.34.1

