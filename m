Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266D3FCC
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383631; cv=none; b=jXVKWHrrEBDJyf8ZrV5PSJkBfs801OwLSY8bxpAuPh7fJQd64MNzqtVVztgkCDDVDhGg/Fklz643VlPA5AgUM7N6FVUCGpiT7ckPTK7OiUQjAuUTZm62OETUmk2tqpyU7Trpn+7syHBcqHOTWY/7IU1Ga+mjZ73whK+rJvUTabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383631; c=relaxed/simple;
	bh=tBl8t5/6YZEDhi5tb5P315nJp5RkSvoIoyLaEcGtyH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7SvcNbIe4DlCMyIsLEHW7C84qSO5DzpVsBhghRv+ORLMv1TdcI+QXkZCFKnUZlIFLV+OEKH7SQSzlK9UHah9hJg4WxaKiPAw45QVwNAdCobRXYpvYH0ibKImWkSAD64H09sA1Ie55H4UvwcLNOuRSvggOIg9VBnrGKi07LxJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6GFC48x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6GFC48x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2931F00893;
	Tue,  2 Jun 2026 07:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780383630;
	bh=byxs6DPGTQExw0JSFreEhFJ9ws+ZywE8+AH7Nsh57AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b6GFC48xRdUv786r0EQhDFsnSC5Vpu4jcYHEplS/u1knx/BklreyzykhZwmNAVzco
	 cJp9q4/c3PDDxXXjZdm5wpXylOJt8aQoFXCORBc2Q+STf4ynk6ST1raiJpTiudRKgS
	 1r7Bu2Rwf5tfLgZKr+LRB5sMeE3C4jnwEPP91XaSj1oqtbKu07pE8kunao6i9+U6Cf
	 0xSv7t+UMJ+v/swqjqqgiW15g66bWzl7I0n8G6Whl6cPsl9TZLt3y7QqHL22GKZXL7
	 0Qurgcy2i8YrS5gWuHMwyp1Tmr1MXfAVZg8RPxT2Gaxi+GZAZX5VJij2Icda5hmWqh
	 EcZWDyMes1Q2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/19] perf env: Refactor perf_env__arch_strerrno
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-15-irogers@google.com>
References: <20260602062452.2583619-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:00:29 +0000
Message-Id: <20260602070029.DA2931F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message claims to hide the declaration if libtraceeve=
nt is not present, but the code removes the conditional compilation, exposi=
ng it unconditionally.
- [Low] Generated C code uses newer ELF machine constants (e.g., EM_LOONGAR=
CH, EM_CSKY) without fallback definitions, breaking the build on systems wi=
th older glibc.
--

commit 39cf4406b4f1694948ce536342e5558e9e7d0701
Author: Ian Rogers <irogers@google.com>

perf env: Refactor perf_env__arch_strerrno

This commit refactors perf_env__arch_strerrno to take an e_machine and an
errno value instead of an architecture string. It updates arch_errno_names.=
sh
to generate an e_machine to function mapping and alters the call sites
in builtin-trace.c to use the newly available e_machine.

> perf_env__arch_strerrno is only available with libtraceevent so hide
> the declaration if no libtraceevent.

[Severity: Medium]
The commit message mentions hiding the declaration when libtraceevent is
missing, but the patch actually removes the HAVE_LIBTRACEEVENT guards. Could
the commit message be more precise about the intent?

> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/tra=
ce/beauty/arch_errno_names.sh
> index d48d8561a7bb4..aae3d92a7893a 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh

[ ... ]

> @@ -52,21 +52,50 @@ process_arch()
>  		|IFS=3D, create_errno_lookup_func "$arch"
>  }
> =20
> +arch_to_e_machine()
> +{
> +	case "$1" in
> +	alpha)      printf '\tcase EM_ALPHA:\n' ;;
> +	arc)        printf '\tcase EM_ARC:\n' ;;
> +	arm)        printf '\tcase EM_ARM:\n' ;;
> +	arm64)      printf '\tcase EM_AARCH64:\n' ;;
> +	csky)       printf '\tcase EM_CSKY:\n' ;;
> +	hexagon)    printf '\tcase EM_HEXAGON:\n' ;;
> +	loongarch)  printf '\tcase EM_LOONGARCH:\n' ;;

[ ... ]

> @@ -74,6 +103,8 @@ cat <<EoHEADER
>  /* SPDX-License-Identifier: GPL-2.0 */
> =20
>  #include <string.h>
> +#include <stdint.h>
> +#include <elf.h>
> =20
>  EoHEADER

[Severity: Low]
Can this cause a build failure on systems with older glibc versions?

The script unconditionally outputs cases for newer ELF machine constants
like EM_CSKY and EM_LOONGARCH into the generated C code, relying solely
on the system elf.h.

If a host has an older glibc where these constants are not yet defined,
it would result in undeclared identifier errors. Is a fallback definition
or internal header needed here?

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index fae70b07ba8de..b41562fb06c63 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c

[ ... ]

> @@ -851,16 +851,11 @@ const char *perf_env__arch(struct perf_env *env)
>  	return arch;
>  }
> =20
> -const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused,=
 int err __maybe_unused)
> -{
> -#if defined(HAVE_LIBTRACEEVENT)
> -	if (env->arch_strerrno =3D=3D NULL)
> -		env->arch_strerrno =3D arch_syscalls__strerrno_function(perf_env__arch=
(env));
> +const char *arch_syscalls__strerrno(uint16_t e_machine, int err);
> =20
> -	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific=
 strerrno function";
> -#else
> -	return "!HAVE_LIBTRACEEVENT";
> -#endif
> +const char *perf_env__arch_strerrno(uint16_t e_machine, int err)
> +{
> +	return arch_syscalls__strerrno(e_machine, err);
>  }

[Severity: Medium]
Does this unintentionally expose perf_env__arch_strerrno unconditionally?

The commit message states the intent is to hide the declaration if there
is no libtraceevent, but this code removes the HAVE_LIBTRACEEVENT guards
entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D14
