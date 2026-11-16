Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813492;
	b=pt7AL/WM45n/czG9pdmXDFt4NtprpXzgk4BEfWk79MncYK/znF8KAEfVNnFZM+9E9+CI
	 1DYKCIkn4GTQJgpMfTitpXxvj8LxpoF/AaqhM4ZlT9A6DRqjKKnr2BjjHNT5o/cO/oKKa
	 1xRxwsSF/hCfGhdOVPzoaj/1f/yc/oCO2/djB5cFWdKlOybuQQ84bnetJVU55brtVmuVk
	 LNWWjdL+Ild2eWpLQbwVO6YoUGbCnBC+59u8uStOa0fqE6z05338vkyzqQxLrwveAzcnc
	 YqnMUNXbNeoH9YChB9Sy0kcNVrL0A/lO6xK/Rpbs5N9GygRxTGx0eWY0HTg3XTOJ2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G6/Z1pkHr+urpMsG5Mgaks1l3Lmvfk6OLLyC3/jYG44=;
	b=mYLfjfJEXCaASS4/XqGRCP09w9VhZMl6/Hb6usfj4rOpsTHsUVdbpzeFL4/CayUExPP5
	 HCRW4syG5VkHx0RcAb7cqxlm42uMUzoEF/v7aWlfdYro9T1wlTvZUYs5sZoQuObm5vcIQ
	 RYg8JlVclMgoNM7yDL0Ecc2rKLYi0EQQHA0oQ7c3hSUoNoUWkUgS1uqmxqWRqJr7Bsz6h
	 NpD92Mae/tnXZZKRgIynx1Ny2RtKnA48jscLe2/g4eLYFktwdIdMTb1SRBUe+Eyq63pqy
	 2PdrhMlgzp0TmdAzcJEBfQ8bs1W/fx2uOEMlg/sHF62dEI0V2EfZGtJ8gr0FktmWKOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dT1KwhLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4752606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dT1KwhLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A61F000C6;
	Mon, 16 Nov 2026 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794813492;
	bh=G6/Z1pkHr+urpMsG5Mgaks1l3Lmvfk6OLLyC3/jYG44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dT1KwhLEMRQKPGpkdx0BOQJROerQeUmabvpZMpk3HOOOmSOyDpKZHSRyJIlCFp+T5
	 ReYwqthKjtSpoT8z+FWLJLqyCl2wOeqBv7wZp3Tjz9SynlfPkymzTcPus4rbldt1f+
	 msmnDSruEOYxIHq64uSicziWdWtg4eJb06DEOXzmImgXB9aYnTIj4wZWkZtByHbzXY
	 CPZYCLHnRSzHHCobYl0J4NJGpb9nOpxTtg1H9jIbR8Vrs8qcn8kIB0aB+446NrzGLY
	 wI7SIIDOsY4R4FFiUp/Nuj0wnlcphlJ+uUJHCO7BjVbUfl/Xe847adAVSewodGfLT+
	 xGj3NYzf2EwZg==
Message-ID: <sashiko-outbox-216402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] perf symbol: Optimize symbol sorting with
 natural-run merge sort and binary insertion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-7-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:18:11 +0000
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
- [Medium] perf symbol: wrong lookup in symbols__find() across split
  sorted tail
--

commit fe0c37e5a14b36cd2ffee46afb7fd00db4d2fa19
Author: Ian Rogers <irogers@google.com>

perf symbol: Optimize symbol sorting with natural-run merge sort and binary=
 insertion

This commit replaces full-array qsort() with natural-run merge sort and
binary insertion, and maintains a sorted prefix and sorted tail to speed
up incremental symbol insertions and sorting.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index f1e3d7af714c1..8a47d1a44e5c7 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -589,8 +935,24 @@ static struct symbol *symbols__find(struct symbols *=
symbols, u64 ip)
>  	if (symbols =3D=3D NULL)
>  		return NULL;
> =20
> -	symbols__sort_read_lock(symbols);
> -	res =3D symbols__find_range(symbols->symbols, symbols->cnt, ip);
> +	down_read(&symbols->lock);
> +	while (!symbols->sorted) {
> +		up_read(&symbols->lock);
> +		down_write(&symbols->lock);
> +		symbols__sort_locked(symbols);
> +		up_write(&symbols->lock);
> +		down_read(&symbols->lock);
> +	}
> +
> +	res =3D symbols__find_range(symbols->symbols, symbols->sorted_cnt, ip);
> +	if (symbols->sorted_cnt < symbols->cnt) {
> +		struct symbol *tail_res;
> +
> +		tail_res =3D symbols__find_range(&symbols->symbols[symbols->sorted_cnt=
],
> +					       symbols->cnt - symbols->sorted_cnt, ip);
> +		if (tail_res && (!res || tail_res->start > res->start))
> +			res =3D tail_res;
> +	}
>  	up_read(&symbols->lock);
> =20
>  	return res;

[Severity: Medium]
Can symbols__find() return an earlier symbol instead of NULL when a
symbol with a higher start address in the other sorted slice ends before
ip?

In a single sorted array, symbols__find_range() only checks
symbol__covers() on the equal-start group with the highest start <=3D ip
and returns NULL if those symbols end before ip, even if an earlier
symbol still covers ip.

When dso__insert_symbol() places an out-of-order symbol into the sorted
tail (for example via symbol__new_unresolved() or db_ids_from_al()),
calling symbols__find_range() on the prefix and tail independently loses
the highest start <=3D ip whenever that slice's candidate does not cover
ip and returns NULL.  If the prefix has [0x0, 0x40) and the tail has
[0x20, 0x30), looking up 0x34 gets res =3D [0x0, 0x40) and tail_res =3D NUL=
L,
so symbols__find() returns [0x0, 0x40) until the tail is later merged,
after which the same lookup returns NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D6
