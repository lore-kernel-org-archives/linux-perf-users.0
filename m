Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5A438470
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874273; cv=none; b=DN2NxTGDAM4TzwSLlm9Gol92kSQbFPBl7sYi0UJY/wrQtsw9+179hChbSEuhw7/LhNdA8RSzua1HjjujR3j/LcPVlk8D+KLspKjOi/v8sNlbN4jw/+g6m5sAamTsFEd8jgDQ1iTsc5EapqOkWc0IpsL1x+4l1rTpB32uTTAetHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874273; c=relaxed/simple;
	bh=sgvb4jYRG/AY8fK9nSF7znS1/T0d4aNdKVJOrRE25gc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJesrnDtiNmV93H1KlqH60tFOSbAfKagmiaY6m1VQ125Vmu/0dZwwWXKhErm6+l6MvuqfAcEneG3nksvE9zNXjfcG2vPOLT7XhtrP2N53Gx+GOykonadErogpmDTjqfcLglv4VZ+jV7ER8AiR7KH1vIxwh8YAkvB/aBLIPSjGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85591F00AC4;
	Tue,  8 Sep 2026 13:30:59 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 25/26] perf annotate-arm64: Support per-cpu variable
 access tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4cebb0f4d2db4d66c4ec19c4c007d6761e5aad8e.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <4cebb0f4d2db4d66c4ec19c4c007d6761e5aad8e.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:30:59 +0000
Message-Id: <20260908133059.E85591F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added logic to track per-cpu base registers in 'add' a=
nd 'ldr' instructions is entirely unreachable dead code because `arch_get_r=
eg_offset` prematurely aborts the tracking state.
--

commit e3331fba4432f08f3db300129b5060bba477930c
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support per-cpu variable access tracking

This commit extends update_insn_state_arm64() to handle per-cpu variable
addressing. It detects 'adrp + ldr' pairs that resolve to the
'__per_cpu_offset' symbol, and attempts to propagate this type information
through subsequent 'ldr' and 'add' instructions. However, the newly added
logic is entirely unreachable dead code because arch_get_reg_offset()
prematurely aborts the tracking state.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 9daf959055457..33fef3d153786 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -649,6 +660,12 @@ static int propagate_load_reg_state(struct type_stat=
e *state,
>  		return 0;
>  	}
> =20
> +	/*
> +	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
> +	 * No special handling is needed here; just fall through to retry
> +	 * and resolve the type from the second register.
> +	 */
> +

[Severity: Medium]
Is this fall-through logic in propagate_load_reg_state() for intermediate
Pattern A ('ldr') instructions actually reachable?

Earlier in propagate_load_reg_state(), arch_get_reg_offset() forces an early
exit by returning -1 when evaluating a multi-register load where the second
register isn't a constant. This happens before this new per-cpu fallback
logic can be reached, making this dead code.

>  	/* Or try another register if any */
>  	if (src->multi_regs && src->reg1 !=3D src->reg2 && sreg !=3D src->reg2 =
&&
>  	    !(src->extend_type || src->shift_type)) {

[ ... ]

> @@ -949,6 +966,34 @@ static void update_add_insn_state(struct type_state =
*state,
>  		return;
>  	}
> =20
> +	if (src_tsr.kind =3D=3D TSR_KIND_PERCPU_BASE) {
> +		int reg2;
> +
> +		if (!src->multi_regs) {
> +			invalidate_reg_state(tsr);
> +			return;
> +		}
> +
> +		reg2 =3D (sreg =3D=3D src->reg1) ? src->reg2 : src->reg1;
> +
> +		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
> +			invalidate_reg_state(tsr);
> +			return;
> +		}
> +
> +		/* Treat percpu as array: inherit type from reg2 */
> +		tsr->type =3D state->regs[reg2].type;
> +		tsr->kind =3D state->regs[reg2].kind;
> +		tsr->offset =3D state->regs[reg2].offset;
> +		tsr->imm_value =3D state->regs[reg2].imm_value;
> +		tsr->ok =3D state->regs[reg2].ok;
> +
> +		pr_debug_dtp("add [%x] percpu (reg%d, reg%d) -> reg%d",
> +			     insn_offset, src->reg1, src->reg2, dreg);
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return;
> +	}
> +

[Severity: Medium]
Does this block ever execute when handling a per-cpu address calculation
(Pattern B like 'add x0, x6, x5') in update_add_insn_state()?

When arch_get_reg_offset() executes earlier in update_add_insn_state(), it
returns -1 for multi-register non-memory operations (like 'add') unless one
register is a TSR_KIND_CONST or the base is a known TSR_KIND_POINTER.

Since the registers here are PERCPU_BASE and GLOBAL_ADDR, it returns -1
and jumps to the try_other_reg label, permanently bypassing this new tracki=
ng
logic.

>  try_other_reg:
>  	/* Try another register if any */
>  	if (src->multi_regs && src->reg1 !=3D src->reg2 && sreg !=3D src->reg2 =
&&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D25
