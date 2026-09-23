Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3A3C65FD
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181373; cv=none; b=iOox5flPda5+yO1kdEc0XGbXCoaK046GLwiPQQAdZsAtu6lC5MyPYH1hSC7Y5Kx3NcYpDaqUgm56LCg+nug9cDvu8zzuvJUJ6QTg6XvPaaNYyGhj6hnI+PIpjkNU1eClted/dQVIuoGmKKC6JCIJWdDPQQF+VNPQDgTsQASS2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181373; c=relaxed/simple;
	bh=+fyNIB/gYv0EvAEnkv3ZVM5zlE/q5WWlZIh5Ef4Yuvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qlwW5P2Nz1yYqHjHDN6Zh7wyGbQRWJwT6D1Z5eTSNj4RE6kXZW0S9PMWRS+GpccQbhvneAcRbhCTIIGwmWaGT2zaXMPmqdnUj7mWzue+kpLDtblaCW8dBBkwrKK7unQ6c+Z4vQZn8eW5n6XGgTD0ybc1cGKp7VJ7D8JDeFQnmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+Dei9Fk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+Dei9Fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3962C1F000FF;
	Wed, 23 Sep 2026 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181365;
	bh=EyUFsfwa2c4xnlLGEHtpHcvWpLGcgQKXAWmbyOpVd+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+Dei9FkbH8d1r+a+YZSQJaLiYZzLHKVVQBVsiwpyYecEvTTBK7u67MFU9jmld2e1
	 OdtVsyFg6qD4NSZ2boZwXn2qEqMrTeUs2H6kRsS3/jb2oyjeJV4FL4lPPW/xfDNL09
	 1mxbUvUe1MDGmWpfwDY0ryFWuh3Fblq8XceFfOHDNNhtYs5rxrba2caUx0NH7wqZh1
	 /PSd32ztHxE6xcM+mucqjciHBTp9P0T3i4BamQjy8fJ2QHSBVLaHNfqDJZDLxCg2+z
	 RTx4iBHeuIbALF3AJszP+27sm4ISE4wymjv3RZfgJvzmT22ObVf/RwEplABbrQqN1o
	 5a1qvfzDNxb3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-10-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-10-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:36:04 +0000
Message-Id: <20260923163605.3962C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: miscalculation of ETMv3 SVC/HYP source addresses
--

commit 29b742481ea9116881bdfbed14f1f45c6d6ded76
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Synthesize exception entries separately from branches

This commit modifies the handling of ARM CoreSight ETM trace exception
entries, synthesizing them separately from branches. It derives exception
source PCs from the preferred return address rather than attributing the
exception to the last completed instruction.

> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf=
/util/cs-etm-decoder/cs-etm-decoder.c
> index 48e8c355a3e49..83a851bdd87bf 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c

[ ... ]

> @@ -524,8 +525,34 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue=
 *etmq,
>  	packet->exception_number =3D elem->exception_number;
>  	if (elem->context.el_valid)
>  		packet->el =3D elem->context.exception_level;
> -	if (elem->excep_ret_addr)
> -		packet->end_addr =3D elem->en_addr;
> +
> +	/* RESET has no defined preferred return address. */
> +	if (!elem->excep_ret_addr ||
> +	    packet->exception_number =3D=3D CS_ETMV4_EXC_RESET)
> +		return ret;
> +
> +	packet->end_addr =3D elem->en_addr;
> +
> +	/*
> +	 * T32 calls can be two or four bytes, requiring an instruction read
> +	 * before end_addr to determine their size. Keep end_addr for the
> +	 * frontend's SVC check and leave start_addr unknown for its fallback.
> +	 */
> +	if (packet->isa !=3D CS_ETM_ISA_A32 && packet->isa !=3D CS_ETM_ISA_A64)
> +		return ret;
> +
> +	/*
> +	 * For A32 and A64, exception calls execute a four-byte SVC, HVC or
> +	 * SMC and save the following PC. Other exceptions use the interrupted
> +	 * or faulting PC, including traps on those instructions.
> +	 *
> +	 * With a shared branch target, no instruction has completed
> +	 * at the target, so last_instr_size remains zero.
> +	 */
> +	if (elem->exception_number =3D=3D CS_ETMV4_EXC_CALL)

[Severity: Medium]
Does cs_etm_decoder__buffer_exception() miscalculate the instruction size f=
or
ETMv3 SVC and HYP call exceptions here?

By only checking against CS_ETMV4_EXC_CALL, it appears to miss the
corresponding ETMv3 call exception values (CS_ETMV3_EXC_SVC=3D10,
CS_ETMV3_EXC_HYP=3D3). When tracing ETMv3 with an SVC or HYP exception that
provides an excep_ret_addr, this would result in a 0-byte instruction size
and a misattributed source address in the trace output.

> +		last_instr_size =3D 4;
> +	packet->start_addr =3D packet->end_addr - last_instr_size;
> +	packet->last_instr_size =3D last_instr_size;
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D10
