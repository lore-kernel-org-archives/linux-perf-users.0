Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B51A6808
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777708777; cv=none; b=Yzj0fpKrUtrnfAXcdKbuURAgNA84I2iBQfDtK/r4wTrrRxzuJT8pnH9xY9RY2PR5RJZL2K/ZKm80hK8JjswUjrHN+UYC9Lm9QPZOGrtHrCWhaxMznDlSf/KjStaHHpbaajhMvLNTjXvP7m+X8o08VyG6T7t8dolhtErmVUyvM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777708777; c=relaxed/simple;
	bh=41/NWyjsC0aU8zoxvUQMwzBE3JZsoMXEHCfjHU4W+48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sixmYxVgmnVb8eXSiHCHfrnDAGk48vW9Jywls0uxk5wFMY0tYREW0Flr7E5HvYc4TFUryk1/+hLkFqF5oJS5mlt3qy1YhjklVt7154GtjOZeEUTUMXkI9jh79HqfHMbpgbFPIauLq2ksaK7BQGVcm4duYzpCHj4iQgVlRW6D6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPFGVqLe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPFGVqLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27896C19425;
	Sat,  2 May 2026 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777708777;
	bh=41/NWyjsC0aU8zoxvUQMwzBE3JZsoMXEHCfjHU4W+48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iPFGVqLe4//VohePpgzwhzKnAKG/0X3fney2HKBOm48H/BRql8BddKYU0vwcRAU6h
	 vlozyhSwub/WdTS2JiVHThZMVgLDDmIyNQlJZ9szoIhiBItlZ4FGn6iBsW/44BJV+X
	 AZeydUC0DXzd04LGI5ZfvoRLRA9iZVA+dTrcaRFuMbHdn301LdehFAtorxmLBrC0Wq
	 UX+utpslJKB+JPTZ4Fm+DFnbkqVGjqeQ+Nq+DhAaLpZJFIx2yyq29bPuSb9V1e81jB
	 S0Kh8LZwjRlOESB+TVSo9xq5sZBC92GMKdzedMFzgXOrhBsk9pNqg4U3Gjvyz10uPG
	 u1GL/xVoI8Ohg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/17] perf arch common: Use perf_env e_machine
 rather than arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-10-irogers@google.com>
References: <20260502065935.291960-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:59:36 +0000
Message-Id: <20260502075937.27896C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Logic inversion in `perf_env__single_address_space` breaks kerne=
l/user address space resolution.
- [Medium] Exact `EM_HOST` check breaks native binutils fallback for 32-bit=
 profiling data on 64-bit hosts.
--

commit e2d5820d159463d4dd20c88669d8e471fefbb4c5
Author: Ian Rogers <irogers@google.com>

perf arch common: Use perf_env e_machine rather than arch

This patch replaces architecture string matching with ELF machine
constants in the perf architecture common code. It updates the
binutils path lookup and single address space checks to use
the e_machine values from the perf environment.

> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 21836f70f231..e9b5b61feffe 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c

[ ... ]

> @@ -145,7 +147,8 @@ static int perf_env__lookup_binutils_path(struct perf=
_env *env,
>  					  const char *name, char **path)
>  {

[ ... ]

>  	/*
>  	 * We don't need to try to find objdump path for native system.
>  	 * Just use default binutils path (e.g.: "objdump").
>  	 */
> -	if (!strcmp(perf_env__arch(NULL), arch))
> +	if (e_machine =3D=3D EM_HOST)
>  		goto out;

The previous check used perf_env__arch() which normalized both 32-bit and
64-bit variants to a single string like "x86". With the exact EM_HOST
comparison, if we are analyzing a 32-bit trace (EM_386) on a 64-bit host
(EM_X86_64), will this evaluate to false and skip the native fallback?

Could this regression cause the tool to wrongly search for a cross-compiler
prefix instead of successfully using the native multi-arch objdump?

[ ... ]

> @@ -237,5 +252,5 @@ int perf_env__lookup_objdump(struct perf_env *env, ch=
ar **path)
>   */
>  bool perf_env__single_address_space(struct perf_env *env)
>  {
> -	return strcmp(perf_env__arch(env), "sparc");
> +	return perf_env__e_machine(env, /*e_flags=3D*/NULL) =3D=3D EM_SPARC;
>  }

Does this introduce a logic inversion regression?

The original implementation using strcmp() evaluated to non-zero (true)
for non-SPARC architectures and zero (false) for SPARC. The new
implementation returns true only for SPARC and false for everything else.

Also, should this check include EM_SPARCV9 to properly handle 64-bit SPARC
traces, since the previous strcmp() against "sparc" would have matched the
normalized string for both?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D9
