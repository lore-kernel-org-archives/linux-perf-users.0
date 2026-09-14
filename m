Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBE245020
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351460; cv=none; b=ElPegLeKhrlkuEWLB3+JggS1tDBLDbIY5kfiRMySugAoFaLX7SdzqTD7wW/A4OQ9GrvxgrNoVxyRjskai7+RUsp0eqYix7tbfM4iu1QexpxTBeGqYh4CI4qkZAicqlE+XCGuC4AFvHkXkttjocmrLxwOkQWzFiqrTuQyqhvqL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351460; c=relaxed/simple;
	bh=4bzdvzr39TGMRQtLLTDwZ2VO8YKDT64lT8BzG56nvP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+xvCXgECFumYBez+gtgf0hHuN3d5oVew4+rxxJs4ycRjZB0+NKIsawVNStvzmmx8co7Poz3KrtvIQ3NHqfz+WRtMTvS6jDG47R7Pb5h1Wb1pD5kWCEfMSiKetzlAut9nesmCVBLH1GcGp/p+oNRmx9XCQXvB6W4QdrJgIQVFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgQQ1LkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgQQ1LkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E881F000FF;
	Mon, 14 Sep 2026 02:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789351458;
	bh=Uz+3XRtgvPugut4R7dovhq/JGD23Ev97SLjVBS9kJ0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EgQQ1LkKd2CmwXwEv8xFOsUJ7jeULBE6WwdTtb56OapuPCd6qASWqzbPsALFBLnte
	 GWKyGR410rkpA9m8jY5LAjWNVscFN88DA+5U17LeXTraOcQGIU3CiJp+HPR0MYR1cs
	 746GZAqiLq6QpK006eVl4FlqDV9AG8sNzbfGpJvmOCscNgU0V0Fluh1iNqaYC5vYGH
	 /85Lx4Cwa8PH6lEyYfvr9SUcgt+mxv7mQZdWJcbnexGCPqTG2YdNm03ufghpMuycG7
	 jkexH+JUPYe56XskR48HpsWrFZKnettsIPXTa4gRuQ6hygzNtWe8sHtCOQs0fCou1W
	 SAPP9FPPPdOrg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 07/10] perf regs: Enable dumping of SIMD registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:04:18 +0000
Message-Id: <20260914020418.97E881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit `<stdio.h>` inclusion for `printf` usage, which ca=
n cause musl build failures.
--

commit a307c3e7165562ef96094cdee1fc722a99865e02
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Enable dumping of SIMD registers

This commit adds support for dumping SIMD registers with the new
PERF_SAMPLE_REGS_ABI_SIMD ABI. It currently supports XMM, YMM, ZMM,
OPMASK, eGPRs, and SSP registers on x86 platforms.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 90d4e45f09f08..a5b596cd14be6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1446,6 +1446,86 @@ static void regs_dump__printf(u64 mask, struct reg=
s_dump *regs,
>  	}
>  }
> =20
> +static void simd_regs_dump__printf(uint16_t e_machine, struct regs_dump =
*regs, bool intr)
> +{
> +	const char *name =3D "unknown";
> +	const char *simd_header;
> +	u32 i, j, idx, pred_base;
> +	uint16_t qwords;
> +	int reg_c;
> +
> +	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
> +		return;
> +
> +	if (!regs->nr_vectors && !regs->nr_pred)
> +		return;
> +
> +	simd_header =3D "... SIMD ABI nr_vectors %" PRIu64 " vector_qwords %" P=
RIu64 \
> +		      " nr_pred %" PRIu64 "  pred_qwords %" PRIu64 "\n";
> +	printf(simd_header, regs->nr_vectors, regs->vector_qwords,
> +	       regs->nr_pred, regs->pred_qwords);

[Severity: Low]
Does this file need an explicit inclusion of <stdio.h>?

The perf tool can be compiled with musl libc, which enforces strict POSIX
namespace separation and does not implicitly include headers. Relying on
implicit header inclusion for printf() can cause build failures under musl.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D7
