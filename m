Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CFF31F99A
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869336; cv=none; b=p3L/YGzM9P/jy1p2MirwKFpzl5BemkqEOht1jDKR2u9wt7iOBhNRdNHl5PxdXH5/rd858rloPIP3uP4n+8PkW/zxaa6Rt3cLDXB1QGoNPd38qON8HsD+9+z9Qoq3z6Kqt+F/BGdzrd/h83CAy6ndKuWhkcNRwI+wM2RuKWfCKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869336; c=relaxed/simple;
	bh=sX0ZvkkEyuRlD8SwJlo0/y1DKgPrrpbWzxqgC4AZOYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jy6PFdBmy7w3+uZrAE2fh/brAt2Q1jppwiekbpyxtzfVo/fDoqxHQI+WRjO4BKkE3nCcC2ZFBUk6Zy1q/UgpuQeMUe06whz1/QpDuo1S4h/MFM4IOEldrvGvy1ab0pDLqC7Qusk0WPaAJu1xZEDIJBsL88kGRmQ3SVP6kSg27tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Boz1bV+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Boz1bV+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765721F00893;
	Sun,  7 Jun 2026 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780869334;
	bh=2RZDfhB6TBQFqy41XfDfBTvbN0cRX931FMjfHpc3278=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Boz1bV+/Ssn0NfyHRH+xtUizqIJbCQU+CDTbueG7VboiVlFT183WwXYs0xkqmF0E3
	 2PSPU/a1fUNMTADxikVVKcf0YOpyL7KKaccDuHA5UmZK/0cyKS0I3SvkTzLj/erqXI
	 Q5YYH1wu4KFf0sgXLDsFI7n6qn88BZFzyDEiTgaeaJdCbFTn1zEE2OIalJ7XLP5Nhs
	 c22oVJxa66rLUBAnQG/cB613pmdNgkCM4JG2JQ3zlh8bc//b8w/Zev47bdgCTooG7u
	 lxE/f8JwG6BMvBtMLsrj/QWPYUMudBVPBg2J5SYVRpLPHSBtN3kaqx58pS8Zzji5K6
	 341gtd5ls1QHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 1/5] perf maps: Add maps__mutate_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607213700.3563842-2-irogers@google.com>
References: <20260607213700.3563842-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:55:34 +0000
Message-Id: <20260607215534.765721F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch fails to add the mandatory `maps__load_maps()` pre-loadi=
ng call to `perf inject`, violating its own architectural contract and leav=
ing the tool vulnerable to deadlocks.
- [High] `maps__load_first` triggers a guaranteed read-to-write self-deadlo=
ck due to the new locking rules.
- [High] Lockless reads of map boundary fields (`start`, `end`, `pgoff`) in=
 `maps__find_symbol_by_name` and `maps__find_symbol` cause TOCTOU/inconsist=
ent reads.
--

commit b899514520f2642fd2ff0bdc70f3cfeac8916515
Author: Ian Rogers <irogers@google.com>
Subject: perf maps: Add maps__mutate_mapping

This patch introduces maps__mutate_mapping() to safely update map address
boundaries under a write lock, fixing a race condition with concurrent map
lookups. It also introduces maps__load_maps() to pre-load kernel maps and
updates symbol parsing paths to use the new synchronized mutator.

>     lock. Callers (such as perf inject) must pre-load all kernel symbol
>     maps up front at startup using maps__load_maps(), completely bypassing
>     dynamic runtime mutations.
>    =20
>     Fixes: 39b12f781271 ("perf tools: Make it possible to read object cod=
e from vmlinux")
>    =20
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Assisted-by: Antigravity:gemini-3.1-pro

[Severity: High]
The commit message explicitly mandates that perf inject must pre-load maps
up front to avoid deadlocks. Does tools/perf/builtin-inject.c need to be
updated in this patch to include the maps__load_maps() call?

Without it, perf inject might remain exposed to the recursive read-to-write
self-deadlock during lazy symbol loading.

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 923935ee21b66..b1b8efe421496 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
[ ... ]
> @@ -576,6 +576,49 @@ void maps__remove(struct maps *maps, struct map *map)
>  #endif
>  }
> =20
> +/**
> + * maps__mutate_mapping - Apply write-protected mutations to a map.
> + * @maps: The maps collection containing the map.
> + * @map: The map to mutate.
> + * @mutate_cb: Callback function that performs the actual mutations.
> + * @data: Private data passed to the callback.
> + *
> + * This acquires the write lock on the maps semaphore to safely protect
> + * concurrent readers from seeing partially mutated or unsorted map boun=
daries.
> + *
> + * WARNING: Acquiring down_write() here can trigger a recursive self-dea=
dlock if
> + * the caller already holds the read lock (e.g., during maps__for_each_m=
ap() or
> + * maps__find() iteration paths that trigger lazy symbol loading). To co=
mpletely
> + * avoid this deadlock, all kernel/module maps must be pre-loaded up-fro=
nt (via
> + * maps__load_maps()) under a clean, single-threaded context before ente=
ring
> + * multi-threaded event processing loops.
> + */

[Severity: High]
Does the newly introduced locking contract cause a read-to-write self-deadl=
ock
in the existing maps__load_first() API?

If another subsystem calls maps__load_first(), it acquires the read lock:

maps__load_first()
   down_read(maps__lock(maps));
   map__load(...)

If map__load() triggers lazy symbol loading, won't it eventually call
maps__mutate_mapping() which unconditionally takes the write lock via
down_write(maps__lock(maps)), deadlocking the thread?

[ ... ]
> +struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *=
name, struct map **mapp)
>  {
> +	struct map **maps_copy;
> +	unsigned int nr_maps;
> +	struct symbol *sym =3D NULL;
> =20
> +	if (!maps)
> +		return NULL;
> =20
> +	/*
> +	 * First, ensure all maps are loaded. We pre-load them outside of any
> +	 * read-to-write locks to avoid deadlocks. Even if some fail, we procee=
d.
> +	 */
> +	maps__load_maps(maps);
> +
> +	/*
> +	 * Create a local snapshot of the maps while holding the read lock.
> +	 * This prevents deadlocking if iteration triggers further map insertio=
ns.
> +	 */
> +	down_read(maps__lock(maps));
> +	nr_maps =3D maps__nr_maps(maps);
> +	maps_copy =3D calloc(nr_maps, sizeof(*maps_copy));
> +	if (maps_copy) {
> +		for (unsigned int i =3D 0; i < nr_maps; i++) {
> +			struct map *map =3D maps__maps_by_address(maps)[i];
> +
> +			maps_copy[i] =3D map__get(map);
> +		}
>  	}
> +	up_read(maps__lock(maps));
> =20
> +	if (!maps_copy)
> +		return NULL;
> =20
> +	for (unsigned int i =3D 0; i < nr_maps; i++) {
> +		struct map *map =3D maps_copy[i];
> +
> +		sym =3D map__find_symbol_by_name(map, name);
> +		if (sym && map__contains_symbol(map, sym)) {

[Severity: High]
Since the maps->lock read lock was dropped prior to this loop, is it safe to
call map__contains_symbol() here?

map__contains_symbol() accesses map->start and map->end. Concurrently, a
thread processing an mmap event could invoke maps__mutate_mapping(), which
mutates these exact boundary fields while holding the maps->lock write lock.
Will this cause a data race resulting in torn boundary reads?

The same lockless read pattern appears to exist in maps__find_symbol():

maps__find_symbol()
   ...
   if (map !=3D NULL && map__load(map) >=3D 0)
       result =3D map__find_symbol(map, map__map_ip(map, addr));

where map__map_ip() accesses map->start and map->pgoff after the read
lock was dropped by maps__find().

> +			if (mapp)
> +				*mapp =3D map__get(map);
> +			break;
> +		}
> +		sym =3D NULL;
> +	}
> +
> +	for (unsigned int i =3D 0; i < nr_maps; i++)
> +		map__put(maps_copy[i]);
> =20
> -	maps__for_each_map(maps, maps__find_symbol_by_name_cb, &args);
> -	return args.sym;
> +	free(maps_copy);
> +	return sym;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607213700.3563=
842-1-irogers@google.com?part=3D1
