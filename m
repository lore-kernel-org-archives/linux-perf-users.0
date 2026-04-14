Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B23D647E
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172674; cv=none; b=Kk/5HexckRFnjovCRfI/2s+xITMZiMJg4jZV9hIMYUOfvWkbI3KCfdQ4fXckpFhVu+g9vOHLcJHHnxCDy6w1bijQD0mwYCVnuFn1UTYVs4CHBy8Ui/PNPdTNyQOHqn+2TB9rM9yMiuVjpdKuZulmDc8PqnQkbfr48CFTOb44K80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172674; c=relaxed/simple;
	bh=J6FVE6TRKsnlAEcGCqfQqaXBg5Euj3nl87b7Lmw7ceM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0bMlo+fkxOuT+KtAbttr77+FVkBs3JSX+zUY+xS/EvNNUKHrSzRj8VwvSldNfbc1JmiEMKW88rP318Y1+9kgAcXlxU/YGWFJVNfBIljmx9dQYS2LZ9g+FAQ+R+7RyrP3Jkshkf9oTvXqaEZHBhnRwxVQtUoJ3QKilNiT4vi5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlUWV0UT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlUWV0UT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1E2C19425;
	Tue, 14 Apr 2026 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776172673;
	bh=J6FVE6TRKsnlAEcGCqfQqaXBg5Euj3nl87b7Lmw7ceM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XlUWV0UTU+go8Q1xAqmnstRMqKozXqzyH84e6YLkB9NqiSCCV5ccnPONg9O9iMLme
	 g8IS8x+H3sENxvVPgW3dj7vZZsBaYsrIaK17VK/G93ZN84GjhLcMNRNSecEvbZbG74
	 I8ElzSVEAqOmQ/DWsWNyz9CPR5UxeW0nfWZ8aHVtLU6OlNLgmDf/ZovjZUt6NnMIGf
	 pwLILVKtowgto2byFOZHEZ1RoRUD13hNicLAAvTuc2WYCBl+SmPK8ib0i03U50c7Ds
	 jT3W75veZ+biluoVHvkUxR9bVkndNV9HjSw7yy+yUo9qvoIbUhj2NY5g8hPR9Vguj/
	 Ah2W4we8Z/K9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf riscv: Add SDT argument parsing for RISC-V
Reply-To: sashiko@lists.linux.dev
To: Unknown <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414124655.129463-1-cp0613@linux.alibaba.com>
References: <20260414124655.129463-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 13:17:52 +0000
Message-Id: <20260414131753.7E1E2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The 'zero' register is translated to '%zero' for uprobes, causin=
g the kernel to reject the probe with -EINVAL.
- [Medium] Incorrect error checking of `sdt_init_op_regex()` leads to a Use=
-After-Free or a crash due to uninitialized `regex_t` structures if `regcom=
p()` fails.
--

commit 8e1a4d45321e1b5de5891b9276cd561935f4b98f
Author: Chen Pei <cp0613@linux.alibaba.com>

perf riscv: Add SDT argument parsing for RISC-V

This commit implements __perf_sdt_arg_parse_op_riscv() to parse RISC-V SDT
probe operands and convert them into uprobe-compatible formats. It uses
regular expressions to match register and memory operand formats.

> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/per=
f/util/perf-regs-arch/perf_regs_riscv.c
> index 5b5f21fcba8c6..51b43e68e0e3d 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c

[ ... ]

> +/* RISC-V register ABI names: zero, ra, sp, gp, tp, t0-t6, s0-s11, a0-a7=
 */
> +#define SDT_OP_REGEX1  "^(zero|ra|sp|gp|tp|t[0-6]|s[0-9]|s1[01]|a[0-7])$"
> +
> +/* RISC-V memory operand: [-]NUM(REG) */
> +#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((zero|ra|sp|gp|tp|t[0-6]|s[0-9=
]|s1[01]|a[0-7])\\)$"

Since the 'zero' register is hardwired and not saved in pt_regs, will the
kernel reject probes with a BAD_REG_NAME error when perf translates it
to '%zero' for tracefs?

Should 'zero' be excluded from these regexes and instead treated as an
unsupported constant-like argument to be skipped with SDT_ARG_SKIP?

[ ... ]

> +static int sdt_init_op_regex(void)
> +{
> +	static int initialized;
> +	int ret =3D 0;
> +
> +	if (initialized)
> +		return 0;
> +
> +	ret =3D regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> +	if (ret)
> +		goto error;
> +
> +	ret =3D regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> +	if (ret)
> +		goto free_regex1;
> +
> +	initialized =3D 1;
> +	return 0;
> +
> +free_regex1:
> +	regfree(&sdt_op_regex1);
> +error:
> +	pr_debug4("Regex compilation error.\n");
> +	return ret;
> +}

[ ... ]

> +int __perf_sdt_arg_parse_op_riscv(char *old_op, char **new_op)
> +{
> +	int ret, new_len;
> +	regmatch_t rm[4];
> +	char prefix;

[ ... ]

> +	ret =3D sdt_init_op_regex();
> +	if (ret < 0)
> +		return ret;

Does this properly catch regex compilation failures?=20

POSIX regcomp() returns a strictly positive integer (like REG_ESPACE)
on error, so this condition will evaluate to false if regcomp() fails.

If the first regcomp() in sdt_init_op_regex() fails, could this lead to a
crash when calling regexec() on the zero-initialized sdt_op_regex1 below?

Alternatively, if the second regcomp() fails, sdt_init_op_regex()
calls regfree(&sdt_op_regex1) before returning the positive error code.

Could this cause a use-after-free when regexec() operates on the freed
regex object?

> +
> +	if (!regexec(&sdt_op_regex1, old_op, 2, rm, 0)) {
> +		/* REG --> %REG */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414124655.1294=
63-1-cp0613@linux.alibaba.com?part=3D1
