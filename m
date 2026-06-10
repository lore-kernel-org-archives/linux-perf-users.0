Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B53DDDC9
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122504; cv=none; b=BUln1wHsunjA3Po7a96IIm+UMw14669KWzeviOGtwuwzUOaVFfiTUrbGb1bJfwOdE93PHL0V5JA6gfsDa4I2hLPv1qvnSqySg/wihyGGlx4x/964rJOp2q+uxbHjAZrgkVpTT5xjcXl9EQYUIbEmZ6f73bmqXemwLgj+1cF2NBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122504; c=relaxed/simple;
	bh=OFRbJ38fsqAwT2OLGsLJ6c2n6K5IDHAAS6rnM+dSi78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RNqrOgyqsDFwKu1jP9npjw3Qo4kB/28f75QiRd5PzHBZbobBo3Zld2mD1MlnKnJnI4OBsscERw6Jm7hiB/P2UcPxdxrhgW4Q39Y2ydK/xe030nCOPb6z7fJyFiWgAFwsP8e8mWN2wdUMD2YhpwaY4moK67FwLdp3jDkup+K/hXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEOdRPnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEOdRPnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EBD1F00893;
	Wed, 10 Jun 2026 20:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122503;
	bh=e34qGWYjCdOMvRsu4G2fRrEWL9UdT++dLVmeQU5S5as=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AEOdRPnz+WHXc/qzQtus5FXi3O077d4r5vSAYDEHwmnQUgCawd/bUuq6Qr9yj3iNx
	 9K9sDhLdiiFF9vAWyEfg0mIMaTNDvGRKINMBhkAKjxvI24cqy1mkPylhr1qPYurGhH
	 hhUnZkILkBxsdbaB4yd78bv1T/lb17aMzktSX+4AurEfuEVAC8A/Of5HSTspSsqXGj
	 PA4lXiE5eg1ga0WwvXZtbPMMwU3SAbyizYBJ+z5gg9nAyJIkKJrdGrceLWrU+qAnNI
	 y2ND0yLaxsRIfnUDuTVBEQZ+VOSi06HNGdphkjCbybuSpoj1uROJ/uZdAGpdgwQUS9
	 vxrgWjfKlXRsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/23] perf symbols: Add bounds checks to
 read_build_id() note iteration in minimal build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610195157.2091137-24-acme@kernel.org>
References: <20260610195157.2091137-24-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 20:15:02 +0000
Message-Id: <20260610201503.01EBD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Malicious ELF files with a crafted `p_filesz` of -1 bypass size ch=
ecks and lead to a null pointer dereference or severe out-of-bounds memory =
access in `read_build_id()`.
- [High] Copy-paste typo clobbers the `p_filesz` field when byte-swapping 3=
2-bit ELF program headers.
- [High] `sysfs__read_build_id()` fails to correctly read sysfs files due t=
o reliance on exact `fstat()` sizes.
--

commit 952d244acf9e87676b56a5f5142736595a4fdb14
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf symbols: Add bounds checks to read_build_id() note iteration in minima=
l build

This commit adds bounds checking to read_build_id() in the minimal ELF pars=
er.
It validates namesz and descsz individually against the remaining data befo=
re
advancing the pointer to prevent out-of-bounds reads from malformed ELF fil=
es.

> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index 8221dc9868f7c..091071d06416e 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
[ ... ]
> @@ -44,7 +45,7 @@ static int read_build_id(void *note_data, size_t note_l=
en, struct build_id *bid,
>  	ptr =3D note_data;
>  	while ((ptr + sizeof(*nhdr)) < (note_data + note_len)) {
>  		const char *name;
> -		size_t namesz, descsz;
> +		size_t namesz, descsz, remaining;
> =20
>  		nhdr =3D ptr;
>  		if (need_swap) {

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but there is a severe out-of-bounds memory access or null pointer dereferen=
ce
possible here.

If note_data is NULL and note_len is -1 (which casts to the maximum size), =
ptr
will be NULL and this code will deference a NULL pointer when reading
nhdr->n_namesz.

This state can be reached from filename__read_build_id() if a malicious ELF
file crafts p_filesz to be -1:

tools/perf/util/symbol-minimal.c:filename__read_build_id() {
    ...
    p_filesz =3D elf32 ? hdrs.phdr32[i].p_filesz : hdrs.phdr64[i].p_filesz;
    if (p_filesz > buf_size) {
        ...
        tmp =3D realloc(buf, buf_size);
        ...
    }
    ...
    if (read(fd, buf, p_filesz) !=3D p_filesz)
        goto out_free;

    ret =3D read_build_id(buf, p_filesz, bid, need_swap);
    ...
}

Because p_filesz is evaluated as a signed ssize_t, -1 is less than buf_size
(which is 0 initially), bypassing the memory allocation and leaving buf as =
NULL.

The error check read(fd, buf, p_filesz) !=3D p_filesz is also bypassed beca=
use
read(fd, NULL, -1) returns -1, which matches p_filesz.

This passes note_data =3D NULL and note_len =3D -1 into read_build_id().

Could we add stricter bounds checking on p_filesz in filename__read_build_i=
d()
to prevent this?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a copy-paste typo =
in
filename__read_build_id() when byte-swapping 32-bit ELF program headers.

tools/perf/util/symbol-minimal.c:filename__read_build_id() {
    ...
    if (need_swap) {
        if (elf32) {
            hdrs.phdr32[i].p_type =3D bswap_32(hdrs.phdr32[i].p_type);
            hdrs.phdr32[i].p_offset =3D bswap_32(hdrs.phdr32[i].p_offset);
            hdrs.phdr32[i].p_filesz =3D bswap_32(hdrs.phdr32[i].p_offset);
        ...
    }
    ...
}

The code correctly swaps p_offset, but then assigns the swapped p_offset va=
lue
to p_filesz, instead of swapping the actual p_filesz field. This reverts the
byte swap and clobbers p_filesz with the original un-swapped p_offset.

Could this be corrected to swap hdrs.phdr32[i].p_filesz?


[Severity: High]
This is another pre-existing issue not introduced by this patch, but
sysfs__read_build_id() appears to rely on exact fstat() sizes.

tools/perf/util/symbol-minimal.c:sysfs__read_build_id() {
    ...
    if (fstat(fd, &stbuf) < 0)
        goto out;

    buf_size =3D stbuf.st_size;
    buf =3D malloc(buf_size);
    ...
    if (read(fd, buf, buf_size) !=3D (ssize_t) buf_size)
        goto out_free;
    ...
}

Sysfs pseudo-files often report inaccurate lengths via st_size (like 0 or 4=
096),
regardless of their actual content size.=20

By requiring the bytes read to strictly match buf_size, won't this
systematically fail for sysfs pseudo-files and incorrectly discard valid bu=
ild
IDs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610195157.2091=
137-1-acme@kernel.org?part=3D23
