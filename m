Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37D372ED5
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879133; cv=none; b=fU7o9FuwNV93pEJu8VpCo+vecCo/Q2HhLvQjc7mI3ME5J864raQAAjAqdhmLoiq1+0HMnBR43JStkQSOYUT4HgJuyGal8jCtgLJTx+DsKyklMK4Vs43XiTKwVMLU+z5oNH0dlPMenJRU8zR3umXz5a63VT3bGHFwtcA6dy+oh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879133; c=relaxed/simple;
	bh=MIaeCKbxU6WA6dTqOXn9oSSvmQ4dz7/1jxnRdMQbVFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n9QnZztH0lD4go+pD7rZK4FkXqVFMbbadEsg8qZrp0K2NO7znnD37yFc6HJ6dvDLJEKmAenU8Dr5MyUVLQao6dikh+JawjqK2pRsroaaeJ0lmrCiosrrLqr4SHyCgqpBxUsWOtbv7B8b5wwzvNqlhonAOFI6sZHjZ2GDA9GkSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl/iqkD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl/iqkD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000111F000E9;
	Wed,  1 Jul 2026 04:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879122;
	bh=SBAYyDR8hH+hiP58yg/L6Kqyu414RZy/giMi8tuBHqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xl/iqkD4oWnjse9iNzaxBIG64uUFKRsNz5rIwXfWf3cMu96Q29eoNduFyzJPJ5wws
	 5fZFFnQ8p+NPSRH0UE5HRa7hWtsOauOtglWnvIjEfeojmiM7ugCNkx3BYU3PP6IOcI
	 D+aKrrzGvtnzE7DNn4mrOSyYkFEN69tZ/cKyjCiR5FDks4EwS7j2JkQTpJatLGpVo+
	 BokAAMbWd2Lt+bSZuF7mRDtsYTj5xA5TGmVMNgBO3suvVc/CtojBOlbvJ2Dq5lndBW
	 uZPgLoW8j+EM6voAAuENkvxslrMAhH9FjipTdhe55END9cE2ge0nJQjwzqAIcXSt6b
	 i3Jq+vufTS0tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/21] perf annotate-arm64: Enable instruction
 tracking support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-14-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-14-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:12:01 +0000
Message-Id: <20260701041202.000111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing function call register invalidation for ARM64 data type tr=
acking.
- [Medium] Failure to invalidate secondary destination registers (`reg2`) i=
n multi-register instructions.

Pre-existing issues:
- [High] Missing `multi_regs` evaluation for register operands in load/stor=
e instructions.
--

commit a1f858405ccf3b88519235d7e08cb42762d969ac
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Enable instruction tracking support

Enable basic instruction tracking for arm64 by implementing three essential
functions in the find_data_type_block() call path: arch_supports_insn_track=
ing,
init_type_state, and update_insn_state.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 77b6f4841c849..48b1c94273eb6 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -324,6 +326,31 @@ static int extract_op_location_arm64(const struct ar=
ch *arch,
>  	return 0;
>  }
> =20
> +#ifdef HAVE_LIBDW_SUPPORT
> +static void update_insn_state_arm64(struct type_state *state,
> +				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
> +				    struct disasm_line *dl)
> +{
> +	struct annotated_insn_loc loc;
> +	struct annotated_op_loc *dst =3D &loc.ops[INSN_OP_TARGET];
> +	u32 insn_offset =3D dl->al.offset;
> +
> +	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
> +		return;
> +

[Severity: High]
Does this function miss a check for function calls?

When an instruction is a function call (e.g., bl or blr), this code does not
check ins__is_call(&dl->ins). As a result, it fails to invalidate the
caller-saved registers (x0-x17) and update the return type in x0.

While init_type_state() correctly initializes the caller_saved flags for
these registers, won't omitting the invalidation here cause subsequent
accesses to inherit incorrect type states across function calls?

> +	/*
> +	 * For unsupported instructions with a destination register, invalidate
> +	 * the destination register itself to prevent incorrect type propagatio=
n.
> +	 */
> +	if (has_reg_type(state, dst->reg1)) {
> +		pr_debug_dtp("%s [%x] invalidate reg%d\n",
> +			     dl->ins.name, insn_offset, dst->reg1);
> +		invalidate_reg_state(&state->regs[dst->reg1]);
> +		return;
> +	}

[Severity: Medium]
Does this fallback logic need to handle secondary destination registers?

When an unsupported instruction modifies multiple registers (e.g., casp),
this only checks and invalidates the primary destination register
(dst->reg1).=20

If the instruction has a secondary register (where dst->multi_regs is
true), should we also invalidate dst->reg2 so it doesn't retain an
incorrect type state?

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
arm64_ldst__parse() regarding multi-register instructions:

tools/perf/util/annotate-arch/annotate-arm64.c:arm64_ldst__parse() {
...
	if (arm64__insn_is_source_first(dl)) {
		ops->source.raw =3D left;
		ops->source.mem_ref =3D false;
		ops->target.raw =3D right;
		ops->target.mem_ref =3D true;
		ops->target.multi_regs =3D arm64__check_multi_regs(arch, ops->target.raw);
	}
...
}

Here, arm64__check_multi_regs() is only applied to the memory operand side
(ops->target in this case). The register operand side is left with
multi_regs =3D false.=20

Because of this, extract_op_location_arm64() fails to parse the second
register (reg2) for instructions like ldp and stp, leaving it as -1. Won't
this cause the data type tracking logic to silently miss type updates and
queries for the secondary register?

> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D13
