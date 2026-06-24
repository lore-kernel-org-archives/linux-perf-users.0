Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D4308F3E;
	Wed, 24 Jun 2026 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283075; cv=none; b=Fpoadq9zu7ib3hutmjTi/NC4uSh2xBgnkB5AWFH70+1NxrbCZ4QDTxl2nrc6d2Ec82UcW26BDOhErn20jJ/YSMLwd+EVkLV8eemohL2JTz1YGXLsOdaSYSff2z+2jxbaM9j1LEchSEj2Z0bCF5KsFE8FrRwC2/3SulPn1q1htTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283075; c=relaxed/simple;
	bh=rRvDOpPNHsh8I9iNW2zJe9yCGCs+8R8D4ga8el/IMik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZY2XjQPn/5/6TUXT3oRRWF7uioTr4Pu7qGL64MXoDtAuc+Y68sns8JSvdBqDlvwL/9N/YDMWhImHSPPnW32FmGPQY4p4TGoOlmskz6LhYmIIA/Ab/Czx6sFmB2tSA5Pb2EHd7B4y8+r4XeSpezHGzxUQnzv31aYKVPQC045mmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4glXKW5ZxfzYQts4;
	Wed, 24 Jun 2026 14:37:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CE48C4058C;
	Wed, 24 Jun 2026 14:37:45 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgDXJTs2eztqqeOoCw--.30751S2;
	Wed, 24 Jun 2026 14:37:43 +0800 (CST)
Message-ID: <7f95a323-b2af-4355-abbf-1d1d418fb99a@huaweicloud.com>
Date: Wed, 24 Jun 2026 14:37:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] perf annotate: Add ARM64 data type profiling
 support
To: Shuai Xue <xueshuai@linux.alibaba.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
 <ajq6tD43gW0KR4N1@google.com>
 <726d154e-cc7e-4f1d-996d-27c3d143e2a1@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <726d154e-cc7e-4f1d-996d-27c3d143e2a1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXJTs2eztqqeOoCw--.30751S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1fAFyfJr4fWr17CFWrAFb_yoW7AF4kpF
	WvyFy5KrW5Crs7Jr17tr4UurySg3y8J3WDWr1UGFW0yFsIyr1S9F42g34j9Fy7Crs5Gw1j
	vryYyF17u3W3AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Shuai,

On 2026/6/24 9:51, Shuai Xue wrote:
> Hi, Namhyung
> 
> On 6/24/26 12:56 AM, Namhyung Kim wrote:
>> Hello,
>>
>> On Tue, Jun 23, 2026 at 09:02:29PM +0800, Shuai Xue wrote:
>>> `perf test -v "perf data type profiling tests"` fails on ARM64:
>>>
>>>      Basic Rust perf annotate test
>>>      perf mem record -o /tmp/perf.data perf test -w code_with_type
>>>      perf annotate --code-with-type -i /tmp/perf.data --stdio --percent-limit 1
>>>      Basic annotate [Failed: missing target data type]
>>>
>>> The root cause is that ARM64 lacks the instruction parsing infrastructure
>>> required for data type profiling. Specifically:
>>>
>>>    1. annotate_get_insn_location() cannot extract register numbers and
>>>       memory offsets from ARM64 load/store instructions, because ARM64
>>>       does not set objdump.register_char or objdump.memory_ref_char
>>>       (unlike x86 which uses '%' and '(').
>>>
>>>    2. arch_supports_insn_tracking() does not include ARM64, so
>>>       find_data_type_block() cannot perform instruction-level type state
>>>       tracking.
>>>
>>>    3. init_type_state() has no ARM64 branch, leaving stack_reg as 0 (x0)
>>>       after memset, which causes x0-based memory accesses to be
>>>       misidentified as stack accesses.
>>>
>>> As a result, perf annotate --code-with-type silently produces no type
>>> annotations on ARM64, and the test grep for "# data-type: struct Buf"
>>> fails.
>>>
>>> This series adds ARM64 data type profiling support following the PowerPC
>>> model: decode raw 32-bit instruction words rather than parsing objdump
>>> text. ARM64's fixed-width encoding and trivial DWARF register mapping
>>> (x0-x30 = DWARF 0-30) make this approach clean and robust.
>>>
>>> Three classes of instructions are tracked for register state propagation:
>>>    - ADRP: compute PC-relative page address for global variable resolution
>>>    - ADD (immediate): combine with ADRP result to form full variable address
>>>    - MOV (register): propagate type state between registers
>>>
>>> This covers the common `adrp + add + ldr/str` pattern that ARM64
>>> compilers emit for global variable access.
>>>
>>> Known limitations:
>>>    - The `adrp + ldr` pattern (with :lo12: folded into the load offset,
>>>      without an intermediate ADD) is not yet handled. This requires
>>>      extending check_matching_type() to resolve TSR_KIND_CONST with the
>>>      load offset, which can be added incrementally.
>>>    - Pointer chain tracking (load-from-memory propagating type to the
>>>      destination register) is not implemented, matching PowerPC's current
>>>      scope.
>>>
>>> Testing:
>>>    All four sub-tests in `perf test "perf data type profiling tests"`
>>>    pass reliably on ARM64 (AArch64, SPE-capable hardware):
>>>      - Basic/Pipe Rust: struct Buf (code_with_type workload)
>>>      - Basic/Pipe C: struct buf (datasym workload, global variable)
>>>
>>> Patch breakdown:
>>>    1/5  Widen type_state_reg::imm_value from u32 to u64 (prerequisite
>>>         for storing 64-bit addresses from ADRP)
>>>    2/5  Add arch__is_arm64() detection, raw instruction parsing from
>>>         objdump output, and enable show_asm_raw for ARM64
>>>    3/5  Add get_arm64_regs() to extract registers and memory offsets
>>>         from load/store instruction encodings (4 addressing modes)
>>>    4/5  Wire up ARM64 in annotate_get_insn_location(),
>>>         arch_supports_insn_tracking(), and init_type_state()
>>>    5/5  Main patch: instruction classification, ADRP/ADD/MOV register
>>>         state tracking, and architecture initialization
>>>
>>> Shuai Xue (5):
>>>    perf annotate-data: Widen type_state_reg::imm_value to u64
>>>    perf disasm: Add ARM64 architecture detection and raw instruction
>>>      parsing
>>>    perf dwarf-regs: Add ARM64 register and offset extraction from raw
>>>      instructions
>>>    perf annotate: Wire up ARM64 data type profiling infrastructure
>>>    perf annotate-arch: Add ARM64 data type profiling support
>>
>> Thanks for the contribution!
>>
>> There was another series on this, please take a look.  I hope you guys
>> can collaborate.
>>
>> https://lore.kernel.org/r/20260403094800.1418825-1-wutengda@huaweicloud.com
>>
> 
> Thanks for the pointer! I wasn't aware of Wutengda's series.
> 
> I'll take a close look at it and compare our approaches. Since both
> series target ARM64 data type profiling, I'll reach out to Wutengda
> directly so we can align our efforts and avoid duplicated work.
> 
> 
> Best regards,
> Shuai Xue
> 
Thanks for reaching out!

I'm currently finalizing the v3 of my patch series. Most of the work is
already done (19/21 patches verified), and I plan to send it out within
the next few days.

The overall approach remains unchanged and continues to follow the x86
implementation. However, compared to v2, it includes several bug fixes
and optimizations addressing known issues.

Once v3 is out, I'd appreciate it if you could review the series and see
if your specific use cases or ideas can be integrated on top of it.

Best regards,
Tengda

