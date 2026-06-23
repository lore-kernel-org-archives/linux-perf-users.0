Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFF3246EC;
	Tue, 23 Jun 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233783; cv=none; b=joM/gEgNq2Gx9tp1BsO46rLbWrcsxCII4OnGtyTfvtI5ECd/WGoJrpJimPebVifyndUSuN94UI9rIn8UjpQCSlDEmNWXs8b7yXQe6xFclxDY6pzwe673fPSo6ldx4fwWjN3xTVNVyRQ1XcS7qxwxSdKvEV5xf5Co/D0iPOiV328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233783; c=relaxed/simple;
	bh=7OjdHZqBwzxFz+pCjVjA0ur7PvoQSlHrXqEHNfUrgm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikch07RoDz7nmYO/rNcp9sS6NptGDRY94uuhnDQCG8vJI/P/Fubb/1QdooQv58C6Bqzdl4ceJYc9ZQmCidgIJduWaeFlYlo5PYLOWWOJoo9VCxHGcvgJCL+Jo1fxJO6xv4k58iFEKjopSAiNlil39Ik8Ri4ICCmKtvZ5LuFmuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw8l1fU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw8l1fU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EBF1F000E9;
	Tue, 23 Jun 2026 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782233782;
	bh=zflr5lJnyOqBOIOzQ3m9AqvOKc/AaroCIuF4VrfYSRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lw8l1fU1B5Yk6ZBpSzz+xzve3DrUzRNPfOyf0eArnPwi2ZPsjXgY9CZv8IFz9hPUH
	 TADx4iAUKVOVivFE7jN6Ymg9yhL0SiGsaCfGThRuKy5j7A1mp3J39+JLL17C3jWGgb
	 MhvwODkeAcVgyx5qrm0vnfZ7er7ziGVJx9kw9OVGaWsgLB+aZ593Peyzc+dqcN22pc
	 fwo8DQ4uEQx3S99Fk4/5CW/WLaHKzdeBkcAU6CqdE9yZUK7AR0QR4y0lOlH0LVZ4tF
	 OjbSYMXTVesR6g/k69m7M5tAqXmmLiaSp3BRXOQ6Meu8gEo6RGs/jDULe/o+eDcPIh
	 gJ//a6wjRd5RA==
Date: Tue, 23 Jun 2026 09:56:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] perf annotate: Add ARM64 data type profiling
 support
Message-ID: <ajq6tD43gW0KR4N1@google.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623130234.8709-1-xueshuai@linux.alibaba.com>

Hello,

On Tue, Jun 23, 2026 at 09:02:29PM +0800, Shuai Xue wrote:
> `perf test -v "perf data type profiling tests"` fails on ARM64:
> 
>     Basic Rust perf annotate test
>     perf mem record -o /tmp/perf.data perf test -w code_with_type
>     perf annotate --code-with-type -i /tmp/perf.data --stdio --percent-limit 1
>     Basic annotate [Failed: missing target data type]
> 
> The root cause is that ARM64 lacks the instruction parsing infrastructure
> required for data type profiling. Specifically:
> 
>   1. annotate_get_insn_location() cannot extract register numbers and
>      memory offsets from ARM64 load/store instructions, because ARM64
>      does not set objdump.register_char or objdump.memory_ref_char
>      (unlike x86 which uses '%' and '(').
> 
>   2. arch_supports_insn_tracking() does not include ARM64, so
>      find_data_type_block() cannot perform instruction-level type state
>      tracking.
> 
>   3. init_type_state() has no ARM64 branch, leaving stack_reg as 0 (x0)
>      after memset, which causes x0-based memory accesses to be
>      misidentified as stack accesses.
> 
> As a result, perf annotate --code-with-type silently produces no type
> annotations on ARM64, and the test grep for "# data-type: struct Buf"
> fails.
> 
> This series adds ARM64 data type profiling support following the PowerPC
> model: decode raw 32-bit instruction words rather than parsing objdump
> text. ARM64's fixed-width encoding and trivial DWARF register mapping
> (x0-x30 = DWARF 0-30) make this approach clean and robust.
> 
> Three classes of instructions are tracked for register state propagation:
>   - ADRP: compute PC-relative page address for global variable resolution
>   - ADD (immediate): combine with ADRP result to form full variable address
>   - MOV (register): propagate type state between registers
> 
> This covers the common `adrp + add + ldr/str` pattern that ARM64
> compilers emit for global variable access.
> 
> Known limitations:
>   - The `adrp + ldr` pattern (with :lo12: folded into the load offset,
>     without an intermediate ADD) is not yet handled. This requires
>     extending check_matching_type() to resolve TSR_KIND_CONST with the
>     load offset, which can be added incrementally.
>   - Pointer chain tracking (load-from-memory propagating type to the
>     destination register) is not implemented, matching PowerPC's current
>     scope.
> 
> Testing:
>   All four sub-tests in `perf test "perf data type profiling tests"`
>   pass reliably on ARM64 (AArch64, SPE-capable hardware):
>     - Basic/Pipe Rust: struct Buf (code_with_type workload)
>     - Basic/Pipe C: struct buf (datasym workload, global variable)
> 
> Patch breakdown:
>   1/5  Widen type_state_reg::imm_value from u32 to u64 (prerequisite
>        for storing 64-bit addresses from ADRP)
>   2/5  Add arch__is_arm64() detection, raw instruction parsing from
>        objdump output, and enable show_asm_raw for ARM64
>   3/5  Add get_arm64_regs() to extract registers and memory offsets
>        from load/store instruction encodings (4 addressing modes)
>   4/5  Wire up ARM64 in annotate_get_insn_location(),
>        arch_supports_insn_tracking(), and init_type_state()
>   5/5  Main patch: instruction classification, ADRP/ADD/MOV register
>        state tracking, and architecture initialization
> 
> Shuai Xue (5):
>   perf annotate-data: Widen type_state_reg::imm_value to u64
>   perf disasm: Add ARM64 architecture detection and raw instruction
>     parsing
>   perf dwarf-regs: Add ARM64 register and offset extraction from raw
>     instructions
>   perf annotate: Wire up ARM64 data type profiling infrastructure
>   perf annotate-arch: Add ARM64 data type profiling support

Thanks for the contribution!

There was another series on this, please take a look.  I hope you guys
can collaborate.

https://lore.kernel.org/r/20260403094800.1418825-1-wutengda@huaweicloud.com

Thanks,
Namhyung

> 
>  .../perf/util/annotate-arch/annotate-arm64.c  | 333 ++++++++++++++++++
>  tools/perf/util/annotate-arch/annotate-x86.c  |   2 +-
>  tools/perf/util/annotate-data.c               |  18 +-
>  tools/perf/util/annotate-data.h               |   2 +-
>  tools/perf/util/annotate.c                    |  12 +-
>  tools/perf/util/disasm.c                      |  64 ++++
>  tools/perf/util/disasm.h                      |   2 +
>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   | 125 +++++++
>  tools/perf/util/include/dwarf-regs.h          |   7 +
>  9 files changed, 558 insertions(+), 7 deletions(-)
> 
> -- 
> 2.51.2.612.gdc70283dfc
