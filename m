Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251A223708;
	Wed, 24 Jun 2026 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782265923; cv=none; b=QAbRy/dKXkRWVIqUgtq1tC+QKaB+LSS57R0TtAcKPAW2pDAV8BMNt9b9kuEk/uvbDhWRvIYFq7XdEimNAtMtBJ+9+j8lmQdjPs6AV2WYzX4wfR1my9DwL9tY7m7xOgWRc/133xOLwWB4/+J1y3/gahQo/ppcLxd5mT9I2kCW92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782265923; c=relaxed/simple;
	bh=0iJ6b3lbu49f0HfjUyoIDjjJuvdtNCLssrC9+GRnfNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4xy5j9OL4hCFjlMJRZGkA/2tzX8r95cbMaW/L/aCqFfxl3ykhR9n97bTYQp/hQ+FoZ5HhQlN11GTj7TumoyupPxZbqz4TShEX6MZekQV3I3Kyuu+1bkfWv4uOoWcdrdXUeqd0H3ipdn7vTqqYiQdFQWSy3PnQ2MaQIWgntRPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o+s15/C8; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o+s15/C8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782265917; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jQ4FzfkJ0zm3rfmB/2UT3SLjcl/uAslm0IAJSButBlM=;
	b=o+s15/C8iI7fuWTq97WbLWCBfPxoCq5wLQCvIRtSHCqb3Kr2SxwU5iFVppYZH01axzdkX18CVOloqcrhz+AY8mYCt7FXN7+ixLwcuOPudnYvJ1np7yhp7lC5mH8m3CkKhRARFto6ygofsqgPI0ZwL8cJB1GTz6zlzBifgy0XpVI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X5VoFv7_1782265914;
Received: from 30.246.162.163(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X5VoFv7_1782265914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 09:51:55 +0800
Message-ID: <726d154e-cc7e-4f1d-996d-27c3d143e2a1@linux.alibaba.com>
Date: Wed, 24 Jun 2026 09:51:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] perf annotate: Add ARM64 data type profiling
 support
To: Namhyung Kim <namhyung@kernel.org>, wutengda@huaweicloud.com
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
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ajq6tD43gW0KR4N1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Namhyung

On 6/24/26 12:56 AM, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jun 23, 2026 at 09:02:29PM +0800, Shuai Xue wrote:
>> `perf test -v "perf data type profiling tests"` fails on ARM64:
>>
>>      Basic Rust perf annotate test
>>      perf mem record -o /tmp/perf.data perf test -w code_with_type
>>      perf annotate --code-with-type -i /tmp/perf.data --stdio --percent-limit 1
>>      Basic annotate [Failed: missing target data type]
>>
>> The root cause is that ARM64 lacks the instruction parsing infrastructure
>> required for data type profiling. Specifically:
>>
>>    1. annotate_get_insn_location() cannot extract register numbers and
>>       memory offsets from ARM64 load/store instructions, because ARM64
>>       does not set objdump.register_char or objdump.memory_ref_char
>>       (unlike x86 which uses '%' and '(').
>>
>>    2. arch_supports_insn_tracking() does not include ARM64, so
>>       find_data_type_block() cannot perform instruction-level type state
>>       tracking.
>>
>>    3. init_type_state() has no ARM64 branch, leaving stack_reg as 0 (x0)
>>       after memset, which causes x0-based memory accesses to be
>>       misidentified as stack accesses.
>>
>> As a result, perf annotate --code-with-type silently produces no type
>> annotations on ARM64, and the test grep for "# data-type: struct Buf"
>> fails.
>>
>> This series adds ARM64 data type profiling support following the PowerPC
>> model: decode raw 32-bit instruction words rather than parsing objdump
>> text. ARM64's fixed-width encoding and trivial DWARF register mapping
>> (x0-x30 = DWARF 0-30) make this approach clean and robust.
>>
>> Three classes of instructions are tracked for register state propagation:
>>    - ADRP: compute PC-relative page address for global variable resolution
>>    - ADD (immediate): combine with ADRP result to form full variable address
>>    - MOV (register): propagate type state between registers
>>
>> This covers the common `adrp + add + ldr/str` pattern that ARM64
>> compilers emit for global variable access.
>>
>> Known limitations:
>>    - The `adrp + ldr` pattern (with :lo12: folded into the load offset,
>>      without an intermediate ADD) is not yet handled. This requires
>>      extending check_matching_type() to resolve TSR_KIND_CONST with the
>>      load offset, which can be added incrementally.
>>    - Pointer chain tracking (load-from-memory propagating type to the
>>      destination register) is not implemented, matching PowerPC's current
>>      scope.
>>
>> Testing:
>>    All four sub-tests in `perf test "perf data type profiling tests"`
>>    pass reliably on ARM64 (AArch64, SPE-capable hardware):
>>      - Basic/Pipe Rust: struct Buf (code_with_type workload)
>>      - Basic/Pipe C: struct buf (datasym workload, global variable)
>>
>> Patch breakdown:
>>    1/5  Widen type_state_reg::imm_value from u32 to u64 (prerequisite
>>         for storing 64-bit addresses from ADRP)
>>    2/5  Add arch__is_arm64() detection, raw instruction parsing from
>>         objdump output, and enable show_asm_raw for ARM64
>>    3/5  Add get_arm64_regs() to extract registers and memory offsets
>>         from load/store instruction encodings (4 addressing modes)
>>    4/5  Wire up ARM64 in annotate_get_insn_location(),
>>         arch_supports_insn_tracking(), and init_type_state()
>>    5/5  Main patch: instruction classification, ADRP/ADD/MOV register
>>         state tracking, and architecture initialization
>>
>> Shuai Xue (5):
>>    perf annotate-data: Widen type_state_reg::imm_value to u64
>>    perf disasm: Add ARM64 architecture detection and raw instruction
>>      parsing
>>    perf dwarf-regs: Add ARM64 register and offset extraction from raw
>>      instructions
>>    perf annotate: Wire up ARM64 data type profiling infrastructure
>>    perf annotate-arch: Add ARM64 data type profiling support
> 
> Thanks for the contribution!
> 
> There was another series on this, please take a look.  I hope you guys
> can collaborate.
> 
> https://lore.kernel.org/r/20260403094800.1418825-1-wutengda@huaweicloud.com
> 

Thanks for the pointer! I wasn't aware of Wutengda's series.

I'll take a close look at it and compare our approaches. Since both
series target ARM64 data type profiling, I'll reach out to Wutengda
directly so we can align our efforts and avoid duplicated work.


Best regards,
Shuai Xue



