Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C63B9D9B
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595176; cv=none; b=f7z+zmehC7DnC486aSQNrJbqn0uPTkBsYm013WqmjUVUp/JJyOt4VmlzwAlMKjwVOmzXureBQSnv35u/uSbO6EoOfB11C/02lnBFItGlm3Rs5E88mxPZHgbugSUtM3oZpKsHcMuPP+/pV1RWjzLSxQJPBWcypbEeYYiyHXJCDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595176; c=relaxed/simple;
	bh=Z44toux+v7O2OH62ZD7p8jnrSI/HjBeyVXJL9AssuXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MbgHivkADKtQliCakkPtHTRuf6givmB/8FffxS/AuIpYYsQV+95t4LEP1PLff/cBe1K5ADEikOG/twLqGEODf9iIKkfPnojnDwNKdubYOv5O4IU1Jq0LAtL0pladbbtimaR6pMzxWnTIbaqEJyzrLR86/nMneO3tNR2aH/ygRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPwT7pdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPwT7pdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F27D1F00893;
	Thu,  4 Jun 2026 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595175;
	bh=AeYUMUQ4dfqBZxyaUDWI0MlsQsgHAKJ6K+FcUnNP964=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BPwT7pdQdmCo3d+CZmpxpI1Zf4eJNNPIdoCffpVg9QHyURvAmrkJiEvwJ54umGZzp
	 pXBkPcCbQgdaYBCWYAuOyl8oijhJBGicCfN2vOifsouaetfMwTs9pLNWv+aOZsZW9C
	 vJbDDwZxuk40q9pUX9XjfV8QP0QsFHbq6v34xnal5QrBW1PIPFgh47Y9bLrkAnHMIB
	 GZhZTupYxiQHLOqBhraWqpzwz9W0zpq13GS6rluGAwa9biB24ycuoP6oM4hlrZetvb
	 eF24LoSoOmK0veH0YdbltQCBlh8mo5KP9DXWUEkbAgwEbp1Ey+/TUsW0OHDxYQiQq4
	 PMXxUKNSIHjAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/5] perf maps: Add maps__mutate_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604172850.683329-2-irogers@google.com>
References: <20260604172850.683329-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:46:14 +0000
Message-Id: <20260604174615.2F27D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Ignoring the return value of maps__load_maps() and a TOCTOU race=
 expose a recursive read-to-write self-deadlock in maps__find_symbol_by_nam=
e().
--

commit 0d10c2abb7793e097fe64599f4a0512e9d3d888d
Author: Ian Rogers <irogers@google.com>

perf maps: Add maps__mutate_mapping

This patch introduces maps__mutate_mapping() to safely update map boundaries
under a write lock. It also adds maps__load_maps() to pre-load kernel symbol
maps up front, aiming to avoid recursive read-to-write self-deadlocks during
lazy symbol loading.

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 923935ee21b66..332222365f237 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
[ ... ]
> @@ -626,6 +669,39 @@ int maps__for_each_map(struct maps *maps, int (*cb)(=
struct map *map, void *data)
>  	return ret;
>  }
> =20
> +int maps__load_maps(struct maps *maps)
> +{
[ ... ]
> +	maps_copy =3D calloc(nr_maps, sizeof(*maps_copy));
> +	if (!maps_copy) {
> +		up_read(maps__lock(maps));
> +		return -ENOMEM;
> +	}
[ ... ]
> @@ -700,6 +776,7 @@ struct symbol *maps__find_symbol_by_name(struct maps =
*maps, const char *name, st
>  		.sym =3D NULL,
>  	};
> =20
> +	maps__load_maps(maps);
>  	maps__for_each_map(maps, maps__find_symbol_by_name_cb, &args);

[Severity: Medium]
Does this expose a recursive read-to-write self-deadlock if maps__load_maps=
()
fails?

If the maps_copy allocation in maps__load_maps() fails with -ENOMEM, it
returns early and leaves the maps unloaded. Because the return value is
ignored here, execution proceeds to maps__for_each_map() which takes a read
lock. When it attempts to lazy-load the unloaded maps, it will call
maps__mutate_mapping() which attempts to acquire the write lock, triggering
the deadlock.

Is there also a race window between these two calls?

If a concurrent thread inserts a new map after maps__load_maps() releases
its lock, but before or during maps__for_each_map(), the new unloaded map
will be iterated over under the read lock.

Would this again trigger the same self-deadlock when lazy loading calls
maps__mutate_mapping()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604172850.6833=
29-1-irogers@google.com?part=3D1
