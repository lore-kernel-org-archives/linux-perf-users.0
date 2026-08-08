Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F67233933
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194680; cv=none; b=SBrTgIuTNqVNq7A6EW6E2UL/AvKG+Zs70XgqaBtTe0ImIN73OVXZpgqYRe/COD+rXLgRV5zoNR8qSEdSBFQ9w3RhrEdcwem2UGw7rAjDF/vp8VI4P1UCnVmtfK95EtZ0jDbWUxpVX1o2Al7zW9R5IvfJR5b7cU/oyltHz9fstB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194680; c=relaxed/simple;
	bh=H6Ya61lFuwoCN+q12Ka/UYSK9wX0ThM56doMi2E++S0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btNDkn0rShmUuOdbFRQjLKdDjVEKQnuXP1PmriD6oI6/HHNR3D6pUetkQ2YNLiU+C8Gni/MnbYM+vbVLczk0tHk22kCW38WIh1vmcgGbP12nOmLXM6Sp6UWlw4n4hN0T6n6M1bQVfkVjGQ27YLulUvUG6Fg97Kh1m1Ji9sKnYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzbOhtCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzbOhtCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE021F000E9;
	Sat,  8 Aug 2026 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194676;
	bh=oGyVwMQutRNLMX3wByR5h8b9x5vf0h+xLR6usGko2x8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KzbOhtCWPWPXC/BpZCtx/de43R3+NpLY+7AVHrYDcd+nQEI9OvuATVprdJCFGJ5Ka
	 bdk4z97DN4fnot4UKDEK9q53bgM3MWmslNDQmcTW94o2emSxrkDIva134Tr5y9Prrj
	 ZEsxs0MYTRK/3m0T20cd4j2xfnmyY7ikt2uPcVCGyr/4IKAkW9WyR6/J1ux28jIqJM
	 e/ji3mJDmMfjQhB4G0Lh2nnXJkdPtXPWWagKaouRNoVtHuVA5ajJikOCXGotHEYARM
	 MWET3suG06U/J7WJouKMvkbJna1u5mBFoFaYvZ6WIgrgR9p64ybPnr0TYFEUuiG3gM
	 KZKOo1Y+oBdiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/23] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-8-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-8-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:11:15 +0000
Message-Id: <20260808131116.3BE021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Propagating errors from extract_reg_offset aborts instruction st=
ate processing, breaking register invalidation, and uses a flawed condition.
--

--- Patch [7]: [PATCH v4 07/23] perf annotate: Introduce extract_op_locatio=
n callback for arch-specific parsing ---
commit ea4cc06c47d3d877b7277db8368241769c5b60d3
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate: Introduce extract_op_location callback for arch-specific par=
sing

Assembly syntax for operands varies significantly across different
architectures, which prevents the operand location (op_loc) parsing
logic in annotate_get_insn_location() from being directly reused.

To simplify the core logic and improve maintainability, move the
operand parsing inside the for_each_insn_op_loc loop into arch-specific
extract_op_location callbacks.

> This refactoring is primarily a cleanup,
> but includes a minor x86-specific change: errors from extract_reg_offset()
> are now propagated, so unrecognized operands are correctly rejected
> instead of being silently ignored, , and testing confirms no functional
> regression from this change.

[Severity: Medium]
Are we certain this change does not introduce functional regressions?

Propagating errors out of extract_reg_offset() appears to break type state
tracking for absolute memory references.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> index 7e61365363938..6044a68966f14 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
[ ... ]
> @@ -809,6 +811,85 @@ static void update_insn_state_x86(struct type_state =
*state,
[ ... ]
> +static int extract_reg_offset(const struct arch *arch, const char *str,
> +			      struct annotated_op_loc *op_loc)
> +{
[ ... ]
> +	op_loc->reg1 =3D arch__dwarf_regnum(arch, p);
> +	if (op_loc->reg1 =3D=3D -1)
> +		return -1;

[Severity: Medium]
Will this error check correctly identify unrecognized registers?

If an instruction contains an unrecognized register like '%zmm0',
arch__dwarf_regnum() returns -2 (-ENOENT). The check for -1 will miss
unrecognized registers, but it will trigger for absolute memory references
like 'mov (0x1234), %rax' which lack a '%' character entirely.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 9d8b4d6b859b8..20be609ebed24 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
[ ... ]
> @@ -2572,6 +2527,7 @@ int annotate_get_insn_location(const struct arch *a=
rch, struct disasm_line *dl,
[ ... ]
> +		if (arch->extract_op_location) {
> +			ret =3D arch->extract_op_location(arch, dl, insn_str, i, op_loc);
> +			if (ret)
> +				return ret;
>  		}
>  	}

[Severity: Medium]
Does propagating this failure cause issues in update_insn_state_x86()?

When absolute memory references return -1 and trigger this early return,
annotate_get_insn_location() will fail.

If update_insn_state_x86() bails out early because of this failure:

tools/perf/util/annotate-arch/annotate-x86.c:update_insn_state_x86() {
    ...
	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
		return;
    ...
}

Won't this bypass the fallback logic that invalidates the destination regis=
ter?
This could cause the analyzer to incorrectly assume the destination register
retains its previous type state, when it actually contains unknown data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D7
