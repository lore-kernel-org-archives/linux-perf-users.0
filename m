Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DE4C9543;
	Tue,  9 Jun 2026 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030781; cv=none; b=XcPBM9T++4gqsMGDm2uIscGxj481y6jlTe9rfU8Zk1qPM8CFxIotIfo7MMprcLEtUjBmkZ//hQ4Hn2uluTCJDBBALYQpJqo3MQ1DQxYcEqBXoJ24J2OBaixbtyG0g5TCrySCFXfDJjmd3yMTUsuk8YaJPSYIVylMJnWYz1fmhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030781; c=relaxed/simple;
	bh=pAw9+f89Qrk9ps1V6Vhz9RJ4row8MZXODznclXWVHhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=np/GAmCjtPkyR50BU66MzwNYUsBgPtPvYn9mwfwwdSTnPj7p4MUkvBh7lL7HHjtWGJn5C7kWxRc+MIzprZS3VQiFN8n3xLxWC30TAv8sKVYooR3Z/qpl7QLm9t3Kznr+eX1kpy+fbhHoSjk0KN/GwKi3BDZL4NvhP6CB68nqdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epgCepHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epgCepHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104641F00893;
	Tue,  9 Jun 2026 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030780;
	bh=RjOQC7GIzyNw+YTMjqCGjizypR7RLw09IXuo01mvHrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=epgCepHeaPUGtRI5Ot/dksIvnZChPq3DJRDDnnk3WTIHMP1OyZxIxK1GBndRmcxNJ
	 5yp0x+VxVKq6eq3rM2ZeJ4DlevoMDFmhiGl/zjOUwlcQlqyUdIb4Es4vWoupIqROy8
	 6aDXRrRQELazUaVUsiPQuma0LYRogQifaM+jeOkzK2AT2oVIxTQMxUumw+IYj2Ux+D
	 DNTvZNWXELDNPr5QnnebpAwqFBQm1X9HcQl2G2xTAzG9YITpcUBsLru3NugPG7OP2j
	 ZpouTs/v+ybeu/irdNcKjHLTvEEizpCHOauNsqvt9ssjs/NP5bvMurdf09LaI1INIh
	 0BSKZCkj2729w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] tools build: Add feature check for elfutils
 libasm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609182108.975586-2-irogers@google.com>
References: <20260609182108.975586-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:46:19 +0000
Message-Id: <20260609184620.104641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] ASMLIBS is missing the -ldl dependency for static builds.
- [Medium] Passing NULL to an integer/boolean argument in disasm_begin trig=
gers implicit pointer-to-integer conversion errors.
--

commit 9ca40464008d6c950047c60bdb1b0966c47a038d
Author: Ian Rogers <irogers@google.com>

tools build: Add feature check for elfutils libasm

This commit introduces a build-time feature test for the elfutils libasm
library in the shared tools/build system. It adds the test program and
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
Will this fail to link during static builds?  Since libdw dynamically
loads backend modules via dlopen, it requires libdl.  DWARFLIBS above
correctly adds -ldl for static builds, but ASMLIBS omits it, which might
cause the feature test to fail and spuriously report libasm as unsupported.

> +
>  $(OUTPUT)test-libdw.bin:
>  	$(BUILD) $(DWLIBS)
> =20

[ ... ]

> diff --git a/tools/build/feature/test-libasm.c b/tools/build/feature/test=
-libasm.c
> new file mode 100644
> index 0000000000000..928fc46ecc755
> --- /dev/null
> +++ b/tools/build/feature/test-libasm.c

[ ... ]

> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stddef.h>
> +#include <elfutils/libasm.h>
> +#include <gelf.h>
> +
> +struct ebl;
> +extern struct ebl *ebl_openbackend(Elf *elf);
> +extern void ebl_closebackend(struct ebl *ebl);
> +
> +int main(void)
> +{
> +	Elf *elf =3D elf_begin(0, ELF_C_READ, NULL);
> +	struct ebl *ebl =3D ebl_openbackend(elf);
> +	DisasmCtx_t *ctx =3D disasm_begin(ebl, elf, NULL);

[Severity: Medium]
Will this fail to build on modern compilers?  The third argument to
disasm_begin() is typically a boolean or integer type (like show_bytes or
fd), but NULL is passed here.  This causes a -Wint-conversion warning,
which compilers like GCC 14 elevate to a hard error by default.  This
could cause the feature test to unconditionally fail.

> +
> +	disasm_end(ctx);
> +	ebl_closebackend(ebl);
> +	elf_end(elf);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609182108.9755=
86-1-irogers@google.com?part=3D1
