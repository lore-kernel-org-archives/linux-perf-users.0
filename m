Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4933263A;
	Tue,  7 Apr 2026 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543463; cv=none; b=sGF0shQAng/XKhzikvMq6jkOBvuC2utp5xLAiurjzOB6lOth+jBm144U1CtcUKlxM6ev11vVNXZODMoRN9k78u0OIkjOXK1VH7gdv/7b+dy6sX50j9HrUVQQTsch6J61H8oFCq41Siy4Sby8jUwqHyFhu6IRkeZi2wvfbvHqoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543463; c=relaxed/simple;
	bh=ZjDuRFze+AHugvjB7qruDfFAWxga1V7Fm3W1dbFGhZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKMc+89PjV7IouAk+PV5Ce0+HkxeFgFfJdwx6qm+dlDBmy02uGteT99qzxrfhOgb/Rj+ONcBR6XsSH0tDoK40nXdmDJcxHppPGkyTID9/dA7mB+1+47lCpcKOeA0PRdU7PqV+r3Wc4MLfydDjQGax69RqB6eQQ83XOOan/lmPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYJ2V1jK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYJ2V1jK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7455DC116C6;
	Tue,  7 Apr 2026 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775543463;
	bh=ZjDuRFze+AHugvjB7qruDfFAWxga1V7Fm3W1dbFGhZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYJ2V1jKJb7okmaQx+prequ0kdbPIp9XLsd5sS0qlt/XdHQh4SENMm1rD/p+1lv9I
	 Yx9uFmry1tOtn36QRC+5187jx1ogut9luleFYBN5E9HWDviaw/aCxFs73FPl6VHIca
	 BEEBBMMAc05rz29IubGdKtHOqrpulk1r1nkt605qpKimxMKSeTgOJzrX6JugDbnRjE
	 UONo2a6jOJsTGszmWny3f4af20rwUCGtwdy/NAsLjjwEie8puqHpekYPW58YYe/ccF
	 m1PybxcTgcS5CmG1eWMEmWRDEBvyqj3pPf1NUy1zB+5QW2WZnlAuJzqZr+otVqHfEw
	 OZjdf7BDVzxuQ==
Date: Mon, 6 Apr 2026 23:31:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 00/16] perf arm64: Support data type profiling
Message-ID: <adSkpI9AoTNgISU5@z2>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>

Hello,

On Fri, Apr 03, 2026 at 09:47:44AM +0000, Tengda Wu wrote:
> This patch series implements data type profiling support for arm64,
> building upon the foundational work previously contributed by Huafei [1].
> While the initial version laid the groundwork for arm64 data type analysis,
> this series iterates on that work by refining instruction parsing and
> extending support for core architectural features.

Thanks for working on this!  I'm happy to see that the changes are well
organized and each commit explained the issues clearly.  

> 
> The series is organized as follows:
> 
> 1. Fix disassembly mismatches (Patches 01-02)
>    Current perf annotate supports three disassembly backends: llvm,
>    capstone, and objdump. On arm64, inconsistencies between the output
>    of these backends (specifically llvm/capstone vs. objdump) often
>    prevent the tracker from correctly identifying registers and offsets.
>    These patches resolve these mismatches, ensuring consistent instruction
>    parsing across all supported backends.
> 
> 2. Infrastructure for arm64 operand parsing (Patches 03-07)
>    These patches establish the necessary infrastructure for arm64-specific
>    operand handling. This includes implementing new callbacks and data
>    structures to manage arm64's unique addressing modes and register sets.
>    This foundation is essential for the subsequent type-tracking logic.

I've only checked up to this part so far.  Let me write replies soon.
I'll continue to review later in this week.

> 
> 3. Core instruction tracking (Patches 08-16)
>    These patches implement the core logic for type tracking on arm64,
>    covering a wide range of instructions including:
> 
>    * Memory Access: ldr/str variants (including stack-based access).
>    * Arithmetic & Data Processing: mov, add, and adrp.
>    * Special Access: System register access (mrs) and per-cpu variable
>      tracking.
> 
> The implementation draws inspiration from the existing x86 logic while
> adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
> perf annotate can successfully resolve memory locations and register
> types, enabling comprehensive data type profiling on arm64 platforms.
> 
> Example Result
> ==============
> 
> # perf mem record -a -K -- sleep 1
> # perf annotate --data-type --type-stat --stdio
> Annotate data type stats:
> total 6204, ok 5091 (82.1%), bad 1113 (17.9%)

I'm impressed that the success rate is quite high.  But I think you need
to confirm that the findings are correct by taking a close look at each
result.  You can try `perf annotate --code-with-type`.

Thanks,
Namhyung


> -----------------------------------------------------------
>         29 : no_sym
>        196 : no_var
>        806 : no_typeinfo
>         82 : bad_offset
>       1370 : insn_track
> 
> Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
> ============================================================================
>  Percent     offset       size  field
>   100.00          0       0x40  struct page      {
>     9.95          0        0x8      long unsigned int   flags;
>    52.83        0x8       0x28      union        {
>    52.83        0x8       0x28          struct   {
>    37.21        0x8       0x10              union        {
>    37.21        0x8       0x10                  struct list_head        lru {
>    37.21        0x8        0x8                      struct list_head*   next;
>     0.00       0x10        0x8                      struct list_head*   prev;
>                                                 };
>    37.21        0x8       0x10                  struct   {
>    37.21        0x8        0x8                      void*       __filler;
>     0.00       0x10        0x4                      unsigned int        mlock_count;
>    ...
> 
> Changes since v1: (reworked from Huafei's series):
> 
>  - Fix inconsistencies in arm64 instruction output across llvm, capstone,
>    and objdump disassembly backends.
>  - Support arm64-specific addressing modes and operand formats. (Leo Yan)
>  - Extend instruction tracking to support mov and add instructions,
>    along with per-cpu and stack variables.
>  - Include real-world examples in commit messages to demonstrate
>    practical effects. (Namhyung Kim)
>  - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
>    https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
> 
> Please let me know if you have any feedback.
> 
> Thanks,
> Tengda
> 
> [1] https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
> [2] https://developer.arm.com/documentation/102374/0103
> [3] https://github.com/flynd/asmsheets/releases/tag/v8
> 
> ---
> 
> Tengda Wu (16):
>   perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>     objdump
>   perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
>   perf annotate-arm64: Generalize arm64_mov__parse to support standard
>     operands
>   perf annotate-arm64: Handle load and store instructions
>   perf annotate: Introduce extract_op_location callback for
>     arch-specific parsing
>   perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>   perf annotate-arm64: Implement extract_op_location() callback
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
>  .../perf/util/annotate-arch/annotate-arm64.c  | 642 +++++++++++++++++-
>  .../util/annotate-arch/annotate-powerpc.c     |  10 +
>  tools/perf/util/annotate-arch/annotate-x86.c  |  88 ++-
>  tools/perf/util/annotate-data.c               |  72 +-
>  tools/perf/util/annotate-data.h               |   7 +-
>  tools/perf/util/annotate.c                    | 108 +--
>  tools/perf/util/annotate.h                    |  12 +
>  tools/perf/util/capstone.c                    | 107 ++-
>  tools/perf/util/disasm.c                      |   5 +
>  tools/perf/util/disasm.h                      |   5 +
>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |  20 +
>  tools/perf/util/dwarf-regs.c                  |   2 +-
>  tools/perf/util/include/dwarf-regs.h          |   1 +
>  tools/perf/util/llvm.c                        |  50 ++
>  14 files changed, 984 insertions(+), 145 deletions(-)
> 
> 
> base-commit: cf7c3c02fdd0dfccf4d6611714273dcb538af2cb
> -- 
> 2.34.1
> 
