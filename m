Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83222E173B;
	Thu,  9 Jul 2026 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576467; cv=none; b=i8KEUb5tTWJGg3HRHiO8/AlsIEJP4PBfedllZCqAqENj88n4FqnHrO1wtroROYCrwP1dozFEfNeujpZ7GkFTooBpCDU6yllp2MkmDScHGJRkgb9aQ2QttdxX88xh48MwMyPS1zWoth/hWr2rG63/TVXhiZ+iiWAbrV+zVmsgytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576467; c=relaxed/simple;
	bh=Ic1uwGlEK4XESVOQw1MQvN5CapS4sveotajTDYIWJ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY2HmnUJMz88VBEfmEafz0T5o0U1jxHJAugu/kTQI6YykmYB+UdfMT83hYkQNWMyu3ILhw/6093IZ1nSsFvRXJpQMf1dgc6p06L96GIi0AWqYr1Pc2Br8ZtdO7rviUb4DlNcm7vcxqPj6MiW5/HGVlxofbCUZfUzS8q9qWrk1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzaE7B+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzaE7B+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DF51F000E9;
	Thu,  9 Jul 2026 05:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783576465;
	bh=9rK45uHfg3sCGD5lJd5qtMbJf3oULmDqqKREt6/XzB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BzaE7B+gP6S1g/LIzQc3QpKK0f5IFqUb3HXJVcUfIYcWfhqjXfv2ARDPbcJiWLeNC
	 /qhUx82DMWeYFLmYmggwuYpW/sSPX8yBKMFHLRnXGQzVQXp1H0yKjhdWYapDfjHO1K
	 DJjDQw3s7YaK8fNz3K456mL92V2QVdmUOzSUYlYzPlQ594K8o6Adwv/M50B84NVeom
	 F08+YvTaUk8MCL/RlmxCgI8CgfBwQGH/OwbGmBSAHNJE3p+kbXHaoSahaXsnqI9RcG
	 2PPlrqmH/ku1s8ynF+aY/rOQkJCB67ReUUxwJrUx1BMcdBKk9CaXPnpvSv6bCvZYmh
	 iBrIDlUQfndMQ==
Date: Wed, 8 Jul 2026 22:54:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 00/21] perf arm64: Support data type profiling
Message-ID: <ak83j6sZGGqwW8Ak@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>

Hello,

On Wed, Jul 01, 2026 at 03:53:34AM +0000, Tengda Wu wrote:
> This patch series implements data type profiling support for arm64,
> enabling 'perf annotate --data-type' to resolve memory locations and
> variable types on arm64 platforms.
> 
> The main changes since v2 include:
> v2: https://lore.kernel.org/all/20260403094800.1418825-1-wutengda@huaweicloud.com/
> 
> * Reworking operand parsing, where src/dst are now set based on the
>   actual instruction definition rather than always treating the left
>   operand as src and the right as dst (Namhyung Kim).
> 
> * Register state handling has been improved, with better support for
>   TSR_KIND_CONST and proper invalidation of dst for unsupported
>   instructions.
> 
> * Several bug fixes are included, such as fixing a refcount leak, a
>   global type resolving error (James Clark), unconditional call to
>   arch->extract_op_location() (sashiko [1]). --itrace=i1i is now enabled
>   by default for ARM SPE data type profiling to avoid overlapping
>   events (James Clark).
> 
> Patch organization
> ==================
> 
> The series is organized as follows:
> 
> 1. Fix refcount leak in print_capstone_detail(). (Patches 01)
> 
> 2. Fix disassembly mismatches (Patches 02-03)
>    Current perf annotate supports three disassembly backends: llvm,
>    capstone, and objdump. On arm64, inconsistencies between the output
>    of these backends (specifically llvm/capstone vs. objdump) often
>    prevent the tracker from correctly identifying registers and offsets.
>    These patches resolve these mismatches, ensuring consistent instruction
>    parsing across all supported backends.
> 
> 3. Infrastructure for arm64 operand parsing (Patches 04-09)
>    These patches establish the necessary infrastructure for arm64-specific
>    operand handling. This includes implementing new callbacks and data
>    structures to manage arm64's unique addressing modes and register sets.
>    This foundation is essential for the subsequent type-tracking logic.
> 
> 4. ARM SPE even handling (Patches 10-11)
>    Patch 10 automatically deduplicates overlapping ARM SPE events (e.g.,
>    l1d-miss, tlb-access) in 'perf annotate' by retaining only the
>    "instructions" event when data type profiling is enabled. Patch 11
>    defaults the itrace period to 1 for PERF_ITRACE_PERIOD_INSTRUCTIONS
>    to fix zero 'Percent' values in annotate output.
> 
> 5. Core instruction tracking (Patches 12-21)
>    These patches implement the core logic for type tracking on arm64,
>    covering several key types of instructions, including:
>    * Memory Access: ldr/str variants (including stack-based access).
>    * Arithmetic & Data Processing: mov, add, and adrp.
>    * Special Access: System register access (mrs) and per-cpu variable
>      tracking.
> 
> The implementation draws inspiration from the existing x86 logic while
> adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
> perf annotate can successfully resolve memory locations and register types,
> providing basic support for data type profiling on arm64 platforms.
> 
> Example Result
> ==============
> 
> # perf mem record -a -K -- sleep 1
> # perf annotate --data-type --stdio --type-stat
> Annotate data type stats:
> total 1138, ok 876 (77.0%), bad 262 (23.0%)
> -----------------------------------------------------------
>          6 : no_sym
>         42 : no_var
>        206 : no_typeinfo
>          8 : bad_offset
>        237 : insn_track
> 
> Annotate type: 'struct page' in [kernel.kallsyms] (66948 samples):
> ============================================================================
>  Percent     offset       size  field
>   100.00          0       0x40  struct page      {
>     9.01          0        0x8      long unsigned int   flags;
>    57.99        0x8       0x28      union        {
>    57.99        0x8       0x28          struct   {
>    33.00        0x8       0x10              union        {
>    33.00        0x8       0x10                  struct list_head        lru {
>    33.00        0x8        0x8                      struct list_head*   next;
>     0.00       0x10        0x8                      struct list_head*   prev;
>                                                 };
>    33.00        0x8       0x10                  struct   {
>    33.00        0x8        0x8                      void*       __filler;
>     0.00       0x10        0x4                      unsigned int        mlock_count;
>    ...
> 
> Each patch's type profiling results are as follows:
> 
> Patch | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
> ------+--------+--------+-------------+------------+------------+------
> 0010  | 6      | 493    | -           | -          | -          | 56.2%
> 0013  | 6      | 42     | 438         | 2          | 11         | 57.1%
> 0014  | 6      | 42     | 399         | 1          | 51         | 60.6%
> 0015  | 6      | 42     | 398         | 1          | 52         | 60.7%
> 0016  | 6      | 42     | 393         | 1          | 57         | 61.2%
> 0017  | 6      | 42     | 376         | 3          | 72         | 62.5%
> 0018  | 6      | 42     | 305         | 7          | 139        | 68.4%
> 0019  | 6      | 42     | 218         | 8          | 225        | 75.9%
> 0020  | 6      | 42     | 217         | 8          | 226        | 76.0%
> 0021  | 6      | 42     | 206         | 8          | 237        | 77.0%
> 
> A few notes:
> * Capstone fails to build when rebased to the base-commit (known issue,
>   not yet fixed [4]). I disabled it locally for testing.
> * Among the remaining 23% bad annotation, about 14% comes from compiler
>   generated prologue or epilogue code (e.g., stp	x21, x22, [sp, #32]).
>   No solution has been identified for this so far.
> 
> Testing
> =======
> 
> Tested on arm64 (all passed):
> 
>   # perf test -v "perf data type profiling tests"
>   81: perf data type profiling tests                                                                  : Ok
> 
>   === Test Summary ===
>   Passed main tests : 1
>   Passed subtests   : 0
>   Skipped tests     : 0
>   Failed tests      : 0
> 
> Tested on x86. The profiling results show no change before/after applying
> this patch series:
> 
>   before : total 880, ok 711 (80.8%), bad 169 (19.2%)
>   after  : total 880, ok 711 (80.8%), bad 169 (19.2%)
> 
> Changelog
> =========
> 
> v2 -> v3:
>   - v2: https://lore.kernel.org/all/20260403094800.1418825-1-wutengda@huaweicloud.com/
>   - Instead of always parsing the left operand as src and the right operand as
>     dst, set them based on the actual instruction definition. (Namhyung Kim)
>   - Fix refcount leak in print_capstone_detail().
>   - Remove useless '<' check when parsing 'addr <symbol>' in arm64_mov__parse().
>   - Add example comments in arm64_ldst__parse().
>   - Split arch__dwarf_regnum() changes into a separate commit.
>   - Rename annotated_addr_mode enum: INSN_ADDR_* -> PERF_ADDR_MODE_*.
>   - Set caller-saved registers in init_type_state().
>   - For instructions with addressing mode, always goto adjust_reg_index_state()
>     at the end to update the src register state.
>   - Handle TSR_KIND_CONST registers for 'mov' and 'add' instructions.
>   - Invalidate dst register for all other unsupported instructions.
>   - Verify type DIE is task_struct pointer before caching globally.
>   - Enable --itrace=i1i by default for ARM SPE data type profiling in 'perf annotate'
>     to avoid overlapping event counting for the same instruction. (James Clark)
>   - Fix global variable type resolving error in check_matching_type(). (James Clark)
>   - Address review comments from sashiko [1]:
>     - Fix unconditional call to arch->extract_op_location()
>     - Handle multi_regs correctly
>     - Fix invalid register state in error path
>     - Other misc fixes
> v1 -> v2:
>   - v1: https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
>   - Fix inconsistencies in arm64 instruction output across llvm, capstone,
>     and objdump disassembly backends.
>   - Support arm64-specific addressing modes and operand formats. (Leo Yan)
>   - Extend instruction tracking to support mov and add instructions,
>     along with per-cpu and stack variables.
>   - Include real-world examples in commit messages to demonstrate
>     practical effects. (Namhyung Kim)
>   - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
> 
> Please let me know if you have any feedback.

Thanks for working on this!  The patchset looks well-organized and it's
nice that you added some real world examples for better understanding.

I think Sashiko found many real issues that need to be handled.  Let's
fix them first.  I'll leave comment on the patches separately.

Thanks,
Namhyung

> 
> [1] https://sashiko.dev/#/patchset/20260403094800.1418825-1-wutengda%40huaweicloud.com
> [2] https://developer.arm.com/documentation/102374/0103
> [3] https://github.com/flynd/asmsheets/releases/tag/v8
> [4] https://lore.kernel.org/all/aiCgbmUtlMCM4Xzt@x1/#t
> 
> 
> Tengda Wu (21):
>   perf capstone: Fix kernel map reference count leak
>   perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
>   perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>     objdump
>   perf annotate-arm64: Generalize arm64_mov__parse to support more
>     instructions
>   perf annotate-arm64: Handle load and store instructions
>   perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>   perf annotate: Adapt arch__dwarf_regnum() for arm64
>   perf annotate: Introduce extract_op_location callback for
>     arch-specific parsing
>   perf annotate-arm64: Implement extract_op_location() callback
>   perf annotate: Deduplicate overlapping ARM SPE events for data type
>     profiling
>   perf auxtrace: Set default period to 1 for
>     PERF_ITRACE_PERIOD_INSTRUCTIONS type
>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>   perf annotate-arm64: Enable instruction tracking support
>   perf annotate-arm64: Support load instruction tracking
>   perf annotate-arm64: Support store instruction tracking
>   perf annotate-arm64: Support stack variable tracking
>   perf annotate-arm64: Support 'mov' instruction tracking
>   perf annotate-arm64: Support 'add' instruction tracking
>   perf annotate-arm64: Support 'adrp' instruction to track global
>     variables
>   perf annotate-arm64: Support per-cpu variable access tracking
>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>     pointer
> 
>  tools/perf/builtin-annotate.c                 |  13 +
>  .../perf/util/annotate-arch/annotate-arm64.c  | 901 +++++++++++++++++-
>  .../util/annotate-arch/annotate-powerpc.c     |  10 +
>  tools/perf/util/annotate-arch/annotate-x86.c  |  97 +-
>  tools/perf/util/annotate-data.c               |  77 +-
>  tools/perf/util/annotate-data.h               |   8 +-
>  tools/perf/util/annotate.c                    | 108 +--
>  tools/perf/util/annotate.h                    |  12 +
>  tools/perf/util/arm-spe.c                     |   1 +
>  tools/perf/util/auxtrace.c                    |   6 +
>  tools/perf/util/capstone.c                    | 144 ++-
>  tools/perf/util/disasm.c                      |   5 +
>  tools/perf/util/disasm.h                      |   5 +
>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |  20 +
>  tools/perf/util/dwarf-regs.c                  |   2 +-
>  tools/perf/util/include/dwarf-regs.h          |   1 +
>  tools/perf/util/llvm.c                        |  50 +
>  17 files changed, 1307 insertions(+), 153 deletions(-)
> 
> 
> base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
> -- 
> 2.34.1
> 
