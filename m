Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957A352005;
	Tue,  9 Jun 2026 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982924; cv=none; b=c+7w1ZiNF61vFvqFzSc3B8UVH2KLWmF1H4RaR9vJdKBiGlHebMIGcQfjfmh8ZcWXUWD5p5aLvXdLLYQG3+SpgynZqbFLlPifowJb321hxhnxWpFb03l9kjxwx9u5JIluL2JnDPDXsbaOUe1srPnGcty4ftmxuI2zHEqwGibul7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982924; c=relaxed/simple;
	bh=rSfOuvMuiQmvcDnjgeINKStvcT2MwECgz6j/jCnDBLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ogdpQmXq7j9ImfUemdg50BUeCh1v8agpSJHb6ha7RpHYFeh0jtnzWtpCVMGTy5sZ8c1H/Mh24aSjBWjJgCGSMbkvjT7KSu9Sbn1MA+6jarjJk67ucGYJm/2MjI8NZzY5aPWFIJhs/YaovP48pZGy1HBhnKVTfpN4DTFdjWJBQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+r0acGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+r0acGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E3B1F00893;
	Tue,  9 Jun 2026 05:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780982922;
	bh=KH0HeRIykWF3xtZ+U/3q4wXCSE3EuithbvOm8aNa9qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+r0acGnEhzNZhjDbGr9RgJ5fR0LQdTuPCgbapAJYhNYFfGIPDR0Xnw6FKOO0rgYL
	 wnUneDvra9sl/vys0kwuo12Zy414/4mE61cN6FS5ikO1offpRQfH0lr5lY5qkM2B/o
	 MaISxzp8bxxSPL87K6lFzudIGTTpsJYQCpRbk1f4dIQLb4XOMNQrQe3e1mFfOeMD0I
	 f2q73DrxdpMNw7tlzFrCDiwm25ItJpXyzm/mhpIpZ+qT2diHf5+mIqV2BFZlWkMD32
	 QXVDOACtHMLjhza2os+TCK/yLK5f+c/6lwPvWUq3fF1BO/em47KPb/y2lggd10tpac
	 6LuMflAACiunw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] tools build: Add feature check for elfutils
 libasm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609051759.405027-2-irogers@google.com>
References: <20260609051759.405027-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:28:42 +0000
Message-Id: <20260609052842.78E3B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `ASMLIBS` definition lacks required dependencies (`-lebl` an=
d `-ldl`) for static builds and older `elfutils` versions, and relies on an=
 unexported symbol in newer versions, guaranteeing spurious feature test fa=
ilures.
- [Medium] Passing `NULL` to the third parameter of `disasm_begin` triggers=
 a `-Wint-conversion` error, spuriously failing the feature test.
--

commit aae74fddf97207e82eca20f4dc0b26d8dfeda751
Author: Ian Rogers <irogers@google.com>

tools build: Add feature check for elfutils libasm

This commit introduces a build-time feature test for the elfutils libasm
library in the shared tools/build system. It adds the test program and=20
updates the Makefiles to attempt building it to detect support.

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 62909a9c799d3..f0f39a2ab2035 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
[ ... ]
> @@ -184,6 +185,11 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
>    DWARFLIBS +=3D -ldl
>  endif
> =20
> +ASMLIBS :=3D -lasm -ldw -lelf
> +ifeq ($(findstring -static,${LDFLAGS}),-static)
> +  ASMLIBS +=3D -lz -llzma -lbz2 -lzstd
> +endif

[Severity: Medium]
Does this ASMLIBS definition miss required legacy dependencies? For static=
=20
builds on older elfutils versions, omitting -lebl and -ldl here might cause=
=20
the feature test to fail to link, silently disabling the libasm feature.

> diff --git a/tools/build/feature/test-libasm.c b/tools/build/feature/test=
-libasm.c
> new file mode 100644
> index 0000000000000..f3598ad1cc9e1
> --- /dev/null
> +++ b/tools/build/feature/test-libasm.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stddef.h>
> +#include <elfutils/libasm.h>
> +#include <gelf.h>
> +
> +typedef struct ebl Ebl;
> +extern Ebl *ebl_openbackend (Elf *elf);
> +extern void ebl_closebackend (Ebl *ebl);
> +
> +int main(void)
> +{
> +	Elf *elf =3D elf_begin(0, ELF_C_READ, NULL);
> +	Ebl *ebl =3D ebl_openbackend(elf);

[Severity: Medium]
Is it safe to rely on ebl_openbackend() here? Modern versions of elfutils=20
(>=3D 0.177) do not export ebl_openbackend dynamically. Could this cause=20
unintended linker errors and spuriously fail the feature test?

> +	DisasmCtx_t *ctx =3D disasm_begin(ebl, elf, NULL);

[Severity: Medium]
Does passing NULL as the third parameter here trigger a -Wint-conversion=20
compiler warning? Since the feature test is compiled with -Werror, expecting
an integer or boolean but receiving a pointer will cause a build failure=20
and silently disable the libasm feature.

> +	disasm_end(ctx);
> +	ebl_closebackend(ebl);
> +	elf_end(elf);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609051759.4050=
27-1-irogers@google.com?part=3D1
