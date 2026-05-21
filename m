Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5833EF
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330885; cv=none; b=QAehmZqeU8UfZJrVFvmYrvG/0UK6lnaOzmCoN23ss42BEST2O0JB48RspBfLq4+vPjBr+aglbGY+6xqEsJX4vG3joVItNgWNGn95rCIMh37xTLzrhgD4LYz/usze++o07DA9OEl47wzEJgurPM0GEDbHSzf5t3jtQBNFFQCDSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330885; c=relaxed/simple;
	bh=OV7eQi6Hca+7L05L8RLJPFr77yXH+JJljHdpEsh8j10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rlnjy85m+a6ZdpECg/wJvkuVcKLZBjtdRaIh1JcWLR41pIaGoyo/oOiriuO3ujGte78PvJu5+a/MqXgeaDgvebdBnVQHUoI2mugq9Ati8IMy5/fSmUxJfbATWueKC3gaZjhqE/YA1hW0olwuTr/3YQL7O20dqbd9pUKDHlYNhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTUNuvK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTUNuvK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A73B1F000E9;
	Thu, 21 May 2026 02:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330883;
	bh=sAbitVZPPCIE/aOvFNpKJoc8F2rylLulajjKpDK23cQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UTUNuvK/cmIhHSww7F+Xs2EWgKmf33HbhJ902YLamsDYK++Q4wtWta1SUXdnkleEE
	 eWfTfj9ZL13P6d8o85WRrHNoG0nwH8dJOA0CGz80a170ijUxcrk9QgKCD9XA4gt1E4
	 79whJNPdjXi0trTe96r+1vROwlV3I0BF3N35fjM3hBOQhgjHb1qj3Y3U++1d8nhdHB
	 2QFmP8rvb8h8ObxR4GYLY8eJYqaoScRqDmwkAhinu2Rvyt3jlL1Z79NyFGGFMUzT3a
	 Cric8x1nT0yzAgKZ3T2F6vYdpVVLYkQigLm0u+PUBe5r477LyJjZmKEgh2D8CT7lFH
	 tTjBXtSQ5/0LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/27] perf header: Validate feature section size and
 add read path bounds checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-20-acme@kernel.org>
References: <20260521011027.622268-20-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 02:34:43 +0000
Message-Id: <20260521023443.9A73B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer truncation in `bitmap_zalloc` within `do_read_bitmap` =
leads to an out-of-bounds heap write.
--

commit dbe69088d8136cd30dd3613e5e0ed7f6bf18b60b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate feature section size and add read path bounds checking

This commit hardens feature section parsing against crafted perf.data files=
 by
adding bounds checking to the read path. It adds fstat() checks to ensure
section offsets and sizes do not extend past EOF. It also uniformizes bounds
checking in __do_read() and adds null-termination safety to do_read_string(=
).

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index ad0a6aab8a6d5..bea1446046282 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -289,16 +298,25 @@ static char *do_read_string(struct feat_fd *ff)
>  	if (do_read_u32(ff, &len))
>  		return NULL;
> =20
> +	/* At least the null terminator. */
> +	if (len < 1 || len > ff->size - ff->offset) {
> +		pr_debug("do_read_string: invalid length %u (remaining %zu)\n",
> +			 len, (size_t)(ff->size - ff->offset));
> +		return NULL;
> +	}
> +
>  	buf =3D malloc(len);

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential integer truncation =
and
out-of-bounds heap write in do_read_bitmap() which is located just below th=
is
function in tools/perf/util/header.c.

In do_read_bitmap():

static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *ps=
ize)
{
    unsigned long *set;
    u64 size, *p;
    ...
    ret =3D do_read_u64(ff, &size);
    ...
    set =3D bitmap_zalloc(size);
    ...
    for (i =3D 0; (u64) i < BITS_TO_U64(size); i++) {
        ret =3D do_read_u64(ff, p + i);

Since bitmap_zalloc() takes an int nbits, if size is a large 64-bit value l=
ike
0xFFFFFFFF00000040, wouldn't it truncate to 0x40 and allocate only 8 bytes?

Since the loop uses BITS_TO_U64(size) which operates on the full 64-bit val=
ue,
could this result in an enormous loop count, sequentially writing
file-controlled data out of bounds on the heap?

I note that this is addressed by a subsequent patch in the series, but I am
mentioning it here as part of the bounds-checking review.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D19
