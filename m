Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442347;
	b=M5y+sqwuMxdGhm2IxM6J5dmurqbzkn9VG5lfctTMZ773atkQMaYqU1cFNjS4gpgdh11R
	 elz5EnqhmI1aNhljm7VSkorAh7e/gch6Kb0c/WfzMf0fBH8x8jnVJwf5ep+BrlpXtEjAO
	 YPyDe3qz1ZOgHA3JUIfPiTkWykF2b9xNuFgAF9tXaL0XVF+2YttB35gSeft2Ga830yG4D
	 a/ZOnIPzN23IVAkcEGdQQtMDBbpU9TV/i38j7IYhUs0gmx+E7qmi49rQM1Mf3e8ONF5aP
	 Qhoo/Dv6ScTnpkvdg7oxRaN5DJdhV8Z26UPp5MaK7YZrOCb7vShruPlJu6GVhpad9Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=noGFPw65KQ2Yh86v4oa5I9kIAoIwJvDG+JpgPGKgNS8=;
	b=FiAHmLcbJKMxLmA/3s56EAWgYOjOXG6jgaqYMxXX118mqyDI+dAaGx/oJwWiEliyXUPH
	 87aVpsOFiyCVJFefDTa0u75ruj4JR9tcSCpy2TfmwVMxRnoLKjak5iY1qeAvBWL6jx+rq
	 Yg41BdcOZd+ehpqxMJ0g4u8vETL+sfPKjqgszxzPcOc9X6luK1sc0wZ/1Vgu972+EI+IZ
	 AzkoFqyZIFUACCuojhguK4xFG20nXMc3lvc2Isqd5wFvzzsXK3TQ7JQ+0WdBSakGDGNu9
	 /v+ZyTtSeVLDIf/YGvxhRuAm9x6AgNpUkIQZUf9TLrK6nxDK1EJtNhlNaO4UJZXSYsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1M6tPsW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F6606A319
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1M6tPsW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024901F000C4;
	Mon, 19 Oct 2026 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442347;
	bh=noGFPw65KQ2Yh86v4oa5I9kIAoIwJvDG+JpgPGKgNS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1M6tPsWmhVFLDN/o3yCGXLE+mVkFUBSS/3jg86ahL7pA8suQNVWDbEqpHdkNnE6K
	 JgoVVJA/ZScAp2Kd8dhbSb9EqzzX0fd+wxtjrtxIAMabT+Aj6rdDG9SM9z5mUmj8I+
	 vGmyEcqX9kXMPSqX9a2fjugoeWYqJ8Y//bd+sYVkuCmrLtsrsFIbs5o92P+Db7IefN
	 lY4odh+Zz/uixIBWxTgBwk0smxwMlIXRBV0uV0GcZJkJB0kEZlp2xrd3ffYv4+PduJ
	 W6Y358/dZ9gFiPhO4huV8TEF/NdaGsGpt5yjA5mD9nuuxswnCV+Eqatx+yf1azkyrS
	 dasHD3cU3uTBw==
Message-ID: <sashiko-outbox-178182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option
 for ARMv5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019201257.3805356-1-irogers@google.com>
References: <20261019201257.3805356-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:39:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vdso: VDSO_UNALIGNED_PACKED default omits non-ARMv5 strict-align=
ment targets
--

commit 1a3f0256f7d442ba6867246bd156ba9784b5b9a5
Author: Ian Rogers <irogers@google.com>

vdso: Add VDSO_UNALIGNED_PACKED config option for ARMv5

This commit adds CONFIG_VDSO_UNALIGNED_PACKED, defaulted to CPU_32v5, to
restore the packed struct implementation of __get_unaligned_t() and
__put_unaligned_t() on ARMv5 where GCC may emit out-of-line memcpy() calls
for __builtin_memcpy().

> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 597f5f0f96819..709eb193999fd 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -23,3 +23,11 @@ config VDSO_GETRANDOM
>  	select VDSO_DATASTORE
>  	help
>  	  Selected by architectures that support vDSO getrandom().
> +
> +config VDSO_UNALIGNED_PACKED
> +	bool
> +	default CPU_32v5
> +	help
> +	  Use packed structs rather than memcpy() in include/vdso/unaligned.h
> +	  for unaligned memory accesses. Enabled on ARMv5 where GCC may emit
> +	  out-of-line memcpy() calls instead of inlining byte accesses.

[Severity: Medium]
Does defaulting VDSO_UNALIGNED_PACKED only to CPU_32v5 leave out other
strict-alignment targets that experience the same GCC __builtin_memcpy()
regression from commit a339671db64b ("vdso: Switch get/put_unaligned() from
packed struct to memcpy()")?

include/linux/unaligned.h includes include/vdso/unaligned.h to define
get_unaligned() and put_unaligned() across the entire kernel and boot
decompressors. On strict-alignment targets, GCC cannot fold
__builtin_memcpy() into a scalar access when the pointer alignment is
smaller than the type alignment, resulting in stack spills or out-of-line
memcpy() calls instead of the register shifts generated for a __packed
struct access.

In arch/arm/Makefile, ARMv3, ARMv4, and ARMv4T targets use separate Kconfig
symbols without selecting CPU_32v5, and !CONFIG_MMU builds pass
-mno-unaligned-access:

    ifeq ($(CONFIG_MMU),)
    CFLAGS_ABI	+=3D-mno-unaligned-access
    endif
    ...
    arch-$(CONFIG_CPU_32v5)		:=3D-march=3Darmv5te
    arch-$(CONFIG_CPU_32v4T)	:=3D-march=3Darmv4t
    arch-$(CONFIG_CPU_32v4)		:=3D-march=3Darmv4
    arch-$(CONFIG_CPU_32v3)		:=3D-march=3Darmv3m

In arch/arm/Kconfig, hardware unaligned access support is distinguished via
HAVE_EFFICIENT_UNALIGNED_ACCESS:

    select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7)=
 && MMU

Should VDSO_UNALIGNED_PACKED default to !HAVE_EFFICIENT_UNALIGNED_ACCESS (or
could include/vdso/unaligned.h use a single __packed __may_alias definition)
so that ARMv3, ARMv4, ARMv4T, ARM !MMU, and other strict-alignment
architectures are covered as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019201257.3805=
356-1-irogers@google.com?part=3D1
