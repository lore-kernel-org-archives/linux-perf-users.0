Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470154652
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777706279; cv=none; b=Mk1iPPcwpnoTqYiRjSpZQC7hsjVWvgLtPrnyXMNc1tbFWScBWZn29i+vD9d8+Bm26e6eWvCnxiydPYDUpGSEvGVJAKiv/TAeb61jDa+PkofjmvvNaxn7l2UaTtyo5RoVvIazYx4K+2fvJVEHJsFDsazgBjMM+DmtXyGdb6tGB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777706279; c=relaxed/simple;
	bh=iA38AAqWKR92rjyvTQdougxLXVsJCVU5+Rw1ayFL2ag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4amQOPCBvv3uDFCgnpEbPglgEdkLzemEqcBRmPwt2/NMsHMlZ+UxofoRNtca0fxXGWunfIaLDFNZ9nG+/TYcYqORT/FFszKWGmiXKnYOhIXfy59JKK+Q/AbcjGh5Frpeg1k0lWbH0XxdGZRGezQmWyUJXLKLfVS+kV2jW7+3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiIb/+E5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiIb/+E5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668FAC19425;
	Sat,  2 May 2026 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777706278;
	bh=iA38AAqWKR92rjyvTQdougxLXVsJCVU5+Rw1ayFL2ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZiIb/+E5qX6Vc6ktJ6zldB1mHiMmKY+meT8PB62F1IsJUTykTiVVdbKVZ5sSCx9Hj
	 7tz3lONVgZgFBJg6T0HL1c/ySUXCnFZwqKzP6e6BGYeXeSc+6oSMhJYaGcSTFdiaOw
	 P7fTnQuhSEKyBLf/y1ubrwAuK/wcQB1oenAfgo0n3xsUsIzOhK6Q4yTI5ZmnO2QLey
	 nDQJm1naRBwhmqaJr1X+pSvYDdBYbLjt4eQpfZgbuV/np/VCh2ZQZNmAUW3OU5G9mO
	 FYGWxgKTXriTUTgpiTAlEJrPEseP3QPBpXS9HWSthWyEtJqX+dtt+tWQGGAeA9U2vz
	 YOOdSsen5vdhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/17] perf symbol: Avoid use of machine__is
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-9-irogers@google.com>
References: <20260502065935.291960-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:17:57 +0000
Message-Id: <20260502071758.668FAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] machine_or_dso_e_machine() incorrectly prioritizes the globally ca=
ched environment architecture over the DSO, and erroneously returns the hos=
t architecture (EM_HOST) for kernel traces.
--

commit ae1a01cb2104e12d0b084739b319fb08570b49d8
Author: Ian Rogers <irogers@google.com>

perf symbol: Avoid use of machine__is

This commit switches from using machine__is to checking the ELF machine
type from either the DSO or the running machine's environment. This aims
to use a more accurate architecture representation and avoid imprecise
string comparisons.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b..8aaaab0ad4b7 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -851,6 +851,24 @@ static int maps__split_kallsyms_for_kcore(struct map=
s *kmaps, struct dso *dso)
>  	return count;
>  }
> =20
> +static uint16_t machine_or_dso_e_machine(struct machine *machine, struct=
 dso *dso)
> +{
> +	uint16_t e_machine =3D EM_NONE;
> +
> +	/* Check for a cached value first. */
> +	if (machine && machine->env && machine->env->e_machine !=3D EM_NONE)
> +		return machine->env->e_machine;
> +
> +	/* DSO should be most accurate */

Does checking the globally cached environment architecture before the DSO
contradict the comment that the DSO should be most accurate?

If the environment architecture is already cached, won't this bypass the DSO
entirely and potentially break analysis of mixed-architecture user binaries?

> +	if (dso)
> +		e_machine =3D dso__e_machine(dso, machine, /*e_flags=3D*/NULL);
> +
> +	if (e_machine !=3D EM_NONE)
> +		return e_machine;

When dso__e_machine() is called for kernel DSOs, does it return the host
architecture (EM_HOST) of the machine running the perf tool?

If so, would returning this host architecture skip the fallback to
perf_env__e_machine(), causing cross-architecture analysis (like reading
an x86_64 trace on an ARM64 host) to fail checks like e_machine =3D=3D EM_X=
86_64?

> +
> +	return perf_env__e_machine(machine ? machine->env : NULL, /*e_flags=3D*=
/NULL);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D8
