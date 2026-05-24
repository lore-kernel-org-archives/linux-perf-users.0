Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3D1CD1E4
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779597471; cv=none; b=RwsLZN5QtNll24xoOqhmQnO8juFxtfGNL5bdArFafjzOAZOq6h+iUOxnAFn7iHyKEAUyLoyqmk6+RxhAvz653Qx5cT8YJG4LjqYngUKjgr6fHfYpGj5UV8juGKddOjoJqYzEuVMEcFPwHu5xJhGtrYRfFqWOKcguBQdSF+jtPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779597471; c=relaxed/simple;
	bh=ujOeILi2GuB4kJiYDFgu4378Wkvz63fvpnLjD7mgMws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKSx533dwIoMLw8EUk1sYo2XEdU308lEap0LcY4hstpQ56DtnPqM2Kc9Qvq6qV64kTdMwJTAVIUV+LvNs+0uI4kCN3OLPk34kwqdeFoVY6WIGGRw79x4hn0SSvehjnZG85ioko7MdfFyiMe6foYPVgTZR2dwHsYlStRD0Qpep7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh7v3bFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh7v3bFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884621F000E9;
	Sun, 24 May 2026 04:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779597469;
	bh=eMhT2+bv6Cw9ItplAhQ5+LrQ4hU66qp+jVDTve2kSEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kh7v3bFVqkcsu96ckXULY9Q4JyAeZ8Jrf2mYOQKkvqRjW2E8oDT0bCP4eZ9YN3arn
	 /Y657n/ALoyUF+bsZY6ByLanXEF8cN8NME6hkqHDFn2eIxDuEMNqBKw8JWf/yaHy3b
	 3L5ZwzOWlUqQDraYLWX51fU/toz8fyWzEOM4i1NlqePMjaSp33teKR1ut8lhxNqelO
	 GdoXhFpFhb+1sBW5Ntv3kEzHAG+nfD1NPcdzC03+kmgOCUMU4vFcdUyxI9mdL1Mfhf
	 iNyZGVzyDB8jSqMmoIRmgL6ggAVgo45nHG4fcFpuWTWpyS4xwQUXcS0KXK4TLqcXGg
	 Eji/6+PpVi8+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/29] perf header: Validate feature section size and
 add read path bounds checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-21-acme@kernel.org>
References: <20260524032709.1080771-21-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:37:48 +0000
Message-Id: <20260524043749.884621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap-based buffer overflow in `do_read_bitmap` due to integer =
truncation when allocating memory for the bitmap.
--

commit cc5b58f0cdfbb325e108ed3d2172a494b021af26
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate feature section size and add read path bounds checking

This commit hardens feature section parsing against crafted perf.data files
by validating section offsets and sizes against the actual file size. It
also adds uniform bounds checking in __do_read() and explicit null-terminat=
ion
for strings to prevent out-of-bounds reads.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index fe23bbd8370c0..90417a478c8db 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -233,23 +233,32 @@ static int __do_read_fd(struct feat_fd *ff, void *a=
ddr, ssize_t size)
[ ... ]
>  static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
>  {
> +	/*
> +	 * Reject negative sizes, which on 32-bit can occur when a
> +	 * u32 >=3D 0x80000000 is passed as ssize_t.  The cast to
> +	 * ssize_t is safe because perf_header__process_sections()
> +	 * validates that each section fits within the file size
> +	 * before any feature callback reaches here, and only
> +	 * feature sections (metadata like build IDs, topology, etc.)
> +	 * use this path =E2=80=94 these cannot legitimately approach 2GB.
> +	 */
> +	if (size < 0 || size > (ssize_t)ff->size - ff->offset)
> +		return -1;
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but exists in the handling of
malformed perf.data files.

In do_read_bitmap(), we read a 64-bit size value and pass it to
bitmap_zalloc():

tools/perf/util/header.c:do_read_bitmap() {
	u64 size, *p;
	...
	ret =3D do_read_u64(ff, &size);
	...
	set =3D bitmap_zalloc(size);
	...
	for (i =3D 0; (u64) i < BITS_TO_U64(size); i++) {
		ret =3D do_read_u64(ff, p + i);
	...
}

Because bitmap_zalloc() takes a 32-bit 'int nbits', could a crafted 64-bit
value like 0x100000001 be silently truncated to 1?

This would result in a tiny 8-byte heap allocation.

Since the loop calculates its iteration count using the full, untruncated
64-bit size, could it proceed to read 64-bit words into the undersized heap
buffer via do_read_u64()?

Given that the loop's reads are only constrained by the overall section size
(ff->size) checked here in __do_read(), could an attacker craft a section
large enough to copy arbitrary data over adjacent heap memory?

(Note: This issue is fixed later in the patch series by commit "perf header:
Validate bitmap size before allocating in do_read_bitmap()".)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D20
