Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE87370D5D
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879415; cv=none; b=hXpJjRvJRjTeCd0J4NsmcUFG9J19h6SQ+f0Sr4lqELVWL9XoSCn4ApkXV2yx7zrNNOGk53G3iejgRRu32jIWZUHBx6dVPmU3R+RaWT/e4NUWPtoTTtGJXzBwud7xMM7BZ4gKRb/DmUXvattItPLeinHaQVT1oaLlMXibNSK6ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879415; c=relaxed/simple;
	bh=Rc35FtZhwqA4s9vWRCDa/IOZrg6cTdgh3D7ajvm9i9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJnng/LlvwHk+uIpEeRHLcTX7ZndtGmfv1oEzjc6QKZA4Se04/2rGd38WvSHdepp/oIXJdyJcROPhC8AXp+7QM6ec4+6LA9KVFPBcCVq2L3MxG/fA8QskjzjJtUh8di8PdNn6UWb0X3E/M/jp4EbwTOS2Xku0le42SyWwdSXEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POYGr3d4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POYGr3d4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CE41F000E9;
	Wed,  1 Jul 2026 04:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879407;
	bh=FnSuNXmVznUH08IiZLkzl+Tk/UM0y/gz4a0Hg6mF6oM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=POYGr3d4V2twXgKaxPJ/C+DmTh+Zmqvvi9ckj2lUhnvUypkNbfdMYr7ht9XFFvduM
	 Hk8gEM33rqreoS8j4+vhAxmkuG9yOYDfAOA5rpW/oZAubLokTAJDHvaD5tycdQ40ry
	 Cfwks0W5o2SQRh3xDfFVc1jhqGnd0QNNI+kek3z73Du3SCUqnd4zll76tZR0lb4ZW4
	 JQkTQDrWazg53crsosWNW8q6YApY4gJemMBJvDifwr8gsqNJVdvJtoYCt+uEtoDw/2
	 fdcj9mPysJSGw7uhtlLjtDI8TA2Pfaa4XV88IDyVwg95wSCv+sMY2UUPfOWodFFnIs
	 mQoNRitpeZQfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/21] perf annotate-arm64: Support stack variable
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-17-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-17-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:16:47 +0000
Message-Id: <20260701041647.81CE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Incomplete handling of ARM64 load/store pair instructions (ldp/s=
tp) causes type tracking corruption by ignoring the second register.
- [Medium] Missing invalidation of destination register when type resolutio=
n fails during a memory load.
- [Medium] Missing invalidation of stack state when storing an unknown regi=
ster type.
- [Medium] Incorrect stack offset calculation when accessing memory via the=
 stack pointer while a different frame base register is active.
--

commit 3e734515747646c2063edf487f47005c1433cf1a
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support stack variable tracking

This commit extends update_insn_state() for arm64 to track data types
stored on the stack. It handles stack loads and stores to update the
register's type state or stack state. This allows 'perf annotate' to
maintain type information for local variables as they move between registers
and memory.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index f283596bb0589..255ccaf331309 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -368,6 +371,8 @@ static void update_load_insn_state(struct type_state =
*state,
>  	int reg_offset;
>  	int sreg =3D src->reg1;
>  	int dreg =3D dst->reg1;
        ^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
When handling ARM64 load pair instructions (ldp), does this code ignore the
second destination register (dst->reg2)? The second register of a load pair
could retain its stale type instead of being updated, which might lead to
false type propagation.

> +	int fbreg =3D dloc->fbreg;
> +	int fboff =3D 0;
> =20
>  	if (!has_reg_type(state, dreg))
>  		goto out_adjust;
> @@ -375,7 +380,52 @@ static void update_load_insn_state(struct type_state=
 *state,
>  	tsr =3D &state->regs[dreg];
>  	tsr->copied_from =3D -1;
> =20
> +	if (dloc->fb_cfa) {
> +		u64 ip =3D dloc->ms->sym->start + dl->al.offset;
> +		u64 pc =3D map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> +			fbreg =3D -1;
> +	}
> +
>  retry:
> +	/* Check stack variables with offset */
> +	if (sreg =3D=3D fbreg || sreg =3D=3D state->stack_reg) {
> +		struct type_state_stack *stack;
> +		int offset =3D src->offset - fboff;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Will this subtract the frame base offset even when the access is relative to
the stack pointer (when sreg =3D=3D state->stack_reg)? If the stack pointer=
 is
used and fbreg is different (e.g., x29), this could yield an incorrect
internal stack offset and lose type information.

> +
> +		stack =3D find_stack_state(state, offset);
[ ... ]
> @@ -413,6 +463,70 @@ static void update_load_insn_state(struct type_state=
 *state,
>  	adjust_reg_index_state(state, src, "ldr", insn_offset);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Is the destination register left uninvalidated if type resolution fails
during a memory load and the code falls through the multi-regs retry logic
to the out_adjust label? The destination register could retain its prior ty=
pe
instead of being invalidated, even though its value was overwritten by an
unknown memory load.

>  }
> =20
> +static void update_store_insn_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    struct disasm_line *dl,
> +				    struct annotated_op_loc *src,
> +				    struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	u32 insn_offset =3D dl->al.offset;
> +	int sreg =3D src->reg1;
> +	int dreg =3D dst->reg1;
        ^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Similar to the load instructions, does this logic ignore the second source
register (src->reg2) for ARM64 store pair instructions (stp)? The second
register of a store pair wouldn't be saved to the stack.

> +	int fbreg =3D dloc->fbreg;
> +	int fboff =3D 0;
> +
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
> +		goto out_adjust;
        ^^^^^^^^^^^^^^^^
[Severity: Medium]
By skipping the rest of the function here, are we bypassing the invalidation
of the stack state? If an untracked register is stored into a stack slot th=
at
previously held a tracked type, the stale type might persist on the stack.

> +
> +	if (dloc->fb_cfa) {
> +		u64 ip =3D dloc->ms->sym->start + dl->al.offset;
> +		u64 pc =3D map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> +			fbreg =3D -1;
> +	}
> +
> +	/* Check stack variables with offset */
> +	if (dreg =3D=3D fbreg || dreg =3D=3D state->stack_reg) {
> +		struct type_state_stack *stack;
> +		int offset =3D dst->offset - fboff;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Could this calculation yield an incorrect internal stack offset by
subtracting the frame base offset even when the access is relative to the
stack pointer? This could happen if the frame base register is different fr=
om
the stack pointer.

> +
> +		tsr =3D &state->regs[sreg];
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D16
