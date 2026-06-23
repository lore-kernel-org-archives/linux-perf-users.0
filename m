Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1951A23A4
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221574; cv=none; b=pJJgxoTC13I/4ehnDA+yILqBkK5+BAtLdrTBJZB74TMFqZZ8aGhPU92xmhMuluCocl+tHKmobMisQHyATlRWsoIFSCQJ1BvkP/iUGHmShunJzaYP83ll6ukht3MclDZTpBgbmtmXBye6vRv4MM69xlYBv2LSTN+50Lkx8flhKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221574; c=relaxed/simple;
	bh=qphoDXqgj3yUxuzYxeaDtjqsrFlNIHaKA8J3QM73qXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o1DAmubtWnCPGLTq3iT71ws+TZh3EgENjHRzo4VKkLkCmgizC0OAJ5EmBvYOOTyQp3tfaRfGpzeYdcKQV2zgOVa5OhNKOh1X67wRttQjYhsNQ80jz2b1D17udaL3dAW6zqksu58LYVNUHB29nELEhRJQSBm5T+RssORW8xqqMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drCZ3EpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drCZ3EpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D531F00A3A;
	Tue, 23 Jun 2026 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782221573;
	bh=OzGYvwRqv/aIgG0+NTEU1bL9oKcoaN5lYKorokjWdWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=drCZ3EpXrIg32A/y1ouzXyOQgTqrNgAqVMBKvfaQMNXlZzeBigvHnbpbRtbNDpFpu
	 7VKraGDtO+LzjDS+En/CJcEU1ZwE1WFTwhb75z/A/uuz2bMC8SaLuYL5J8bwt/zhOj
	 evyVTqV+yD5HTeyXh8M2fDmoYoVRpSHCq5DHD3fl2zBVHbkSvPWtzFfKeWHEN/Ofqa
	 IyquVn7yb/IeSV9UMo817tgxdkDUQgUPs5Nas+kHZkEmywFb3Eg8Auo1JVPpcqIgAS
	 C9kk/Kz2+TuSfq73uKhBSlWAlGdSZU/Oa5t/V3XniGWxiCXfhLrzQlVeuYBKmB+kvZ
	 HAuPKdcrfNTJQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 5/5] perf annotate-arch: Add ARM64 data type
 profiling support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623130234.8709-6-xueshuai@linux.alibaba.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
 <20260623130234.8709-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:32:52 +0000
Message-Id: <20260623133253.10D531F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Eager global variable resolution in ADRP causes incorrect type bin=
ding when the page boundary falls inside an adjacent variable.
- [High] Missing register type state invalidation for unhandled instruction=
s leads to stale type propagation.
- [Low] Comment mismatch regarding bit 26 in A64_INSN_LDR_LIT_MASK.
--

commit 429208e90da6fddfa29cce218b8f6998420f5ba0
Author: Shuai Xue <xueshuai@linux.alibaba.com>

perf annotate-arch: Add ARM64 data type profiling support
   =20
This commit adds data type profiling support for ARM64, allowing
perf annotate --code-with-type to show data types accessed by memory
instructions. It implements raw instruction decoding to track register
states across ADRP, ADD, and MOV instructions.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index b98aaf9a8a7be..887ed22c4ca05 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -14,6 +23,47 @@ struct arch_arm64 {
>  	regex_t jump_insn;
>  };
> =20
> +/*
> + * ARM64 instruction encoding masks and values.
> + * Derived from ARM Architecture Reference Manual, C4.1 A64 encoding ind=
ex.
> + *
> + * These mirror the definitions in arch/arm64/include/asm/insn.h but are
> + * duplicated here because that header depends on kernel-only macros
> + * (BUILD_BUG_ON, __always_inline).
> + */
> +
> +/* GP Load/Store: bit[27]=3D1, bit[26]=3D0 (GP, not SIMD/FP), bit[25]=3D=
0 */
> +#define A64_INSN_GP_LS_MASK	0x0e000000
> +#define A64_INSN_GP_LS_VAL	0x08000000
> +
> +/* LDR/LDRSW (literal): bits[29:27]=3D011, bit[26]=3D0 -- must be exclud=
ed from GP LS */
> +#define A64_INSN_LDR_LIT_MASK	0x3b000000

[Severity: Low]
This isn't a bug, but does the mask definition exclude bit 26, contradicting
the preceding comment that states bit[26]=3D0?

> +#define A64_INSN_LDR_LIT_VAL	0x18000000
> +
> +/*
> + * Load/Store register (register offset):
[ ... ]
> @@ -69,6 +119,285 @@ static const struct ins_ops arm64_mov_ops =3D {
[ ... ]
> +static void update_insn_state_arm64(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    Dwarf_Die *cu_die,
> +				    struct disasm_line *dl)
> +{
> +	u32 insn =3D dl->raw.raw_insn;
> +	int rd, rn;
> +	struct type_state_reg *tsr;
> +
> +	if (arm64_is_adrp(insn)) {
> +		u64 pc, page_addr;
> +		int offset;
> +		Dwarf_Die type_die;
> +
> +		rd =3D A64_RT(insn);
> +		if (!has_reg_type(state, rd))
> +			return;
> +
> +		tsr =3D &state->regs[rd];
> +
> +		pc =3D map__rip_2objdump(dloc->ms->map,
> +				       dloc->ms->sym->start + dl->al.offset);
> +		page_addr =3D arm64_adrp_target(pc, insn);
> +
> +		/*
> +		 * Try to resolve the global variable at this page address.
> +		 * If not found, store it as a constant for later ADD resolution.
> +		 */
> +		if (get_global_var_type(cu_die, dloc,
> +					dloc->ms->sym->start + dl->al.offset,
> +					page_addr, &offset, &type_die)) {

[Severity: High]
Does eager global variable resolution in ADRP cause incorrect type binding =
when
the page boundary falls inside an adjacent variable?

If the 4KB-aligned page address happens to fall within the memory span of a
preceding global variable, get_global_var_type() might immediately resolve =
the
address to that wrong variable. The subsequent ADD instruction then adds its
immediate offset to the wrong variable's offset, never attempting to resolve
the true target variable.

Should type resolution be deferred until the full address is formed in the
subsequent ADD?

> +			tsr->type =3D type_die;
> +			tsr->kind =3D TSR_KIND_POINTER;
> +			tsr->offset =3D offset;
> +			tsr->ok =3D true;
> +
> +			pr_debug_dtp("adrp [%x] global addr=3D%#"PRIx64" -> reg%d",
> +				     (u32)dl->al.offset, page_addr, rd);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		} else {
[ ... ]
> +	if (arm64_is_mov_reg(insn)) {
> +		int rm;
> +
> +		rd =3D A64_RT(insn);
> +		rm =3D A64_RM(insn);
> +
> +		if (!has_reg_type(state, rd))
> +			return;
> +
> +		tsr =3D &state->regs[rd];
> +
> +		if (!has_reg_type(state, rm) || !state->regs[rm].ok) {
> +			tsr->ok =3D false;
> +			return;
> +		}
> +
> +		tsr->type =3D state->regs[rm].type;
> +		tsr->kind =3D state->regs[rm].kind;
> +		tsr->offset =3D state->regs[rm].offset;
> +		tsr->imm_value =3D state->regs[rm].imm_value;
> +		tsr->ok =3D true;
> +
> +		pr_debug_dtp("mov [%x] reg%d -> reg%d",
> +			     (u32)dl->al.offset, rm, rd);
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return;
> +	}
> +}

[Severity: High]
Are we missing register type state invalidation for unhandled instructions
here?

If an unhandled instruction clobbers a register, this function simply ignor=
es
the instruction and implicitly returns. The old type state for that register
is never invalidated, causing it to retain a stale data type. Subsequent
memory accesses using the clobbered register could falsely resolve against =
the
stale type, polluting the output with false positives.

Should there be an invalidation fallback for unhandled instructions, similar
to how x86 explicitly calls invalidate_reg_state() for unhandled clobbering
instructions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623130234.8709=
-1-xueshuai@linux.alibaba.com?part=3D5
