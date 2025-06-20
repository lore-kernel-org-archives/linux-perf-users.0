Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260530E85C;
	Fri, 20 Jun 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404549; cv=none; b=Di2e53BeTtoXsNlFAH1EWTwmI9i+P35LXBF8nc5nE+nr3fiSrfEvBRgxJXzc4PX6hqJcWpY96pd7GjA5lJPhUQCF/p8F/zm9kg66EnMpGik/4QrMY8CbsZvKMR36O7Tg0w5ofe4Mk+LkRYa7YdLj2rZZrEdqPWvxwsWlvd5UqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404549; c=relaxed/simple;
	bh=rX4dGrsbLq3FgPw/2yOAdvSoS8IhBEmeFaDDof+YduA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4ZEWLUEYzYQ8+uBEMJ8wAVjhKeM/druIZRM4PbZ7bnP1uBTnDWtdGgkHBUCTbklCG1LnofwZXzNZETXujxUdcZIk9/wwsKBpSFuX3LyNnl283zTPWbLHK/6UFU5fABc+WocAL8PL8gdUEh062GjxUgBeq7rK4K6z3hJkaWDDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVAxzzDY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVAxzzDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404548; x=1781940548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rX4dGrsbLq3FgPw/2yOAdvSoS8IhBEmeFaDDof+YduA=;
  b=HVAxzzDYoM/rLwc0fHAdfB5j8Zc5SC8k4YqfQGAiDyP/qbEO8Z2xX67J
   JdTQSSN1rJW5njH27GY1gNA74GIfwicAFQxGwj+zRu9uyMgWYmQT1zXOj
   16b5FFnHvVNIF74gZPWEC64IgubzHGPVb/HhGfjXj+dFekjWJeYXSdSbH
   Di9C9uQ333CtjlNEtyQRrtROd9eyWx1VS/SzLAYSGvoDRRNX1dSdtkkVn
   lcVKw6sUkY6z0LGLZhNi5bqsf54kmZ1HcAZfrI9HLkMYX4jMTAcSv9nzu
   Jg40dwGyty747Smud8SiMCNXQV7Xsc7Bsl5b770MTmG11kWRPMH2Efcb3
   Q==;
X-CSE-ConnectionGUID: iw4t9+UAT1KmLjG+YSXr6g==
X-CSE-MsgGUID: Z4q5KXSXQOmh9Rs/oCsbew==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887701"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887701"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:07 -0700
X-CSE-ConnectionGUID: t3hEvRYBQwazCwA07Niiig==
X-CSE-MsgGUID: mdbPH5DQR8KHW1sr60JdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156650933"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:04 -0700
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
Subject: [Patch v4 00/13] arch-PEBS enabling for Intel platforms 
Date: Fri, 20 Jun 2025 10:38:56 +0000
Message-ID: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
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

Comparing with v3 patchset, the most significant change is to remove the
sampling support for new SIMD regs (OPMASK/YMM/ZMM). Considering the
complication of supporting SIMD regs sampling, the SIMD regs sampling
support is extracted as an independent patchset[1] and this patchset only
focus on the arch-PEBS enabling itself. Once the basic SIMD regs sampling
is supported, the arch-PEBS based SIMD regs (OPMASK/YMM/ZMM) sampling
would be added on top of the basic SIMD regs sampling.

Changes:
  v3 -> v4:
  * Rebase code to 6.16-rc2
  * Extract the new SIMD regs sampling to an independent patchset
  * Fix the PEBS buffer allocation issue (Peter)
  * Fix the arch-PEBS dynamic constraints issue (Kan)

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
    perf record -e branches:p -Iax,bx,ip,ssp,xmm0 -b -c 10000 sleep 1

  5. User space PEBS sampling case with basic GPRs and LBR groups
    perf record -e branches:p --user-regs=ax,bx,ip -b -c 10000 sleep 1

  6 PEBS sampling case with auxiliary (memory info) group
    perf mem record sleep 1

  7. PEBS sampling case with counter group
    perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1

  8. Perf stat and record test
    perf test 96; perf test 125


History:
  v3: https://lore.kernel.org/all/20250415114428.341182-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20250218152818.158614-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20250123140721.2496639-1-dapeng1.mi@linux.intel.com/

Ref:
  [1]: https://lore.kernel.org/all/20250613134943.3186517-1-kan.liang@linux.intel.com/


Dapeng Mi (13):
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
  perf/x86: Support to sample SSP register
  perf/x86/intel: Support to sample SSP register for arch-PEBS
  perf tools: x86: Support to show SSP register

 arch/x86/events/core.c                        |  37 +-
 arch/x86/events/intel/core.c                  | 256 +++++++-
 arch/x86/events/intel/ds.c                    | 595 ++++++++++++++----
 arch/x86/events/perf_event.h                  |  46 +-
 arch/x86/include/asm/intel_ds.h               |  10 +-
 arch/x86/include/asm/msr-index.h              |  20 +
 arch/x86/include/asm/perf_event.h             | 117 +++-
 arch/x86/include/uapi/asm/perf_regs.h         |   4 +-
 arch/x86/kernel/perf_regs.c                   |   7 +
 tools/arch/x86/include/uapi/asm/perf_regs.h   |   7 +-
 tools/perf/arch/x86/util/perf_regs.c          |   2 +
 tools/perf/util/intel-pt.c                    |   2 +-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |   2 +
 13 files changed, 959 insertions(+), 146 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.43.0

