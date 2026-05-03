Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214D18FDBE
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769485; cv=none; b=HGGlA7hrkFNZ+bQsQdFU+0xBwZsboaDXZ5XSR952wORdcHhcW/wu8N4LKT4GqwkXlSbWF8GNDs5hB+f/RBy9rS4t3jfUE4GAn4FyYs+JWLIWkow0rXs5LIQ+n/PuEzKugMrY5S2B7OKQLIyEXHk1U9hxJxQz0V1gOlG0TxJO55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769485; c=relaxed/simple;
	bh=CH+ARa4LL9OQdxcHxCJON/F/dRWQnuKSgw0oei3JHKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6JtnJOwDRaiiB6T3schlO6ilW63LXWbYfiMVNU2uash2MUxTIMF0y2FlBa0RSw+LYQQnB+Bx/qCXA2JjGe1D32zTm0NUhsu+VvYN/o9ba3CGcAZTVZBEK2gn8wU4ewmFPhCTsCnLKYqJgcVjCvXqIrclHzO2xSbOuqOpLDfbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3GiG2NW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3GiG2NW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109EAC19425;
	Sun,  3 May 2026 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777769485;
	bh=CH+ARa4LL9OQdxcHxCJON/F/dRWQnuKSgw0oei3JHKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k3GiG2NWp7S6KyteKJMroIrBy+rBpmzHlFk0gV6GDOII3yU6l7C1j+lYCRZkkO/bl
	 PnwveqLNYdE1utCV4eYe99S6P3E1tGoWK9fG0oqy2I5fLt9fzisrktCnAGgv6ViWhT
	 AKLYm793TRRgsxxvFTIphFvNa6yKLZ0XYpKg9VSEA44kKWqNldjuqOPTRkC8HcoZa5
	 A3eHOjUb6nPXwjYeQdg8xklLFiSCGgpSO9BgWoOUDipHFOBCcaOQt5FZ8PImtjCfxc
	 OKLxjXKHMAsupjQfztbiHMdnZDJrEbRjfYzQvpphUW/mymoJ/z4HsH0zzor6iQGg+e
	 OBfM82cHAxxKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/18] perf symbol: Avoid use of machine__is
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-7-irogers@google.com>
References: <20260503002248.1040791-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 00:51:24 +0000
Message-Id: <20260503005125.109EAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch completely fails to read the ELF machine architecture =
from the DSO for kernel objects, introducing a cross-architecture analysis =
regression.
--

commit 01fba2f5fba1a6782bc236fbef6a297cb4c04daf
Author: Ian Rogers <irogers@google.com>

perf symbol: Avoid use of machine__is

This commit switches to using the ELF machine from the dso or running
machine rather than the machine perf_env arch to avoid falling back on
EM_HOST and imprecise string comparisons.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b..a4b1f837a5a5 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -1428,7 +1444,7 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>  		free(new_node);
>  	}
> =20
> -	if (machine__is(machine, "x86_64")) {
> +	if (machine_or_dso_e_machine(machine, dso) =3D=3D EM_X86_64) {

Does this actually avoid falling back to EM_HOST for kernel objects?

Looking at dso__e_machine_endian(), kernel DSOs (like DSO_BINARY_TYPE__VMLI=
NUX,
KALLSYMS, and KCORE) skip reading the ELF header entirely and immediately
return perf_env__e_machine(machine->env).

Additionally, at this point in dso__load_kcore(), the DSO binary type has n=
ot
been set yet. It is set later in the function via dso__set_binary_type().
Because of this, it returns EM_NONE, causing machine_or_dso_e_machine() to
also fall back to perf_env__e_machine().

Since perf_env__e_machine_nocache() defaults to EM_HOST if the architecture=
 is
missing, analyzing a non-x86 perf.data file missing an architecture string =
on
an x86_64 host will evaluate to EM_X86_64.

Previously, machine__is() used perf_env__raw_arch(), which safely returned
"unknown" if the architecture was missing, preventing incorrect matches.

Could this change incorrectly trigger x86_64-specific trampoline mappings f=
or
non-x86 kernel objects?

>  		u64 addr;
> =20
>  		/*
>  		 * If one of the corresponding symbols is there, assume the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D6
