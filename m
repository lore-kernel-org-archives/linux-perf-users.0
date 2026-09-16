Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BD2253FC
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523643; cv=none; b=LkZvx1KxeiEgLnbxlq1yFglenOY6co4JkENR4nCGyIjjz/QpffG12Yx7KIeSeEIAizUefSJuiTz1fClOrHzkvL5Ze6lxQVgJdkOGo7Hk1BTpjtWso4ILRoaojoc3oQ+jos6A3V8mHjEQU2BBBm9DUCKoDKbGWW2e8UteceO7Skg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523643; c=relaxed/simple;
	bh=QcNTI4L4m++dgJhzrs3vR9Jx5duC2Ridc6i6ovyYIPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FEchzpNzUyWvbCChX1uHlgzuLXmfvcy4gY057dDWH/vToU+DHdHGqPzs6sGq6K2lhShJ8GvldRDpQGttq5XxShcUYPEryFVKfYLaRi+ikf/wY5rLpNdusvrQxEm+kinMLLos9wiCimeFthae2Ipk/jktcv2oA1gbBHxTHgiUfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPXihg4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPXihg4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2114B1F000FF;
	Wed, 16 Sep 2026 01:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523628;
	bh=cqv77EMDAhmJavU/P7C+ywvQXcms2djUDRF6Tlg/NJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPXihg4DLg/MNdU3ik9HVF8qSns7Rf7QsRVccGHeVmKtoGM1CLApIH5TTh0t2/w4+
	 OqVz+xF9012W4vZ3Wn/40L/wMuYpF+hB1OGfb4fX1czxVdK7DVX9XqpNGchhrHASmA
	 3thcVPyiaIwmXUcSo9MHaQW9H5ZRwseIWuvIW8hTNImfzZVmTNr7tco+Q+cOpfYV0o
	 cU6he2pSYT6BTavYPCWQiSsKZUcxPdmjQ84nz5KJZcgN9U001BG1I9wyC31zHlCo6U
	 3VBqh0TcMN8mHzlw6UjNd3CRh08m4ut56O6HacrnRmuzpnA2l8IIZ3STho05dQiGg/
	 azgQKO4g/K30w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 25/26] perf annotate-arm64: Support per-cpu variable
 access tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <735c23b4a55db2c67be4920792922550ff4f6409.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <735c23b4a55db2c67be4920792922550ff4f6409.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:53:47 +0000
Message-Id: <20260916015348.2114B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: retry mechanism fails for per-cpu variable loads
--

commit 0a8000b94df79930832d6fd4535fbe42f682b339
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support per-cpu variable access tracking

This commit extends update_insn_state_arm64() to handle per-cpu variable
addressing. It detects pairs resolving to the '__per_cpu_offset' symbol
and marks the destination register as TSR_KIND_PERCPU_BASE to propagate
type information during subsequent instructions.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index b25a3c70675c1..f4b7b0eb44f42 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -666,6 +677,12 @@ static int propagate_load_reg_state(struct type_stat=
e *state,
>  	}
> =20
>  load_non_regoff:
> +	/*
> +	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
> +	 * No special handling is needed here; just fall through to retry
> +	 * and resolve the type from the second register.
> +	 */
> +
>  	/* Try another register if any */
>  	if (src->multi_regs && src->reg1 !=3D src->reg2 && sreg !=3D src->reg2 =
&&
>  	    !(src->extend_type || src->shift_type)) {

[Severity: Medium]
Will this retry logic actually succeed for per-cpu variable loads?

Since both registers in the per-cpu load are non-constant
(TSR_KIND_PERCPU_BASE and TSR_KIND_GLOBAL_ADDR), arch_get_reg_offset()
returns -1 for both the initial attempt and the retry pass because it
requires the 'other' register in a multi-register operand to be
TSR_KIND_CONST.

Does this break the intended fallback logic here in
propagate_load_reg_state(), resulting in an unhandled -1 return and
silent type propagation failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D25
