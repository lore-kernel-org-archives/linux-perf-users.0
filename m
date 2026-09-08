Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4F4F0545
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873510; cv=none; b=ez6NEPtg02wVMJO02zBXJ5nJ3nxKYa+UHt0MQJJFTtxfl6YqS92QJW5IUANyaOmoL+sb74IlM4am0q7I//JPMfqeU5KN7CugrZOGR9OCYKfMPYr7oXJISfc0BIdYBfxjJ+9ESsvWPM5A0PbxFO6M2HziFSi9OHp/VWp1x+sj+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873510; c=relaxed/simple;
	bh=z4kpZZ78mMm1Nd5nSffbkODdXI10lNFnhKEZ7zaQm8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M2tnUMMkAzTs0ygH3y6xZeq4ORiAfD64wrG0fh0LyRNuBGdvft2Xv0x/knyFsY00FnqjQypd7/RApGO/7JxjUFxH1gThscCmzGPba5wCIsBaJovjRg0EnV4bVU27lNyYDZbwtM4QBwBdUC4SjKXCfMX66yHEgTzjzEuORmysvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD131F00A3D;
	Tue,  8 Sep 2026 13:18:25 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/26] perf annotate-arm64: Enable instruction
 tracking support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8ff5cfde0aad3d585b34f177fd87e8ec57ba4fa1.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <8ff5cfde0aad3d585b34f177fd87e8ec57ba4fa1.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:18:24 +0000
Message-Id: <20260908131825.2DD131F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete initialization of ARM64 caller-saved registers in ini=
t_type_state() misses x30 (Link Register) and x18. According to the ARM64 A=
APCS64 ABI, x30 is intrinsically caller-saved (it is clobbered by function =
calls to store the return address), and x18 is also a temporary/caller-save=
d register (unless strictly reserved by a platform ABI). Because these regi=
sters are omitted during initialization, their `caller_saved` flags remain =
`false`. Consequently, their data type states are not invalidated across fu=
nction calls, allowing stale type info to erroneously propagate.
--

commit 7f29650747bf4bd656328dd491ef0f827ab60d8c
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Enable instruction tracking support

Enable basic instruction tracking for arm64 by implementing three
essential functions in the find_data_type_block() call path. This
allows arm64 to support basic variable type inference during
instruction tracking.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index d8a5904359b1a..8fda4d4d68887 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -442,6 +446,77 @@ static void extract_op_location_arm64(const struct a=
rch *arch,
[ ... ]
> +	if (ins__is_call(&dl->ins)) {
> +		struct symbol *func =3D dl->ops.target.sym;
> +		const char *call_name;
> +		u64 call_addr;
> +
> +		call_name =3D func ? func->name : dl->ops.target.name;
> +		pr_debug_dtp("call [%x] %s\n", insn_offset, call_name ?: "<unknown>");
> +
> +		/* Invalidate caller-saved registers after call */
> +		call_addr =3D map__rip_2objdump(dloc->ms->map,
> +					      dloc->ms->sym->start + dl->al.offset);
> +		for (unsigned int i =3D 0; i < ARRAY_SIZE(state->regs); i++) {
> +			struct type_state_reg *reg =3D &state->regs[i];
> +
> +			if (!reg->caller_saved)
> +				continue;

[Severity: Medium]
Because x30 and x18 are omitted from being marked as caller-saved during ty=
pe
state initialization, their caller_saved flags will be false.

Are these registers unintentionally skipped here, preventing them from being
invalidated across function calls?

> +			/* Keep register valid within DWARF location lifetime */
> +			if (reg->lifetime_active && call_addr < reg->lifetime_end)
> +				continue;
> +			invalidate_reg_state(reg);
> +		}
> +		return;
> +	}
[ ... ]
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 104b80d471f1b..c51b20a7af9b6 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
[ ... ]
> @@ -178,6 +179,13 @@ static void init_type_state(struct type_state *state=
, const struct arch *arch)
>  		state->regs[11].caller_saved =3D true;
>  		state->ret_reg =3D 0;
>  		state->stack_reg =3D X86_REG_SP;
> +	} else if (arch__is_arm64(arch)) {
> +		int i;
> +
> +		for (i =3D 0; i < 18; i++)
> +			state->regs[i].caller_saved =3D true;

[Severity: Medium]
According to the ARM64 AAPCS64 ABI, x30 (Link Register) is intrinsically
caller-saved since it is clobbered by function calls to store the return
address.

x18 is also typically a temporary/caller-saved register unless strictly res=
erved
by a platform ABI.

This loop halts at 17, failing to set the caller_saved flag for x18 and x30.

Could this omission allow stale data type information for these registers to
erroneously propagate across function calls?

> +		state->ret_reg =3D 0;
> +		state->stack_reg =3D ARM64_REG_SP;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D13
