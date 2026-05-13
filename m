Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF43ABD96;
	Wed, 13 May 2026 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651589; cv=none; b=OeBHHmVnMc/lsOIS0Y865zTbnBATX8CGe/sviOuceHHdS/XMLFJ3RR47XTOgHpdGuIWjBCKvdpW5Aiiu7jj+PtNYlTCx9QdXWwUzweOh6dfKYARZzlAo01dVvptowIRhrA29ytX6/x7jLQSQH2U7gOoU8gZomTqI4r2UzJ1rN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651589; c=relaxed/simple;
	bh=UYC2I6R+N3tA8XEu9ZNRuDw8joNJXIKIamgztzLdTRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iedbl9EQnedE57nx9JKqEjelro2B8wymOjzEheDz1DVWEddR2joIXLGZc1dhFUMThvX4zW9GQ6Y3pdOgJlL3gErasjP4gDJRacuSbI9SPiLDc1fNlo3pvVjq95uxKHEqjNUOFuPtyWsF4eCOq7xJZYzSX0YanRMyz5lWCmPhNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q97mtKI0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q97mtKI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651588; x=1810187588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UYC2I6R+N3tA8XEu9ZNRuDw8joNJXIKIamgztzLdTRA=;
  b=Q97mtKI09eIqeK0ThWm/MV5UHbMK5eV45tw4JR157T9qSf6eYmesMEOs
   nswR7MCDB2CUMh6z0N9WZJCkRgKaForytP7BzgxnYz57w5utMhbhTsOXC
   gSN2hxnJzv+axLfiYuElon7mZQ5+j+Fr0h7xklK92koJQT+IIxsFqwz/d
   QKQOVxiltamKzas0f1SpFZmmakTas/N+3lL43MNg1EgGS15ja47e18Qm7
   VCmtXVztDGtXOBo9F2Gd6A0bIwFgNoNF8TgwHI2hlZ3Wjb3xHt8snxPOx
   U7uOQAzZo1Ng6e2ecN+lBElLLFDa7oci9yjHtu5+4JxVuyQi0JgDK4p/h
   w==;
X-CSE-ConnectionGUID: /1jNx6KWQy6+px6kZzuLnQ==
X-CSE-MsgGUID: dumo4ZINSmm7soW4cztrog==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79683140"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79683140"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:53:07 -0700
X-CSE-ConnectionGUID: dJ6fKqJhQUCTwFnub3nZug==
X-CSE-MsgGUID: /msAF0EETGulGrkS3km1NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238079520"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:53:01 -0700
Message-ID: <fd27c4a6-98c0-43d9-a8cc-393ea40cdd16@linux.intel.com>
Date: Wed, 13 May 2026 13:52:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 00/24] Support SIMD/eGPRs/SSP registers sampling for
 perf
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
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since Sashiko gave much valuable comments on this patchset, suppose it's
time to refresh a new version patchset to fix all the comments of Sashiko.
Please expect the upcoming v8 patchset. Thanks.

On 3/24/2026 8:40 AM, Dapeng Mi wrote:
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
> Starting from Intel Ice Lake, XMM registers can be collected in a PEBS
> record. Future Architecture PEBS will include additional registers such
> as YMM, ZMM, OPMASK, SSP and APX eGPRs, contingent on hardware support.
>
> This patch set introduces a software solution to mitigate the hardware
> requirement by utilizing the XSAVES command to retrieve the requested
> registers in the overflow handler. This feature is no longer limited to
> PEBS events or specific platforms. While the hardware solution remains
> preferable due to its lower overhead and higher accuracy, this software
> approach provides a viable alternative.
>
> The solution is theoretically compatible with all x86 platforms but is
> currently enabled on newer platforms, including Sapphire Rapids and
> later P-core server platforms, Sierra Forest and later E-core server
> platforms and recent Client platforms, like Arrow Lake, Panther Lake and
> Nova Lake.
>
> Newly supported registers include YMM, ZMM, OPMASK, SSP, and APX eGPRs.
> Due to space constraints in sample_regs_user/intr, new fields have been 
> introduced in the perf_event_attr structure to accommodate these
> registers.
>
> After a long discussion in V1,
> https://lore.kernel.org/lkml/3f1c9a9e-cb63-47ff-a5e9-06555fa6cc9a@linux.intel.com/
> The below new fields are introduced.
>
> @@ -547,6 +549,25 @@ struct perf_event_attr {
>
>         __u64   config3; /* extension of config2 */
>         __u64   config4; /* extension of config3 */
> +
> +       /*
> +        * Defines set of SIMD registers to dump on samples.
> +        * The sample_simd_regs_enabled !=0 implies the
> +        * set of SIMD registers is used to config all SIMD registers.
> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
> +        * config some SIMD registers on X86.
> +        */
> +       union {
> +               __u16 sample_simd_regs_enabled;
> +               __u16 sample_simd_pred_reg_qwords;
> +       };
> +       __u16   sample_simd_vec_reg_qwords;
> +       __u32   __reserved_4;
> +
> +       __u32   sample_simd_pred_reg_intr;
> +       __u32   sample_simd_pred_reg_user;
> +       __u64   sample_simd_vec_reg_intr;
> +       __u64   sample_simd_vec_reg_user;
>  };
>
>  /*
> @@ -1020,7 +1041,15 @@ enum perf_event_type {
>          *      } && PERF_SAMPLE_BRANCH_STACK
>          *
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;         # 0 ... weight(sample_simd_vec_reg_user)
> +        *              u16 vector_qwords;      # 0 ... sample_simd_vec_reg_qwords
> +        *              u16 nr_pred;            # 0 ... weight(sample_simd_pred_reg_user)
> +        *              u16 pred_qwords;        # 0 ... sample_simd_pred_reg_qwords
> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +        *      } && PERF_SAMPLE_REGS_USER
>          *
>          *      { u64                   size;
>          *        char                  data[size];
> @@ -1047,7 +1076,15 @@ enum perf_event_type {
>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_SRC
>          *      { u64                   transaction; } && PERF_SAMPLE_TRANSACTION
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;         # 0 ... weight(sample_simd_vec_reg_intr)
> +        *              u16 vector_qwords;      # 0 ... sample_simd_vec_reg_qwords
> +        *              u16 nr_pred;            # 0 ... weight(sample_simd_pred_reg_intr)
> +        *              u16 pred_qwords;        # 0 ... sample_simd_pred_reg_qwords
> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +        *      } && PERF_SAMPLE_REGS_INTR
>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
>          *      { u64                   data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>
>
> To maintain simplicity, a single field, sample_{simd|pred}_vec_reg_qwords,
> is introduced to indicate register width. For example:
> - sample_simd_vec_reg_qwords = 2 for XMM registers (128 bits) on x86
> - sample_simd_vec_reg_qwords = 4 for YMM registers (256 bits) on x86
>
> Four additional fields, sample_{simd|pred}_vec_reg_{intr|user}, represent
> the bitmap of sampling registers. For instance, the bitmap for x86
> XMM registers is 0xffff (16 XMM registers). Although users can
> theoretically sample a subset of registers, the current perf-tool
> implementation supports sampling all registers of each type to avoid
> complexity.
>
> A new ABI, PERF_SAMPLE_REGS_ABI_SIMD, is introduced to signal user space 
> tools about the presence of SIMD registers in sampling records. When this
> flag is detected, tools should recognize that extra SIMD register data
> follows the general register data. The layout of the extra SIMD register
> data is displayed as follow.
>
>    u16 nr_vectors;
>    u16 vector_qwords;
>    u16 nr_pred;
>    u16 pred_qwords;
>    u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>
> With this patch set, sampling for the aforementioned registers is
> supported on the Intel Nova Lake platform.
>
> Examples:
>  $perf record -I?
>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>
>  $perf record --user-regs=?
>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>
>  $perf record -e branches:p -Iax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask -c 100000 ./test
>  $perf report -D
>
>  ... ...
>  14027761992115 0xcf30 [0x8a8]: PERF_RECORD_SAMPLE(IP, 0x1): 29964/29964:
>  0xffffffff9f085e24 period: 100000 addr: 0
>  ... intr regs: mask 0x18001010003 ABI 64-bit
>  .... AX    0xdffffc0000000000
>  .... BX    0xffff8882297685e8
>  .... R8    0x0000000000000000
>  .... R16   0x0000000000000000
>  .... R31   0x0000000000000000
>  .... SSP   0x0000000000000000
>  ... SIMD ABI nr_vectors 32 vector_qwords 8 nr_pred 8 pred_qwords 1
>  .... ZMM  [0] 0xffffffffffffffff
>  .... ZMM  [0] 0x0000000000000001
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [0] 0x0000000000000000
>  .... ZMM  [1] 0x003a6b6165506d56
>  ... ...
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... ZMM  [31] 0x0000000000000000
>  .... OPMASK[0] 0x00000000fffffe00
>  .... OPMASK[1] 0x0000000000ffffff
>  .... OPMASK[2] 0x000000000000007f
>  .... OPMASK[3] 0x0000000000000000
>  .... OPMASK[4] 0x0000000000010080
>  .... OPMASK[5] 0x0000000000000000
>  .... OPMASK[6] 0x0000400004000000
>  .... OPMASK[7] 0x0000000000000000
>  ... ...
>
>
> History:
>   v6: https://lore.kernel.org/all/20260209072047.2180332-1-dapeng1.mi@linux.intel.com/
>   v5: https://lore.kernel.org/all/20251203065500.2597594-1-dapeng1.mi@linux.intel.com/
>   v4: https://lore.kernel.org/all/20250925061213.178796-1-dapeng1.mi@linux.intel.com/
>   v3: https://lore.kernel.org/lkml/20250815213435.1702022-1-kan.liang@linux.intel.com/
>   v2: https://lore.kernel.org/lkml/20250626195610.405379-1-kan.liang@linux.intel.com/
>   v1: https://lore.kernel.org/lkml/20250613134943.3186517-1-kan.liang@linux.intel.com/
>
> Dapeng Mi (12):
>   perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
>   perf/x86/intel: Avoid PEBS event on fixed counters without extended
>     PEBS
>   perf/x86/intel: Enable large PEBS sampling for XMMs
>   perf/x86/intel: Convert x86_perf_regs to per-cpu variables
>   perf: Eliminate duplicate arch-specific functions definations
>   x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after saving FPU state
>   perf/x86: Enable XMM Register Sampling for Non-PEBS Events
>   perf/x86: Enable XMM register sampling for REGS_USER case
>   perf: Enhance perf_reg_validate() with simd_enabled argument
>   perf/x86/intel: Enable arch-PEBS based SIMD/eGPRs/SSP sampling
>   perf/x86: Activate back-to-back NMI detection for arch-PEBS induced
>     NMIs
>   perf/x86/intel: Add sanity check for PEBS fragment size
>
> Kan Liang (12):
>   perf/x86: Use x86_perf_regs in the x86 nmi handler
>   perf/x86: Introduce x86-specific x86_pmu_setup_regs_data()
>   x86/fpu/xstate: Add xsaves_nmi() helper
>   perf: Move and rename has_extended_regs() for ARCH-specific use
>   perf: Add sampling support for SIMD registers
>   perf/x86: Enable XMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Enable YMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Enable ZMM sampling using sample_simd_vec_reg_* fields
>   perf/x86: Enable OPMASK sampling using sample_simd_pred_reg_* fields
>   perf/x86: Enable eGPRs sampling using sample_regs_* fields
>   perf/x86: Enable SSP sampling using sample_regs_* fields
>   perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
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
>  arch/x86/events/core.c                | 392 +++++++++++++++++++++++++-
>  arch/x86/events/intel/core.c          | 127 ++++++++-
>  arch/x86/events/intel/ds.c            | 195 ++++++++++---
>  arch/x86/events/perf_event.h          |  85 +++++-
>  arch/x86/include/asm/fpu/sched.h      |   5 +-
>  arch/x86/include/asm/fpu/xstate.h     |   3 +
>  arch/x86/include/asm/msr-index.h      |   7 +
>  arch/x86/include/asm/perf_event.h     |  38 ++-
>  arch/x86/include/uapi/asm/perf_regs.h |  51 ++++
>  arch/x86/kernel/fpu/core.c            |  27 +-
>  arch/x86/kernel/fpu/xstate.c          |  25 +-
>  arch/x86/kernel/perf_regs.c           | 134 +++++++--
>  include/linux/perf_event.h            |  16 ++
>  include/linux/perf_regs.h             |  36 +--
>  include/uapi/linux/perf_event.h       |  50 +++-
>  kernel/events/core.c                  | 138 +++++++--
>  tools/perf/util/header.c              |   3 +-
>  26 files changed, 1193 insertions(+), 199 deletions(-)
>
