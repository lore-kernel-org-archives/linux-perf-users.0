Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78D55294B
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000296; cv=none; b=EYjXGZktFXExhZp9c2szeaqYy6Lt4pGM3hsoRKPfX9l+wWYNLnxPWoDbGxQRCYOENnjxUJzCjosy+NQIAuWSCUHRs+w5hEKuLt71Q7CRfrM6qauNdhmxRjBs1NfdZysfTjose3xxqytReErolX3O3GbMotAVFkQw0LZAhNlWpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000296; c=relaxed/simple;
	bh=COqKl3WccPTawMH1zAjPtVEyv6JOugSo6yRoQxb/QXc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cYC518eX29nF2bbfbUnYpB62663wOFLgWvJ7r9mRiAv0HfmBsCLx1GmxxAohjTGNYA7BK+ed3fTl2Y9cHKejvwuX7moOcIDY3xpr9L7QSZOiU3wwZo6nt7eVlAHVJK2H/6jc9KVcQhQwET3mTf2vhSEqM5LVGa2AccSOWCr0lU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouhgHAs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouhgHAs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC78E1F000C4;
	Wed, 14 Oct 2026 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792000294;
	bh=2mQYHOOh1hO8v6mq02HUAVHGl0RIUVy4GfONwfclp4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ouhgHAs670Z8MtTmFLLgR9264e1x0epumfnRJlN7EcYNpTSmeUIx1ayCYvumVUZFh
	 wVM+t1dZIvmB3S0okY9VpjgeBZ8BwSXXYuk/2GUYGTqbcAc2ykDn53qghd+S7HqIIM
	 /GHirkvmGTvjD6aFHB0tBa5nuVz3E7WmYro1rLWXebZG5I5+8ejv0BGm+/VEzpMJMX
	 iU0gfVW5N/I9+tEuqJu8rEOt5jzjLKOLjVLX4ml5Irn3G1qArxALLiEKgCI6tL427p
	 tJCiy4X0NutIFJNk5S71YrLFniBuDOt+VeTtMSaaFl7pdRqa2N22jLqzYQHKyMzaec
	 c4xRB5XbXmSsg==
Message-ID: <sashiko-outbox-171613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf: zstd: add streaming decompression and format
 probe functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivan Shapovalov" <intelfx@intelfx.name>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014-perf-zstd-v1-3-9652727886fa@intelfx.name>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
 <20261014-perf-zstd-v1-3-9652727886fa@intelfx.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 17:51:34 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf tools: zstd_is_compressed() returns true on file open failu=
re
- [Low] perf: missing explicit <stdint.h> and <endian.h> for musl compatibi=
lity
--

commit a4c94e50df0d36cb48138075042eb1c0c1527f18
Author: Ivan Shapovalov <intelfx@intelfx.name>

    perf: zstd: add streaming decompression and format probe functions
   =20
    Add an actual streaming zstd decompression (fd->fd) entry point,
    plus a file->fd wrapper and a helper to detect zstd magic on a file
    for compressions[] in dso.c.

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 3af8910bb87cf..982655a1f1a51 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c

[ ... ]

> @@ -172,3 +176,103 @@ size_t zstd_decompress_buffer(struct zstd_data *dat=
a, void *src, size_t src_size

[ ... ]

> +bool zstd_is_compressed(const char *file)
> +{
> +	int fd =3D open(file, O_RDONLY);
> +	const uint32_t magic_le =3D htole32(ZSTD_MAGICNUMBER);

[Severity: Low]
Does this code need explicit inclusions for <stdint.h> and <endian.h>?

It appears compiling perf tools with musl libc could result in a build fail=
ure
here, since musl enforces strict POSIX header namespace separation and does=
 not
leak uint32_t and htole32 through other standard library headers.

> +	char buf[4];
> +	ssize_t rc;
> +
> +	if (fd < 0) {
> +		pr_err("zstd: failed to open(%s): %s\n", file, strerror(errno));
> +		return -1;

[Severity: Medium]
Since zstd_is_compressed() returns a bool, does returning -1 here implicitly
evaluate to true?

If open() fails, returning true could cause callers probing file formats to
erroneously identify missing or unreadable files as valid ZSTD-compressed
archives. This could break fallback logic and lead to downstream decompress=
ion
attempts on missing files.

> +	}
> +
> +	rc =3D read(fd, buf, sizeof(buf));
> +	close(fd);
> +	return rc =3D=3D sizeof(buf) ?
> +	       memcmp(buf, (const char *) &magic_le, sizeof(buf)) =3D=3D 0 : fa=
lse;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-perf-zstd-=
v1-0-9652727886fa@intelfx.name?part=3D3
