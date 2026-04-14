Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6194358379
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206782; cv=none; b=aIEsRDOVGThCwAX6wSF4JA9/Lf2Cwns89iITBrtzVK2hNEsw/t7BXdD+mOj4Q663PxytAVRucffxshkxqU+V09DWesfsCXlFXBxAts2EMIeUjQLpwihJoPc3hIziyeP77uWdmKVmBAl4eIg+65wGwokV+LD1kNgBDAKPt0piMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206782; c=relaxed/simple;
	bh=ZzgaCaz3/piaFOCdP+BajYJVKpOFbmMN4cVdemGXSQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OaxLs0HTs7K5UpAwlUdZ83JsB0hXdPJZ0v9I5wu+O8LmFR7+8TgPNuCE9O9bE1rfEl67SUj2824n5e3OHzRC0IX+BaXJodbirbnMP+7xqNMrtWu6edTI5+ziTNav+6sXOa+FsG3ewHERdcNVe7fV1OW5qKM6Vg+8M6SksMEpyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE+add7/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE+add7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE69C19425;
	Tue, 14 Apr 2026 22:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776206782;
	bh=ZzgaCaz3/piaFOCdP+BajYJVKpOFbmMN4cVdemGXSQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AE+add7/7x81Ji+/taa8LYrcY6CZd+0+CWNv9iCbEBn7LRsmbyHw9eCgFaxTambKY
	 YKvr9cj48w67po0hAep0yEPWT1Xj/ctxVmZ6kERWAi0L33tpid4mw3N4UCMCa/XmhE
	 udVwcDoHdGRAbZYwI8UrHqhylu+1NUELbJswnnDjP2F13xp/nOMWN0Z4lWVWyBwLAO
	 gLSnlOO18z1i2/HpPE8l65nL55khHu0+4JouBhFMtwxDHKqUtaB9Jmva49fDLc24Dr
	 gRpxnXJ2ioPDNK04bctZfI9ukwNI5N9yA8ZOOvVRaAHy55VOGa53giuFhR63U1m5rR
	 v26c7bgX5xgmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf header: Validate bitmap size before allocating
 in do_read_bitmap()
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414204847.293557-5-acme@kernel.org>
References: <20260414204847.293557-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:46:21 +0000
Message-Id: <20260414224622.2AE69C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Integer truncation in `bitmap_zalloc()` leads to a massive hea=
p buffer overflow. While the added bounds check ensures `BITS_TO_U64(size)`=
 elements fit in the declared section size, `bitmap_zalloc(int nbits)` expl=
icitly takes a 32-bit signed integer. A crafted `size` (e.g., `0x100000040`=
) passes the 64-bit bounds check but truncates to 64 when passed to `bitmap=
_zalloc()`, allocating only 8 bytes. The un-truncated 64-bit size is then u=
sed as the upper bound for the read loop, causing `do_read_u64()` to write =
millions of elements sequentially past the 8-byte allocation until the phys=
ical end of the file is reached.
- [High] Architecture-dependent heap buffer overflow on 32-bit systems due =
to mismatched allocation and read sizes. On 32-bit architectures, `bitmap_z=
alloc(size)` allocates memory based on `sizeof(unsigned long)`, which is 4 =
bytes. However, `do_read_bitmap()` casts the allocated buffer to a `u64 *` =
and reads 8-byte chunks using `do_read_u64()`. For small bit counts like `s=
ize =3D 1`, `bitmap_zalloc()` allocates exactly 4 bytes, but the read loop =
executes once and writes 8 bytes, causing a 4-byte out-of-bounds heap write.
--

commit 6e9a72cba35d6256871d1af4ce151caaca2e76e2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate bitmap size before allocating in do_read_bitmap()

This commit adds a bounds check in do_read_bitmap() to prevent large
allocations that exceed the remaining section size. It validates that
the requested bit count fits within the file data before calling
bitmap_zalloc().

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -290,6 +290,9 @@ static int do_read_bitmap(struct feat_fd *ff, unsigne=
d long **pset, u64 *psize)
>  	if (ret)
>  		return ret;
> =20
> +	if (BITS_TO_U64(size) > (ff->size - ff->offset) / sizeof(u64))
> +		return -1;
> +
>  	set =3D bitmap_zalloc(size);

Does this code truncate the allocation size?

The size variable is a u64, but bitmap_zalloc() takes a 32-bit signed integ=
er
for its nbits parameter. If a crafted file provides a large size value like
0x100000040, the 64-bit bounds check above would pass if the section is
large enough.=20

However, the value would be truncated to 64 when passed to bitmap_zalloc(),
allocating only an 8 byte buffer.

[ ... ]

>  	p =3D (u64 *) set;
> =20
>  	for (i =3D 0; (u64) i < BITS_TO_U64(size); i++) {
>  		ret =3D do_read_u64(ff, p + i);

Could this loop write out of bounds on 32-bit architectures?

The bitmap_zalloc() function allocates memory based on sizeof(unsigned long=
),
which is 4 bytes on 32-bit architectures. For a small bit count like size =
=3D 1,
the allocation would be exactly 4 bytes.

Since the code casts the buffer to a u64 pointer and reads 8-byte chunks us=
ing
do_read_u64(), the first read would write 8 bytes, overflowing the 4-byte
allocation.

Could this loop also cause a heap buffer overflow due to the truncation
mentioned earlier?

If size is truncated by bitmap_zalloc() to a very small allocation, this
loop still uses the un-truncated 64-bit size as its upper bound. It would
sequentially write millions of elements past the small allocation until it
reaches the physical end of the file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414204847.2935=
57-1-acme@kernel.org?part=3D4
