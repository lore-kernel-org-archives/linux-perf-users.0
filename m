Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0A3603E0
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260778; cv=none; b=mCcIPNVGz0UXkIVNQIKwhDRnwdDwTFMaavlAB8f6pTgutefVpndBrI8OTPwlk4lxNxe1B2xTAulnvsLR7hcaXkqfioeOHA156YCTFifx2XdSfmAQ9QpG17DsRkDN32Jb+Lln0iCDmkyozPubnDPxe9uAuGO/O6R0/vC6KYkDwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260778; c=relaxed/simple;
	bh=6tVX034l4sKHnV8mQLbkO9TJTIV1y2/gW+l+SsoYHC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fDkqJW2AOG0u1643eiP5QBMI3yiNnkI8x/MkPCmEdRLeoXKX4sdK/KFOsXJGnMR4dmvIzZ6NPDCvKC1GcweWh8kK9oq/Itakr6Kjfzvz7FrMJNtIN7BkriwTwVJGLRxbz4joGr5lI9LeHMju/HXyD2lqD/j8udiWPDqch04BSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMlPSJun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMlPSJun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AEC1F000E9;
	Wed, 20 May 2026 07:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260777;
	bh=sNrghKsjDAlBQTgIimxS5QTVPlreVk76sObO0qWr6Oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMlPSJunZaTD9gwME7ZUl1RC8/3uqy4ISbiB7Lybt2OMImEai0t8PGmr3tJ/dTfIZ
	 j+vwJWHUHP+W5Ao6vddvefMMXHfyKFBFUZB6HNuC3N1SvAIBzbgCZV3v6hm6qfj27v
	 V1lW0Pp4urfkbdvhi9IG2k5mcBvqnTJC/S0j75X+oavhKKOBbRgtC/GJbzdzmWky4z
	 qhWvwq9UwjAM/sOGO0H0R8RtaoPGGpVh4wNOi+Fn3wgAcZaEZznjKSjM4EFusYRpZx
	 xROfHT8hSlGGlZxaoX+/Kmtk32bjBq3XeLo11Lv6io/SFTx5evtyblhruiyuP02uYz
	 EVei2CRTlMzyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] perf maps: Add maps__mutate_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520063050.3917261-2-irogers@google.com>
References: <20260520063050.3917261-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 07:06:16 +0000
Message-Id: <20260520070617.22AEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a guaranteed recursive read-to-write self-dea=
dlock during lazy symbol loading by acquiring a write lock inside `maps__mu=
tate_mapping` while the thread already holds a read lock. The provided miti=
gation function, `maps__load_maps()`, is effectively dead code for most too=
ls as it is never actually invoked for them.
--

commit 020b20379ee4c690b3b4da226aa6a8b8bbcfe099
Author: Ian Rogers <irogers@google.com>

perf maps: Add maps__mutate_mapping

This commit introduces maps__mutate_mapping() to safely mutate map boundari=
es
under a write lock, resolving concurrent lookup race windows. It also adds
maps__load_maps() to pre-load kernel symbol maps upfront in order to bypass
dynamic runtime mutations during lazy symbol loading.

Fixes: 39b12f781271 ("perf tools: Make it possible to read object code from=
 vmlinux")
Signed-off-by: Ian Rogers <irogers@google.com>

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 923935ee21b66..7dce07e4d9b49 100644
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
> +int maps__mutate_mapping(struct maps *maps, struct map *map,
> +			 int (*mutate_cb)(struct map *map, void *data), void *data)
> +{
> +	int err =3D 0;
> +
> +	if (maps)
> +		down_write(maps__lock(maps));

[Severity: High]
Can this down_write() trigger a recursive self-deadlock for existing tools
that rely on lazy kernel symbol loading?

If tools like perf lock or perf probe have not been updated to call the new
maps__load_maps() up front, they may still trigger lazy loading while itera=
ting
over maps.

In that scenario, a read lock is already held:

maps__for_each_map()
  down_read(maps__lock(maps));
  ...
  maps__find_symbol_by_name_cb()
    map__load()
      dso__load()
        dso__load_kernel_sym()
          maps__mutate_mapping()
            down_write(maps__lock(maps));

Since the read lock is held by the same thread across the loop, will this
down_write() cause a deadlock when lazy loading occurs?

> +
> +	err =3D mutate_cb(map, data);
> +
> +	if (maps) {
> +		RC_CHK_ACCESS(maps)->maps_by_address_sorted =3D false;
> +		RC_CHK_ACCESS(maps)->maps_by_name_sorted =3D false;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520063050.3917=
261-1-irogers@google.com?part=3D1
