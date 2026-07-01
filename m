Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23037189A
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878864; cv=none; b=FjW92M7KT0MSp3CGyFjoSSjAxFuapY2PfWzNjj+pCqd7Q7AGtNOmS+gZvVzsopW2lm1QmRAPVG9ZNMqLQ+ycFeU9Jl+1+G+1sMfy0qS7eqLR7FEfnqPYMYmC+tpxgaolQgBsTfH81capcEotrg+6+ut3i2lXwA80EHe4Ll5aLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878864; c=relaxed/simple;
	bh=3Ok+Y6xcMgfkoHb/Enl7tb4VHq/wzYV9YOEUE0G8FPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfx9P1SgmwL2jUrnkZ319mGvTToKSz/xo2UEz//cgQCm4OTyqTKw3EGYc6FGVwQMWZI3J/f52CqzKfqbnM3fNL2oOermoezaQ0WI73PNoLTBX26NVj9EBq1+uDXBj+xJXhhZAROOsKKn+PR4whywYZRDmZEnY83fVTawb7PQCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=getBLm5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="getBLm5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886DD1F000E9;
	Wed,  1 Jul 2026 04:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878856;
	bh=2RoGYWAsQsKkyYHQ4ZHoAE7IcFIFJasW1OrTmaa8fCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=getBLm5AG9SgF0pJBHANJtD4ZNSjmP5I1saogWqapYfts4T3cdUAqn9T3YR8jQNP9
	 NZf0IG7ySzQ+wvjGe47Pu0AViuzgRMx5vcfwp9VnN6fOxsJVeQME6T7+8c/v5haQCa
	 tkNzoM6Za/bogqqGFVwz7DPY4DcT5yflFXoFCyDfS0ozrDJUp9beLIOSTpR7806p1d
	 v9tZyMHktcTgRIUm1e68GhVcuPmYklwF6uIEIG1eas4d9Cd5J96FBhFjVLahZ12eur
	 SWv4vBBY2xSKWhzEXYOvi99ri6bpCcm7cueiumAQY1vB5wG2yAlw7XMDKmwIl0086/
	 mv0w8ywcOqNew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/21] perf annotate-arm64: Handle load and store
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-6-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-6-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:07:36 +0000
Message-Id: <20260701040736.886DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] arm64_ldst__parse fails to parse PC-relative load instructions, =
breaking operand extraction for literal pool loads.
- [Medium] Failure to strip inline comments before parsing operands allows =
comments to corrupt `multi_regs` evaluation.
--

commit 9939a67ebc615cf049eb33c68f83aa3646abb3f0
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Handle load and store instructions

This commit adds ldst_ops to parse data types and offsets for ARM64 memory
access instructions using regex prefix matching.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index a1667237114a6..451500def8c12 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -141,6 +142,104 @@ static const struct ins_ops arm64_mov_ops =3D {
[ ... ]
> +static int arm64_ldst__parse(const struct arch *arch,
> +			     struct ins_operands *ops,
> +			     struct map_symbol *ms __maybe_unused,
> +			     struct disasm_line *dl)
> +{
> +	char *s, *left, *right;
> +
> +	right =3D s =3D strchr(ops->raw, arch->objdump.memory_ref_char);
> +	if (!s)
> +		return -1;

[Severity: Medium]
Will this fail to parse PC-relative load instructions?

When processing a PC-relative load instruction (e.g., ldr x0, 4005c0 <sym>),
the 'ld' prefix matches the new ldst_insn regex in arch__new_arm64() and
routes it to arm64_ldst__parse().

Since PC-relative loads lack a bracket ('['), strchr() will return NULL,
causing the function to immediately return -1. Does this leave operands
unpopulated and break annotation features like data type tracking for
literal pool loads?

> +
> +	while (s > ops->raw && *s !=3D ',')
> +		--s;
> +
> +	if (s =3D=3D ops->raw)
> +		return -1;
> +
> +	*s =3D '\0';
> +	left =3D strdup(ops->raw);
> +
> +	*s =3D ',';
> +	if (!left)
> +		return -1;
> +
> +	right =3D strdup(right);
> +	if (!right) {
> +		zfree(&left);
> +		return -1;
> +	}
> +
> +	if (arm64__insn_is_source_first(dl)) {
> +		ops->source.raw =3D left;
> +		ops->source.mem_ref =3D false;
> +
> +		ops->target.raw =3D right;
> +		ops->target.mem_ref =3D true;
> +		ops->target.multi_regs =3D arm64__check_multi_regs(arch, ops->target.r=
aw);

[Severity: Medium]
Does this code incorrectly include inline comments when evaluating multi_re=
gs?

The string duplicated into 'right' includes trailing comments from the raw
operand string because they are not stripped prior to parsing.

If objdump outputs an inline comment containing a comma and a string
resembling a register name (for example: // read, x2), could
arm64__check_multi_regs() wrongly flag the operand as having multiple
registers and corrupt data type profiling?

> +	} else {
> +		ops->source.raw =3D right;
> +		ops->source.mem_ref =3D true;
> +		ops->source.multi_regs =3D arm64__check_multi_regs(arch, ops->source.r=
aw);
> +
> +		ops->target.raw =3D left;
> +		ops->target.mem_ref =3D false;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D5
