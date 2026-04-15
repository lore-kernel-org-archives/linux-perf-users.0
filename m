Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E0175A8B;
	Wed, 15 Apr 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216916; cv=none; b=TF3hkyZaiLGqheboK4EJraa2EBcStJnxuVxxEFSrFw1/07XJqliVfq/ybtBLvAdcZZzOgzLDl8/7qnVtowxlAQwbbR7ReUPMkr523FNViJNAPymApr1L5bSZtx23mRfa5txMxBnOPD0JdxEu9d2CnikmgsOdC8SjoTjidp2BVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216916; c=relaxed/simple;
	bh=e2nKYyfZOvcjIjGibFm/ajJk32ROzwm/edOMkSf9Qjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sY+TehFgl6l5SqF94ql78EMCkgiTpW98xnQj4FotCHRruSLFv+iRTNq/6GbHImH0MPuzA7zxmnRQouW2vGScrSFSWu1pWEE0rnLFiILDZLyouzBl8f0uvSHY2hCZGEB0hrWe7ifXN+lBwK0sjbVeC2scKkpGIFlgemXsH7/wtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fwNxD3Wr7zKHLtd;
	Wed, 15 Apr 2026 09:34:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7197B4058C;
	Wed, 15 Apr 2026 09:35:05 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgDHwrxE695pbMDFAQ--.36837S2;
	Wed, 15 Apr 2026 09:35:01 +0800 (CST)
Message-ID: <f8f683c0-140c-4d94-b12d-9a4c198b59f4@huaweicloud.com>
Date: Wed, 15 Apr 2026 09:34:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] perf arm64: Support data type profiling
To: James Clark <james.clark@linaro.org>
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
 <e0f7183b-784c-4928-bcbb-eadfb485ed33@linaro.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <e0f7183b-784c-4928-bcbb-eadfb485ed33@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHwrxE695pbMDFAQ--.36837S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1fGr1UWr45tF4DAF15XFb_yoW3ZFWDpF
	s3t347JrWUGr1ktr17Jr4UXry5Jr4UJ3WUGr18JFy8Jr4UAr1jqr4UXr1jgF17Gr4xAr1U
	Jr1Utr1DZr1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/14 23:10, James Clark wrote:
> 
> 
> On 03/04/2026 10:47, Tengda Wu wrote:
>> This patch series implements data type profiling support for arm64,
>> building upon the foundational work previously contributed by Huafei [1].
>> While the initial version laid the groundwork for arm64 data type analysis,
>> this series iterates on that work by refining instruction parsing and
>> extending support for core architectural features.
>>
>> The series is organized as follows:
>>
>> 1. Fix disassembly mismatches (Patches 01-02)
>>     Current perf annotate supports three disassembly backends: llvm,
>>     capstone, and objdump. On arm64, inconsistencies between the output
>>     of these backends (specifically llvm/capstone vs. objdump) often
>>     prevent the tracker from correctly identifying registers and offsets.
>>     These patches resolve these mismatches, ensuring consistent instruction
>>     parsing across all supported backends.
>>
>> 2. Infrastructure for arm64 operand parsing (Patches 03-07)
>>     These patches establish the necessary infrastructure for arm64-specific
>>     operand handling. This includes implementing new callbacks and data
>>     structures to manage arm64's unique addressing modes and register sets.
>>     This foundation is essential for the subsequent type-tracking logic.
>>
>> 3. Core instruction tracking (Patches 08-16)
>>     These patches implement the core logic for type tracking on arm64,
>>     covering a wide range of instructions including:
>>
>>     * Memory Access: ldr/str variants (including stack-based access).
>>     * Arithmetic & Data Processing: mov, add, and adrp.
>>     * Special Access: System register access (mrs) and per-cpu variable
>>       tracking.
>>
>> The implementation draws inspiration from the existing x86 logic while
>> adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
>> perf annotate can successfully resolve memory locations and register
>> types, enabling comprehensive data type profiling on arm64 platforms.
>>
>> Example Result
>> ==============
>>
>> # perf mem record -a -K -- sleep 1
>> # perf annotate --data-type --type-stat --stdio
>> Annotate data type stats:
>> total 6204, ok 5091 (82.1%), bad 1113 (17.9%)
>> -----------------------------------------------------------
>>          29 : no_sym
>>         196 : no_var
>>         806 : no_typeinfo
>>          82 : bad_offset
>>        1370 : insn_track
>>
>> Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
>> ============================================================================
>>   Percent     offset       size  field
>>    100.00          0       0x40  struct page      {
>>      9.95          0        0x8      long unsigned int   flags;
>>     52.83        0x8       0x28      union        {
>>     52.83        0x8       0x28          struct   {
>>     37.21        0x8       0x10              union        {
>>     37.21        0x8       0x10                  struct list_head        lru {
>>     37.21        0x8        0x8                      struct list_head*   next;
>>      0.00       0x10        0x8                      struct list_head*   prev;
>>                                                  };
>>     37.21        0x8       0x10                  struct   {
>>     37.21        0x8        0x8                      void*       __filler;
>>      0.00       0x10        0x4                      unsigned int        mlock_count;
>>     ...
>>
>> Changes since v1: (reworked from Huafei's series):
>>
>>   - Fix inconsistencies in arm64 instruction output across llvm, capstone,
>>     and objdump disassembly backends.
>>   - Support arm64-specific addressing modes and operand formats. (Leo Yan)
>>   - Extend instruction tracking to support mov and add instructions,
>>     along with per-cpu and stack variables.
>>   - Include real-world examples in commit messages to demonstrate
>>     practical effects. (Namhyung Kim)
>>   - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
>>     https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
>>
>> Please let me know if you have any feedback.
>>
> 
> LGTM apart from a few small comments. I will do some testing as well.
> 

Thanks for the feedback! I'll look into your comments and address them.
Please let me know if any issues come up during your testing.

-- Tengda

>> Thanks,
>> Tengda
>>
>> [1] https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
>> [2] https://developer.arm.com/documentation/102374/0103
>> [3] https://github.com/flynd/asmsheets/releases/tag/v8
>>
>> ---
>>
>> Tengda Wu (16):
>>    perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>>      objdump
>>    perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
>>    perf annotate-arm64: Generalize arm64_mov__parse to support standard
>>      operands
>>    perf annotate-arm64: Handle load and store instructions
>>    perf annotate: Introduce extract_op_location callback for
>>      arch-specific parsing
>>    perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>>    perf annotate-arm64: Implement extract_op_location() callback
>>    perf annotate-arm64: Enable instruction tracking support
>>    perf annotate-arm64: Support load instruction tracking
>>    perf annotate-arm64: Support store instruction tracking
>>    perf annotate-arm64: Support stack variable tracking
>>    perf annotate-arm64: Support 'mov' instruction tracking
>>    perf annotate-arm64: Support 'add' instruction tracking
>>    perf annotate-arm64: Support 'adrp' instruction to track global
>>      variables
>>    perf annotate-arm64: Support per-cpu variable access tracking
>>    perf annotate-arm64: Support 'mrs' instruction to track 'current'
>>      pointer
>>
>>   .../perf/util/annotate-arch/annotate-arm64.c  | 642 +++++++++++++++++-
>>   .../util/annotate-arch/annotate-powerpc.c     |  10 +
>>   tools/perf/util/annotate-arch/annotate-x86.c  |  88 ++-
>>   tools/perf/util/annotate-data.c               |  72 +-
>>   tools/perf/util/annotate-data.h               |   7 +-
>>   tools/perf/util/annotate.c                    | 108 +--
>>   tools/perf/util/annotate.h                    |  12 +
>>   tools/perf/util/capstone.c                    | 107 ++-
>>   tools/perf/util/disasm.c                      |   5 +
>>   tools/perf/util/disasm.h                      |   5 +
>>   .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |  20 +
>>   tools/perf/util/dwarf-regs.c                  |   2 +-
>>   tools/perf/util/include/dwarf-regs.h          |   1 +
>>   tools/perf/util/llvm.c                        |  50 ++
>>   14 files changed, 984 insertions(+), 145 deletions(-)
>>
>>
>> base-commit: cf7c3c02fdd0dfccf4d6611714273dcb538af2cb
> 

