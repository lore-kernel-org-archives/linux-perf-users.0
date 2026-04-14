Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9B3E9583
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179414; cv=none; b=hObEZosDYK38tm6YoLwpmqj6JLLkGLJ2jkvoUBj6xJHvC4N5EWJjT3PrFbYXr4a8UWS+PqehZcwdpTWZ8sI5/1SzsT8WN0p8sGV5Bba5Hf/6DjtbeBoCpOzXPesG7iOeRpp7x0r4e9db2HhNL32QH/OtnEPkwRNwgq/J8IrdyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179414; c=relaxed/simple;
	bh=uMchkorxToYSrU6ghe2GS10pMnhri5zs8xu3S+YpKxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5cRl4Thf2YL88ZcLcWIZOjoOITFTds42FO0HEpATQc2YWRHbT/I9WeoPGbqtGCZn5L499zs/6t/E+Yodb3faYZIBoiZ2dJxLbfFRJcML8T6NzFbcUsZRx+sx9XB+8u9FuSVekHQ9Nb3ty6xghrVqcSM1eWJB9XASk5bi4UibGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzzaeOLt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzzaeOLt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d03db7f87so3566416f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776179410; x=1776784210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QFDI9YfKzUZJ8z8gPIF1oW5RHbzvFlT0YT3Kdp1CRo=;
        b=JzzaeOLt48ldvjt/An0SZcG4VKc6gosBtSwdPJn0csjM5FydWltcegy8e0dz9gD4Ts
         wbdXoMRy/ghR0PCxbjM6heS9nf6enE7ZSpbynlzUhtOALq4ncoRQb25hNwipemDzup4b
         gGQJLkYPjooWrp/Rfin1iZL3XOTVU2go8rsmGJ3fKT6MPBEOL2eAu7gGNMiN5+MXFxzY
         QZQ+ITMh4xUEqK2s0KTwqJFwBfQj2nmC/fkRS06Q6De1sfhHdIHOofC01eZi2QvBDmNd
         3Q5sjuKFJI7sCdioFfZQ0VzC7cuHD1MjP8RbwSWYK2HqwMfvc+H+TJNti5VdoCmFv0uS
         aR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179410; x=1776784210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QFDI9YfKzUZJ8z8gPIF1oW5RHbzvFlT0YT3Kdp1CRo=;
        b=OdtpJ/7A+pww9KY94yzf2IsXDXQ1Afhnk7KTQfN1lchtZGKTkHKzQQGEWRM8lOCrkz
         iP7Agtnbm6kjQFohqmA+KeilqdGPNX4lhJnF7/UqNFocR/A+JS0eUq1iZCUtqAq0/2a0
         IL/QKdVKjeSPBbupkFTDwkPyvjDbP/+Ov94RSYeRg2mHuD1nACY99dLzjbW31qqRB22w
         oTWlDwJtQ81ZRJYjTY8YvvT2iRq1I0grXYxqIEtX2FaU7mP/7dY0v7FpY87duDaGQ6zY
         rPJviTnAno3monjZnsgJOFXhEgcvmQ2dU2kgSdWNqBy9VgK7pd4eA5t1eR9bIVfi78Wd
         HzGA==
X-Forwarded-Encrypted: i=1; AFNElJ+hjgNkWNuklU5L346X3Ubl5mnVVDNrTyMiuCSD4g+gpuCbDqpyTwiQFS2e9RqoryOJje059Kyhdq1jmVBO1HkY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+zTq73epn5pXq+uTzSo3RYQCuu4mPO2L0H6W1k6b14C1ybc/4
	N3YtD2vBkbzs+S4d6zm5DsGcajaHUAriahmOKqs930shy79L1ogyefNHPq4BBoJRApo=
X-Gm-Gg: AeBDies6WX+qFwNM6vmj4q2qM3Fk3O01JrRBj+8R5cHY4wzBa25f5XztC1EufVEb+Zp
	4glsvSDH5/av9mkEnHW7Zbbwkn0yZdaTW8Lu6sL8M8x/VOXwqOmBQBwmfRMaVwoTjCtbrvUGpdV
	vxWPgCkmZGLSM80kLeVkaWYOJfaXLsvI1vFPiyIPlhIoiTQhfEc1UISCd38556ryFzwG1x/IhP6
	puMePUbX46B2sbCUQaMDHjZoL2DAeaSFck7F3YWnHXvNXe+QLW+MwgtneHPJVa4s9vTPRPPXU82
	iAvVF8Ypkqv+eVhV+1mXFN6aYXu8QfpD/FAilEK3jv4ArN3yq3g6XgENZOZaKAYu5map/hhgUal
	MD9iTRv+THBwYn3UjIeCNgUi7Id7mXVEbkkuq6jp76XbPA/028Th/R2Cx4yw4tmyupPBA0XXfSE
	MpPhErapdRCtkKCUMBqLUgue8V9aKMgTUMXzPinf2Y
X-Received: by 2002:a05:6000:2c02:b0:43d:75a2:44aa with SMTP id ffacd0b85a97d-43d75a246a4mr14223665f8f.43.1776179410088;
        Tue, 14 Apr 2026 08:10:10 -0700 (PDT)
Received: from [172.17.16.20] ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7e61af8csm9304625f8f.34.2026.04.14.08.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 08:10:09 -0700 (PDT)
Message-ID: <e0f7183b-784c-4928-bcbb-eadfb485ed33@linaro.org>
Date: Tue, 14 Apr 2026 16:10:07 +0100
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

LGTM apart from a few small comments. I will do some testing as well.

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

