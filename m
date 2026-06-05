Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9882DC332
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692513; cv=none; b=K+Ph2RyYpOOozUZtmn8rQx2iTk/M2jCP/JfdGE0P5hEmEbQMNc9+s9EdMDh1/cwAr/C52KyjTh4qXf8pzQ1Asb2GrhUd6wMJoTcIzTB8f+0Y1UwfnFvngqhNfwMXY6INRx1Pavi+zzYF8IliyD3MbTe6bC9WdrJLBuVNyjns7no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692513; c=relaxed/simple;
	bh=RaMAJny/ZpB8VPERXDfGYzb+c8CQsDL+A6UkMn1dXvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNF6WropPy0URIqZAWUESDYm1PerxuQL6CtHpmmxY/d0TaIVTnu6TRoFS7FSe0xNRAUPVXEsKdcWEwPeyEbVrj3picBOLE0TfBt/uxRGavKEcDatCA7UoA3NiZL0luxAyUNFom3Q9ZXgOX8dQWilP+EOGmWQcw4bhhIaBT2Vsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIvZdkdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIvZdkdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C4E1F00893;
	Fri,  5 Jun 2026 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692512;
	bh=zDKFyAZdyHpgs2MU0z4Mpc+u1QJzSkkodqwYLuuOZyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIvZdkdF/yFx35KBX3BGqc8Fo0p+TjIKZ3PE9rrnLJDPzvGLffc5Xf7oV0HZF5YNe
	 UiF+wJU4Dg2X6EZ/PwaJqvY+bhbcw98TE/HF7SviLruwJYbBi9Rcwi9Pd2owzTwQyU
	 mp7qLrIEWYp7+ZSMCVRLPwFtBDNFWzGov5i8raZBHfrj8pUaMoZBt6ebhhuJqXiDbw
	 J9C8qeoEYX3ETMZd2LHpJkoNRsHyGZI5u9jEh4tU87LKizR0d5UqkfT+Svdnoa4cve
	 SCWvYWd0/TpuUg4AQ4FTyGPD/mKusGXc3MXj7LsCc1wXdGbRdqZs8uzGSVzH1gk8LE
	 f04wIaqHRIyzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] perf mmap: Guard cpu__get_node() return in
 aio_bind()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605203316.1758661-2-acme@kernel.org>
References: <20260605203316.1758661-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:48:31 +0000
Message-Id: <20260605204831.F0C4E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] A failure during AIO initialization causes a NULL pointer derefe=
rence during cleanup in `perf_mmap__aio_munmap`.
--

commit 288781c48aca8cf278f6a1c8e4af510fc3cb0e4c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf mmap: Guard cpu__get_node() return in aio_bind()
   =20
    perf_mmap__aio_bind() passes the cpu__get_node() return value directly
    to an unsigned long variable (node_index).  When cpu__get_node() returns
    -1 for an unknown CPU, the implicit int-to-unsigned-long conversion
    sign-extends it to ULONG_MAX. Check the return value in a signed
    temporary before assigning to node_index, and skip the NUMA binding
    when the node is unknown.

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
This isn't a bug introduced by this patch, but I noticed a potential NULL
pointer dereference during error cleanup if AIO initialization fails.

If memory allocation fails early in perf_mmap__aio_mmap():

tools/perf/util/mmap.c:perf_mmap__aio_mmap() {
    ...
	map->aio.nr_cblocks =3D mp->nr_cblocks;
	if (map->aio.nr_cblocks) {
		map->aio.aiocb =3D calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
		if (!map->aio.aiocb) {
			pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
			return -1;
		}
    ...
}

The function returns an error, but leaves map->aio.nr_cblocks set to the
requested number of blocks while map->aio.data remains NULL.

This error bubbles up and triggers error recovery, which eventually calls
perf_mmap__aio_munmap():

tools/perf/util/mmap.c:perf_mmap__aio_munmap() {
    ...
	for (i =3D 0; i < map->aio.nr_cblocks; ++i)
		perf_mmap__aio_free(map, i);
    ...
}

Which loops based on nr_cblocks and passes the map to perf_mmap__aio_free():

tools/perf/util/mmap.c:perf_mmap__aio_free() {
    ...
	if (map->aio.data[idx]) {
    ...
}

Is it possible for map->aio.data to be NULL here? It seems evaluating this
array index (or calling zfree(&(map->aio.data[idx])) when libnuma is not
supported) could cause an immediate NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605203316.1758=
661-1-acme@kernel.org?part=3D1
