Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C555328AC
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873523; cv=none; b=TlR/tPz5QNbIqb2LtoJTTP1tbh9ufguZPfFQHsZMYW2uL6C/QQatIJM218RBV2Yz9sH2AuKghIiMUqmiCHq30sqGLafoBsfVsVvjz0LoJbQVdz06t19OT99Gy5CPOqr4uNqAMyWaecR/sI5gpPcoD7xuNHWq4m4ZOCFRKRyLhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873523; c=relaxed/simple;
	bh=S90Qx+qGAS5rvwhJw9/bnz9bgxYnrLon8FJd5hD/NVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=epZhFWKKm0VO8cmZrV2lMF9uLCLFZAq3iTAhErc+YIH8EGmaomLtbn3a4VRA652Q/Atgm+UJd2QD7zUzG6P+Pc4icwkRZ7bAjblyNq9cXmP8atBr7Lb64NQAjyvDp13sESx20/e7GseOCZ968DWJdqi4LJooMYBksWQKikeeX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB14B1F00A3A;
	Tue,  8 Sep 2026 13:18:35 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/26] perf annotate-arm64: Implement
 extract_op_location() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <73c9999d6089cd754ec5df65d1cca97ce3797b8d.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <73c9999d6089cd754ec5df65d1cca97ce3797b8d.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:18:35 +0000
Message-Id: <20260908131835.EB14B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Shift and extension modifiers are silently ignored for single-re=
gister operands in extract_op_location_arm64().
--

commit e285d74ff460ca1f5c334760a2efdd0b26f56319
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Implement extract_op_location() callback

This commit implements the extract_op_location() callback for the arm64
architecture to handle its specific assembly syntax and addressing modes.
This enables perf annotate to resolve memory locations and register types
for data type profiling.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index a7595a954cfae..d8a5904359b1a 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> +static void extract_op_location_arm64(const struct arch *arch,
> +				      struct disasm_line *dl __maybe_unused,
> +				      const char *op_str, int op_idx __maybe_unused,
> +				      struct annotated_op_loc *op_loc)
> +{
> +	const char *s =3D op_str;
> +	char *p =3D NULL;
> +
> +	if (op_str =3D=3D NULL)
> +		return;
> +
> +	/*
> +	 * Handle immediate operand.
> +	 * e.g., "#0xc600" -> offset =3D 0xc600, imm =3D true
> +	 *
> +	 * After parsing, check for post-modifiers like "lsl #16", which
> +	 * typically occur in instructions such as movk, movz, movn, etc.
> +	 */
> +	if (*s =3D=3D arch->objdump.imm_char) {
> +		op_loc->offset =3D strtol(s + 1, &p, 0);
> +		if (p && p !=3D s + 1) {
> +			op_loc->imm =3D true;
> +			s =3D p;
> +		}
> +		goto check_modifiers;
> +	}
> +

[ ... ]

> +	/* Extract the primary register */
> +	op_loc->reg1 =3D arch__dwarf_regnum(arch, s);
> +	if (op_loc->reg1 =3D=3D -1)
> +		return;
> +
> +	/* Move to the next operand field, if present */
> +	s =3D strchr(s, ',');
> +	if (s =3D=3D NULL)
> +		return;
> +	s =3D skip_spaces(s + 1);
> +
> +	/* Extract secondary register or immediate offset */
> +	if (op_loc->multi_regs)
> +		op_loc->reg2 =3D arch__dwarf_regnum(arch, s);
> +	else if (*s =3D=3D arch->objdump.imm_char)
> +		op_loc->offset =3D strtol(s + 1, NULL, 0);
> +
> +check_modifiers:
> +	/*
> +	 * Look for a following shift or extension modifier:
> +	 *   ", lsl #3"   -> extend_type =3D PERF_EXT_NONE,
> +	 *                   shift_type =3D PERF_SHIFT_LSL, amount =3D 3
> +	 *   ", uxtw #3"  -> extend_type =3D PERF_EXT_UXTW,
> +	 *                   shift_type =3D PERF_SHIFT_LSL, amount =3D 3
> +	 *   ", uxtw"     -> extend_type =3D PERF_EXT_UXTW,
> +	 *                   shift_type =3D PERF_SHIFT_LSL, amount =3D 0
> +	 */
> +	s =3D strchr(s, ',');
> +	if (s =3D=3D NULL)
> +		return;

[Severity: Medium]
Will this silently ignore shift and extension modifiers for single-register
operands in extract_op_location_arm64()?

When perf annotate processes an instruction like "cmp x0, x1, lsl #3", the
source operand string is parsed as "x1, lsl #3". During primary register
extraction, the pointer 's' is advanced past the first comma to point
directly at "lsl #3".

Because multi_regs is false and the operand is not an immediate, execution
falls through to the check_modifiers block. At this point, the string is
just "lsl #3". The strchr(s, ',') search will fail and the function returns
early without parsing the modifier.

Could this lead to missing annotations and incomplete statistics for these
instructions during data type profiling?

> +	s =3D skip_spaces(s + 1);
> +
> +	op_loc->extend_type =3D arm64__check_ext_type(s);
> +	op_loc->shift_type =3D arm64__check_shift_type(s);
> +	/* ARM64 extended operands are implicitly shifted by LSL. */
> +	if (op_loc->extend_type !=3D PERF_EXT_NONE)
> +		op_loc->shift_type =3D PERF_SHIFT_LSL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D9
