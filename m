Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30803B1EC0
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523360; cv=none; b=iN1BLOZJMeBcuOYS1qJUhMYm2sksdYv/AjJnNDCESDKlfGZejWqLSAWhbvUFGCHuYjF/3DR/Z81EjqKLM++hsWnuS/WrREB/Vs+E/DcOuDr54+ZWSBMHA+rE7XnbVyZJAIoKWDU5px6ceC+Dqr/rreLfUymgJa9MhV0nPMe78NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523360; c=relaxed/simple;
	bh=ovfrJgCYDN/X1EEXWTZZyIbSLzgwILEL6eMjva2jQfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pmUn64miuJniB/a2gPJRn6ewwm5y6KDRIGLXlW+DnP8/ayvf+ySQRc0tdqXCAinUKARkfDWJeXoQUr4YwoX69Gq0Yb3FjzA8ok0nElVLbOuV0mGV21sR6mNxIWti7tVglcz5vALSc/QshjTw3nK6VFQwNoqMiJnojK+VU5azZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPa/EDcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPa/EDcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C91F000FF;
	Wed, 16 Sep 2026 01:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523346;
	bh=hc2MyTL117g53RkZY1Uclwj/t2W5hCvMaHgRkGxjL1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPa/EDcMZjLNFrwmiv9VNLrikbgqBDOL4xaJ/dNN9nxc5ZBVd1H3JQTMwgfwHUk5g
	 wxOvduPW8lFi8ZcIXsBC7Q/91VSHbNc45z1+OMIsUugX+RrOJbmebpr3Jeve8zemJe
	 7C2qphZyoogLuJrNHMGScTUYBCiAX5ubyKKy9cBpCRSKMohnwXLhaFpJagtbJEWKM9
	 c2qsSO7fKbgb/IvnW6bEbxigqdljcZo+5DS/T9bhSWUstCDsbsBLAD2jqk509baHuT
	 dz8LZ/UPRayj8kDv7wrqROu+7XoQhRNWPmOlFMZtQTwHhoE4SWjRfzYbhKmL/+KpuP
	 xtOouM0yDUdYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/26] perf annotate-arm64: Support stack variable
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <11bcde1a75d96b524cc5a7f6fa442025680e56a0.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <11bcde1a75d96b524cc5a7f6fa442025680e56a0.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:49:05 +0000
Message-Id: <20260916014905.D44C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: stale stack state due to bypassed invalidation in update_s=
tore_insn_state
--

commit 2ddb0f384d44eeb70844d8c3adc06f8d55101f68
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support stack variable tracking

Extend update_insn_state_arm64() to track data types stored on the stack. T=
he
implementation handles stack loads and stores to follow data types as they
move between registers and memory.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index a72c7703dd6b3..8339aab0d314f 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> +/*
> + * For store insns: propagate type from @sreg to the memory location ref=
erenced
> + * by @dst, applying @mem_spacing to account for multi-regs stores (e.g.=
 stp).
> + */
> +static void propagate_store_reg_state(struct type_state *state,
> +				      struct data_loc_info *dloc,
> +				      struct disasm_line *dl, int sreg,
> +				      struct annotated_op_loc *dst,
> +				      int mem_spacing)
> +{
[ ... ]
> +		if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> +			stack =3D find_stack_state(state, offset);
> +			/* Preserve compound states when only a member is overwritten. */
> +			if (stack && !stack->compound)
> +				delete_stack_state(state, offset);
> +
> +			return;
> +		}
[ ... ]
> +static void update_store_insn_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    struct disasm_line *dl,
> +				    struct annotated_op_loc *src,
> +				    struct annotated_op_loc *dst)
> +{
> +	int mem_spacing =3D 0;
> +
> +	if (!has_reg_type(state, dst->reg1))
> +		return;
> +
> +	/* Handle the first source register */
> +	if (has_reg_type(state, src->reg1))
> +		propagate_store_reg_state(state, dloc, dl, src->reg1,
> +					  dst, mem_spacing);
> +
> +	if (!src->multi_regs || !has_reg_type(state, src->reg2))
> +		goto out_adjust;

[Severity: Medium]
Does the has_reg_type() guard here inadvertently skip the stack state
invalidation logic?

Looking at propagate_store_reg_state() above, there is logic to delete the
stack state if the source register is untracked. However, because
update_store_insn_state() completely bypasses the call to
propagate_store_reg_state() when the source register is untracked, this
cleanup is never reached.

If an untracked register is stored into a stack slot previously used for a
tracked variable, could this leave stale tracking state on the stack, causi=
ng
subsequent loads from that slot to inherit the wrong type?

> +
> +	/* Handle the second source register */
> +	mem_spacing =3D arm64__reg_size(dl->ops.source.raw);
> +
> +	if (mem_spacing >=3D 0)
> +		propagate_store_reg_state(state, dloc, dl, src->reg2,
> +					  dst, mem_spacing);
> +
> +out_adjust:
> +	adjust_reg_index_state(state, dloc, dl, dst);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D21
