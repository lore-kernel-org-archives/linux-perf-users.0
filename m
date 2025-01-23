Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986F2F3B;
	Thu, 23 Jan 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613212; cv=none; b=cUNmVG7OwOFciT8+Xdv32N86j/JZAXMTtYCuRXZlA58kU4ovBsPhMKm5dd/TwrIwrshaAoWkE8Tb5lkOk9nJfE6ikld5XNbhhO7rRZCC5HuWlCR1yE8Ht55R84KOkLti+Lp8KTa8qsi7b4zqWN1tpZQkLDmgewtEFznmZH+vfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613212; c=relaxed/simple;
	bh=+NaRClZC6uCqXwr3eGZ5Yd22degxy1KIGaxZvpQquU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mUAzUl3dM0v4K2x7aC793Mba41nAt0mSSGxh7xnOUqmM+BtDeoysm7E1TAL1XvuuXHUWxCTXlq+rMgkterfTmNBS1W0XlxZx/Tzeghi/fgVNqKvfOwt2cN8TFqiXlDprgLb1omvk6Dsypyob7xnjYNTCZJu1+cs+DqlxgK/h7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFtukkmn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFtukkmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613210; x=1769149210;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NaRClZC6uCqXwr3eGZ5Yd22degxy1KIGaxZvpQquU0=;
  b=bFtukkmnTIHJ3rzPLUzUivq/MPKHfdck86y04JyS0vwoF4XnWMNa0IhP
   ZB62xiPyELsNQ5b8p1sCZpk87WdBd5KO5e6TWpIekclLgVufLZi8muJBz
   XJ3EEQygJaCjQ+cDVIYWgAdLozIyyBgbPlkk8tjzGqkX0pmV7/tfmR95P
   lBc9bHZWXoddd3muQ7eOwPubEq8d9dBNNp9ME7bV1wOAbrzQsYX4og8Q2
   s8YwOGGPRJGu9nB5blHILZ0uBgDrx1RmQoh3qi83wV26JmnkngB+Jxeuc
   zkCMMgEtDv7vTajCSh/IjvoPLFSQ9AKoV5clRyY5rZy0cYLYtM5Y+td6v
   w==;
X-CSE-ConnectionGUID: J2nW5oRzTJG6JwaHHSHJmg==
X-CSE-MsgGUID: vP+cwBaHRfWfV5/R7/XpiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513013"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513013"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:09 -0800
X-CSE-ConnectionGUID: b45excVlQqm0yo+u9CzdsA==
X-CSE-MsgGUID: Xt/iCb1UTzCAiV5Nfeg9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334395"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:05 -0800
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
Subject: [PATCH 00/20] Arch-PEBS and PMU supports for Clearwater Forest
Date: Thu, 23 Jan 2025 14:07:01 +0000
Message-Id: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enables PMU and architectural PEBS (arch-PEBS) for
Clearwater Forest (CWF).

Comparing with previous generation Sierra Forest (SRF), CWF has two key
differences on PMU perspective.

a. Increases 3 fixed counters, fixed counter 4, 5 and 6 which are used
to profile topdown-bad-spec, topdown-fe-bound and topdown-retiring
events.

b. Introduce architectural PEBS which is used to replace previous
DS area based PEBS.

The general fixed counter bitmap (CPUID.23H.1H.EBX) support has been
upstreamed along with the ARL/LNL PMU enabling patches. Only CWF
specific event attributes need to be supported in this patch series.

Comparing with the legacy DS area based PEBS, especially for adaptive
PEBS, arch-PEBS basically inherits all currently supported PEBS 
groups, such as basic-info group, memory-info group, GPRs group,
XMMs (Vector registers) group and LBRs group, but with some new fields
in these groups.

The key differences between legacy PEBS and arch-PEBS are

a. Arch-PEBS leverages CPUID.23H.4/5H sub-leaves to enumerate supported
capabilities. These two cpuid sub-leaves tell which PEBS groups are 
supported and which GP and fixed counters support arch-PEBS. 
IA32_PERF_CAPABILITIES MSR is not used for indicating PEBS capabilities
anymore.

b. Arch-PEBS increases several new MSRs, IA32_PEBS_BASE,
IA32_PEBS_INDEX and IA32_PMC_GPn/FXm_CFG_C MSRs. IA32_PEBS_BASE MSR is
used to tell HW the PEBS buffer starting address and size, HW would
write the captured records into the PEBS buffer. IA32_PEBS_INDEX MSR
provides several fields, like WR_OFFSET and THRESH_OFFSET. WR_OFFSET is
used to tell SW the latest PEBS record offset in PEBS buffer by HW and
THRESH_OFFSET tells HW that a PMI should be generated if current written
PEBS record cross this offset. IA32_PMC_GPn/FXm_CFG_C is per-counter
MSR, each GP or fixed counter has its own CFG_C MSR. This MSR is used to
configure which PEBS groups would be captured for the corresponding
counter once the counter overflows. Since each counter has its owned
CFG_C MSR, it means that arch-PEBS supports to capture different PEBS
groups for different counters. Whereas the legacy DS-based PEBS only
supports a global shared PEBS configuration, all counters have to share
same PEBS configuration. This is a significant improvement for
arch-PEBS, it provides more flexibility and higher efficiency. The
legacy MSRs IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG are deprecated in
arch-PEBS.

c. Arch-PEBS increases the capabilities to capture more registers, like
SSP register and higher width xsave-enabled vector registers, like
OPMASK/YMM/ZMM registers. Of course, not all platforms support to
capture all these vector registers, HW would suggest which vector
registers are supported by CPUID.23H.4H.EBX, such as CWF only supports
to capture XMM/YMM registers. New added SSP register would be placed into
GPRs group and all vector registers including XMM registers would be
placed into xsave-enabled registers group.

d. Arch-PEBS does some changes on the PEBS record layout although some
groups still have same format with previous legacy adaptive PEBS. 
Arch-PEBS supports PEBS record fragments as well, if the continued bit
in the record header is set, it indicates there are fragments followed.

The details about arch-PEBS can be found in chapter 11 "Architectural
PEBS" of "Intel architecture instruction set extensions programming
 reference"[1].

The patch 01/20 provides basic PMU support for CWF, the patch 02/20 fixes
an error about parsing archPerfmonExt (0x23) CPUID leaf, the left
patches (03/20 ~ 20/20) provides arch-PEBS support for kernel and perf
tools. This patch series is based on Peter's perf/core tree + Kan's PEBS
counter snapshot patchset (v10)[2].


Tests:

The following tests are run on CWF and no issue is found. Please notice
nmi_watchdog is disabled when running the tests.

a. Basic perf counting case.
   perf stat -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles,topdown-bad-spec,topdown-fe-bound,topdown-retiring}' sleep 1

b. Basic PMI based perf sampling case.
   perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles,topdown-bad-spec,topdown-fe-bound,topdown-retiring}' sleep 1

c. Basic PEBS based perf sampling case.
   perf record -e '{branches,branches,branches,branches,branches,branches,branches,branches,cycles,instructions,ref-cycles,topdown-bad-spec,topdown-fe-bound,topdown-retiring}:p' sleep 1

d. PEBS sampling case with basic, GPRs, vector-registers and LBR groups
   perf record -e branches:p -Iax,bx,ip,ssp,xmm0,ymmh0 -b -c 10000 sleep 1

e. PEBS sampling case with auxiliary (memory info) group
   perf mem record sleep 1

f. PEBS sampling case with counter group
   perf record -e '{branches:p,branches,cycles}:S' -c 10000 sleep 1
   
g. Perf stat and record test
   perf test 95; perf test 119

h. perf-fuzzer test


Ref:

[1] https://www.intel.com/content/www/us/en/content-details/843860/intel-architecture-instruction-set-extensions-programming-reference.html
[2] https://lore.kernel.org/all/20250121152303.3128733-1-kan.liang@linux.intel.com/


Dapeng Mi (19):
  perf/x86/intel: Add PMU support for Clearwater Forest
  perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
  perf/x86/intel: Decouple BTS initialization from PEBS initialization
  perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
  perf/x86/intel: Initialize architectural PEBS
  perf/x86/intel/ds: Factor out common PEBS processing code to functions
  perf/x86/intel: Process arch-PEBS records or record fragments
  perf/x86/intel: Factor out common functions to process PEBS groups
  perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
  perf/x86/intel: Setup PEBS constraints base on counter & pdist map
  perf/x86/intel: Setup PEBS data configuration and enable legacy groups
  perf/x86/intel: Add SSP register support for arch-PEBS
  perf/x86/intel: Add counter group support for arch-PEBS
  perf/core: Support to capture higher width vector registers
  perf/x86/intel: Support arch-PEBS vector registers group capturing
  perf tools: Support to show SSP register
  perf tools: Support to capture more vector registers (common part)
  perf tools: Support to capture more vector registers (x86/Intel part)
  perf tools/tests: Add vector registers PEBS sampling test

Kan Liang (1):
  perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

 arch/arm/kernel/perf_regs.c                   |   6 +
 arch/arm64/kernel/perf_regs.c                 |   6 +
 arch/csky/kernel/perf_regs.c                  |   5 +
 arch/loongarch/kernel/perf_regs.c             |   5 +
 arch/mips/kernel/perf_regs.c                  |   5 +
 arch/powerpc/perf/perf_regs.c                 |   5 +
 arch/riscv/kernel/perf_regs.c                 |   5 +
 arch/s390/kernel/perf_regs.c                  |   5 +
 arch/x86/events/core.c                        |  94 ++-
 arch/x86/events/intel/bts.c                   |   6 +-
 arch/x86/events/intel/core.c                  | 292 +++++++-
 arch/x86/events/intel/ds.c                    | 697 ++++++++++++++----
 arch/x86/events/perf_event.h                  |  62 +-
 arch/x86/include/asm/intel_ds.h               |  10 +-
 arch/x86/include/asm/msr-index.h              |  28 +
 arch/x86/include/asm/perf_event.h             | 147 +++-
 arch/x86/include/uapi/asm/perf_regs.h         |  86 ++-
 arch/x86/kernel/perf_regs.c                   |  55 +-
 include/linux/perf_event.h                    |   2 +
 include/linux/perf_regs.h                     |  10 +
 include/uapi/linux/perf_event.h               |  10 +
 kernel/events/core.c                          |  53 +-
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  87 ++-
 tools/include/uapi/linux/perf_event.h         |  13 +
 tools/perf/arch/arm/util/perf_regs.c          |   5 +-
 tools/perf/arch/arm64/util/perf_regs.c        |   5 +-
 tools/perf/arch/csky/util/perf_regs.c         |   5 +-
 tools/perf/arch/loongarch/util/perf_regs.c    |   5 +-
 tools/perf/arch/mips/util/perf_regs.c         |   5 +-
 tools/perf/arch/powerpc/util/perf_regs.c      |   9 +-
 tools/perf/arch/riscv/util/perf_regs.c        |   5 +-
 tools/perf/arch/s390/util/perf_regs.c         |   5 +-
 tools/perf/arch/x86/util/perf_regs.c          | 108 ++-
 tools/perf/builtin-script.c                   |  19 +-
 tools/perf/tests/shell/record.sh              |  55 ++
 tools/perf/util/evsel.c                       |  14 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/parse-regs-options.c          |  23 +-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  90 +++
 tools/perf/util/perf_regs.c                   |   5 -
 tools/perf/util/perf_regs.h                   |  18 +-
 tools/perf/util/record.h                      |   2 +-
 tools/perf/util/sample.h                      |   6 +-
 tools/perf/util/session.c                     |  31 +-
 tools/perf/util/synthetic-events.c            |   7 +-
 45 files changed, 1851 insertions(+), 267 deletions(-)

-- 
2.40.1

