Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63630674E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382319; cv=none; b=kyP82H3AmGP8gdBwx9rn1TJ8p4y9NlYKpLq/XeYVnznpEVZUgY/ixLnPrwjapTl+erbMNB1VcO6Bok4WuGhW/A97aJbSkjz6AMD1DILB0gGD8OHXY75K6fG80Zi+FivVv3vjW4NYaW0rcndsA24fgv4HNQud2TGytLGZukHKD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382319; c=relaxed/simple;
	bh=WwzVe0pGREdSlFGz6uH70qIRI84agH7vVc5zKX0hZGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bBiOeJsAY+A06yd11y6/7muK7Zkmc8vdC+VHJe2ZGlR96ol3zUij5EUPJrGHs1X7+xHjwb5NedxzIkqxZhEeFOIX9jEyjYCEXK85QhzAEClBfvgfYURpwGaAX7EdFKUu9Bw7THkZuOBZliHGEjHXkfbpW+D7JfI/sn/u+L49PQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMpwn/jE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMpwn/jE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F04B1F00893;
	Tue,  2 Jun 2026 06:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382318;
	bh=JDcr3UsHUqVYqxYfgZ1SSZYYGctNWda/pIA1uGLvfjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FMpwn/jEgOd5NjavbE9igUT58BsU+O2A0DSQ1zkV8hIhTSGah7yr6+MQWvpxIPZJ2
	 3HtW1mr3ErJ2sfiQ63uUAvzPWJggb43HMSanBG2k+v9rfBpXkpQdw9TDBWX4o3b8+w
	 YYajDG+aLpaZba7+so02BX60+0X6sk/XPFc+Ct2uKsVBsBZmVDBMaye+YyMdxl2TI8
	 1NXCWUIk5rQXcxCvVpJSfhaXR2jwjvqhkFC6IxbKf9/JuhL5jgEU5YOA2uxjNOF+s6
	 pDXYAxORInxglKlF9KQNhg36/EENvHjMn9cBKh81w5AJW28RCYy+WcVtHkdDzdKnwc
	 DCyaV8mocMM9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/19] perf capstone: Determine architecture from
 e_machine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-5-irogers@google.com>
References: <20260602062452.2583619-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:38:38 +0000
Message-Id: <20260602063838.7F04B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compiling `perf` with Capstone < 4.0 will fail with undeclared iden=
tifiers `CS_ARCH_RISCV` and `CS_MODE_RISCV*`.
--

commit 408e93bdddd7f0b1d7be6fe9fd0af6c070a4e302
Author: Ian Rogers <irogers@google.com>

perf capstone: Determine architecture from e_machine

Avoid the use of arch string that is imprecise and use the e_machine. Do
more e_machine to capstone machine translations adding MIPS and RISCV.
Remove unnecessary maybe_unused annotations.

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 25cf6e15ec272..5ad537fea4360 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c

[ ... ]

> +static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is=
_big_endian,
> +				  enum cs_arch *arch, enum cs_mode *mode)
> +{
> +	*mode =3D is_big_endian ? CS_MODE_BIG_ENDIAN : CS_MODE_LITTLE_ENDIAN;
> +
> +	switch (e_machine) {

[ ... ]

> +	case EM_SPARCV9:
> +		*arch =3D CS_ARCH_SPARC;
> +		*mode |=3D CS_MODE_V9;
> +		return true;
> +	case EM_RISCV:
> +		*arch =3D CS_ARCH_RISCV;
> +		*mode |=3D (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;

[Severity: Low]
Will compiling perf with Capstone versions older than 4.0 fail here?

Capstone introduced RISC-V support in version 4.0. Because the build system
feature test for Capstone in tools/build/feature/test-libcapstone.c only
checks for x86 support, it seems it will successfully compile with Capstone
3.0 and define HAVE_LIBCAPSTONE_SUPPORT.

If HAVE_LIBCAPSTONE_SUPPORT is defined but the system has Capstone 3.0,
using CS_ARCH_RISCV directly will cause a hard compiler error.

Should there be an updated feature test for Capstone 4.0, or version guards
around the RISC-V specific code?

> +		return true;
> +	default:
> +		return false;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D4
