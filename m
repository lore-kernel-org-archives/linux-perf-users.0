Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589753;
	b=xKi5XG1XxL1dhgqgz5x8a5Pb5uizIRTSoxdHnYpxu2Fq4TCkvrVUHK7fahhnquM2pNXs
	 5exyNvizLqS+GivtkGO/P3cZA+0PNbCiLX8gq1GVlKf2s/PxKrqvkMVxLMqROcgWZ8bpD
	 1iq+drVk9m5PzANtENnRuDgOVuIV1RfElsPQ79YT4QPPkhLD2qIkjHk3vN0q3UW79pbLO
	 RaV33IZrqkLRdY5zgOEAqiP8phH4//mFOmhR1sfmWMi+rzIJMn5swfk7Z9ZmiQ6FpdxM7
	 Xu2T7yxKdKNHmvMc5WtDYOy3P/VPJwqH24noRNr4hXG1XSDNmS5+X64+FRmMQvf45Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5/cvQ/WpERcEiojhvfIwM6kY1cfonNI9IUH8+1mrPdk=;
	b=KLQW4sGrrpO7jT9Ep8+flOSBTWEA5DlFBUjc+dqAQG65X1hF7ezOe3Fyu1kikjykdGiI
	 tBtp2NTRkAX0A+nq+N37BSAkupnpi+l56GBnbAxUNVYbuvYSD+yCTbRtAs3AirLTlYH/H
	 tAOKc87lWPPMURljQBJG2Jz/E3NMk8/KXfFk0VBkImonB2c2vBQf89YX0I08rrYjKk7tX
	 KaI3tWPUXgglpOE+2TKF3MjmSyHxvyfxdV+ZypTPfWC73OLYrV3VLQQM+zfaFJXg4MLPM
	 yh9A4QPZNf+DdQnqZjlvSGXQMrkAu4TOiQUUlaezDe0VybCIZwEyohQ077J/a6aJ6wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xii9RDBd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E5606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xii9RDBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB031F000C7;
	Fri, 13 Nov 2026 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589752;
	bh=5/cvQ/WpERcEiojhvfIwM6kY1cfonNI9IUH8+1mrPdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xii9RDBdBmSsUp2vxmVV4gVa7bmEFLAJYQzdY0w18YTux7si3mg6QCnw8Fro5vmbe
	 u+BU4Jcu1Ij18OmynnWXvLBJBZD2lpFdLdUbUXOSBw9p3GEyLIvZKjid0LknasmsRH
	 L5bg5+aS427UAW1mv9dPnLG594RsWtIiNRj2itJrUjsooz2ZI6l9s1XjX+lXdgkv30
	 2s0UwIv7TQnR5EpRKTpaZjpepupEr+1owkQobd1f+oFWTMaeLkaOrNbx3uhAohfQbM
	 1VcroatQWFYBqMujegqHV6r2dyhpkRrkHmok2sSky2LQ2mwpl9vHjNFt810dwNC4t6
	 Ekve8Bbbj3k7g==
Message-ID: <sashiko-outbox-213278@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/21] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-13-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:09:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf dso: broken bsearch() ordering in __dso_id__cmp() with
  build_id
--

commit c6037e2ef92de325486412d51231ca52f297ef40
Author: Ian Rogers <irogers@google.com>

perf dsos: Use read lock fast path in dsos__findnew_id()

This commit adds a read-lock fast path to dsos__findnew_id() and
prioritizes build IDs over inode fields when comparing and improving DSO
IDs.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index f0e02062c09c8..f736a94a53a97 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1649,6 +1649,11 @@ static void dso__set_long_name_id(struct dso *dso,=
 const char *name, bool name_a
> =20
>  static int __dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
>  {
> +	if (build_id__is_defined(&a->build_id) && build_id__is_defined(&b->buil=
d_id)) {
> +		if (a->build_id.size !=3D b->build_id.size)
> +			return a->build_id.size < b->build_id.size ? -1 : 1;
> +		return memcmp(a->build_id.data, b->build_id.data, a->build_id.size);
> +	}
>  	if (a->mmap2_valid && b->mmap2_valid) {
>  		if (a->maj > b->maj) return -1;
>  		if (a->maj < b->maj) return 1;
> @@ -1663,11 +1668,6 @@ static int __dso_id__cmp(const struct dso_id *a, c=
onst struct dso_id *b)
>  		if (a->ino_generation > b->ino_generation) return -1;
>  		if (a->ino_generation < b->ino_generation) return 1;
>  	}
> -	if (build_id__is_defined(&a->build_id) && build_id__is_defined(&b->buil=
d_id)) {
> -		if (a->build_id.size !=3D b->build_id.size)
> -			return a->build_id.size < b->build_id.size ? -1 : 1;
> -		return memcmp(a->build_id.data, b->build_id.data, a->build_id.size);
> -	}
>  	return 0;
>  }

[Severity: Medium]
Can moving the build_id check ahead of mmap2_valid break the bsearch()
ordering in __dsos__find_by_longname_id()?

A DSO created from an MMAP2 event without a build ID has mmap2_valid =3D
true, and retains mmap2_valid =3D true when a build_id is later added via
__dso__improve_id() or dso__set_build_id().  If two DSOs with the same
long_name have both build_id and mmap2_valid set (for example, after a
library is replaced on disk), qsort() orders them in dsos->dsos by
build_id.

When dsos__findnew_id() later searches for a lookup key that has only
mmap2_valid set and no build_id, __dso_id__cmp() skips the build_id
comparison and compares (maj, min, ino) against an array sorted by
build_id.  If the build_id order and inode order disagree, bsearch()
searches the wrong half of dsos->dsos, misses the existing DSO, and
inserts a duplicate entry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D12
