Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1624BBEB
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382481; cv=none; b=SPlwINIkuPA7Un17JWBtLIaN49AGpYSKx5XOv4vSrEZM6hf9xQjZgB1XfFfF36Qd5XTakVV97e3TAguDeVwK1EmEKtC2q1abTjbF6EOcMObiMCpb9BcUBxlLGEe9lkn5PHF6vZA7WdPz24IdtOVr49Q/CRGW2mtx05CJK9QUtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382481; c=relaxed/simple;
	bh=UnWjEw7kIT2Q8Vkhkj5BjADlbyqvpfjeuoF7OVfaaMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SlNPx3reFCq4/fTt6TMWkJWfYrHUubIawM+SzpKpxU8KkFODNnAu15sNwe68g248pF4JRyuaC5mucYdb5XWTayTAfGyb4gfHw77nuc4H1n4R2JGI+9RACI03NMvoH29F2+CEsUrW6HtruF93VPy+aQ3Ysa8C29VRcVbKbNLggk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNuHfglm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNuHfglm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6929D1F00893;
	Tue,  2 Jun 2026 06:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382480;
	bh=zLWPQ2m8Sn5F/Jk18NSey6N/1KPk360DXsLtMyxNkoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNuHfglm3T4g9kOXPdl8CufUecY95+NfA/k8jyXVfFckoglpJWJmeut2w4JmovheV
	 GhgBVXVI6ie0w/02VHmOpNwk3HgEHiyQloFsguPngCoAL3ooBJ/bD/t64fuJbXhITG
	 Y9Crk3OvZLIjcW8EMMr63/Rb9IRDgHWbuiVZj/Sfn9+VBv1YFSsEw+O47J5yDgfEEC
	 Xo/dTzUzA3HzHQEPidysDqMJ4lFI3M5sAi0iNXBjWQLgMecfGDFsoHvID80cIDE6wD
	 bogq+pOvnZhi2OKLTQ1uZPtQ+WzKSUqqfn7YAH+ntSKzUeelGMhxSDJEgXHMA4987B
	 btbfiIb0F/CAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/19] perf arch common: Use perf_env e_machine
 rather than arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-11-irogers@google.com>
References: <20260602062452.2583619-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:41:20 +0000
Message-Id: <20260602064120.6929D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] is_native_compatible() incorrectly skips bitness checks for arch=
itectures that share the same e_machine (e.g., MIPS, PARISC, S390), causing=
 32-bit hosts to erroneously attempt native disassembly of 64-bit targets.
- [Medium] Native SPARC64 profiling fails to resolve the system objdump pat=
h due to a flawed architecture matching condition.
--

commit 0ccc4649e16f322564aa71d657e01e2dc842077f
Author: Ian Rogers <irogers@google.com>

perf arch common: Use perf_env e_machine rather than arch

This commit changes the binutils path lookup to use the e_machine ELF const=
ant
rather than architecture string matching. It introduces is_native_compatible
to determine if the host can natively disassemble the target.

> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c

[ ... ]

> @@ -141,11 +146,40 @@ static int lookup_triplets(const char *const *tripl=
ets, const char *name)
>  	return -1;
>  }
> =20
> +static bool is_native_compatible(struct perf_env *env, uint16_t target, =
uint16_t host)
> +{
> +	if (target !=3D host) {
> +		/* A 64-bit host can natively disassemble its 32-bit compat architectu=
re */
> +		if (host =3D=3D EM_X86_64 && target =3D=3D EM_386)
> +			return true;
> +		if (host =3D=3D EM_AARCH64 && target =3D=3D EM_ARM)
> +			return true;
> +		if (host =3D=3D EM_PPC64 && target =3D=3D EM_PPC)
> +			return true;
> +		if (host =3D=3D EM_SPARCV9 && target =3D=3D EM_SPARC)
> +			return true;

[Severity: Medium]
Is this architecture matching condition reversed for SPARC?

When perf is built natively on a 64-bit SPARC system, EM_HOST is defined as
EM_SPARC, not EM_SPARCV9. When reading a native 64-bit SPARC perf.data file,
the target yields EM_SPARCV9.

Since host evaluates to EM_SPARC and target to EM_SPARCV9, this branch
appears unreachable.

Will this cause native SPARC64 profiling to incorrectly evaluate as a
cross-compilation environment and fail to resolve the system objdump?

> +		return false;
> +	}
> +
> +	/* target =3D=3D host case */
> +	if (target =3D=3D EM_RISCV) {
> +		bool target_is_64 =3D perf_env__kernel_is_64_bit(env);
> +		bool host_is_64 =3D (sizeof(void *) =3D=3D 8);
> +
> +		/* 32-bit host cannot natively disassemble 64-bit target */
> +		if (!host_is_64 && target_is_64)
> +			return false;
> +	}

[Severity: Medium]
Does this bitness check need to apply to other architectures?

Architectures like MIPS, PARISC, and S390 also share the same e_machine val=
ue
across 32-bit and 64-bit binaries.

By restricting this check strictly to EM_RISCV, could a 32-bit host for the=
se
other architectures erroneously attempt native disassembly of a 64-bit targ=
et
and fail to use the proper cross-compiler triplets?

> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D10
