Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D23E1CFA
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353521; cv=none; b=f4TDHUfTTZMn1RG945oJlj1NeQwbv8y+3yH1fnoHnydRa9BgCVJ+6t21NuoxkIqho/K89fCFpg5JalIWQip455jWVz7U8KMAm4hfaV+1VySC3ta82mAc5tIJFtxksXA4k4rn7eUSM0aFTZUigv/o2JbbjkGlPOOMqTvCT8UtY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353521; c=relaxed/simple;
	bh=/X8ItnyA/kqYxt6tBH5sp0atYOKdyjxvtoz6cRHBLas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxAgbafP34XZvirnvGiZEV7iWpBNChaL0Sbz0fsO9Jhj/maLY9qt6Fa6Pir8BQUjr+LqEOTEjUjZI4JeUcRQ2cUg6tbgdpsk8Oa27YhxFrs8FPRqaQfxVEfXLH8/JfX3cGUOToZtNjQN7qQASjzgVLaGMfqClzuTKAm9vXxpIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUE6TKfk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUE6TKfk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso133201255e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776353518; x=1776958318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prWA7W2ACOCk6HGSY5V1GIkFG4SIB+ah9yxh0HXKDtU=;
        b=gUE6TKfkmEiqoO8GD8XhMaCkgBmPLIjXWZU1Q81N1yYJTHRzEMQuV8LPRLT+2o3/eQ
         aYYj9ONRPgV4fJh4g/OnfYhFdxPpIMNjf6D1TQiM0+mIjCngsXBgPQ0tJF0pud6HKHE5
         nAkVxlbHM2k/KxC9gRz49jDG1AUAwvrzhexIogyO2opi8oUanThcyMpShhZQUBRKL8TI
         j+/CCiYfI4/v1nENNFHuEirFc4WnOou+SPRtdID/B3WRTaBq123w/Q8hwdpMkoviQn8n
         V/unyGU1DyGlwOVp8gHxxLcL4tMJRgr99P7mciQuk2gPFnA8E56L16RptGL0ZYhYcNPW
         wo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353518; x=1776958318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prWA7W2ACOCk6HGSY5V1GIkFG4SIB+ah9yxh0HXKDtU=;
        b=K6QAnLz0RWoPGLhQpvLCWLkP2/ZJK7Rm55yjtJ/xPm5iHmdLmLtEbcUH+vqyZHUfF+
         SlHznF1hR+cNO255A6nhQ0C5otqb+YfDP+oh/GvSgFGPdnUojQbYOnjvfg4DGmpeqRGD
         dftmoi+gF374up3IDt/aWUeTbxYZDRyX9Y3R/PZlxAd2uluyEg99n0u10H5BdYjape2L
         Mxw/ZNA5ZpDSqPmklPYwGbjJ2jBWYqo2JSO91d0ZrfUMt9Beq56NLW+CzcplmxiWfuXT
         K4TVOhBh4yalSLIpYxFfrJ9rBHgpmluEZBR7MgHFqAOrnVsftqn22P0mo99tJtUIWUUu
         Dlsw==
X-Forwarded-Encrypted: i=1; AFNElJ9F9qVMfGQyQ0vI4V52kVw2f3X6FWlP0ICMHMFfORsgj1WZNA0FVwlpr7o19FxR3gok1D6wRYh8qOsPlFCiEWGG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5P8hKUm9pfK20Stu6gdjX69W12HPdBNtYQFMhvF18ogmDdC7B
	hHOtuC76SKWU9qT/QUB8gUU5qq0ATxvhs+ENpZb8NbJntET/heVOwybHki2ZApNn3Ic=
X-Gm-Gg: AeBDiev+zjFTJG2tDLg5ecfLOG3hdbf4+HBnNU1dfIPbH4cudXTtvYRtsv/9molG7tB
	1f00LcctdLmaFGjbbeF6yJQKB9B34ysdUU6NkTtfGRp0j6TrtwLmLoOI/CBStRmoC0Im0ei3oLu
	lA4+R3Ny2COOhSvXEsWhN1u13eZ1uVKRjju0UX+oUkeF4kxic0jfQ9f/JSwwDeUGrqRYhbiBtD5
	kGhRPdjFRCOXX+YRGYa0R2YL67w02tsxs3o7taypzUakk9evkeDtAZ5XwP695GhXw1yaxIrriLq
	N8yEaZ2aaCMFjsidfQJUsiPqIt7Fw+RjqKGVRCwzPBgjXYSUUPyQgXb7cuHHrv5cyoSenvY4DQF
	KvEeOGDGtIqG6qpWzCiHGaM2CcmsFQkGv1qQvv27HmJZsQC6gVT5lxBaVryjJvjer2l+6NLindI
	6VjcsBFO5O4Qe8psxRIXPhkgNVsVIEEYY+RfjFFwyAvZk=
X-Received: by 2002:a05:600c:a306:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-488d68607e8mr263915345e9.21.1776353518124;
        Thu, 16 Apr 2026 08:31:58 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581652csm64439625e9.3.2026.04.16.08.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 08:31:57 -0700 (PDT)
Message-ID: <55fde39f-36b4-44b4-bb9f-4179c6d2d066@linaro.org>
Date: Thu, 16 Apr 2026 16:31:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] perf arm64: Support data type profiling
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/04/2026 10:47, Tengda Wu wrote:
> This patch series implements data type profiling support for arm64,
> building upon the foundational work previously contributed by Huafei [1].
> While the initial version laid the groundwork for arm64 data type analysis,
> this series iterates on that work by refining instruction parsing and
> extending support for core architectural features.
> 
> The series is organized as follows:
> 
> 1. Fix disassembly mismatches (Patches 01-02)
>     Current perf annotate supports three disassembly backends: llvm,
>     capstone, and objdump. On arm64, inconsistencies between the output
>     of these backends (specifically llvm/capstone vs. objdump) often
>     prevent the tracker from correctly identifying registers and offsets.
>     These patches resolve these mismatches, ensuring consistent instruction
>     parsing across all supported backends.
> 
> 2. Infrastructure for arm64 operand parsing (Patches 03-07)
>     These patches establish the necessary infrastructure for arm64-specific
>     operand handling. This includes implementing new callbacks and data
>     structures to manage arm64's unique addressing modes and register sets.
>     This foundation is essential for the subsequent type-tracking logic.
> 
> 3. Core instruction tracking (Patches 08-16)
>     These patches implement the core logic for type tracking on arm64,
>     covering a wide range of instructions including:
> 
>     * Memory Access: ldr/str variants (including stack-based access).
>     * Arithmetic & Data Processing: mov, add, and adrp.
>     * Special Access: System register access (mrs) and per-cpu variable
>       tracking.
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

Hi Tengda,

Did you run this with any itrace options? If I run your command I get 
repeated blocks of duplicate stats and types, which is very confusing. 
One for each sample type that we generate decoding SPE.

For example the default perf report output has all these groups:

   Available samples
   0 arm_spe_0/
     ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/
   0 dummy:u
   3 l1d-miss
   18 l1d-access
   0 llc-miss
   0 llc-access
   0 tlb-miss
   22 tlb-access
   0 branch
   0 remote-access
   22 memory
   22 instructions

Obviously there are 22 samples total (instructions) and they get 
duplicated into whatever other categories they happen to have flags for.

To remove the duplicates you have to do --itrace=i1i. Could that need to 
be default for perf annotate with SPE?

> Annotate data type stats:
> total 6204, ok 5091 (82.1%), bad 1113 (17.9%)
> -----------------------------------------------------------
>          29 : no_sym
>         196 : no_var
>         806 : no_typeinfo
>          82 : bad_offset
>        1370 : insn_track
> 
> Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
> ============================================================================
>   Percent     offset       size  field
>    100.00          0       0x40  struct page      {
>      9.95          0        0x8      long unsigned int   flags;
>     52.83        0x8       0x28      union        {
>     52.83        0x8       0x28          struct   {
>     37.21        0x8       0x10              union        {
>     37.21        0x8       0x10                  struct list_head        lru {
>     37.21        0x8        0x8                      struct list_head*   next;
>      0.00       0x10        0x8                      struct list_head*   prev;
>                                                  };
>     37.21        0x8       0x10                  struct   {
>     37.21        0x8        0x8                      void*       __filler;
>      0.00       0x10        0x4                      unsigned int        mlock_count;
>     ...
> 
> Changes since v1: (reworked from Huafei's series):
> 
>   - Fix inconsistencies in arm64 instruction output across llvm, capstone,
>     and objdump disassembly backends.
>   - Support arm64-specific addressing modes and operand formats. (Leo Yan)
>   - Extend instruction tracking to support mov and add instructions,
>     along with per-cpu and stack variables.
>   - Include real-world examples in commit messages to demonstrate
>     practical effects. (Namhyung Kim)
>   - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
>     https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
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
>    perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>      objdump
>    perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
>    perf annotate-arm64: Generalize arm64_mov__parse to support standard
>      operands
>    perf annotate-arm64: Handle load and store instructions
>    perf annotate: Introduce extract_op_location callback for
>      arch-specific parsing
>    perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>    perf annotate-arm64: Implement extract_op_location() callback
>    perf annotate-arm64: Enable instruction tracking support
>    perf annotate-arm64: Support load instruction tracking
>    perf annotate-arm64: Support store instruction tracking
>    perf annotate-arm64: Support stack variable tracking
>    perf annotate-arm64: Support 'mov' instruction tracking
>    perf annotate-arm64: Support 'add' instruction tracking
>    perf annotate-arm64: Support 'adrp' instruction to track global
>      variables
>    perf annotate-arm64: Support per-cpu variable access tracking
>    perf annotate-arm64: Support 'mrs' instruction to track 'current'
>      pointer
> 
>   .../perf/util/annotate-arch/annotate-arm64.c  | 642 +++++++++++++++++-
>   .../util/annotate-arch/annotate-powerpc.c     |  10 +
>   tools/perf/util/annotate-arch/annotate-x86.c  |  88 ++-
>   tools/perf/util/annotate-data.c               |  72 +-
>   tools/perf/util/annotate-data.h               |   7 +-
>   tools/perf/util/annotate.c                    | 108 +--
>   tools/perf/util/annotate.h                    |  12 +
>   tools/perf/util/capstone.c                    | 107 ++-
>   tools/perf/util/disasm.c                      |   5 +
>   tools/perf/util/disasm.h                      |   5 +
>   .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |  20 +
>   tools/perf/util/dwarf-regs.c                  |   2 +-
>   tools/perf/util/include/dwarf-regs.h          |   1 +
>   tools/perf/util/llvm.c                        |  50 ++
>   14 files changed, 984 insertions(+), 145 deletions(-)
> 
> 
> base-commit: cf7c3c02fdd0dfccf4d6611714273dcb538af2cb

