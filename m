Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42ED2D0602
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968199; cv=none; b=bikFFC2WeQUK0cG3/8Bnoq2BPc0s/1CTUTb0DGoEfBxCPwx7n1wRIasOvQ+YXJzYouxKRKUzDTghc8R3qaLQYp1CPS5PYQEsxW2A9jD8erMm9hgoowRVqjuBqMh95dfmHtdGNdAdiHCoUYellW9ZOXS7X3B6SWgZ+5wVp5YOk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968199; c=relaxed/simple;
	bh=6B88eKmbv3i+foH7wdf37OzFNkOUGKcDHom2pbc+6F8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Htui4SU4PDvWs2SuYc2uneZEQ1XymBi87pVKvDsdQ76+Jf1FgtOSO8efn0v+aJ8LiMtdH9x97OIGu7MNUoVexVqW1gO14kWcBsmwS6H6O+JzAgDaFekelgahtjIgWQwXe/VTTO5ioh0sOnl7cUmTdl68uNnSv9onWkD9ND7jexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo2aEBt8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo2aEBt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC9F1F00893;
	Tue,  9 Jun 2026 01:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780968198;
	bh=woWY/l0hhI6IcpteW6Hkw4iLYTZbEyX7YPC4TFsExxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jo2aEBt8agFYYw1jqoBCpfSosAgj3twQRuv2Z+fmlKlc5qF5nqX4H4DRMvaA7nwmV
	 5JawlHsppE7uu97IDF7oVEZvA+dhys3lLadUrwWjpbiJ/EH3YSkdnAdUIMjdbbq7l8
	 LdcS6n4LgrW1w/7o9Li6070vV5OlI9rtrjkjuyvwHM7TECJoNNlkKcivsK9dUnazcu
	 VFWe7tLmJ2HidomwddL9NR3PriMXB54HKrVZP71nFIHbI4mKwvvqhP1P84Q/xNV9Jj
	 h5mIuAE/sn/32S3CtTa1imVnLX05n/YeehKCMMcf+92h7K84j/aFEar6NnYB7zFu7j
	 AaPqk28qsfqkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] perf tools: NULL bitmap pointers after
 bitmap_free()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-5-acme@kernel.org>
References: <20260609010526.1998472-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:23:18 +0000
Message-Id: <20260609012318.8AC9F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mmap__munmap() sets map->affinity_mask.bits to NULL but fails to=
 reset nbits, causing a NULL pointer dereference on reuse
--

commit 94be33133bc6900d241e747a65660202c60936fa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: NULL bitmap pointers after bitmap_free()

Two call sites free bitmaps without NULLing the pointer, risking
double-free if the structure is reused or cleanup is called twice.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a33c78f030d91..e915390556752 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3084,6 +3084,7 @@ static int record__mmap_cpu_mask_alloc(struct mmap_=
cpu_mask *mask, int nr_bits)
>  static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
>  {
>  	bitmap_free(mask->bits);
> +	mask->bits =3D NULL;
>  	mask->nbits =3D 0;
>  }

[ ... ]

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index d64aec6c7c843..c6bd4c37d50ee 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -238,6 +238,7 @@ static void perf_mmap__aio_munmap(struct mmap *map __=
maybe_unused)
>  void mmap__munmap(struct mmap *map)
>  {
>  	bitmap_free(map->affinity_mask.bits);
> +	map->affinity_mask.bits =3D NULL;

[Severity: Medium]
In record__mmap_cpu_mask_free() above, nbits is reset to 0, but it is not
reset here.

If this struct mmap is later reused and mmap__mmap() is called with
mp->affinity =3D=3D PERF_AFFINITY_SYS, perf_mmap__setup_affinity_mask()
is bypassed, leaving bits as NULL while nbits retains its old, positive val=
ue.

If the user runs perf with -vv, mmap__mmap() calls mmap_cpu_mask__scnprintf=
(),
which passes the NULL pointer and positive nbits to bitmap_scnprintf().

Could this cause find_first_bit() to unconditionally dereference the NULL
pointer array and crash the tool?

Should we also add map->affinity_mask.nbits =3D 0 here?

> =20
>  	zstd_fini(&map->zstd_data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D4
