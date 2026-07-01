Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FF383320
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879011; cv=none; b=tvGat/O6oWVzw7GXZImZ88NNMwqDKwrUlDsxg4Ubqq+yQo3X729Y2WU2Jop6dr55aJ3i2d0bNlKMvOjwLWcqIfmJKs6ftSwZhEV1sr+oxpTElyD3uzWPcOK7zgbMJdS+icO4eWMbig89Is9NAFkoQaROAbE/k2uXaQp1h6BncjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879011; c=relaxed/simple;
	bh=vx9swL6/DBEkEIGsKzpMX9knWqp03gMecmlIUhGe23A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I0IL3c8aR2ui6/HOWMVtY4RtTNTuJgVXTARrPOyPYROE5HtkhILS/bDX7B4aH4ZsmIDuDsQ2/okkLQMfH2fZKjSbXJTcETV/CTKXiNl4s6JRiY+fXrzoIis5FAFSMn1/uBqe7dsFy1wMW7er0Q6ZrhcpaPtFbomPDvvfPFMs94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDrGGxUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDrGGxUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBC31F000E9;
	Wed,  1 Jul 2026 04:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782879003;
	bh=jIYLOJGrpkLvrq+ZgCPEl718oWcxmW54IBhB7qhhpKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDrGGxUOBsMCaOzDFujKmI+RLJiPvBYI6n+mIx1YErFzMxAzK9H+23V8HjJOUq1Oh
	 mfrgAOUuA3Dyxdxocx6rk4kv49za/iGpQU7NXVhUlhhPzqn3ryriW5VaiIcy4cPMwt
	 +MvELXFxbIbizjPwzKrOeNuBK7fqglSEVkzncwM2xUjZIsiRS6buTkbI3ZR4NC41hQ
	 1Kb3OpeLGWvzUWxk7TLgrWfXt0cjK9yMt+PcT0dNsKRSBUAHAzaRNb9TGttUBj5+nK
	 eLW0EehtzP5AOzw6Yg4tAFPw5OIwDxMEpYmK13FZOqj4akS4HTLyZSJZ/g7S7eSevb
	 FrAQ6HUkbbJDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/21] perf annotate-arm64: Implement
 extract_op_location() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-10-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-10-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:10:02 +0000
Message-Id: <20260701041002.EBBC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Post-index memory references with register offsets are incorrect=
ly classified as SIGNED_OFFSET.
--

commit 1b03950d2edd24d57bf3a7ad6271aea1980c92e3
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Implement extract_op_location() callback

Implement the extract_op_location() callback for the arm64 architecture
to handle its specific assembly syntax and addressing modes, enabling data
type profiling for this architecture.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 451500def8c12..77b6f4841c849 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> +static int extract_op_location_arm64(const struct arch *arch,
> +				     struct disasm_line *dl __maybe_unused,
> +				     const char *op_str, int op_idx __maybe_unused,
> +				     struct annotated_op_loc *op_loc)
> +{
> +	const char *s =3D op_str;
> +	char *p =3D NULL;
> +
> +	if (op_str =3D=3D NULL)
> +		return 0;
[ ... ]
> +	/*
> +	 * Handle memory references (e.g., [x0, #8]), identify
> +	 * arm64 specific addressing modes
> +	 */
> +	if (*s =3D=3D arch->objdump.memory_ref_char) {
> +		op_loc->mem_ref =3D true;
> +
> +		p =3D strchr(s, ']');
> +		if (p =3D=3D NULL)
> +			return -1;
> +
> +		/* Pre-index: [base, #imm]! */
> +		if (p[1] =3D=3D '!')
> +			op_loc->addr_mode =3D PERF_ADDR_MODE_PRE_INDEX;
> +		/* Post-index: [base], #imm */
> +		else if (p[1] =3D=3D ',' && strchr(p + 1, arch->objdump.imm_char))
> +			op_loc->addr_mode =3D PERF_ADDR_MODE_POST_INDEX;

[Severity: Medium]
Does this incorrectly restrict post-index addressing classification to only
immediate offsets?

In ARM64, a comma immediately following the closing bracket (p[1] =3D=3D ',=
') is
sufficient to identify a post-index addressing mode, regardless of whether
the offset is an immediate or a register (for example, Advanced SIMD
instructions like ld1 {v0.16b}, [x2], x5).

If the condition fails for register offsets, it appears it will incorrectly
fall through to PERF_ADDR_MODE_SIGNED_OFFSET. Could this cause the base
register write-back to be silently ignored in adjust_reg_index_state(),
leading to stale and corrupted type state tracking for the base register?

> +		/* Signed offset: [base{, #imm}] */
> +		else
> +			op_loc->addr_mode =3D PERF_ADDR_MODE_SIGNED_OFFSET;
> +
> +		s++;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D9
