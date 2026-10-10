Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBF387566
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Oct 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657387; cv=none; b=YAPTiNI8ef/ICpw/KrQRsb48ik44Ujg08ma7souK1x2iQL5H3W7+RWf7XntS6kV98nGZGjEPCsjukLrfocT6Kv+NZlSRNr4pyXOI7hKXa142gug7z4JIYqi7uxuRLUVJqmnkXL3J3eMjpoHwt1lBXSiKjrs6yHOX9zlGs+j6ZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657387; c=relaxed/simple;
	bh=iN2HLzDzl5+MJt9ih6IeCETY0Uig4EFMyfLVYnJsm5M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c+3+1VL4cPemlwRT8TeVNQuiBxxGpaO/CvMB//qfSu2j/WO0H0Gg4JN4z6L6bpTLmbra6DnyHcf5e+lor2oA+krmI/CilA2xMfqkhnA2vUPpeW1HfIqh3ansHTWtPoQNqft+iIQ4PpOHNf/8OHTI242KYQDbml0+ZI6K6R2fN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emz6s3lz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emz6s3lz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57541F000FF;
	Sat, 10 Oct 2026 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791657378;
	bh=1E2rIl6adTCIBrfEJ8oYIA2pxqHb0q+EAXKjqVEKtoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emz6s3lzK1mAvl7q0JHTshynoFcT//6lzX4lk2Dmv1bdwoptOWjXujTOapw1pnzvu
	 +HsBnIQchp9wTzMyvH5KlqV+yocFMlhoiGTLjZ9Tia2eIceU2STHKDcIHpN7bE/rBd
	 p1bv6Zw8Mi9sQWYNV5dUiweHLw8hCV0Qg/OLqyAIJKRaKhze8sm0/DNIRBsBReSnqS
	 EPeNT3SCMwBbmapWvnE2o32mR+vhuBUNQ/8NE5tSV7/OY/9AFYmLceR5YjmlYxC15J
	 7W6o6HanB8XCdn7tOPfjsw4AVoTVbK7zj0WxW09OpPekjbSoyUNnW6sT6LG0wIA10I
	 H3WxkUHGG8veA==
Message-ID: <sashiko-outbox-166827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf symbol: Fix symbol loading from libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261010182439.9732-1-namhyung@kernel.org>
References: <20261010182439.9732-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 18:36:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: pe-file-parsing breaks due to dso__load_bfd_symbols()=
 return value change
--

commit 5ad4f779ca47fdb7586a43ebe4942962c3038922
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Fix symbol loading from libbfd

This commit modifies dso__load_bfd_symbols() to return a positive number
representing the number of loaded symbols instead of 0 on success. The call=
er
in dso__load() is also updated to check for this positive return value.

Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table with =
libbfd")

> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 33dc6158b2b1f..c2462b54b0e56 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -411,7 +411,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char=
 *debugfile)
>  	symbols__fixup_duplicate(dso__symbols(dso));
>  	dso__set_adjust_symbols(dso, true);
> =20
> -	err =3D 0;
> +	err =3D dso__has_symbols(dso);

[Severity: Medium]
Does this change break the pe-file-parsing perf test?

Looking at the pe-file-parsing test in tools/perf/tests/pe-file-parsing.c
inside run_dir(), it still expects the old 0 return value for success:

    ret =3D dso__load_bfd_symbols(dso, debugfile);
    TEST_ASSERT_VAL("Failed to load symbols", ret =3D=3D 0);

Since dso__has_symbols() evaluates to a positive number when symbols exist,
won't this cause the test suite to unconditionally fail when analyzing valid
PE files?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010182439.9732=
-1-namhyung@kernel.org?part=3D1
