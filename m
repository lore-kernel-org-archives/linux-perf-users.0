Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D4310784;
	Tue,  1 Sep 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252938; cv=none; b=i0K7D9Z/hrrr8RNaqSF/KIlmmNZV7ezKGvf/o4wX2NTMaAam2kCOs3FEeWmnnv4HDHp7Y2KYR79J3BjpicF6dK/94XtrqfehpmbmhJ3DdpjHE4TWsU2TEDY2yBWJQI1Po1zS9EVW8cdG+SzSde2zu6dbO7Pho18J1fTy+OUecfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252938; c=relaxed/simple;
	bh=2mxy+0jYC1BbuGMbDsbUYTKch83qiLlVoIW1YWFb0W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxJ1M0R/vZRZQDD27tZH7oVZ4W8mOobqIlzGl1XG3v88TWROWUpfMW7cL9F+gI37lYigjnjH32qIajgOPKdCkdDVXKhp8avmCUmnScrTRMJolQQuo+Z7GPuuyFAnGEFusldklEef8CCKTxE0wYzLe7diNkSBrQjmZaQqGjvIPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmA76ajC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmA76ajC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788252936; x=1819788936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2mxy+0jYC1BbuGMbDsbUYTKch83qiLlVoIW1YWFb0W8=;
  b=lmA76ajC25nUGlsc2TWfGofvMm4B87QJs6+ahq7pziSmmV3YAnKEMjfm
   /XTtLG40VNLAwgWQ9XQGq9jjyXqGY8xnQPi+oMz/Z9IagTkza0Wso3Lc+
   K8POrO/q6dwPBehLBEQEnTN7k4Vy68jSDyTAGk1ukAIU6IhA/jxa4XZzZ
   Yt8j82FKRDykv7MsDUaeRBzArGo5/VTI51iFaRGyhkfhuHIgmWi13wh1n
   yge5mEzTsrlNPpMGwwcI5tEJOphyrviC+Buz80z4Pg3URxeJeMInJgYP+
   GUuHSWLw3LsQaxuk5NFnN4LQKTOJy6OQJPz5h9BnExbB2YR4np1Jbttk0
   A==;
X-CSE-ConnectionGUID: PMoSTh7jShiaQ3vsMtlX0Q==
X-CSE-MsgGUID: +CRhI1iBSgibZyGIWmXDHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92363874"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92363874"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:55:36 -0700
X-CSE-ConnectionGUID: i6v12J3/RmqygblKlvIr2w==
X-CSE-MsgGUID: Ns7XbHkdSOqbfP5bINenyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="292544729"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:55:30 -0700
Message-ID: <e80b6588-1ac7-48df-a8f1-8305cffcd14a@linux.intel.com>
Date: Tue, 1 Sep 2026 16:55:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v10 00/23] Support SIMD/eGPRs/SSP registers
 sampling for perf
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

Kindly ping ... Not sure if you have bandwidth to review this patch series? 

Currently all review comments are addressed and finally Sashiko can't find
issues. :)

Thanks.


On 8/24/2026 4:27 PM, Dapeng Mi wrote:
> The below prerequisite bug-fix patchset has been merged, resend this
> patch series to trigger Sashiko's review.
>
> https://lore.kernel.org/all/20260717080342.1879573-1-dapeng1.mi@linux.intel.com/
>
> Patch layout:
> - Patches 1-5: Bug fixes and cleanup needed before enabling XSAVES-based
>   sampling in NMI context.
> - Patches 6-7: FPU-related preparation, including xsaves_nmi() and
>   related cleanup/optimization.
> - Patches 8-11: PMI-based XMM sampling support through the existing
>   sample_regs_intr/sample_regs_user interfaces for both
>   PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER.
> - Patches 12-19: New SIMD register interface and support for
>   XMM/YMM/ZMM/OPMASK, APX eGPRs, and SSP through that interface.
> - Patch 20: Extend arch PEBS to support YMM/ZMM/OPMASK, APX eGPRs, and
>   SSP with the new interface.
> - Patch 21: Enable new interface based sampling.
> - Patches 22-23: arch PEBS bug fix and sanity check.
>
> Changes since v9:
> - Patch 07/23: Update fpu_swap_kvm_fpstate() to clear fpu->__task_fpstate
>   only after switching back to host state, ensuring that when non-NULL it
>   points to host FPU state.
> - Patch 11/23: Fix an issue where guest FPU state can be sampled during
>   host user-regs sampling.
> - Patch 13/23: Improve and streamline perf_simd_reg_validate() to enforce
>   full-register-only sampling for SIMD registers (XMM/YMM/ZMM/OPMASK).
> - Patch 21/23: Simplify and unify PERF_PMU_CAP_SIMD_REGS capability
>   handling for both PEBS and non-PEBS events.
> - Refine changelog text across the full patch series.
>
> Changes since v8:
> - Patch 01/24: Fix missing PMI handler unregister on PMU initialization
>   failure (Sashiko).
> - Patch 11/24: Skip kernel-space SIMD sampling when exclude_kernel is 
>   set, to account for PMI skid (Sashiko).
> - Patch 12/24: Skip guest kernel-space SIMD sampling for user register
>   sampling.
> - Patch 14/24: Strengthen SIMD register configuration validation in
>   perf_simd_reg_validate() (Sashiko).
> - Patch 17/24: Strengthen PRED (OPMASK) register configuration validation
>   in perf_simd_reg_validate() (Sashiko).
> - Patch 21/24: Enhance large-PEBS checks for SSP and APX eGPR registers
>   (Sashiko).
> - Patch 22/24: Refine PERF_PMU_CAP_SIMD_REGS setup: advertise the
>   capability only when both XSAVES and Arch PEBS are supported (Peter).
> - Refine patch changelogs across the series.
>
> Changes since V7:
> - Validate the return value of intel_pmu_init_hybrid() (Patch 01/23).
> - Replace pt_regs with x86_perf_regs in xen_pmu_irq_handler()
>   (Patch 06/23).
> - Improve event_has_extended_regs() (Patch 09/23).
> - Explicitly ensure the allocated XSAVE area is 64-byte aligned
>   (Patch 10/23, Sashiko).
> - Clear the SIMD register pointers in x86_user_regs to avoid exposing
>   stale register data to user space (Patch 11/23, Sashiko).
> - Refine the SIMD register interface and sample data layout, and add the
>   missing SIMD data reservation in perf_prepare_sample() for non-x86
>   architectures (Patch 12/23, Sashiko).
> - Improve perf_simd_reg_validate() for x86 (Patch 13/23, Sashiko).
> - Refine SSP sampling and ensure the GPR sub-group flag is set for PEBS
>   (Patch 19/23, Sashiko).
> - Fix the incorrect large-PEBS check for XMM (Patch 20/23, Sashiko).
> - Fix missing handling in x86_pmu_handle_guest_pebs() for back-to-back
>   PMI detection (Patch 22/23, Sashiko).
> - Strengthen the PEBS record header sanity checks to prevent invalid
>   memory access (Patch 23/23, Sashiko).
>
> Changes since V6:
> - Fix potential overwritten issue in hybrid PMU structure (patch 01/24)
> - Restrict PEBS events work on GP counters if no PEBS baseline suggested
>   (patch 02/24)
> - Use per-cpu x86_intr_regs for perf_event_nmi_handler() instead of
>   temporary variable (patch 06/24)
> - Add helper update_fpu_state_and_flag() to ensure TIF_NEED_FPU_LOAD is
>   set after save_fpregs_to_fpstate() call (patch 09/24)
> - Optimize and simplify x86_pmu_sample_xregs(), etc. (patch 11/24)
> - Add macro word_for_each_set_bit() to simplify u64 set-bit iteration
>   (patch 13/24)
> - Add sanity check for PEBS fragment size (patch 24/24)
>
> Changes since V5:
> - Introduce 3 commits to fix newly found PEBS issues (Patch 01~03/19)
> - Address Peter comments, including,
>   * Fully support user-regs sampling of the SIMD/eGPRs/SSP registers
>   * Adjust newly added fields in perf_event_attr to avoid holes
>   * Fix the endian issue introduced by for_each_set_bit() in
>     event/core.c
>   * Remove some unnecessary macros from UAPI header perf_regs.h
>   * Enhance b2b NMI detection for all PEBS handlers to ensure identical
>     behaviors of all PEBS handlers
> - Split perf-tools patches which would be posted in a separate patchset
>   later
>
> Changes since V4:
> - Rewrite some functions comments and commit messages (Dave)
> - Add arch-PEBS based SIMD/eGPRs/SSP sampling support (Patch 15/19)
> - Fix "suspecious NMI" warnning observed on PTL/NVL P-core and DMR by
>   activating back-to-back NMI detection mechanism (Patch 16/19)
> - Fix some minor issues on perf-tool patches (Patch 18/19)
>
> Changes since V3:
> - Drop the SIMD registers if an NMI hits kernel mode for REGS_USER.
> - Only dump the available regs, rather than zero and dump the
>   unavailable regs. It's possible that the dumped registers are a subset
>   of the requested registers.
> - Some minor updates to address Dapeng's comments in V3.
>
> Changes since V2:
> - Use the FPU format for the x86_pmu.ext_regs_mask as well
> - Add a check before invoking xsaves_nmi()
> - Add perf_simd_reg_check() to retrieve the number of available
>   registers. If the kernel fails to get the requested registers, e.g.,
>   XSAVES fails, nothing dumps to the userspace (the V2 dumps all 0s).
> - Add POC perf tool patches
>
> Changes since V1:
> - Apply the new interfaces to configure and dump the SIMD registers
> - Utilize the existing FPU functions, e.g., xstate_calculate_size,
>   get_xsave_addr().
>
>
> This series adds support on x86 for sampling SIMD registers, APX eGPRs,
> and SSP with both PMI-based and PEBS-based sampling.
>
> Starting with Intel Ice Lake, PEBS can sample XMM registers, but PMI-based
> XMM sampling is still not available. On newer Intel platforms with
> architectural PEBS support, such as Clearwater Forest and Diamond Rapids,
> the hardware also gains support for sampling additional SIMD state
> (XMM/YMM/ZMM/OPMASK), APX extended GPRs, and SSP.
>
> To support these registers consistently across both PMI and PEBS, this
> series makes the following changes:
>
> 1. Adds a new perf_event_attr interface for SIMD register selection.
>    The existing sample_regs_user/sample_regs_intr bitmaps do not have
>    enough space to represent the full SIMD register set, so this series
>    introduces dedicated fields for SIMD and predicate register masks and
>    element widths.
>
> 2. Introduces a new sample data layout for SIMD register data.
>    SIMD register payload is appended after the GPR payload, and a new ABI
>    flag, PERF_SAMPLE_REGS_ABI_SIMD, indicates its presence.
>
> 3. Adds xsaves_nmi() to allow SIMD/eGPR/SSP sampling from PMI handlers in
>    NMI context.
>
> 4. Extends the arch PEBS path to support YMM/ZMM/OPMASK, APX eGPRs, and
>    SSP sampling.
>
>
> New perf_event_attr fields
> --------------------------
>
> This series adds the following fields to perf_event_attr:
>
>     /*
>      * Defines the sampling SIMD/PRED(predicate) register bitmaps and
>      * qword (8-byte) lengths.
>      *
>      * sample_simd_regs_enabled != 0 indicates SIMD/PRED registers are
>      * requested. The register bitmaps and element sizes are described by:
>      *
>      *   sample_simd_{vec,pred}_reg_{intr,user}
>      *   sample_simd_{vec,pred}_reg_qwords
>      *
>      * sample_simd_regs_enabled == 0 indicates no SIMD/PRED registers are
>      * requested.
>      */
>     __u16 sample_simd_regs_enabled;
>     __u16 sample_simd_pred_reg_qwords;
>     __u16 sample_simd_vec_reg_qwords;
>     __u16 __reserved_4;
>
>     __u32 sample_simd_pred_reg_intr;
>     __u32 sample_simd_pred_reg_user;
>     __u64 sample_simd_vec_reg_intr;
>     __u64 sample_simd_vec_reg_user;
>
> Field semantics:
> - sample_simd_vec_reg_qwords: qword count for regular SIMD registers
> - sample_simd_pred_reg_qwords: qword count for predicate registers
> - sample_simd_vec_reg_{intr,user}: SIMD register masks for
>   PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER
> - sample_simd_pred_reg_{intr,user}: predicate register masks for
>   PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER
> - sample_simd_regs_enabled: indicates whether the new SIMD fields are in use
>
> Examples:
>
> To sample ZMM registers for PERF_SAMPLE_REGS_INTR:
>
>     sample_simd_regs_enabled = 1
>     sample_simd_vec_reg_qwords = 8          // 512 bits = 8 qwords
>     sample_simd_vec_reg_intr = 0xffffffff   // zmm0-zmm31
>
> To sample OPMASK registers for PERF_SAMPLE_REGS_USER:
>
>     sample_simd_regs_enabled = 1
>     sample_simd_pred_reg_qwords = 1         // 64 bits = 1 qword
>     sample_simd_pred_reg_user = 0xff        // opmask0-opmask7
>
> After introducing these fields, bits [63:32] in sample_regs_user and
> sample_regs_intr are reclaimed for APX eGPRs and SSP instead of the
> previous XMM0-XMM15 encoding.
>
> Discussion of the new SIMD register interface is available at:
> https://lore.kernel.org/lkml/20250617081458.GI1613376@noisy.programming.kicks-ass.net/
>
> Sample data layout
> ------------------
>
> SIMD register data is appended after the GPR data.
>
> For PERF_SAMPLE_REGS_USER:
>
>     { u64 abi;                      // enum perf_sample_regs_abi
>       u64 regs[weight(mask)];
>       struct {
>             u64 nr_vectors;         // 0 ... weight(sample_simd_vec_reg_user)
>             u64 vector_qwords;      // 0 ... sample_simd_vec_reg_qwords
>             u64 nr_pred;            // 0 ... weight(sample_simd_pred_reg_user)
>             u64 pred_qwords;        // 0 ... sample_simd_pred_reg_qwords
>             u64 data[nr_vectors * vector_qwords +
>                      nr_pred * pred_qwords];
>       } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>     }
>
> For PERF_SAMPLE_REGS_INTR:
>
>     { u64 abi;                      // enum perf_sample_regs_abi
>       u64 regs[weight(mask)];
>       struct {
>             u64 nr_vectors;         // 0 ... weight(sample_simd_vec_reg_intr)
>             u64 vector_qwords;      // 0 ... sample_simd_vec_reg_qwords
>             u64 nr_pred;            // 0 ... weight(sample_simd_pred_reg_intr)
>             u64 pred_qwords;        // 0 ... sample_simd_pred_reg_qwords
>             u64 data[nr_vectors * vector_qwords +
>                      nr_pred * pred_qwords];
>       } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>     }
>
> PERF_SAMPLE_REGS_ABI_SIMD indicates that SIMD register data is present.
>
> The metadata fields are encoded as u64 to keep perf tool parsing and
> cross-endian support straightforward.
>
> Example
> -------
>
>   $ perf record -I?
>   available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>   R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27
>   R28 R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>
>   $ perf record --user-regs=?
>   available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>   R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27
>   R28 R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>
>   $ perf record -e branches:p \
>         -Iax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask \
>         -c 100000 ./test
>   $ perf report -D
>
>   ...
>   14027761992115 0xcf30 [0x8a8]: PERF_RECORD_SAMPLE(IP, 0x1): 29964/29964:
>   0xffffffff9f085e24 period: 100000 addr: 0
>   ... intr regs: mask 0x18001010003 ABI 64-bit
>   .... AX    0xdffffc0000000000
>   .... BX    0xffff8882297685e8
>   .... R8    0x0000000000000000
>   .... R16   0x0000000000000000
>   .... R31   0x0000000000000000
>   .... SSP   0x0000000000000000
>   ... SIMD ABI nr_vectors 32 vector_qwords 8 nr_pred 8 pred_qwords 1
>   .... ZMM[0][0] 0x616c2f656d6f682f
>   .... ZMM[0][1] 0x696c2f7265737562
>   ...
>   .... ZMM[31][7] 0x0000000000000000
>   .... OPMASK[0] 0x00000000fffffe00
>   ....
>   .... OPMASK[7] 0x0000000000000000
>   ...
>
> Testing
> -------
>
> The following intr-regs, user-regs, and combined sampling tests were run
> on DMR and NVL. The sampled register data was reported correctly and no
> issues were observed.
>
>   $ ./perf record -e branches:p \
>         -Iax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask -b -c 10000 sleep 1
>
>   $ ./perf record -e branches \
>         -Iax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask -b -c 10000 sleep 1
>
>   $ ./perf record -e branches:p \
>         --user-regs=ax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask \
>         -b -c 10000 sleep 1
>
>   $ ./perf record -e branches \
>         --user-regs=ax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask \
>         -b -c 10000 sleep 1
>
>   $ ./perf record -e branches:p \
>         -Ixmm,ymm,zmm,opmask \
>         --user-regs=ax,bx,r8,r16,r31,ssp \
>         -b -c 10000 sleep 1
>
>   $ ./perf record -e branches:p \
>         --user-regs=xmm,ymm,zmm,opmask \
>         -Iax,bx,r8,r16,r31,ssp \
>         -b -c 10000 sleep 1
>
>   $ ./perf record -e branches:p \
>         -Iax,bx,r9,r17,r30,ssp \
>         --user-regs=ax,bx,r8,r16,r31,ssp \
>         -b -c 10000 sleep 1
>
>   $ ./perf record -e branches:p \
>         -Ixmm,opmask --user-regs=zmm \
>         -b -c 10000 taskset -c 0 sleep 1
>
>
> History:
>   v9: https://lore.kernel.org/all/20260706015439.3040804-1-dapeng1.mi@linux.intel.com/
>   v8: https://lore.kernel.org/all/20260529075645.580362-1-dapeng1.mi@linux.intel.com/
>   v7: https://lore.kernel.org/all/20260324004118.3772171-1-dapeng1.mi@linux.intel.com/
>   v6: https://lore.kernel.org/all/20260209072047.2180332-1-dapeng1.mi@linux.intel.com/
>   v5: https://lore.kernel.org/all/20251203065500.2597594-1-dapeng1.mi@linux.intel.com/
>   v4: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/
>   v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@linux.intel.com/
>   v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linux.intel.com/
>   v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@linux.intel.com/
>
> Dapeng Mi (20):
>   perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
>   perf/x86/intel: Enable large PEBS sampling for XMMs
>   perf/x86/intel: Convert x86_perf_regs to per-cpu variables
>   perf: Eliminate duplicate arch-specific function definitions
>   perf/x86: Use x86_perf_regs in NMI handlers
>   x86/fpu: Add update_fpu_state_and_flag() helper
>   perf/x86/intel: Centralize PERF_PMU_CAP_EXTENDED_REGS updates
>   perf/x86: Enable XMM register sampling for non-PEBS events
>   perf/x86: Enable XMM register sampling for REGS_USER case
>   perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Support YMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Support ZMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Support OPMASK sampling using sample_simd_pred_reg_* fields
>   perf: Enhance perf_reg_validate() with simd_enabled argument
>   perf/x86: Support eGPRs sampling using sample_regs_* fields
>   perf/x86: Support SSP sampling using sample_regs_* fields
>   perf/x86/intel: Support arch-PEBS based SIMD/eGPRs sampling
>   perf/x86/intel: Advertise PERF_PMU_CAP_SIMD_REGS capability
>   perf/x86: Activate back-to-back NMI detection for arch-PEBS induced
>     NMIs
>   perf/x86/intel: Add sanity check for PEBS record/fragment size
>
> Kan Liang (3):
>   x86/fpu/xstate: Add xsaves_nmi() helper
>   perf: Move and enhance has_extended_regs() for arch-specific use
>   perf: Add sampling support for SIMD registers
>
>  arch/arm/kernel/perf_regs.c           |   8 +-
>  arch/arm64/kernel/perf_regs.c         |   8 +-
>  arch/csky/kernel/perf_regs.c          |   8 +-
>  arch/loongarch/kernel/perf_regs.c     |   8 +-
>  arch/mips/kernel/perf_regs.c          |   8 +-
>  arch/parisc/kernel/perf_regs.c        |   8 +-
>  arch/powerpc/perf/perf_regs.c         |   2 +-
>  arch/riscv/kernel/perf_regs.c         |   8 +-
>  arch/s390/kernel/perf_regs.c          |   2 +-
>  arch/x86/events/core.c                | 483 +++++++++++++++++++++++++-
>  arch/x86/events/intel/core.c          | 108 ++++--
>  arch/x86/events/intel/ds.c            | 232 ++++++++++---
>  arch/x86/events/perf_event.h          | 208 ++++++++++-
>  arch/x86/include/asm/fpu/sched.h      |   5 +-
>  arch/x86/include/asm/fpu/xstate.h     |   3 +
>  arch/x86/include/asm/msr-index.h      |   7 +
>  arch/x86/include/asm/perf_event.h     |  35 +-
>  arch/x86/include/uapi/asm/perf_regs.h |  53 +++
>  arch/x86/kernel/fpu/core.c            |  33 +-
>  arch/x86/kernel/fpu/xstate.c          |  25 +-
>  arch/x86/kernel/perf_regs.c           | 174 ++++++++--
>  arch/x86/xen/pmu.c                    |   5 +-
>  include/linux/perf_event.h            |  23 ++
>  include/linux/perf_regs.h             |  36 +-
>  include/uapi/linux/perf_event.h       |  49 ++-
>  kernel/events/core.c                  | 177 +++++++++-
>  26 files changed, 1490 insertions(+), 226 deletions(-)
>
>
> base-commit: 917d558b151cad5b05991e5eaee22efab33525ca
