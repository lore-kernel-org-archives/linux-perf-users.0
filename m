Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350496;
	b=NiUUJxGv3JR64FEPoLHPWedklGV2iS9/mqhbwu9de4qL3njJKfBX3VLX24w7JLVeobNe
	 jYIMAEcgUHeBBtIgSHUBeGXELsICXYXgqRkYImkFMnANJCYj5BlQgS5KKgZSjn2I3Yg2J
	 QEuizjPKMj1ECmcO+K4v4r6VIoNmYQQiQOFNOigBm1mN87i6pTkaoiANbTXpaOIS8Obod
	 VsT50ti5d7TfGAN7KnFxup3jPkY6V/FJHYlqSTJLfeho0KXHm6zD55WLPcigBtHprFA/D
	 0aAjSTuLcp/DdqOxym8kKaGTIFjd/IQWvu/6X0pUGBdNpyGc6Ugy6Pv8h+hfeDBLPzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YBNbvsxKzRePVO6/QF6BpDp8nSa0rJzovFHkW40C7WE=;
	b=5KI4EPhXHq4Gt95EAp7TntwBpT7uMP1g554bSpQBBS36yf9q4ffwgBfbl/Gt+IS3p4Sz
	 t/UV6Vd6FD6wUgbqxLchdcUnIP7Op7FSCnnI1eVhkYzfc8l/SSP5kwJ3qDyNhSR7k5vqg
	 j3Ds5XlTkBI4KqeXl8IAbkOrgm23+IBDOiR6VInoOn/+chuONVE7/r4T4m76Sivl5O6an
	 7WSJiHMTN7EeiDjU4Z4JzYc7ygQNvGbRHBGMgcEJ0TSqDt9wtRSasfoRNzLU91NK+9X6S
	 LMLityLU/lIs562rN4J0eaUHJJxt2HPGDTLBPabYWBbxYMa5mz2WexQ0F6Kb2TB22UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5godb2V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2102606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5godb2V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E3C1F008A2;
	Tue, 10 Nov 2026 22:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350495;
	bh=YBNbvsxKzRePVO6/QF6BpDp8nSa0rJzovFHkW40C7WE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5godb2Vr1APvCiCnxuIEPvf4dKZL9t70zD+hPpsLd4Qyc2AtbL67NJi/tz5l1/TC
	 Iya8JNlZN4n/1qzeWJ67rc59YbobZSg+MTjIY+7PogNoK4dpgRus12GWp9vIMeNuqK
	 jzzpiFZWdvTQJuFwz3bKvR4x7wDOlzNIMVLO8zsPYEWtF12xRP8xlk0wrkKQXi0Pae
	 oTNLVKsezBXeY/81pTTRU2OoKxiskHD7o2g5CeVn5/9xkd5JvqDMDGmudrGVkGPBLG
	 48RHZCdGVXNDJHM5qG/GQce1qG7QCkXlG5g/DyecbZzJRmzVccmGsxMuM4vAkzlzSC
	 jgBnK6PCVh1CA==
Message-ID: <sashiko-outbox-207840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/20] perf symbol: Switch backing storage from
 rbtree to struct symbols array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-16-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:41:34 +0000
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
- [Medium] perf symbol: missing end address tie-breaker in
  symbols__sort_cmp()
--

commit 0573604acc8bf2d5351a71f4fe63cacfd8d508e5
Author: Ian Rogers <irogers@google.com>

perf symbol: Switch backing storage from rbtree to struct symbols array

This commit replaces the embedded rbtree node in struct symbol with a
locked, lazily-sorted pointer array in struct symbols and updates symbol
iteration and lookup callers to use it.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index ec2a78873b903..66c5bd0386362 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -213,57 +213,153 @@ static int choose_best_symbol(struct symbol *syma,=
 struct symbol *symb)

[ ... ]

> +static inline bool symbol__less_or_equal(const struct symbol *a, const s=
truct symbol *b)
> +{
> +	return symbol__start(a) <=3D symbol__start(b);
> +}
> +
> +static int symbols__sort_cmp(const void *vlhs, const void *vrhs)
> +{
> +	const struct symbol *lhs =3D *((const struct symbol **)vlhs);
> +	const struct symbol *rhs =3D *((const struct symbol **)vrhs);
> +
> +	if (symbol__start(lhs) !=3D symbol__start(rhs))
> +		return symbol__start(lhs) < symbol__start(rhs) ? -1 : 1;
> +	return 0;
> +}

[ ... ]

> @@ -397,97 +495,94 @@ static void symbol__set_idle(struct symbol *sym, bo=
ol idle)

[ ... ]

> -static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 =
ip)
> +/*
> + * Binary search @symbols->symbols for a symbol covering @ip. Lazily sor=
ts
> + * @symbols under @symbols->lock if unsorted.
> + */
> +static struct symbol *symbols__find(struct symbols *symbols, u64 ip)
>  {
> -	struct rb_node *n;
> +	int low, high;
> +	struct symbol *res =3D NULL;
> =20
>  	if (symbols =3D=3D NULL)
>  		return NULL;
> =20
> -	n =3D symbols->rb_root.rb_node;
> +	symbols__sort_read_lock(symbols);
> =20
> -	while (n) {
> -		struct symbol *s =3D rb_entry(n, struct symbol, rb_node);
> +	low =3D 0;
> +	high =3D (int)symbols->cnt - 1;
> +	while (low <=3D high) {
> +		int mid =3D low + (high - low) / 2;
> +		struct symbol *s =3D symbols->symbols[mid];
> +		u64 start =3D symbol__start(s);
> +		u64 end =3D symbol__end(s);
> =20
> -		if (ip < symbol__start(s))
> -			n =3D n->rb_left;
> -		else if (ip > symbol__end(s) || (ip =3D=3D symbol__end(s) && ip !=3D s=
ymbol__start(s)))
> -			n =3D n->rb_right;
> -		else
> -			return s;
> +		if (ip < start)
> +			high =3D mid - 1;
> +		else if (ip > end || (ip =3D=3D end && ip !=3D start))
> +			low =3D mid + 1;
> +		else {
> +			res =3D s;
> +			break;
> +		}
>  	}
> +	up_read(&symbols->lock);
> =20
> -	return NULL;
> +	return res;
>  }

[Severity: Medium]
Should symbol__less_or_equal() and symbols__sort_cmp() also compare
symbol__end() when two symbols share the same start address?

Because they only compare symbol__start(), a sized symbol [X, X + L) can
precede a zero-length alias [X, X) at the same start address (for example
when symbol_conf.allow_aliases is set or when both .symtab and .dynsym
define symbols at X).

If symbols__find() looks up an ip in (X, X + L) and mid lands on the
later [X, X) entry, ip > end advances low =3D mid + 1, skipping the
covering [X, X + L) entry to its left and returning NULL.

In addition, during ELF loading symbols__fixup_end() runs before
symbols__fixup_duplicate() and extends a trailing [X, X) entry up to the
next distinct symbol address Y, inflating its size before
choose_best_symbol() compares lengths, and map__fixup_end() can pick the
shorter symbol at symbols->symbols[symbols->cnt - 1] as the map end.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D15
