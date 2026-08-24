Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184643E5A0E
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553437; cv=none; b=jYsvonu79t6qqtWJ7Oo4Gvabnbg3j/KWB/5DwXrbKhXjVYyFInIRnZIG89Bk/nfS+yaE0e8252KQCBWQOJiWdaJnWhdDuMbCpGVQ+HV/NEojgVkSKI7vbZIMGocM9/mauKFoz1FrxrOfyb1Lvk5/14YmLedfqWaWtFDQsIthBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553437; c=relaxed/simple;
	bh=Y4CkpkQ1f/o6zX59BMY7m23OJrfO9fCZ8DXPrNoGmJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QsbyJ2LSbMs1qe9BJoNulOwsVgZn70XfoaIRQC+AXxzfzHVaK1vafbLYgT7ONWpKAJXVL0r9XCRaZ7EjRor0d9Ev/FVn6f0GekI14ZDh836Ngex2xRIyInFDKLRODl9p0vFYgnODROnFEkcpYTldi7OhAwroTckrxR4pli6o4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjxuJ/gQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjxuJ/gQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685B31F000E9;
	Mon, 24 Aug 2026 06:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787553434;
	bh=mmT8uKgFvoKCrwtVLVlpgi6Ak58S2LJTNU+PU61IkfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjxuJ/gQ29cmB60tl5X5mJs3SE+fH8A9QLoRMdlS7BQWZBwGtSeWkXALRsXZe3/+8
	 PkrKIWF3OpjLwpBY+qOcb+Y4NLcH24uedzwwZ0mKBWTq/R8Msp4MuR+173a9UUqM3k
	 +j5/05jTPh0/Du1TTEdIfzGkfI4hYJZidHc81+LIK5/cmk5aNPpXTTGs0omDqD56fk
	 M5HvNmCZVbrBnthx73xSJUKfJGP0agevA4uFMCSSy6B5XuGRvQ+vPb2tmDEOmsR/IR
	 2JFXiFpe78dkbJnNYcDwXUdQMXLGDAS6e+8suJHDd5eb/SM1j5GGqtU6fonh13qUdi
	 US9VJaPovNKBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf libdw: Pass dso_name explicitly to properly
 anchor split-debug builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824062841.1529489-2-irogers@google.com>
References: <20260824062841.1529489-1-irogers@google.com>
 <20260824062841.1529489-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:37:13 +0000
Message-Id: <20260824063714.685B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] State caching bug in dso__libdw_dwfl ignores dso_name and breaks=
 split-debug resolution.
- [Low] Missing __maybe_unused attribute on the dso_name parameter in the l=
ibdw__addr2line() fallback stub.
--

--- Patch [1]: [PATCH v1 1/2] perf libdw: Pass dso_name explicitly to prope=
rly anchor split-debug builds ---
commit d6c05f5d9fb09508b13daaab6b752a240e96edf3
Author: Ian Rogers <irogers@google.com>

perf libdw: Pass dso_name explicitly to properly anchor split-debug builds

This commit modifies libdw__addr2line and dso__libdw_dwfl to accept an expl=
icit
dso_name parameter. It aims to accurately anchor libdw to the dynamically
discovered split-debug file instead of the stripped executable.

> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index 4ca7e7e4fbe93..f53caee980b0b 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c
> @@ -25,17 +25,17 @@ void dso__free_libdw(struct dso *dso)
>  	}
>  }
> =20
> -struct Dwfl *dso__libdw_dwfl(struct dso *dso)
> +struct Dwfl *dso__libdw_dwfl(struct dso *dso, const char *dso_name)
>  {
>  	Dwfl *dwfl =3D dso__libdw(dso);
> -	const char *dso_name;
>  	Dwfl_Module *mod;
>  	int fd;
> =20
>  	if (dwfl)
>  		return dwfl;

[Severity: Medium]
Does this early return prevent the newly passed dso_name from being used if=
 a
Dwfl object is already cached?

For example, in tools/perf/arch/powerpc/util/skip-callchain-idx.c,
check_return_addr() calls:

    dwfl =3D dso__libdw_dwfl(dso, NULL);

This early call passes NULL for dso_name, which caches the stripped executa=
ble's
Dwfl. When get_srcline() later calls libdw__addr2line() with the newly
discovered split-debug file, won't this early return just provide the alrea=
dy
cached stripped executable's Dwfl and ignore the passed split-debug dso_nam=
e?

[ ... ]
> diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> index b120947374159..4bdd28d44e25e 100644
> --- a/tools/perf/util/libdw.h
> +++ b/tools/perf/util/libdw.h
[ ... ]
> @@ -40,7 +40,8 @@ void dso__free_libdw(struct dso *dso);
> =20
>  #else /* HAVE_LIBDW_SUPPORT */
> =20
> -static inline int libdw__addr2line(u64 addr __maybe_unused, char **file =
__maybe_unused,
> +static inline int libdw__addr2line(const char *dso_name, u64 addr __mayb=
e_unused,
> +				   char **file __maybe_unused,

[Severity: Low]
Will this cause a build failure when compiling with HAVE_LIBDW_SUPPORT disa=
bled
(e.g., NO_LIBDW=3D1)? The fallback stub introduces the dso_name parameter b=
ut
doesn't use it, and lacks the __maybe_unused attribute present on the other
unused parameters in the same signature.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824062841.1529=
489-1-irogers@google.com?part=3D1
