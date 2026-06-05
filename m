Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC936F903
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703788; cv=none; b=rEkVT/IQLDgKCEOPNaYC+Fh1m89ScUKW64hwdEec7Fj8uKKFrhosOovWcLgjiNkQbH+BNGpHka1+EhOdBIJ+yctCHjJAQVLSNMbfYIyapq5dNWuIvqvETgMH2Ll4HQUewf7rtXh69wJz45xd1ZSIR0kJ9jrxBvgYuWwI+GypR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703788; c=relaxed/simple;
	bh=4BJMwDRQUyGGdqVSxXPWubsrIzQDkP+p00FiTa3uNrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r/vADuu3JiOHIVinFr28tN1rsOPnBgUmFEsMFHFBHxn3zyJ5fSzRGyiBSVuV+bXvRPs8mR0B0/ipBlGPnpGnPKDfbMbEY/icqeEO42qyQy24wIq6rwSiObBzRZt22r9b8BLzc9I9PsigH/OhsR9qYXQlMYhKKyoBU2V5WPSZN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZns+tIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZns+tIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD231F00893;
	Fri,  5 Jun 2026 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703786;
	bh=IubcKy8ld9h3EQJgEn6YATqQSGYgUEZl6Vwf5fdj/O4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZns+tIFUAPJPhogsENMkKDoCo+PDO8Wc3AjoASWMtoDBidzsy8dwl2q7qQTV2kMp
	 qOJIM94tac0OeRbwEVqF++MQOlchdBmOpKloxgmZWsRyBx6pj34MbTvAc9Vu3DwTtH
	 IxvYUODGvcKeml99DAWkLtcbH6RtEcSuBi0M3hSCZtKAZcgAPCZTIP54BRbQY+DNNF
	 7BN4aWoIGrwU1nHMVd30OWg/Z2Y80sHMU84AISYuWNXw9wQdqIEANPd2ZQgdMA0zeK
	 8aB0bXUCmKpG/Db6yN5l8nKqTHQkjYr34JsKGgPhR6hgZrou2gJkGf93fRP/CtSBh1
	 kY7EDv9zGBGFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf mmap: Guard cpu__get_node() return in
 aio_bind()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605233837.1773732-2-acme@kernel.org>
References: <20260605233837.1773732-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:56:26 +0000
Message-Id: <20260605235626.BAD231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] NULL pointer dereference in `perf_mmap__aio_free()` when memory =
allocation fails in `perf_mmap__aio_mmap()`.
- [Medium] Sign-extension out-of-bounds write vulnerability in `perf_mmap__=
setup_affinity_mask`.
--

commit 2a2adfec0327c3db4323154825d9029d39b512eb
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf mmap: Guard cpu__get_node() return in aio_bind()

This commit fixes a sign-extension out-of-bounds write in perf_mmap__aio_bi=
nd()
by assigning the return of cpu__get_node() to a signed integer first.
If the return value is less than zero, the function safely returns early
instead of performing out-of-bounds operations.

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index b69f926d314b1..4404a99eee45f 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -104,9 +104,15 @@ static int perf_mmap__aio_bind(struct mmap *map, int=
 idx, struct perf_cpu cpu, i
>  	int err =3D 0;
> =20
>  	if (affinity !=3D PERF_AFFINITY_SYS && cpu__max_node() > 1) {
> +		int node;
> +
>  		data =3D map->aio.data[idx];
>  		mmap_len =3D mmap__mmap_len(map);
> -		node_index =3D cpu__get_node(cpu);
> +		node =3D cpu__get_node(cpu);
> +		/* -1 sign-extends to ULONG_MAX, wrapping bitmap_zalloc(0) and OOB __s=
et_bit */
> +		if (node < 0)
> +			return 0;
> +		node_index =3D node;
>  		node_mask =3D bitmap_zalloc(node_index + 1);
>  		if (!node_mask) {
>  			pr_err("Failed to allocate node mask for mbind: error %m\n");

[Severity: Medium]
This is a pre-existing issue, but I noticed a similar sign-extension issue =
in
perf_mmap__setup_affinity_mask() that could cause an out-of-bounds write.

If map->core.cpu.cpu is -1 (for example, for a dummy CPU map created by perf
record -p <pid> --affinity cpu), wouldn't it be sign-extended to ULONG_MAX
when passed to __set_bit()?

tools/perf/util/mmap.c:perf_mmap__setup_affinity_mask() {
    ...
	if (mp->affinity =3D=3D PERF_AFFINITY_NODE && cpu__max_node() > 1)
		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
	else if (mp->affinity =3D=3D PERF_AFFINITY_CPU)
		__set_bit(map->core.cpu.cpu, map->affinity_mask.bits);
    ...
}


[Severity: Medium]
This is also a pre-existing issue, but while looking at the mmap code, I
noticed a potential NULL pointer dereference during error cleanup.

If memory allocation for map->aio.data fails in perf_mmap__aio_mmap(), the
function returns -1 while map->aio.nr_cblocks is already set.

During the cleanup sequence, perf_mmap__aio_munmap() unconditionally loops =
up
to map->aio.nr_cblocks:

tools/perf/util/mmap.c:perf_mmap__aio_munmap() {
    ...
	for (i =3D 0; i < map->aio.nr_cblocks; ++i)
		perf_mmap__aio_free(map, i);
    ...
}

Inside perf_mmap__aio_free(), the pointer offset is calculated and passed to
zfree():

tools/perf/util/mmap.c:perf_mmap__aio_free() {
	zfree(&(map->aio.data[idx]));
}

If map->aio.data is NULL, won't passing its evaluated offset to zfree()
cause a segmentation fault when __zfree() tries to free the invalid pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605233837.1773=
732-1-acme@kernel.org?part=3D1
