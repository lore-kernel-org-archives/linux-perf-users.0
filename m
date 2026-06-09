Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76273383C95;
	Tue,  9 Jun 2026 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989574; cv=none; b=Eu+8PLcwaK/2I7lmX0o/TKknkw0gdnUV3ya1soTRN+KQQX/H7ZwgMA2rUsOaALjVAedL78VqnXWxnqDTk5kWndhoJ3e27Ns0q5chPNFmeulJdiQr9E8O/xIrd5/0AXdDqAI3nsq7sxAn0qXEaKbXSL8xZqPDFxpEa3Fwebvh7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989574; c=relaxed/simple;
	bh=GKkIzghRUvawjjfOojGCcFf75QcxZQ7q1x6mKvROcuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7EFpXIcFx1N7yCej3dIXN/640AUiRWK6zVecjhbRJx6qpoGCmkxx2nRwypyuCsqTQVfhse4Xnh80mfnvjkvuaFbq/h5ePQ7HYF2HpC5OgBAR1ZvgMmYgi8V5zVH4bOttA4qu4cqqbZpYvFRYvhzdEcDP68mmKdCWiXrPqyKVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9cRZFLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9cRZFLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4B51F00893;
	Tue,  9 Jun 2026 07:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989573;
	bh=NLfISVf0DomlokqTrNpIWP1QcMUzQTpfcFDPeJtYxmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9cRZFLi7aHk/BN05Riu4IcqlxRYS6QqJUZ0C0AvFMjxsGHxjmqqCeBl1KUSZ8TeG
	 TEBW6eAP8D5A7p1TGcXs+MhC1GAcXDDDKPp9GUzE500O88QYN+F1Hq8vPGZWy53Cob
	 OLh9qLZxSJStEBiMkyQTdnOi6tr/pxDIgxOdyuhEAppA0Oh7BVFGBMyW/tievx4DjL
	 OF3EJnQs59JrUY7zJuESvZxhe/+YrJjJxeQAoFhfb0babksImSZgOnV7IWqehrmvHi
	 HUvXChP1eNVjfLS3jh61R03JoCAv+KPi7co9UEgbhm+8dAV0tBZhzKCAvlOsQJ/sUs
	 QcEEjFWwwaCGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] perf build: Add build support and capability for
 elfutils libasm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609070732.545416-3-irogers@google.com>
References: <20260609070732.545416-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:19:32 +0000
Message-Id: <20260609071933.1F4B51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The LIBASM_DLOPEN build configuration is defined but completely =
lacks the corresponding C code to dynamically load the library.
- [Medium] Setting NO_LIBDW=3D1 fails to exclude libdw from the build, lead=
ing to unintended linkage and static build failures.
--

commit 2a3530a4ffc824890cb03d14fd777712b83cb02e
Author: Ian Rogers <irogers@google.com>

perf build: Add build support and capability for elfutils libasm

Configure perf build system to utilize the libasm feature check
(supporting both static and dynamic builds) and export the config flags.
Add "libasm" capability detection to perf check.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 6e7b15fab2ecc..8527d20f498f8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config

[ ... ]

> @@ -432,6 +439,7 @@ ifeq ($(feature-file-handle), 1)
>  endif
> =20
>  ifdef NO_LIBELF
> +  NO_LIBASM :=3D 1
>    NO_LIBDW :=3D 1
>    NO_LIBUNWIND :=3D 1
>    NO_LIBBPF :=3D 1

[ ... ]

> @@ -1060,6 +1068,20 @@ ifndef NO_CAPSTONE
>    endif
>  endif
> =20
> +ifndef NO_LIBASM
> +  $(call feature_check,libasm)
> +  ifeq ($(feature-libasm), 1)
> +    CFLAGS +=3D -DHAVE_LIBASM_SUPPORT $(LIBASM_CFLAGS)
> +    ifdef LIBASM_DLOPEN
> +      CFLAGS +=3D -DLIBASM_DLOPEN

[Severity: Medium]
Is there corresponding C code to handle the dlopen and dlsym wrappers for=20
libasm?

It looks like if LIBASM_DLOPEN is defined, the build skips linking libasm=20
directly. However, without the runtime dynamic loading implementation, won'=
t=20
this result in unresolved symbol linker errors when trying to build with=20
LIBASM_DLOPEN=3D1?

> +    else
> +      LDFLAGS +=3D $(LIBASM_LDFLAGS)
> +      EXTLIBS +=3D -lasm -ldw -lelf

[Severity: Medium]
If a user configures the build with NO_LIBDW=3D1 to avoid linking libdw, wo=
n't
this unconditional addition of -ldw override their request?

Setting NO_LIBDW=3D1 does not implicitly set NO_LIBASM=3D1. As a result, th=
e=20
libasm feature check still executes and forcibly appends -ldw to EXTLIBS.

For static builds, will this cause linker errors since NO_LIBDW=3D1 skips a=
dding
DWARFLIBS (like -lz and -lzstd) that libdw.a requires?

> +    endif
> +    $(call detected,CONFIG_LIBASM)
> +  endif
> +endif
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609070732.5454=
16-1-irogers@google.com?part=3D2
