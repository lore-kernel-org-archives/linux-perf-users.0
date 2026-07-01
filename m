Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13C376A19
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878731; cv=none; b=Suy572jS/Vh48Unrb4DtKGctSCGySgqHrRB1hPWJmw2rCEe44ph82GmHOb8e+Vu+YHfe/7abO+11zvCf9yXpCq2E3HfgAUv4VpX4XKkcF7WptdYSxlvVtwIzKHZCSTAIy6ACRwO/dbwAGWW4D//KqjtWbHW6gMEkig+Y60pMelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878731; c=relaxed/simple;
	bh=KtRnfzhytYoJUlA8ZwYntk/NsMX4+g69HzT91OAImlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qwbt6tTaAYwSzhoZSv3DFCO5Fjiv5EvwDDCGvy+mtVBK9i0AvQB9vAXJ6HC/7M0pnt/jaOo4pZBT8+p5Q7vHUSQA7MeyTzyaxIviePWONMbHqYEg69u38X1ZIPbzxMfLd2hY7VcXH1bnFQzxghod+oY3DusdE6T0K6DEk4m5g4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOnLTLQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOnLTLQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3F21F000E9;
	Wed,  1 Jul 2026 04:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878724;
	bh=V4W9Fyi8XbPObMHkExptb8xF3BxN+UFe991f6FIV0rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOnLTLQUOtaDpetdDYC8BFRxPxEn+xVer5gMYspMzizwy47FFObUXccBYmnAZvrvJ
	 FaZ3QuWPhz55FDJyBjd/tqdtgCXhgu2PnCwE+Pr6Q7FSMplMg0+ccKxboQyIV9V0Ya
	 UpFz/6zzmAe/qb0D48T2c2LsPZUgFVPmoTvAdxQv734IouI0I2Y2xiU7Sd3QCYp/cp
	 Se8XcZKQESDH6tnSqy5mDroUSFsZb6eH54zneDcHm+AmQt2PttBngxlt1S0jgMDexM
	 bUx2H/XIv41Yyxd6lK4wXcLpe4aVARX/d3bf8aBgFANeQx6tp6/dLZxDpFWI5Glwla
	 s1Z71i83+JFxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/21] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-4-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-4-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:05:24 +0000
Message-Id: <20260701040524.8D3F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of <string.h> for POSIX string functions.
--

commit c3571a268605b8e2ad28ebe5943729438021e5fe
Author: Tengda Wu <wutengda@huaweicloud.com>

perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump

This commit addresses an inconsistency between libllvm and objdump when
parsing arm64 'adrp' instructions. It extracts the target address during
callbacks and formats it as an absolute address with symbol names in
symbol__disassemble_llvm().

> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index a0deb742a7331..533d47e8084d7 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c

[ ... ]

> @@ -227,6 +241,42 @@ int symbol__disassemble_llvm(const char *filename, s=
truct symbol *sym,
>  				free(name);
>  			}
>  		}
> +		if (storage.pcrel_adrp_addr !=3D 0) {
> +			/*
> +			 * ADRP (Address Page) instructions encode a 21-bit signed
> +			 * immediate offset relative to the current PC's page.
> +			 *
> +			 * To maintain consistency with standard objdump output,
> +			 * we truncate the raw encoded immediate at the comma
> +			 * and replace it with the resolved absolute page address.
> +			 *
> +			 * Example conversion:
> +			 * From: adrp x18, 8014
> +			 * To:   adrp x18, ffff800081f5f000 <this_cpu_vector>
> +			 */
> +			char *name;
> +			char *s =3D strchr(disasm_buf, ',');

[Severity: Low]
Does this file need to explicitly include <string.h>?

This patch introduces a new use of strchr() here in
symbol__disassemble_llvm(), but tools/perf/util/llvm.c lacks a direct
inclusion of <string.h> at the top of the file.

While this might compile under glibc due to implicit header inclusion,
missing explicit POSIX headers can cause build failures on systems
using musl libc, which enforces strict namespace separation.

> +
> +			if (s =3D=3D NULL)
> +				goto err;
> +
> +			s++;
> +			*s =3D '\0';
> +			disasm_len =3D strlen(disasm_buf);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D3
