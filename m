Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137ED3D8132
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744306; cv=none; b=G8nxqA+vP2szT+W1dKI9Y0v91V7ba4fP5gjr+vFuVkMdY8qW0KU9cZuYU4ftS/MKbGX0O8kkBLJiXzFePsF1MKwP4ZwpJinWTaWZR5jy+qCwx5Cb4qYCSMaaCflIZzw+nTEO+A6sh7dgPbTgh5Sa0lLoErJuaj5AlKWQTzbST/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744306; c=relaxed/simple;
	bh=Fd/Hg0lpB0LsMtANmfuOIBHjYj0tweUvCFa4SIonkWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XIeNuJckbhmEEaUHcN2KtTD00mSRtGxMEbJufzG3G6kzpz7eXBR1HGPRJhtRuwRAa46BiRilog+jnojt4gtyFJSeFImhosL5s+tTGyGqsotppXhBO6ZFWN7qQC0V1bC7B0cGMn3A3bkURZdtKMhH9OV+XKQZywskA/syIzM1MHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZPVoi+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZPVoi+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CE8C2BCC6;
	Thu, 14 May 2026 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778744305;
	bh=Fd/Hg0lpB0LsMtANmfuOIBHjYj0tweUvCFa4SIonkWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dZPVoi+6wicrFOHX/m1TfOf5roO7uBcAkcl7RRmYVzHGZwtOM75d64BEhlC9kB8YA
	 09bgjduJXYUDvQrdyw3sSf7G8Fn1s84VVmKcnfRC6+1nUFCCMOukYJZVqvejWpCCXt
	 HTEsz2m+AjvZ4VuNIV7C9FTS5iEuBdD/jU88ilHoG7q4E4Yt7RaZELCJIDlx8RF85B
	 qSuFWH01KSGmq7mgjH2CkFRCDeg6uQEMC1sih1Z673UZ/SOGBboOSPtVwENd6aCqai
	 dHLzJh2Q3GO+n5OMbUqoPjznM0gH3FWl+vCH7d+sK96rtCbok/OFK4RuDxvVbMfmoB
	 u5ssaM1WRk43Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf riscv: Fix discarded const qualifier error in
 _get_field()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Guan" <guanli.oerv@isrc.iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
References: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 07:38:25 +0000
Message-Id: <20260514073825.95CE8C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Deterministic NULL pointer dereference in `get_cpuid()` when `/pro=
c/cpuinfo` parsing fails.
- [Low] The patch resolves a const-qualifier warning by forcefully casting =
to `(char *)` instead of using const-correct variable types.
--

commit 5d7d955a53ac900eccabdb8ae292dcf199883310
Author: Li Guan <guanli.oerv@isrc.iscas.ac.cn>

perf riscv: Fix discarded const qualifier error in _get_field()

This commit addresses a build failure on GCC 14 caused by strict type check=
ing
on pointer assignments. It resolves the discarded-qualifiers warning by
explicitly casting the return values of strrchr() to a (char *).

> diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/=
util/header.c
> index 4b839203d4a54..d01ba64aecfd5 100644
> --- a/tools/perf/arch/riscv/util/header.c
> +++ b/tools/perf/arch/riscv/util/header.c
> @@ -21,12 +21,12 @@ static char *_get_field(const char *line)
>  {
>  	char *line2, *nl;
> =20
> -	line2 =3D strrchr(line, ' ');
> +	line2 =3D (char *)strrchr(line, ' ');

Would it be better to declare line2 and nl as const char * rather than
forcefully casting away the const qualifier?

Since these variables are only used for pointer arithmetic and passed to
strndup() (which accepts a const char *), propagating the const qualifier
would prevent bypassing the compiler safety checks.

>  	if (!line2)
>  		return NULL;
> =20
>  	line2++;
> -	nl =3D strrchr(line, '\n');
> +	nl =3D (char *)strrchr(line, '\n');
>  	if (!nl)
>  		return NULL;

While reviewing this file, I also noticed a pre-existing issue in the
get_cpuid() function:

tools/perf/arch/riscv/util/header.c:get_cpuid() {
	char *cpuid =3D _get_cpuid();
	int ret =3D 0;

	if (sz < strlen(cpuid)) {
		ret =3D -EINVAL;
		goto free;
	}
...
}

Can this unconditional call to strlen() cause a segmentation fault if
_get_cpuid() returns NULL?

If _get_cpuid() fails to open /proc/cpuinfo or cannot find the expected
fields (mvendorid, marchid, mimpid), it will return NULL. Passing that NULL
pointer to strlen() would cause the tool to crash in environments without
/proc mounted or on older RISC-V kernels.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513154851.1085=
334-1-guanli.oerv@isrc.iscas.ac.cn?part=3D2
