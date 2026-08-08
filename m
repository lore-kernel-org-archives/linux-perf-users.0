Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0D3E928B
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195355; cv=none; b=sjjkJ1Kpr0rQXfcEiw7OuV/+cyxlIzGzUmp87zKFkJJ2KXQUEUVbk2wi57YE1sHEharKqdWIFiY8iBG6tdtmZaOatO3G8ORwwxxJE72vqfAOkZ+1uOFUrx4o7kiV4gXZmfDna8gDCgJPY3S1JQ3e0FmvshP8kC3j5GPkAW2YKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195355; c=relaxed/simple;
	bh=rvdKZg2b4CuFVa0g4EnczpWL10EogL/uevpaZFWtTgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V38BAXMilU+j7v9lVwAwoqHf+dvF0ii5KuUMU0VyrZK0DniiqyzJ1AsmXhe+nleV4YPRFJWTzGClhcba0CFpZl9DETDMOrbnktWnvPwohtxDvCKjvgS1QewsuY+dlDMROa2wpSwgeujfya2EA6s9W3m0F7mNGkLB0xpdo3xE0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOsGe3CM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOsGe3CM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8D01F000E9;
	Sat,  8 Aug 2026 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786195353;
	bh=5IyAUKkseJjyPail9APY+W6EUWzZH5tlRLDjIfda1zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOsGe3CMwqyk6yEH0Va2sUBjTnQ2eSGEm0u8u9XrLi5RnS5UW/q30t7apj+mjaJkK
	 VGps1cHEsDhx+Wk8J5gOYikPDuFg7lTbZsYnUJUgRz4dbN9mNtnLVsNVLzU00pLvVD
	 i6gOZ2tElHPqKJ22btshVL1iK7mGlh2YTy+iBLnKCfPA70Xb2g2wQ8+NtJEce/TPCk
	 gynHrpW+w/Qe+n/HwUa7SItxB+KNjpkgFMwdPYYElSj1Njw+CvBBIR3cEk6Ubu7hN2
	 rtwBs4u55cj42Da+07h8y8DupXiyJhCuqL4ekJtgDfg8pFwHvdsRPJtDgUDbzIrsTK
	 D6TKy8/aXmV/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/23] perf annotate-arm64: Enable instruction
 tracking support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-13-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-13-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:22:32 +0000
Message-Id: <20260808132233.5A8D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing bounds check on the secondary destination register (`dst->=
reg2`) leads to an out-of-bounds stack write in `update_insn_state_arm64()`.
- [Medium] Incorrect invalidation of base pointer type information during m=
emory store instructions in `update_insn_state_arm64()`.
--

--- Patch [12]: [PATCH v4 12/23] perf annotate-arm64: Enable instruction tr=
acking support ---
commit f55f5ca2b14376eae146cdb6373ed5a53a114257
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Enable instruction tracking support

Enable basic instruction tracking for arm64 by implementing three
essential functions in the find_data_type_block() call path.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 6b4f1228afa9b..44daa0176e512 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -353,6 +357,65 @@ static int extract_op_location_arm64(const struct ar=
ch *arch,

[ ... ]

> +	/*
> +	 * Invalidate destination register(s) for unsupported instructions to
> +	 * prevent stale type info from propagating to subsequent instructions.
> +	 */
> +	if (has_reg_type(state, dst->reg1)) {
> +		pr_debug_dtp("%s [%x] invalidate reg%d",
> +			     dl->ins.name, insn_offset, dst->reg1);
> +		invalidate_reg_state(&state->regs[dst->reg1]);

[Severity: Medium]
Does this incorrectly invalidate the base pointer type information during m=
emory
store instructions?

If dst->mem_ref is true (e.g., for a store instruction like str x1, [x0]),
this fallback lacks a !dst->mem_ref check. Will it incorrectly invalidate t=
he
extracted base register (x0), assuming it is being overwritten?

> +		if (dst->multi_regs) {
> +			pr_debug_dtp(" and reg%d", dst->reg2);
> +			invalidate_reg_state(&state->regs[dst->reg2]);

[Severity: High]
Can this cause an out-of-bounds write on the stack-allocated type_state
structure?

If an instruction parses with multiple registers where the second is invalid
(e.g., ldp x0, x99, [sp]), extract_op_location_arm64() sets op_loc->reg2
to a negative error code since it cannot find the register name.

Because there is no check for dst->reg2 >=3D 0 here, does this result in a
negative index being used for the regs array?

> +		}
> +		pr_debug_dtp("\n");
> +		return;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D12
