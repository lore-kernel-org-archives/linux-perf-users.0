Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245989;
	b=3NBUjI2P6K/jC59xEmTVpGeiJjFORrCVkPgFMGU4uCIqTldkT+sAxbU55kEmzJ+aew8T
	 Mf9eecLJKazXsYKTGalp6gYID4J4jLpIbQdCiGEBsTL2rRoWCi1ACpZiVqCPlirjVzwZq
	 joQuibGBYO+FmztT3ky3u0eWQW12Qbhq22ITefSnjXhyi2KChfXOvBVUyvAZzgvmFi7jS
	 6nzOJA3OKC6kOzQn4DpUDwZ5+A/hHb8a9Riytni1YfWKj0NL5VORtQK9GZW/7anIb9zUr
	 +xwzjcF83rwFmKfvhhgaKWmPdjiT/ZOjaQuzXsXjwRDqqR4sTU1zBHBT2BITlZNuzkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jE/0HN5OL+5/lCFty3fivQoPRKeNkuMJbwHsyA13jcg=;
	b=IekKggrTjp6NptsmAeJ74vrtdyZbJX3vrGKkVsvEFKJaoSwTYxQE44O58KIMdb7w9Pk4
	 KuHPxm2cUBJ9R0WoNwsogzf9uHd6Lc+HxGlVT4c29vbzz04/NuGyRGaPdDnCpD/F2MKuN
	 YasbON9OM5aKzXgMM6vZDUjqZF79t0dfwSTr5ptMA15p4jkknfoQCt22GmHpWox7uIABB
	 YnuP6FTqjblmIRKhXN0OgVTQiHCnolqIJcmEzahZV4IdQPlY7/FethnCIKpoLvqTTIlzq
	 J3aNxroY/pEtLk4VQV83fL09Vv7Evnw0JOnfhJEgl8rQMUWBlpzJxOa1aRJVqvmmb2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkIX7b+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92130606A320
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkIX7b+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E36B1F000C4;
	Sat, 21 Nov 2026 07:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795245989;
	bh=jE/0HN5OL+5/lCFty3fivQoPRKeNkuMJbwHsyA13jcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkIX7b+0KXNadu5zJ8zvnwhjaiQtaZ6cNTPYdP/XgKA60W5BU+9e9wnbdLikZa+EN
	 BE8THfIHFKVt3OjTa1QGw2R8QqoEqMcADv9OoTR7UpbKr56z2rUTYz9+sJ7xErL4FP
	 isiyi0Ce1u0aBE3saV5UxDghIBjrn8IS002+RQvIRSFPwmI0IQMvbGz/PV5WU2n9dv
	 rwy+gMn+/lr4pHikA1pipsfi3LrPa6qgGbzmplZzvosIe9N2P19kHb2J6aidSALvD9
	 QgnhZminhL5CjLJe9IpvmQCBp6Nhh5hi200OHLyMiq/q47JimpM6T2i8UY0lKdfLeZ
	 DFRkdLAKsxE6w==
Message-ID: <sashiko-outbox-226773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] perf symbol: Optimize incremental symbol
 insertion with sorted tail
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121071651.67118-8-irogers@google.com>
References: <20261121071651.67118-1-irogers@google.com>
 <20261121071651.67118-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:26:28 +0000
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
- [Low] perf symbol: redundant prefix scan in symbols__sort_locked()
  fast path
--

commit 1abf9914a30c24a8a1249efd5024c7868a9413c0
Author: Ian Rogers <irogers@google.com>

perf symbol: Optimize incremental symbol insertion with sorted tail

This commit optimizes incremental symbol insertion and small-append sorting
by tracking a sorted prefix length in struct symbols, adding an in-place
binary insertion fast path for small appends, and maintaining a sorted tail
buffer for out-of-order dynamic symbol insertions.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 114fe5ea38915..0eaeced63cd47 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -432,12 +434,47 @@ static void symbols__sort_range_with_tmp(struct sym=
bol **arr, unsigned int n,
> =20
>  static void symbols__sort_locked(struct symbols *symbols)
>  {
> -	if (symbols->sorted)
> +	unsigned int m =3D symbols->sorted_cnt;
> +	unsigned int k;
> +
> +	if (symbols->sorted && symbols->sorted_cnt =3D=3D symbols->cnt)
> +		return;
> +
> +	if (m > symbols->cnt)
> +		m =3D 0;
> +	k =3D symbols->cnt - m;
> +
> +	if (k =3D=3D 0) {
> +		symbols->sorted =3D true;
>  		return;
> +	}
> =20
> -	if (symbols->cnt <=3D 64) {
> +	/*
> +	 * When only a few symbols have been appended since the last sort
> +	 * (including single-symbol insertions), insert them directly at
> +	 * their binary-searched sorted positions in O(N) without allocating.
> +	 */
> +	if (k <=3D 8 || symbols->cnt <=3D 64) {
>  		symbols__insertion_sort_range(symbols->symbols, 0, symbols->cnt);
> -	} else {
> +		symbols->sorted_cnt =3D symbols->cnt;
> +		symbols->sorted =3D true;
> +		return;
> +	}

[Severity: Low]
Does passing start =3D 0 to symbols__insertion_sort_range() in the k <=3D 8=
 fast
path scan the entire already-sorted prefix [0 .. m)?

tools/perf/util/symbol.c:symbols__insertion_sort_range() {
	for (unsigned int i =3D start + 1; i < end; i++) {
		struct symbol *sym =3D arr[i];

		if (!symbol__less_or_equal(arr[i - 1], sym)) {
			unsigned int pos =3D start +
				symbols__upper_bound(&arr[start], i - start, sym);
    ...
}

When symbols__sort_locked() is called after 1 to 8 out-of-order symbols are
appended to a large sorted table, the loop walks i from 1 through m - 1 and
dereferences every pair of adjacent struct symbol pointers in the prefix
before reaching the k new entries at index m.  Starting the insertion loop =
at
max(m, 1U) while keeping the binary search base at index 0 would avoid
scanning the sorted prefix.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121071651.6711=
8-1-irogers@google.com?part=3D7
