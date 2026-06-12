Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F1946A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225697; cv=none; b=Uj+5jUmly6TNO6dsLNrJnzE0A9+Gw1qA/yh6z+EWubafpj25rClC6aN0PhyCEbCxW6Kk4aJUyMPFPJNBWQ36AANLbS9ykSwLBSF7QY1DbxR7v4e3uD04H3qk7oGDjzOgSe+DNU0wDMiHBSHySpvMiKtU3fU7Yq21WobjEpi4kQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225697; c=relaxed/simple;
	bh=jCtqeJyH26MJ+DOTfVzkDZzCwizFu19Wut7DRzKP/Ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aRcweCFM65F/gmArtcPP0PHa5BAksbUOLcMq1L1CYCpfdPRGyxu0kWPHvbq7HIEy4LL0AEQxvJw3Y2mfM8vam3cjwgJIM0HMuwPPk8c0/uvIepPU07irfjdcinkvFB8gNL6I+a8uT1MZKkboXJwkp++iHIVCIoNFHU7jjIbClQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMkqopC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMkqopC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC5E1F000E9;
	Fri, 12 Jun 2026 00:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225696;
	bh=ESNRWuRR4n3BoYSj9EBDi2SJ9XJ4QjKfYrsQE8Gp3+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMkqopC3pMAuHOmFHIenlq0hWptAaimMa+a8lkOH6TPdZaS7lu8g40nundGjGWYGq
	 IjNLVGkT4P7BhuTPjZLtSOxkSOEHumqgrdU5g0qH+Jk6xVehwU1x6cQFJnv86AAAWD
	 AZW4i/PsLJSG2Da3dtIH+cST7rhbY6T6bsaaNa1HzTv3Xijiwu5wlobt5ze8M1oEF8
	 GmMIIlJOjNscKoknzWPSqb+785YEd9KdShqvCehwGglR/sTOtb5nVFOp1Kp6gSLJo2
	 ezKsChzIyC82zMSpU7iCJKbjE/JqW9+Ql2aTccD1ec0Y/S4pqDd6tpDzBLH0EDo8SE
	 2xW4uGg4dVRqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] perf dso: Set error code when open() fails on
 uncompressed fallback path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-7-acme@kernel.org>
References: <20260612003444.50723-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:54:54 +0000
Message-Id: <20260612005455.CCC5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Type punning by accessing a char array through an incompatible p=
ointer type in tools/.
--

commit 4b3994ef70950d73fb48b1cdff6e7ffb7ee129d2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Set error code when open() fails on uncompressed fallback path

filename__decompress() has an early return for files that are not
actually compressed, where it calls open() directly. When open()
fails, the function returns -1 but never sets *err, leading to a stale
or zero errno. This causes callers to treat fd 0 as a valid DSO file
descriptor.

> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index 091071d06416e..ea2de3d50d33c 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c

[ ... ]

> @@ -217,29 +220,36 @@ int sysfs__read_build_id(const char *filename, stru=
ct build_id *bid)
>  {
>  	int fd;
>  	int ret =3D -1;
> -	struct stat stbuf;
> -	size_t buf_size;
> -	void *buf;
> +	/*
> +	 * read_build_id() casts this buffer to a u32 note header pointer,
> +	 * so it must be aligned for u32 access.
> +	 *
> +	 * Accessing a char[] through a u32* is technically type-punning
> +	 * under C strict aliasing rules, but perf unconditionally builds
> +	 * with -fno-strict-aliasing (Makefile.config), so this is safe.
> +	 *
> +	 * This file is only compiled when libelf is not available =E2=80=94 the
> +	 * common case uses the libelf-based path in symbol-elf.c instead.
> +	 */
> +	char buf[BUFSIZ] __aligned(4);

[Severity: Medium]
The comment mentions that perf unconditionally builds with
-fno-strict-aliasing, making this safe. However, do files under the tools/
directory generally assume standard -fstrict-aliasing?

When this character array is passed to read_build_id() and cast to an
incompatible structure pointer type:

sysfs__read_build_id()->read_build_id() {
	nhdr =3D ptr;
	if (need_swap) {
		nhdr->n_namesz =3D bswap_32(nhdr->n_namesz);

Could this type punning lead to undefined behavior or compiler optimization
issues if standard compiler flags are used for tools?

> +	ssize_t len;
> =20
>  	fd =3D open(filename, O_RDONLY);
>  	if (fd < 0)
>  		return -1;
> =20
> -	if (fstat(fd, &stbuf) < 0)
> -		goto out;
> +	/*
> +	 * Use a fixed buffer and a single read() instead of fstat() + malloc(),
> +	 * because sysfs pseudo-files often report st_size=3D0 or 4096
> +	 * regardless of actual content size.
> +	 *
> +	 * BUFSIZ (8192) is more than sufficient: a sysfs build-id note is
> +	 * ~36 bytes (12-byte note header + 4-byte "GNU" name + 20-byte SHA1).
> +	 */
> +	len =3D read(fd, buf, sizeof(buf));
> +	if (len > 0)
> +		ret =3D read_build_id(buf, len, bid, false);
> =20
> -	buf_size =3D stbuf.st_size;
> -	buf =3D malloc(buf_size);
> -	if (buf =3D=3D NULL)
> -		goto out;
> -
> -	if (read(fd, buf, buf_size) !=3D (ssize_t) buf_size)
> -		goto out_free;
> -
> -	ret =3D read_build_id(buf, buf_size, bid, false);
> -out_free:
> -	free(buf);
> -out:
>  	close(fd);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D6
