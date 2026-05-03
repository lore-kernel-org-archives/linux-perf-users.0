Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804742A80
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768717; cv=none; b=XjpupY2dI6kgY5TtN37cnhnpYF5QQ0wWWwJbTJXAe4lHQBLzITFw5HUwVn1jBxkr6bDT12B/1KMml01AoYOiQaMinJZuhKkpox+RW9mZVKnrFK25Xn1ygw2wcsunqQ5uvrTvvUz+GR9LbE3LLPKUJziYNZIQCz+MESEeDdO60Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768717; c=relaxed/simple;
	bh=VFWMrDxD3spnRZQSkytC27dAhVxbpwsASccd1O8I3iI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BcV00ZERCUrCl+adZQIud2CfwKWjXwqDQyZzx6ua92h8NdoTxYlbSeH5LElsr/FJQbx9lkDQ2EJXk02PdXC/rFbcGlLnX1UElPaVdJewbrCRaILnFQMCi8cbWVhVow7BzHrh/RQlXxViv+qQC7S/dVWKhk4CjOwtjJOPf1rSOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7ldnzPk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7ldnzPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEE0C19425;
	Sun,  3 May 2026 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777768717;
	bh=VFWMrDxD3spnRZQSkytC27dAhVxbpwsASccd1O8I3iI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=G7ldnzPkZ8oZk+N0EYxrDa591dZ476s0A09btsglPThwdvPC/fNOR8plo7f4KxZI+
	 WwFTwbxItwfN9VR5Pk9z6Gv4n2r4fwUyk/sVnEYq+EIFYZFK6dcedhPZsNJ7dAX0Ws
	 3PTFtuu38NEBFocHKOVNoZ50/Eykt9wdEBFn0+xSC/taxUVSmLhg7OlryFoRN/vrjD
	 9doipMDMveohxsNmDQQ9VxavT67jzLlNBaUpX10FEoHoCTk/DAE8pIFfstEsLAuKMz
	 dz6BEKBuS8nra773vJgluRRgedxy04bS8QC14CyRHjLGPs0tFaN+VMoTlR/rd0GM7C
	 n/8jCfHkqI5VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/18] perf arch common: Use perf_env e_machine
 rather than arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-11-irogers@google.com>
References: <20260503002248.1040791-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 00:38:36 +0000
Message-Id: <20260503003837.2EEE0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Native objdump fallback breaks for cross-bitness profiling (e.g.=
, analyzing a 32-bit profile on a 64-bit host).
- [Medium] Unintended address space handling change for 32-bit SPARC.
--

commit ba683ab91ed0ab22877903f737b0057971f914b1
Author: Ian Rogers <irogers@google.com>

perf arch common: Use perf_env e_machine rather than arch

This commit updates the perf architecture matching logic to use e_machine
values instead of architecture strings.

> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 21836f70f231..1d8aff9b32d6 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
[ ... ]
> @@ -145,7 +150,8 @@ static int perf_env__lookup_binutils_path(struct perf=
_env *env,
[ ... ]
>  	/*
>  	 * We don't need to try to find objdump path for native system.
>  	 * Just use default binutils path (e.g.: "objdump").
>  	 */
> -	if (!strcmp(perf_env__arch(NULL), arch))
> +	if (e_machine =3D=3D EM_HOST)
>  		goto out;

Does this change break cross-bitness profiling on the same architecture
family?

Previously, perf_env__arch() normalized both 32-bit (EM_386) and 64-bit
(EM_X86_64) ELF machine types into a single family string like x86. This
allowed a 64-bit host to fall back to the native objdump when analyzing a
32-bit profile.

With the new check, EM_386 is not equal to EM_X86_64 for a 32-bit profile
on a 64-bit host, causing the check to fail. The code then attempts a tripl=
et
lookup, such as i686-pc-linux-gnu-objdump.=20

If these specific prefixed symlinks are not installed, will this trigger a
fatal ui__error and abort perf annotate, even though the native objdump
inherently supports multilib and 32-bit binaries?

[ ... ]
> @@ -237,5 +255,5 @@ int perf_env__lookup_objdump(struct perf_env *env, ch=
ar **path)
>   */
>  bool perf_env__single_address_space(struct perf_env *env)
>  {
> -	return strcmp(perf_env__arch(env), "sparc");
> +	return perf_env__e_machine(env, /*e_flags=3D*/NULL) !=3D EM_SPARCV9;
>  }

Is this an intended logic change for 32-bit SPARC?

Before this patch, perf_env__arch() mapped both 32-bit (EM_SPARC) and
64-bit (EM_SPARCV9) to sparc, so the strcmp returned 0 (false) for both
variants.=20

Now, the function evaluates to false for 64-bit SPARC (EM_SPARCV9) but
evaluates to true for 32-bit SPARC (EM_SPARC).

Could this unexpectedly alter address space separation for 32-bit SPARC
profiles?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D10
