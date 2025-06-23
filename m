Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21331C4A2D;
	Thu, 26 Jun 2025 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909370; cv=none; b=SCTNgjXfEmbC+VSHMSXpaH2x3ElIJJK0zjfqG9hLX+orD2WzwNoKsqd3pkwnIrkyzkHOsVDuJFq4L7LnUDRMDmVde3lZ/6rZxYdFmaW/5NkR2YsxrXUXwsGN4KQDQgVh9e6j4I71LcVP1hu4Lr1bMQuL02oQe0N5GYWp+yMOrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909370; c=relaxed/simple;
	bh=k9xdnWqn/0qEfBMEcHCOZd72jPJo7KEY4XI8xGo7sOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppO4ljCyf0naf7e5tjXQnwv3my9Ic2KrBAHrn+oCIUP6DrWWJ7roK1IfPtWDfGOOycjAR98I+foLyP5HM1JMbcYCleahYtw/9MacnMWAHYziMSBH7i02/J5MPw8O3z+JexHFNzoT2TAzt+07PUn1Y8ryM7D10cC7ZfwgddjEYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eU0x2r7x; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eU0x2r7x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909369; x=1782445369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k9xdnWqn/0qEfBMEcHCOZd72jPJo7KEY4XI8xGo7sOo=;
  b=eU0x2r7xVoTqpLeOCn+J1fFvgSHIjNiBSzVQbCB+uhgye/yM2RZqy5JQ
   aUxcOtwRpDzIEKjqDmIWSx9DJnIxrw+E5Q/F+PQpovxvwLqjijUR/hbfZ
   QuE4xIoM9L59owOIxumJzC4/tckJsLRRSL7ZdUnwFBkLKawItSP+/IHiB
   uxIv0IZDbvmBwuWSL5uxK5Fr7siNtG+ox63HH19OLveFFMhwx1ra+l7r2
   KaOpJwejqtaJpKf2yDFQYQu4k0avFlRjVJnofxuQK+Opht8dJr9huAaJI
   KmCeIM3eA+cKLAOwDaKi09KgvlpsbXD//D26loIGVEwsGxwS56FAeMdpU
   g==;
X-CSE-ConnectionGUID: 9VQb7KJ9S1y75OJN/FbdFw==
X-CSE-MsgGUID: PYZTQew/QrKjUtvJWY5fCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55820633"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55820633"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:42:48 -0700
X-CSE-ConnectionGUID: 4C3awxQsTJOFOLpY3Nd+lQ==
X-CSE-MsgGUID: F3z2nRPtQxKSNIOUIpPWUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157894899"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 20:42:45 -0700
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
Subject: [Patch v5 00/10] arch-PEBS enabling for Intel platforms
Date: Mon, 23 Jun 2025 22:35:35 +0000
Message-ID: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Changes:
  v4 -> v5:
  * Rebase code to 6.16-rc3
  * Allocate/free arch-PEBS buffer in callbacks *prepare_cpu/*dead_cpu
    (patch 07/10, Peter)
  * Code and comments refine (patch 09/10, Peter)

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

  6 PEBS sampling case with auxiliary (memory info) group
    perf mem record sleep 1

  7. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1

  8. Perf stat and record test
    perf test 96; perf test 125


History:
  v4: https://lore.kernel.org/all/20250620103909.1586595-1-dapeng1.mi@linux.intel.com/
  v3: https://lore.kernel.org/all/20250415114428.341182-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250613134943.3186517-1-kan.liang@linux.intel.com/

Dapeng Mi (10):
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
 arch/x86/events/intel/core.c      | 268 +++++++++++++-
 arch/x86/events/intel/ds.c        | 595 ++++++++++++++++++++++++------
 arch/x86/events/perf_event.h      |  40 +-
 arch/x86/include/asm/intel_ds.h   |  10 +-
 arch/x86/include/asm/msr-index.h  |  20 +
 arch/x86/include/asm/perf_event.h | 116 +++++-
 7 files changed, 930 insertions(+), 140 deletions(-)


base-commit: 86731a2a651e58953fc949573895f2fa6d456841
-- 
2.43.0

