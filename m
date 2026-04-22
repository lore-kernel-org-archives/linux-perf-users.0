Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA73C345B
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851460; cv=none; b=duFf62TWF7+5vEmhqguh79MSzzvnpVUMaHVxQZ6+sDETz0MYfggK6U5pUfBPTBS12OC1k2hn3gZRxA7Z4hltDzUDk78ggJSASon+yb8ZMQkkE6S/Cj54yeu7O2pAiqXL7a1crwREv22y5dFS5Jx2xu8it1umme4OvCE/yOg3XNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851460; c=relaxed/simple;
	bh=5xUFW6x7AiKpZFD9QIr8rWHVKv1XCJbfmOIpJaNH+4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWHRaVa6Of/az+xQbLt85PC4vSdJ0ZJMtiTrp4xxiChpmiRGzsuRsDXnNckoqpPp5A4hiw2rnr80MNNqTEr6BwPsD3S53IEDFYKXxqHyWNBe+niRA/5d6ztetJ33wcuWywlT2KTtnvk22UPDUbwUbHgHQrY5YfLL9xz4ruYMmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHYdcxzg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHYdcxzg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso29786495e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776851457; x=1777456257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xruNovgsNWKBCJHbnRHFSY98cj69iKjlBC5qOQajM+E=;
        b=yHYdcxzgmNYiXUgII591tmPgwpc8xVyR+noX/dvf4deCEaXAf96rEdiMvP6E4Ds+8I
         B9B5ZjRnRtMuLzw5CcRT3YRTYE65lEKdDuGehGaeBOHevwx+mavTfhTw0tq0opTDpfDn
         cpcifDCm1T/3Wm4J0ic2+hWoJ5vD7rELzmCR/Cp/AN4M8pYXekRVbFJojBo/armjSCtP
         rCP7S60ufhoL/ONE+U3iohh9t/hXxZZfXh1I5Z5zP0OcESo05yq41ftYGFiYqVxBWCmx
         hHYYBMghrY5bDxM+zX5hz6d/LPK8xtavGxY42dGid9kFWbA55mYe5PsnRZ0vK6vTx+xs
         BwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851457; x=1777456257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xruNovgsNWKBCJHbnRHFSY98cj69iKjlBC5qOQajM+E=;
        b=hscsSkcwKh+TZIBw5/IpZvUZqRLkp7yz3YeS5jXOSZ1JWMCcl1Hc7vkiVyvSOsjv4u
         8qhSamd3AD9xFrHoyrkHzWKmfaG87kMOQDSRGsF+l38Txd1Sq040BvzPTSCVi4Xz900D
         Vqh5fZv/HOBToBGOMPaKrKSeOMDNAEVePWIevZgEGPdGHDTCiI4K/ubLi5j0z8wC8BMZ
         OLFwPoPPrAhD6t7HCmUIrDgYkj6LJjJ/9tyukJwdut+26Ml4h6Id0eBsHt7sN4E2rn9/
         pvYT3fRSOQICcMQAimCF05T+8cLFcmOyzCrsCjcrr0jC9S+rJYPlE+V52LPFYHBrEK1B
         oiQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dRdTHWCFP0ue1qavBfmoNHoSII1bIuQCjR49npEXXtoMZHzfFlgv1gG+zR567SEObVYLLfyvM5ZvRP5sAAfx0@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxV0eBraukVoJQLShVOFKRIspEfuMJFWKFkjWYhCYEhtQbuJz
	uBzPxK/hJtmK5+UCPzg0fNl2DLTQP0x15FSlfmRwNpq98PXxDPMxFeZfuAtXs1hlJbQ=
X-Gm-Gg: AeBDievgnuRNgQLvkfbt/tVEd65jlij66Farey+fc4TI1w+Hnjfoowof6aRMq0gKZBR
	Y7MH300pgDRRpWxOaF+c6yMwrSxUFCs0MPxvsIEUzni2Y9yprjxS6e/0afRmvKYZd1/eg5nhaP6
	GxXvFOsbc6K/dFrf4MeuuPDN/z0V7DCxbB1aACXAwenEDIp/G347n0MJEVCFNeVwccySh01s3jp
	YAdrIAtxHCvg2MGq58UNhV8ch0cY5y4VsyLVD1S8nrSVFy3UVmhLbc//HV+LL/RuiTJOOlgufDV
	xBbfrouzqdxsIm2Or0PbO2oUbxOsI+xdfBMkSu+0vv0uE4B8y1mxFXZLNk6fWmWrQwQ/5RwVko9
	YYKOYR3itGAQrnfsEhgCuz0A2OqAyuZvot8Iy2vao5s/Ej15zzlBYvSaA7luERph3LyJVuzmLQt
	qsnvWw8I76Fuymxi96Gm3swoqn/1u6yNoqR3X+iQcxzo8=
X-Received: by 2002:a05:600c:1389:b0:485:9a50:338d with SMTP id 5b1f17b1804b1-488fb739d3amr295594215e9.3.1776851456926;
        Wed, 22 Apr 2026 02:50:56 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5334cc2bsm49633645e9.19.2026.04.22.02.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 02:50:56 -0700 (PDT)
Message-ID: <eb00bda8-7ad7-4101-8fa6-1ecbb2f2fb82@linaro.org>
Date: Wed, 22 Apr 2026 10:50:55 +0100
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

Did you try recording the Perf datasym workload? With llvm-objdump I 
only get hits on data1 and not data2. And with binutils I don't get any 
hits on that struct at all, although the rest of the samples in 
ld-linux-aarch64.so etc look roughly the same between binutils and llvm. 
I would have thought such a simple example like datasym would work with 
both.

  $ perf record -e arm_spe_0/load_filter=1,store_filter=1,
     min_latency=30/u -c 10000 -- perf test -w datasym

  $ perf annotate --data-type --type-stat --itrace=i1i --stdio

With llvm-objdump-14:

   Annotate data type stats:
   total 25, ok 19 (76.0%), bad 6 (24.0%)
   -----------------------------------------------------------
          1 : no_sym
          1 : no_mem_ops
          3 : no_var
          1 : no_typeinfo
          9 : insn_track

   Annotate type: 'struct buf' in build/local/perf (6663 samples):
   ===============================================================
    Percent     offset       size  field
     100.00          0       0x40  struct buf       {
     100.00          0        0x1      char        data1;
       0.00        0x1       0x37      char[]      reserved;
       0.00       0x38        0x1      char        data2;
                                 };



With binutils that entry is missing:

   Annotate data type stats:
   total 25, ok 14 (56.0%), bad 11 (44.0%)
   -----------------------------------------------------------
          1 : no_sym
          1 : no_cuinfo
          3 : no_var
          6 : no_typeinfo
          4 : insn_track

...


But with the following patch I get plausible output for datasym with 
llvm where both entries in the struct have hits. It looks like you need 
to add the offset when calling get_global_var_type() for 
TSR_KIND_GLOBAL_ADDR otherwise all entries point to the first member of 
the struct:

   Annotate data type stats:
   total 4, ok 2 (50.0%), bad 2 (50.0%)
   -----------------------------------------------------------
          1 : no_sym
          1 : no_typeinfo
          2 : insn_track

   Annotate type: 'struct buf' in build/local/perf (35 samples):
   =====================================================================
    Percent     offset       size  field
     100.00          0       0x39  struct buf       {
      40.00          0        0x1      char        data1;
       0.00        0x1       0x37      char[]      reserved;
      60.00       0x38        0x1      char        data2;
                                 };


diff --git a/tools/perf/util/annotate-data.c 
b/tools/perf/util/annotate-data.c
index 7161417d1c76..0e5825121227 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1287,7 +1287,9 @@ static enum type_match_result 
check_matching_type(struct type_state *state,
                  * The register holds the address of a global variable. 
  Try to
                  * find the variable by the address and get its type.
                  */
-               if (get_global_var_type(cu_die, dloc, dloc->ip, 
state->regs[reg].addr,
+               var_addr = state->regs[reg].addr + dloc->op->offset;
+
+               if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
                                         &var_offset, type_die)) {
                         dloc->type_offset = var_offset;


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

