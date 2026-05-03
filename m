Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BE2E3FE
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770713; cv=none; b=ZkFSCH9c8S8lMoF8a0J3l2hYTP+SQXUoczFTSxbWkBFQ5zMXD1/0pvID3xmMLvXAmivhxmDg1NPSjkS8UPd4VnC4zLi2b6W+FvQ90ELJ6VPOfiGZ9VR0miz/WzeXIeMf0+tKJvXp2hKH2qa4tgEIkRofH95dc47MbUx4F9hN75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770713; c=relaxed/simple;
	bh=r6c1jbZoKf0pvZ11wsVgrVwJU08CxX7PNyNo8MugPss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JRQIl2haEEl5PQJmpcGlD+HxKFkRroqOaEpSvuqDlLu6BWpUz112ejW/ff1kJqSZEdTOcyjmWrIY58ftDFze7J9ceLcBUvFX2BJYnPD3R7wVcWhC7Zm1aRKzkMFeFf8jOooyokj+6liJJGJXCeyhvkwCbJGGoGG9bsXv+xBKAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPy+aBb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPy+aBb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5F6C2BCB8;
	Sun,  3 May 2026 01:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770713;
	bh=r6c1jbZoKf0pvZ11wsVgrVwJU08CxX7PNyNo8MugPss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sPy+aBb29bwRR3wzH26Rv4LvH3xSOkTRH4QpN1Vbg8OujXQMFesZ9On9iHTJwaKoN
	 25weUXl2VqIZCfi1ZNRGModt47RDJslecsOBTr8JaZOyE4oA1IEFTZZLFFFkSAXZD3
	 NS3o+tH4bGAf9B7LfajWbLyuQQeWdQo1iVjzmBeKY338aGQ/oJeCcZXZ7H36n0kuCW
	 xlKqdKnVjv0QKbmIRnebGEzx/QFwowd6+9hoPrH+BTFLJB2yFK4OA+cTS7qSSRSQBq
	 G3yyXEikZdxNMGEGcZHceoW0UBS8kjm157TWGBmJ2i/Y5S506FbGK7T8mBiiA3wHMF
	 ufOKL7DFmjB2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 18/18] perf symbol: Lazily compute idle
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-19-irogers@google.com>
References: <20260503002248.1040791-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:11:52 +0000
Message-Id: <20260503011153.4C5F6C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unnecessary out-of-line function call `perf_env__e_machine` befo=
re the fast-path cache check in `symbol__is_idle` introduces measurable ove=
rhead on the `perf top` hot path.
--

commit 786c2d40f855657d57b68d17dcb788ab5ff93929
Author: Ian Rogers <irogers@google.com>

perf symbol: Lazily compute idle

This commit switches from an idle boolean to a helper function,
symbol__is_idle, to lazily compute whether a symbol is an idle function.
The computation now takes the machine's architecture and kernel version into
consideration.

Link: https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ib=
m.com/
Link: https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@=
126.com/

[ ... ]

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4702b8989354..2caa6b8b8609 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -760,55 +747,90 @@ int modules__parse(const char *filename, void *arg,
>  	return err;
>  }
> =20
> -bool symbol__is_idle(const struct symbol *sym)
> -{
> -	uint16_t flags =3D atomic_load(&sym->flags);
> -	uint16_t idle_val =3D (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_ID=
LE_SHIFT;
> -
> -	return idle_val =3D=3D SYMBOL_IDLE__IDLE;
> -}
> -
>  /*
>   * These are symbols in the kernel image, so make sure that
>   * sym is from a kernel DSO.
>   */
> -static bool symbol__compute_is_idle(const char *name)
> +static int sym_name_cmp(const void *a, const void *b)
> +{
> +	const char *name =3D a;
> +	const char *const *sym =3D b;
> +
> +	return strcmp(name, *sym);
> +}
> +
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct p=
erf_env *env)
>  {

[ ... ]

> +	const char *name =3D sym->name;
> +	uint16_t e_machine =3D perf_env__e_machine(env, /*e_flags=3D*/NULL);

Does calling perf_env__e_machine() before checking the cached idle_val
introduce unnecessary overhead on the perf top hot path?

Delaying the e_machine initialization until after the cache check below
might help avoid this out-of-line function call when the idle state is
already known.

> +
> +	{
> +		uint16_t flags =3D atomic_load(&sym->flags);
> +		uint16_t idle_val =3D (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_I=
DLE_SHIFT;
> +
> +		if (idle_val !=3D SYMBOL_IDLE__UNKNOWN)
> +			return idle_val =3D=3D SYMBOL_IDLE__IDLE;
> +	}
> +
> +	if (!dso || dso__kernel(dso) =3D=3D DSO_SPACE__USER) {
> +		symbol__set_idle(sym, /*idle=3D*/false);
> +		return false;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D18
