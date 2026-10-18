Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFE3ECBC7
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341871; cv=none; b=uLs9UlwsjlFRIaNNZfb/VMd+RIGl5Qi2oGEXnjrmGtx2YuJliP8ts4xSXUg2NGbvMGHgBx4WH9NpAPsUTYREjBWszKfGuTZxLwWIJPrXM6X42gQYcPrFp1qUpVdHmYCVydDiKx9nfei/sqiGu/HN7ychUeD73dl9L7d3AX9z388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341871; c=relaxed/simple;
	bh=LxCVwuenPzpu/i6bVL/bfWAdYYvUGSKoJwuVi7ymAMw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uUHHkRpbaSWaqGMdLLLO2RtqNMM02DBIO1Yj+NDmLc2Mzl/hr0YA1KDBm8++WMf0wkbx6tIPliEBQDWeDoKtRa4snlxbwW8XR1gww6qiPryUitiFc2LhMgOJgK9B2eRCO4/+eTJQDgqeeJRlfn5I/FYiTgyHZv7kwBFSg4XjqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F37RQ3ZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F37RQ3ZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C434F1F000C4;
	Sun, 18 Oct 2026 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341866;
	bh=m9jNWQirugswcifmB/7hWnO8eSvDuDVjjwyQY2GxaaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F37RQ3ZJmkKJB//NDTaKoF9Nv8Cy+2EyjUC9LZ5+1DIO2zllLfmW0+Uvj+JYTmx+A
	 NOCpCQg2G5f+urza2FWtzfMKsD7eR60kM982AnRTfRlm3/D3oIMPDuCisBY4jx2sVz
	 wEPv/Y1pt/NpqrGRnxIoxFqmXqOiZYVYvVFji+tUS4QTFLUwfdCvvvV+JzSMBeg11p
	 o6+BQWraualteUDiPejNPycjcEWoaIai96Sl6aAPXHaPUXXXilvr5sdVgaVcd27AsQ
	 o5GSAL6PE94dzqBMBpSiRL34kdS2gYlEUO8bTWVN4yFIGlCR15zM7XmpybpWGH+uuA
	 SYgPkouAOWeew==
Message-ID: <sashiko-outbox-176289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] perf symbol: Ensure dso__set_is_64_bit() for
 libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018163741.850434-5-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
 <20261018163741.850434-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:44:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf symbol: bfd_get_arch_size() always returns -1 in dso__load_=
bfd_symbols()
--

commit 6d3220ac244766831d73c524c0b8f5184af28a7b
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Ensure dso__set_is_64_bit() for libbfd

This commit calls dso__set_is_64_bit() using bfd_get_arch_size() when
loading symbols via libbfd in dso__load_bfd_symbols().

> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index a4dcb406c79e9..9cc6216ce3adb 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -462,6 +462,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char=
 *debugfile)
>  	symbols__fixup_end(dso__symbols(dso), false);
>  	symbols__fixup_duplicate(dso__symbols(dso));
>  	dso__set_adjust_symbols(dso, true);
> +	dso__set_is_64_bit(dso, bfd_get_arch_size(abfd) =3D=3D 64);

[Severity: Medium]
Will bfd_get_arch_size(abfd) always return -1 here?

Earlier in tools/perf/util/libbfd.c:dso__load_bfd_symbols(), ELF binaries
are rejected before reaching this point:

	if (bfd_get_flavour(abfd) =3D=3D bfd_target_elf_flavour)
		goto out_close;

In GNU binutils libbfd, bfd_get_arch_size() only checks ELF targets and
returns -1 for any other BFD flavour:

	if (abfd->xvec->flavour =3D=3D bfd_target_elf_flavour)
		return get_elf_backend_data (abfd)->s->arch_size;
	return -1;

Because abfd is guaranteed to be non-ELF here (such as a 64-bit PE/COFF
binary), bfd_get_arch_size(abfd) =3D=3D 64 always evaluates to false and
unconditionally sets dso->is_64_bit to false.

Should this use bfd_arch_bits_per_address(abfd) =3D=3D 64 instead so that t=
he
address size is queried across all BFD flavours?

> =20
>  	err =3D dso__has_symbols(dso);
>  out_free:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018163741.8504=
34-1-namhyung@kernel.org?part=3D5
