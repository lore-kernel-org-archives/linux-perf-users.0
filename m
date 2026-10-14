Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A95304BC
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999522; cv=none; b=g3w4xp4Hy6mfn6QvvLPu8n8IWH0vlxibHPuKY43kFe4OkoM5EIJJdA4DvOLq7PkxGGaXjiH7164Uo76C5yjkVAPFMNZwHnkMIXbS7FRiCBv7swlAFIgWWl+ILJP9yNHd6D1c1EVe5+XGK5F0HczomLKq7ZBfct1gpu7MDrWHLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999522; c=relaxed/simple;
	bh=PzHaB0ehu127Q/XNNhiY/JqTtmpSRJ65L/VcznYZPNI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dYdzXM3y8PLsZQSkFOQWR96uRdujgvAM8aIzK217f14nA1ihsBEnebRDZc+EFb2ssqE4F7xH5XejJK9JJpnZEVOXMpt+ZGJA4FUYGpFvM1fBdw+j/nXw7yKtYSfx/t9C48gx9HmadC2r0bMtHUpMEZNrY6CVYOFMPYXMg4yaL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJaods+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJaods+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C21F000C4;
	Wed, 14 Oct 2026 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999517;
	bh=GWLfnBs/0wdp4K76D7SU8jUS6egB0/30djlk0mnZqkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZJaods+7oX/eW1DCa1JR5pxpE2aTF6HpRaggEvXx2vNApd4YJTzn9DvTet3ykyD5b
	 jyKzjpb9lgo15priE7VRYixfpqsYEWcRHoSBsEPukEqzbCZzjoQ4M5X0P7lkt4fwN7
	 U1/o/SbJhGGLaaH1QppLJ3EXKtXkbvph7CQNlUvWPma4QhvSyxSrGe3QFKHnFCkzOr
	 YsFaMBJWHJn/hII9c6gjtKCJEfVcGCjV494g+fmk+WPeVN1J4s241oWnYGxf/1Qz5z
	 hiUrafayXmtLmR3etJ5NQJIefgRUAMBTuM8gwdU1lhCoLWmSIvfaZKDMlhwk5LreHC
	 vJbIwfwTHF50w==
Message-ID: <sashiko-outbox-171580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf: zstd: zstd_decompress_stream ->
 zstd_decompress_buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivan Shapovalov" <intelfx@intelfx.name>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014-perf-zstd-v1-1-9652727886fa@intelfx.name>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
 <20261014-perf-zstd-v1-1-9652727886fa@intelfx.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:38:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: stale function name in comment for zstd_decompress_buffer
--

commit a8489356f2f1a85e8397e7dba79a95d1bfde0cb1
Author: Ivan Shapovalov <intelfx@intelfx.name>

perf: zstd: zstd_decompress_stream -> zstd_decompress_buffer

This commit renames zstd_decompress_stream() to zstd_decompress_buffer() to
free up the old name for an actual streaming decompression function.

> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 25c9b378aa163..d7956cd75c26d 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
[ ... ]
> @@ -92,15 +92,15 @@ static int perf_session__process_compressed_event(con=
st struct perf_tool *tool _
>  		src =3D (void *)event + sizeof(struct perf_record_compressed2);
>  		src_size =3D event->pack2.data_size;
>  		/*
>  		 * data_size is independent of header.size (which
>  		 * includes padding); verify it doesn't exceed the
>  		 * actual payload to prevent out-of-bounds reads in
>  		 * zstd_decompress_stream().
>  		 */

[Severity: Low]
Could this comment in perf_session__process_compressed_event() be updated to
reference the renamed zstd_decompress_buffer() function?

Since the commit message indicates the old name will be reused for a differ=
ent
function, leaving this stale comment could be confusing when the new functi=
on
is introduced.

>  		if (src_size > event->header.size - sizeof(struct perf_record_compress=
ed2))
>  			goto err_decomp;
>  	} else {
>  		goto err_decomp;
>  	}
> =20
> -	decomp_size =3D zstd_decompress_stream(session->active_decomp->zstd_dec=
omp, src, src_size,
> +	decomp_size =3D zstd_decompress_buffer(session->active_decomp->zstd_dec=
omp, src, src_size,
>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-perf-zstd-=
v1-0-9652727886fa@intelfx.name?part=3D1
