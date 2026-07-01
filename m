Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCD40D564
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879673; cv=none; b=EaELka60SFVqwYP+7XIcvtWHh3qfMMwt+XMOY3RQaUSc+AQjUpP7k1lMvT+ocr8bzLCI6JSrMfW4nR/xDTfA61vOBUiSXevzwiw07q9lNXhSDKqdSPeGweIOV9lnWXcKaRzSnfddrjHveiOmgbIpEk/n7bfc+ZraQUAUeS58Axc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879673; c=relaxed/simple;
	bh=5m8OSuA0Yu7/gRRekp1UZUXXq9fZ8QcaIztauIAQMbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lACVnngElBZBhhlBdIU8OZaVWmOJniv+MSHXj23zuu15BJpW2zhK+0RyCFZeURgHWqkkFZOOWkAjqF49X5GAcFd8pcRYya5j1eAg7BxmFQNm+v8lt7UK5jJYSFSQ0IgplnybAQSxNK4YLSmKJp1mLj3HdnyquKOMiq4YtnFfF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUh255BF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUh255BF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565541F000E9;
	Wed,  1 Jul 2026 04:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879669;
	bh=Go6XtHntqCGtYA9j2j5KixjChRr6UPyi+jvPGVMnWFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUh255BFunCMQ2wIScKU2kwSujVMKcU0S9XeLriSOuZLMTRMJnLFi3G7I8j/4onCE
	 WGtBR+IOCFexFTr9x0/qXC/4pJWdrUBfafWIcZ5DAmYiV/yn5v3YrOn29LEXSg+pJf
	 VyhWadmikKhfbhkz6YVgy9CiMPSPLSScR0w3j9cQK4hMBQJONDJrec+wZsLpK3hkPJ
	 ftWWfErK5pmx5H0Vnlc6fzunXhtg1tRW34BVGPgnS4mqmmx5+osE04vI1DEW74cOnc
	 fXquKBf2VBn5y5WVRtKpoKxxVEqQUr8+FO+Jkd3ziPpcagCiGBABOyw+szhMqrIbw+
	 wGkCVUJO4e9sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/21] perf annotate-arm64: Support 'mov' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-18-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-18-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:21:08 +0000
Message-Id: <20260701042109.565541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Type state corruption due to DWARF register overloading for the =
stack pointer (`sp`) and zero registers (`xzr`/`wzr`).
--

commit 8b77f0fe5f1ec7e9d14eee63f44f48d6c55f7234
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'mov' instruction tracking

This commit extends update_insn_state() for arm64 to track register-to-regi=
ster
and immediate-to-register 'mov' instructions. It propagates data type
information or immediate values to the destination register to improve type
inference.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> +static void update_mov_insn_state(struct type_state *state,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *src,
> +				  struct annotated_op_loc *dst)
> +{

[ ... ]

> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	tsr->type =3D state->regs[sreg].type;

[Severity: Medium]
Will this code corrupt the stack pointer's type state if the zero register
(xzr or wzr) is used in a mov instruction?

Looking at tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c, the function
__get_dwarf_regnum_arm64() maps sp, wzr, and xzr all to DWARF register 31:

    if (!strcmp(name, "sp") || !strcmp(name, "wzr") || !strcmp(name, "xzr"))
        return 31;

If a zero register is used as a destination (e.g., mov xzr, x0), does its
tracked state overwrite the tracked state of the stack pointer?

Conversely, if a zero register is used as a source (e.g., mov x0, xzr),
does the destination register incorrectly inherit the type of the stack
pointer instead of being treated as a constant 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D17
