Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DD563FD0
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931022; cv=none; b=fkLHkjvirBcJFyyHQSMBABmOXLjHNSNL7k9a6Tpumr2aXzrBb+CfsrGH8lXdFXDRACngMh0cUV+IJ8ZVn/vxRF7Jms/GolVnAK7eZ5RrQJtVY9oHDT+fDuD69F3QTtW+U6OH6AVK8msrnN+c3ai7Npk2CvLQ8Qa9V9gefDy6Pvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931022; c=relaxed/simple;
	bh=3alItrpnDIZdaspx1TrIHy0QPG8GQacQmn6GzzFGUPg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uFemamS9ioEXmOSf1dhrx0e8F2iW5s4HY06aNHfmZIt0cvCDGqwsNdBMRUVDUotC8LsYyYo7zlZlPk1L+A+pin75MHzeUoBqSdu6NULc5/c/I29hDca3KG5As6nYyKz258fVsNuA6CZY/EQJnRnD8jtLZ2Dr45/3ntFQ8gTlOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHQ82Jnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHQ82Jnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895B11F000FF;
	Tue, 13 Oct 2026 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931019;
	bh=/fdtA/uznSm0vGiLAn4lj2z56QK0CIG6GQewr1CU6uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHQ82JnuB5S7e85JpRn+4iEU0naoLtQEVL81GqKxFhBCbZ4X6x/ApHy4YcTfFzH6/
	 +4RwyUD0Qoi8uIgOi1CyGJx4y4FCFAiVU6q53y6ng88Dbaowr53qPHeaWteuDvDVnJ
	 ylLY/Smbyf0xMIaTGfmtElNyrsJSEDZvBH55WoptTFvFmnWXi7ZQG8JMWC37fbbDez
	 QEOKTBP+WVDWpM+rluvwOj1Y/xw5Q2CKqtacVrXbxy+sQG9GO5W9US9kQ1oMc28fCR
	 ipQ8U8jW0rsn8kOdRwsC+EFONqlfoa2mGJUjw8+V+MTsop6Nf8Jiq5CfQpPOXzi4iv
	 WF0qJaaE0/bdg==
Message-ID: <sashiko-outbox-170585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-3-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:36:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] tools headers: missing Clang ASM_INPUT_G workarounds may cause b=
ad inline asm
- [Low] tools headers: missing __diag_clang_23 breaks __diag_ignore API
--

commit 2b6bac7c46f78e737bc9e5436ea6f3f62dcfe7d3
Author: Ian Rogers <irogers@google.com>

tools headers compiler: Synchronize compiler_types.h with the kernel sources
   =20
Synchronize the non-__KERNEL__ sections of
tools/include/linux/compiler_types.h and
tools/include/linux/compiler-gcc.h with the kernel sources (including
___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
__signed_scalar_typeof, __native_word, compiletime_assert, and the
__diag pragma helpers required by compiler-context-analysis.h), and
remove the duplicated definitions from tools/include/linux/compiler.h.

> diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/com=
piler-gcc.h
> index e20f98e14e814..9213691e8e097 100644
> --- a/tools/include/linux/compiler-gcc.h
> +++ b/tools/include/linux/compiler-gcc.h

[ ... ]

> @@ -33,10 +33,59 @@
>  #define __packed	__attribute__((packed))
>  #endif
>  #ifndef __noreturn
> -#define __noreturn	__attribute__((noreturn))
> +#define __noreturn	__attribute__((__noreturn__))
>  #endif
>  #ifndef __aligned
>  #define __aligned(x)	__attribute__((aligned(x)))
>  #endif
>  #define __printf(a, b)	__attribute__((format(printf, a, b)))
>  #define __scanf(a, b)	__attribute__((format(scanf, a, b)))
> +
> +/*
> + * Turn individual warnings and errors on and off locally, depending
> + * on version.
> + */
> +#define __diag_str1(s)		#s
> +#define __diag_str(s)		__diag_str1(s)
> +
> +#ifdef __clang__
> +#define __diag_clang(version, severity, s) \
> +	__diag_clang_ ## version(__diag_clang_ ## severity s)
> +
> +/* Severity used in pragma directives */
> +#define __diag_clang_ignore	ignored
> +#define __diag_clang_warn	warning
> +#define __diag_clang_error	error
> +
> +#define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
> +
> +#define __diag_clang_all(s)	__diag(s)
> +
> +#define __diag_ignore_all(option, comment) \
> +	__diag_clang(all, ignore, option)
> +

[Severity: Low]
Does this missing __diag_clang_23 definition cause a regression in the
__diag_ignore API for Clang?

It looks like __diag_GCC_8 was ported for GCC, but the equivalent
Clang-specific diagnostic ignore request was omitted.

Could this cause a compilation failure due to an undefined macro expansion
when a header uses __diag_ignore(clang, 23, ...) and is included by tools?

> +#define CC_HAS_TYPEOF_UNQUAL (__clang_major__ > 19 || (__clang_major__ =
=3D=3D 19 && __clang_minor__ > 0))
> +#else /* !__clang__ */
> +#define __diag_GCC(version, severity, s) \
> +	__diag_GCC_ ## version(__diag_GCC_ ## severity s)
> +

[ ... ]

> diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/c=
ompiler_types.h
> index b3adbf5682f02..31e9f7d2a466a 100644
> --- a/tools/include/linux/compiler_types.h
> +++ b/tools/include/linux/compiler_types.h

[ ... ]

> +/*
> + * Clang has trouble with constraints with multiple
> + * alternative behaviors ("g" , "rm" and "=3Drm").
> + */
> +#ifndef ASM_INPUT_G
> +  #define ASM_INPUT_G "g"
> +  #define ASM_INPUT_RM "rm"
> +  #define ASM_OUTPUT_RM "=3Drm"
> +#endif
> +

[Severity: Medium]
Will Clang incorrectly use these generic definitions and produce bad codegen
because the Clang-specific overrides ("ir" and "r") were omitted from the
port?

The kernel explicitly overrides these for Clang because of issues with "g"
or "rm" constraints.

Since those overrides are missing here, could tools utilizing kernel arch
headers end up with incorrect inline assembly behavior when built with Clan=
g?

> +#ifdef CONFIG_CC_HAS_ASM_INLINE
> +#define asm_inline asm __inline
> +#else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D2
