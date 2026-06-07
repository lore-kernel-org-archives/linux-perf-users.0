Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54854332637
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875760; cv=none; b=eQA2wTMks8gGUPqpVMO+2ZaOFetYOhK3UhSyDGyNft0KnG31Rfa2CP1ySx6ZpIkhP1Cq5bFC4waoB8Y8QW5rikjWUCjYTbTF1foAPmiNJ+OqOaHqaRLqKsAC4YBhhL32VRAlZGmCkgdEb9zzB7QpXPq4TrA267W82kObRCHuxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875760; c=relaxed/simple;
	bh=sNL8uLlw+mDFX7g5PP3bRfugJPy1WpWQjvGMTiGl5ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=inEJL6p09/WsQV4uxdLJGIpFJNOuWq7vPX/l40erl5zScih5j9WBvSWQ8GW1n+MjadHjKoHHu5CY6zLVlQDLpAp3gXI5aTxzAlw7thrPrtmsmYUxBOikYUJp7jtq7Y3IjiLj1mNYcY88yAV7mszGe3YlWO0QuyWJ29g3Xebc7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd4k6ahv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd4k6ahv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83A91F00893;
	Sun,  7 Jun 2026 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875758;
	bh=g+DJsitYagiPLVk+RrSmvRtuq4thfIHDT34rE5XAUkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kd4k6ahvm9hqIa1h1wDCkfPR2OFS5QGX1Fx0veLPZd3cNjgkyFg5kR6FVUWxAwcPY
	 S0aVHK2Aab3a+v4gDJFzHXikXaxque2V+umVFqXMvy4uCRs2p9oUK5IKRlx6HYGOjK
	 ULJDn3HItKNjBderu4OTtK/jd0VOmRPFPriJwDtuLMIbm753R7uyWXGUuM4A5YdxzX
	 7MJNiRMiBTmFeVRCOWteiN02tVeUuSHQSljBLYK9JC3DGTN++kVlVnE2Ovna1hBSiZ
	 mx6FkcIiDY1S1eSlT2mdBIxhbZujIkDm6cy6x1UnGpKNrpra61UnjNNo96CgNVBm0K
	 k34aYEVRf04ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] perf tools: Add O_CLOEXEC to open() calls in DSO
 and ELF code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607232925.1935819-9-acme@kernel.org>
References: <20260607232925.1935819-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 23:42:38 +0000
Message-Id: <20260607234238.A83A91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stack buffer overflow in `sysfs__read_build_id` due to integer=
 overflow.
- [High] Incomplete fix for file descriptor leaks; `mkstemp()` calls still =
lack `O_CLOEXEC`.
- [High] Out-of-bounds memory read in `filename__read_debuglink` when parsi=
ng malformed ELF files.
--

commit ebdb5f81eceb8366c0e12ca6798c1cd5dfc35089
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code

This commit adds the O_CLOEXEC flag to open() calls in dso.c and
symbol-elf.c. The goal is to prevent file descriptors from leaking to
child processes spawned during symbol resolution.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 7dced896c64ea..fb2e78fe2aa8e 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -344,7 +344,7 @@ int filename__decompress(const char *name, char *path=
name,
>  	 * descriptor to the uncompressed file.
>  	 */
>  	if (!compressions[comp].is_compressed(name))
> -		return open(name, O_RDONLY);
> +		return open(name, O_RDONLY | O_CLOEXEC);
> =20
>  	fd =3D mkstemp(tmpbuf);

[Severity: High]
This isn't a bug introduced by this patch, but since the goal is to prevent
file descriptor leaks to child processes, should we also update the
mkstemp() calls?

Here in filename__decompress(), mkstemp() creates a temporary file
descriptor without the close-on-exec flag. This FD will be inherited by
spawned child processes. Could this be changed to use
mkostemp(tmpbuf, O_CLOEXEC)?

[ ... ]
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 186e6d92ac3d7..c2bdfd0003df2 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
[ ... ]
> @@ -935,7 +935,7 @@ int sysfs__read_build_id(const char *filename, struct=
 build_id *bid)
>  	size_t size =3D sizeof(bid->data);
>  	int fd, err =3D -1;
> =20
> -	fd =3D open(filename, O_RDONLY);
> +	fd =3D open(filename, O_RDONLY | O_CLOEXEC);

[Severity: Critical]
This is a pre-existing issue, but there appears to be an integer overflow
risk further down in sysfs__read_build_id() that could lead to a stack
buffer overflow.

The function reads nhdr.n_namesz and nhdr.n_descsz directly from the file.
Since these are 32-bit values, they can be arbitrarily large. The
calculation:

    int n =3D namesz + descsz;

can overflow the 32-bit signed integer n, resulting in a negative value.
The size check:

    if (n > (int)sizeof(bf)) {
        n =3D sizeof(bf);
        ...
    }

bypasses truncation because a negative number is smaller than sizeof(bf).
When read(fd, bf, n) is called, the negative n is interpreted as a massive
size_t count, potentially reading up to 2GB of data into the 8KB stack
buffer bf[BUFSIZ].

Could this be exploited if perf processes data from an untrusted root
directory?

>  	if (fd < 0)
>  		goto out;
> =20
[ ... ]
> @@ -995,7 +995,7 @@ int filename__read_debuglink(const char *filename, ch=
ar *debuglink,
>  	if (err >=3D 0)
>  		goto out;
> =20
> -	fd =3D open(filename, O_RDONLY);
> +	fd =3D open(filename, O_RDONLY | O_CLOEXEC);

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of an
out-of-bounds read further down in filename__read_debuglink() when parsing
malformed ELF files?

Later in this function, the code blindly copies the section data:

    /* the start of this section is a zero-terminated string */
    strncpy(debuglink, data->d_buf, size);

If a corrupted ELF file provides a small .gnu_debuglink section without
a null terminator, strncpy() lacks bounds validation against the actual
section size (data->d_size) and could read past the end of the mapped
section data.

If this crosses into unmapped memory, could it cause a segmentation fault
and crash perf?

>  	if (fd < 0)
>  		goto out;
> =20
[ ... ]
> @@ -1985,7 +1985,7 @@ static int kcore__init(struct kcore *kcore, char *f=
ilename, int elfclass,
>  	if (temp)
>  		kcore->fd =3D mkstemp(filename);
>  	else
> -		kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL, 0400);
> +		kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, =
0400);

[Severity: High]
This is also a pre-existing issue, but the if (temp) branch uses mkstemp()
which lacks O_CLOEXEC. This creates an inconsistent state compared to the
else branch that correctly adds O_CLOEXEC.

Does this mkstemp() need to be replaced with mkostemp(..., O_CLOEXEC)
to fully prevent file descriptor exhaustion? (There is also another
mkstemp() call in read_gnu_debugdata() that exhibits the same behavior).

>  	if (kcore->fd =3D=3D -1)
>  		return -1;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607232925.1935=
819-1-acme@kernel.org?part=3D8
