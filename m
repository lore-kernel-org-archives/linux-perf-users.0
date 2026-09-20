Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37531175A9C
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872147; cv=none; b=HVpc5TyziEQiuDMbmUwQ0PcyXpbFzdB+rLg3ZpOIhDu690CN8lAeZPFs1KzHfwuDqs+49khRzhBgcSYGHkAJELHgPWfHKP9059Z3//ObIeTLWwzWXk9RRq2pASpHRhG0kVwADunfckHVQBkT22oZfFPXM4KAbyR2YHWzTe0OGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872147; c=relaxed/simple;
	bh=0Lu73IjFWnl0GDfWzBHyGTkelqeDAMYF0v/hUzcjGtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZxaTZKzZddxVey/M4LIkqE/YeqSm8TCU4s/xdQZGzDtJIhkE6NjkV6cCo4W89DNe4QKyJJYg79sVLprz7gWwzMO31DZscxhiHOxl11XSQnr3fa6ELy5pRa6Szuu8Njm/zgX9TlP8MQmZeMuuywm36MRYytIr56MNCtBiseonxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHUC4dtR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHUC4dtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EDC1F000FF;
	Sun, 20 Sep 2026 02:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789872145;
	bh=4bLk+DFrvLS0jHu0pXGQYV023/NKB/qIZl2Gvj3aVbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cHUC4dtRHDOQnJ4kSe5C3HiiMBo+qHHlHPlXEuvYAEqlcHrJxeHmO6sgAldLEcPo5
	 VOD7gFybP7EHc3MyiW0XXmGUVqutxp+Wpg+7JtobhAiyOgjZHN2fscdwpXeTV5BwH1
	 oXk+X28p0n30C3TW2M1YucYBi+4A8Wk128bv+7J2NcgrD0Ztyk7kMNSTdajZZPZ5BZ
	 ch3+cQ2FKpIHGUVzXDa4NEjPcb/uhFpgs/TaZgB+dFWAUKny/Paf5HM+HzFiFVcrk9
	 fZdA3n7SOA8LZdpd9zL+nnnhfSxjDX1q/WK+ZweGj8v64H7qJCyn2sqnQHthuqBiwl
	 iKrjq4x8nG7mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf symbols: Fix broken ELF_C_READ_MMAP
 fallback guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919-perf-symbol-memory-send-v2-1-495b8f00ad7c@uber.com>
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-1-495b8f00ad7c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:42:25 +0000
Message-Id: <20260920024225.94EDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: build failure on non-elfutils systems due to removed ELF_C_RE=
AD_MMAP fallback
--

commit 85681e93b31655f473355c4d4ba6288016a5ebcd
Author: Alireza Haghdoost <haghdoost@uber.com>

perf symbols: Fix broken ELF_C_READ_MMAP fallback guard

This commit removes the compile-time fallback guard for ELF_C_READ_MMAP,
relying on the assumption that perf already requires a recent elfutils vers=
ion
that provides this enumerator. It replaces the conditional definition with =
an
unconditional one.

> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index d0bac824c79c8..46b1649c64fc7 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -57,15 +57,7 @@ static inline bool is_livepatch_symbol(const char *str)
>  	return strstarts(str, KLP_SYM_PREFIX);
>  }
> =20
> -/*
> - * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
> - * for newer versions we can use mmap to reduce memory usage:
> - */
> -#ifdef ELF_C_READ_MMAP
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
> -#else
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ
> -#endif
> +#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP

[Severity: Low]
Does this unconditional reference cause a build failure on systems using
alternative libelf implementations?

ELF_C_READ_MMAP is an elfutils-specific extension and is undefined in
alternative implementations like elftoolchain, or in older libelf releases.

The perf build system verifies basic libelf support via test-libelf.c, which
only probes for ELF_C_READ. If a non-elfutils libelf is installed, the feat=
ure
test successfully passes and sets HAVE_LIBELF_SUPPORT.

When the compiler then evaluates symbol.h, the unconditional reference to
ELF_C_READ_MMAP will trigger an 'undeclared identifier' error.

Should this optional library extension be dynamically probed (e.g., via=20
test-libelf-mmap.c) and safely guarded with fallbacks to avoid breaking bui=
lds=20
on non-elfutils systems?

> =20
>  #ifdef HAVE_LIBELF_SUPPORT
>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-perf-symbo=
l-memory-send-v2-0-495b8f00ad7c@uber.com?part=3D1
