Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4B3EBF23
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917252; cv=none; b=WfyVhVZJKpPmFZztgd3fBXliHS2r7PnOIWDiBfKGaGrzxj0D+jpEEU4ZAASQKzYMn5BKFGnBkDnxnCyj1SxKCgzGsxTKiQ+7rtgkzYJ6V9rhXP9FKGxqafJQvU/263gejfuPnWvQ0iNvadSfpeSbjqnwVoDADu2tJKOY/EHuSrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917252; c=relaxed/simple;
	bh=D4axoju+KUSHbKKT55FYbu+AaQ9NAG1WMCFmf9Y6+c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOMa8wspud1cADOK0JW/hF50ch89TJx8HEzAbApCs84OOARq6i9otkyYVw/a8rc3fBf3PFjGK+eD65WY2SqGZ/VDxzpEjdT+WvzJdNCWgXbCXQllpGcVTFM5vnc4D6RPkDVRtyet6S3a1v4SjxZiLhMwQISbqnei2K/5OcRpXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ikeaak2v; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ikeaak2v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785917230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RyFHAmnxx0/ymhDekWev9I5Arzzmwq8UaZpl1nESOE=;
	b=Ikeaak2vrD3qJf+KaLdPzn2aI3Ty20b03euVkyMxY/zYnbA+2oCWqs3gOR2Uekow9uhsYE
	r1nouToSqwzgbWLZ2luegCLd0MG2F3kO5KG4innHraMepnTRrHiwig/BjBB1Rz9P/bKXtC
	hH6pD6QuxEEH9jVB0GkOG5JZrl/Ak84=
From: Atish Patra <atish.patra@linux.dev>
To: Paul Walmsley <pjw@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 05/22] RISC-V: Define indirect CSR access helpers
Date: Wed,  5 Aug 2026 01:07:06 -0700
Message-ID: <20260805080706.2895158-1-atish.patra@linux.dev>
In-Reply-To: <1b20aa77-0f0f-08c7-9439-972983adf709@kernel.org>
References: <1b20aa77-0f0f-08c7-9439-972983adf709@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 6:39 PM, Paul Walmsley wrote:

> Thanks.  These macros seem better implemented as static inline functions.
> That also nicely aligns the code with what you write in the patch
> description.

Unfortunately these can't be functions - the conversion doesn't build once
anything calls them.

I applied your version of the header and switched the driver over to the
csr_indirect_* names. drivers/perf/riscv_pmu_sbi.o builds fine before the
change, and after it:

  CC      drivers/perf/riscv_pmu_sbi.o
  ./arch/riscv/include/asm/csr_indirect.h:30: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:18: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:30: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:30: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:30: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:42: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:43: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:44: Error: unknown CSR `iregcsr'
  ./arch/riscv/include/asm/csr_indirect.h:45: Error: unknown CSR `iregcsr'
  make[4]: *** [scripts/Makefile.build:289: drivers/perf/riscv_pmu_sbi.o] Error 1

one error per inlined instantiation: line 18 is csr_indirect_read(), line
30 csr_indirect_write(), lines 42-45 the four accesses in
csr_indirect_warl().

The reason is that csr_read()/csr_write() stringify the CSR argument
straight into the inline asm template:

  #define csr_read(csr)                                         \
  ({                                                            \
        register unsigned long __v;                             \
        __asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)        \
                              : "=r" (__v) :                    \
                              : "memory");                      \
        __v;                                                    \
  })

so the CSR operand has to be a literal token. With iregcsr as a function
parameter the template becomes "csrr %0, iregcsr", which the assembler
has no way to resolve.

This isn't a matter of inlining or of only ever passing constants:
__ASM_STR() expands in the preprocessor, long before inlining or constant
propagation, so __ASM_STR(iregcsr) is "iregcsr" regardless of what the
caller passes or which optimisation level is used. It isn't
toolchain-specific either - gcc 12, gcc 16 and clang 22 all reject it,
clang with the more explicit "operand must be a valid system register
name or an integer in the range [0, 4095]".

The underlying reason is architectural rather than a quirk of the macro:
csrr/csrw encode the CSR as a 12-bit immediate and there is no
register-indirect form. Which is of course why Sscsrind exists in the
first place, but the sireg CSR number itself still has to be an
immediate. That constraint is also why asm/csr.h keeps all seven
accessors (csr_read, csr_write, csr_swap, csr_set, csr_clear,
csr_read_set, csr_read_clear) as macros, with no static inline variant of
any of them.

The reason for-next is green today is that this patch only adds the
header. The callers are in patches 12 and 14, which aren't applied yet,
and an uncalled static inline isn't emitted, so the bad asm never reaches
the assembler. It breaks as soon as the driver patches land.

The only way to keep a function signature would be a switch with a
literal CSR in each arm. The driver uses four of the IREG CSRs - CSR_SIREG
for the counter, CSR_SIREG2 for the hpmevent, and CSR_SIREG4 / CSR_SIREG5
for the rv32 high halves - so that would mean a four-arm switch in each of
the three helpers, which seems clearly worse than the macro.

One clarification on your version, since only part of it is a problem: the
iselbase/iseloff parameters are fine as values - they're data written to
the literal CSR_ISELECT, not a CSR number. It's specifically iregcsr that
can't be a variable.

> That also nicely aligns the code with what you write in the patch
> description.

Fair point, and that mismatch is real - the changelog says "Add a few
helper functions" while the patch defines macros. Since the macros have to
stay, I'll fix it from the other side: reword the body to say helper
macros (matching the subject, which already says "helpers") and add a line
explaining why they can't be functions, so the next reader doesn't have to
rediscover it.

> Also, I renamed this file to change the abbreviation "ind" to "indirect",
> along the lines of this feedback here:
>
>    https://lore.kernel.org/linux-riscv/CAHk-=whhSLGZAx3N5jJpb4GLFDqH_QvS07D+6BnkPWmCEzTAgw@mail.gmail.com/
>
> This case is even worse since there are already uses of "csr_index" in
> the codebase, so it's even more unclear what "ind" is supposed to mean.

No objection at all - csr_indirect_* and csr_indirect.h are clearer, and
the collision with the existing csr_index uses is a good argument on its
own. (The driver has its own rvpmu_csr_index(), which is exactly the
confusion you're describing.) I'll use the new names in the driver
patches.

> Updated patch follows.  Please let me know if you have any objections,

So: renames yes, macros-to-functions no. If 6f1ece4a6691 can still be
amended, the fix is to keep your rename and restore the macro bodies.
Happy to send that as a patch if that's easier, or as a fixup on top of
for-next if the branch has already been published - just let me know which
you prefer.

Thanks for picking up the earlier patches.

--
Regards,
Atish
