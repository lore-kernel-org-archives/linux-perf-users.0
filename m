Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E13849C;
	Thu, 25 Sep 2025 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780854; cv=none; b=BMwICeh/pBlrT8kc0oB1Yse4w0B1a+mNQr11cQ545/U1H0eIRt9co40Anpl0YBuS3SYgL7w/fUPVD8Mizk90+2uHB6OcDXFAQs95wxMVhZ7g0Io8xLc2/CdedjDRzZasCdxWA/HPhHV7dzMVeXpvEnRDHTF0zw7UN3C75xjTWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780854; c=relaxed/simple;
	bh=TvXZQtjJFfQtGTb6aE5U5LBFLnI1T8Rj/jKxdlhf41Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ae1fc3WICPuIqttOR4kdBpF7kWdt0ymJOtncUJR5o2li8UNINILglzluopjsyGTYHu0Wv6kCXSd19JRXPMAZuwu0OKWGyEjSKy0T/Kdr2vNys9fF1eleGXZqTdIs2vSDaLyPk8OhNm7p1KICS8EVVgP1XsOL/cqOR9utXlZ+K6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKmk5tv7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKmk5tv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780853; x=1790316853;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TvXZQtjJFfQtGTb6aE5U5LBFLnI1T8Rj/jKxdlhf41Q=;
  b=KKmk5tv7SfXDcX+uc12cWYOMMOZs6Fqc5AgMb/tm/zmTslD/aYMemgnf
   irgWJMSIjVv5lY5EFl0RtNrobuK7A8qXqGTzVJ4ygRW/O0QaaPSQPWnH3
   Fo7KvEa+t+bV6woasF2T9++M+9KgXnQYosOWM72iFRm+hmBiPG5C82ILu
   2u3lya8dGL0OyEya7ubiQbWCxixfMcjI2KQIwTKxs2EvosCpt85CIKdZn
   okfyhxZ45PvSDe2MEwY86GU6q8uUXIzYRZJHao1zpqMjBBTtVHo+dA8it
   MvPP9tzhNWL64UwJhPm0U86Y9cwLW9DNoq8EmR8D97xCBux0tVV21l1jo
   g==;
X-CSE-ConnectionGUID: 9N96+Ed0SV+xFrDlJNHQsg==
X-CSE-MsgGUID: evOnrlfGTdaDtDoJ+qPCwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139472"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139472"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:12 -0700
X-CSE-ConnectionGUID: saVxe+P4RrWToLAwuwnn0g==
X-CSE-MsgGUID: 1Q9xLIUVSTqHbX2J/TLKUg==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528261"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:07 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 00/17] Support vector and more extended registers in perf 
Date: Thu, 25 Sep 2025 14:11:56 +0800
Message-Id: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since V3:
- Drop the SIMD registers if an NMI hits kernel mode for REGS_USER.
- Only dump the available regs, rather than zero and dump the
  unavailable regs. It's possible that the dumped registers are a subset
  of the requested registers.
- Some minor updates to address Dapeng's comments in V3.

Changes since V2:
- Use the FPU format for the x86_pmu.ext_regs_mask as well
- Add a check before invoking xsaves_nmi()
- Add perf_simd_reg_check() to retrieve the number of available
  registers. If the kernel fails to get the requested registers, e.g.,
  XSAVES fails, nothing dumps to the userspace (the V2 dumps all 0s).
- Add POC perf tool patches

Changes since V1:
- Apply the new interfaces to configure and dump the SIMD registers
- Utilize the existing FPU functions, e.g., xstate_calculate_size,
  get_xsave_addr().

Starting from the Intel Ice Lake, the XMM registers can be collected in
a PEBS record. More registers, e.g., YMM, ZMM, OPMASK, SPP and APX, will
be added in the upcoming Architecture PEBS as well. But it requires the
hardware support.

The patch set provides a software solution to mitigate the hardware
requirement. It utilizes the XSAVES command to retrieve the requested
registers in the overflow handler. The feature isn't limited to the PEBS
event or specific platforms anymore.
The hardware solution (if available) is still preferred, since it has
low overhead (especially with the large PEBS) and is more accurate.

In theory, the solution should work for all X86 platforms. But I only
have newer Inter platforms to test. The patch set only enable the
feature for Intel Ice Lake and later platforms.

The new registers include YMM, ZMM, OPMASK, SSP, and APX.
The sample_regs_user/intr has run out. A new field in the
struct perf_event_attr is required for the registers.

After a long discussion in V1,
https://lore.kernel.org/lkml/3f1c9a9e-cb63-47ff-a5e9-06555fa6cc9a@linux.intel.com/

The new field looks like as below.
@@ -543,6 +545,25 @@ struct perf_event_attr {
        __u64   sig_data;

        __u64   config3; /* extension of config2 */
+
+
+       /*
+        * Defines set of SIMD registers to dump on samples.
+        * The sample_simd_regs_enabled !=0 implies the
+        * set of SIMD registers is used to config all SIMD registers.
+        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
+        * config some SIMD registers on X86.
+        */
+       union {
+               __u16 sample_simd_regs_enabled;
+               __u16 sample_simd_pred_reg_qwords;
+       };
+       __u32 sample_simd_pred_reg_intr;
+       __u32 sample_simd_pred_reg_user;
+       __u16 sample_simd_vec_reg_qwords;
+       __u64 sample_simd_vec_reg_intr;
+       __u64 sample_simd_vec_reg_user;
+       __u32 __reserved_4;
 };
@@ -1016,7 +1037,15 @@ enum perf_event_type {
         *      } && PERF_SAMPLE_BRANCH_STACK
         *
         *      { u64                   abi; # enum perf_sample_regs_abi
-        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+        *        u64                   regs[weight(mask)];
+        *        struct {
+        *              u16 nr_vectors;
+        *              u16 vector_qwords;
+        *              u16 nr_pred;
+        *              u16 pred_qwords;
+        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+        *      } && PERF_SAMPLE_REGS_USER
         *
         *      { u64                   size;
         *        char                  data[size];
@@ -1043,7 +1072,15 @@ enum perf_event_type {
         *      { u64                   data_src; } && PERF_SAMPLE_DATA_SRC
         *      { u64                   transaction; } && PERF_SAMPLE_TRANSACTION
         *      { u64                   abi; # enum perf_sample_regs_abi
-        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+        *        u64                   regs[weight(mask)];
+        *        struct {
+        *              u16 nr_vectors;
+        *              u16 vector_qwords;
+        *              u16 nr_pred;
+        *              u16 pred_qwords;
+        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+        *      } && PERF_SAMPLE_REGS_INTR
         *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
         *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
         *      { u64                   data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE


Since there is only one vector qwords field, the qwords for the newest
vector should be set by the tools. For example, if the end user wants
XMM0 and YMM1, the vector qwords should be 4. The vector mask should be
0x3. The YMM0 and YMM1 will be dumped to the userspace. It's the tool's
responsibility to output the XMM0 and YMM1 to the end user.

The POC perf tool patches for testing purposes is also attached.

Examples:
 $perf record -I?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 SSP XMM0-31 YMM0-31 ZMM0-31 OPMASK0-7

 $perf record --user-regs=?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 SSP XMM0-31 YMM0-31 ZMM0-31 OPMASK0-7

 $perf record -e cycles:p -IXMM,YMM,OPMASK,SSP ./test
 $perf report -D
 ... ...
 237538985992962 0x454d0 [0x480]: PERF_RECORD_SAMPLE(IP, 0x1):
 179370/179370: 0xffffffff969627fc period: 124999 addr: 0
 ... intr regs: mask 0x20000000000 ABI 64-bit
 .... SSP   0x0000000000000000
 ... SIMD ABI nr_vectors 32 vector_qwords 4 nr_pred 8 pred_qwords 1
 .... YMM  [0] 0x0000000000004000
 .... YMM  [0] 0x000055e828695270
 .... YMM  [0] 0x0000000000000000
 .... YMM  [0] 0x0000000000000000
 .... YMM  [1] 0x000055e8286990e0
 .... YMM  [1] 0x000055e828698dd0
 .... YMM  [1] 0x0000000000000000
 .... YMM  [1] 0x0000000000000000
 ... ...
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... OPMASK[0] 0x0000000000100221
 .... OPMASK[1] 0x0000000000000020
 .... OPMASK[2] 0x000000007fffffff
 .... OPMASK[3] 0x0000000000000000
 .... OPMASK[4] 0x0000000000000000
 .... OPMASK[5] 0x0000000000000000
 .... OPMASK[6] 0x0000000000000000
 .... OPMASK[7] 0x0000000000000000
 ... ...


History:
  v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@linux.intel.com/
  v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linux.intel.com/
  v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@linux.intel.com/

Kan Liang (17):
  perf/x86: Use x86_perf_regs in the x86 nmi handler
  perf/x86: Setup the regs data
  x86/fpu/xstate: Add xsaves_nmi
  perf: Move has_extended_regs() to header file
  perf/x86: Support XMM register for non-PEBS and REGS_USER
  perf: Support SIMD registers
  perf/x86: Move XMM to sample_simd_vec_regs
  perf/x86: Add YMM into sample_simd_vec_regs
  perf/x86: Add ZMM into sample_simd_vec_regs
  perf/x86: Add OPMASK into sample_simd_pred_reg
  perf/x86: Add eGPRs into sample_regs
  perf/x86: Add SSP into sample_regs
  perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
  perf tools: Only support legacy regs for the PT and PERF_REGS_MASK
  perf tools: headers: Sync with the kernel sources
  perf tools: parse-regs: Support the new SIMD format
  perf tools: regs: Support to dump regs for PERF_SAMPLE_REGS_ABI_SIMD

 arch/x86/events/core.c                        | 315 ++++++++++++-
 arch/x86/events/intel/core.c                  |  75 ++-
 arch/x86/events/intel/ds.c                    |  12 +-
 arch/x86/events/perf_event.h                  |  80 ++++
 arch/x86/include/asm/fpu/xstate.h             |   3 +
 arch/x86/include/asm/perf_event.h             |  30 +-
 arch/x86/include/uapi/asm/perf_regs.h         |  65 ++-
 arch/x86/kernel/fpu/xstate.c                  |  32 +-
 arch/x86/kernel/perf_regs.c                   | 139 +++++-
 include/linux/perf_event.h                    |  16 +
 include/linux/perf_regs.h                     |  26 +
 include/uapi/linux/perf_event.h               |  45 +-
 kernel/events/core.c                          | 111 ++++-
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  65 ++-
 tools/include/uapi/linux/perf_event.h         |  45 +-
 tools/perf/arch/x86/include/perf_regs.h       |   2 +-
 tools/perf/arch/x86/util/perf_regs.c          | 443 +++++++++++++++++-
 tools/perf/util/evsel.c                       |  45 ++
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/parse-regs-options.c          | 133 +++++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  43 ++
 tools/perf/util/perf_event_attr_fprintf.c     |   6 +
 tools/perf/util/perf_regs.c                   |  54 +++
 tools/perf/util/perf_regs.h                   |  10 +
 tools/perf/util/record.h                      |   6 +
 tools/perf/util/sample.h                      |  10 +
 tools/perf/util/session.c                     |  78 ++-
 27 files changed, 1814 insertions(+), 77 deletions(-)


base-commit: 6d48436560e91be858158e227f21aab71698814e
-- 
2.34.1

