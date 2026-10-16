Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBF599A35
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172659; cv=none; b=cPsArvBL4bXdTJBSE6vsw/NGnZ6jZ8fMW1QNmhQyQkm7/2UxWLCq2Fsnj+5hnaF4hmLNTlx193c8zzlnrVFDAA5ZE/ASSIvEEz/h+W2IgzUPnxzlXT65QGk8eKgADDPunUBK1ol6c/mErYM8WpDM1zLdz4OjosXubrj3wggZrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172659; c=relaxed/simple;
	bh=2Km5Aem/hdpPwXeJFqtXX7CsrIXI4BgpK/SpNTV5xRA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YyxO/XBELZR7hMIiZH2AvR7uKUOxmwuKBoGP45qV3ULLGurZ8euuYRxDW5WqyWEgIsFjJUY/lSbaAnx7VVwvqGRCCNFuVT4bB1w7EcPbYCjCmUMjcPtOcpsOBgMguC3LVQHeZxdztsDrRM6JfcXgtn1/tnuZ05XkVoczjWKxRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmY2UmBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmY2UmBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEF41F000C4;
	Fri, 16 Oct 2026 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172655;
	bh=ehL8wmQ3kd2o5jZLbmM30PNzsfPM1d/SZy75+KovhcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LmY2UmBcFrfzGNYNdYrLGPxkYl6TOCl2/OPW7SpxMNd8cMxxhJbSZWM/ZbNob6D8g
	 Ua+EHDd8kxBPz/hdFgwPw5ujYhXUsF28n3trkinJM3VVAbii99gtjc8QcNs7Ti4Nkk
	 mBVZgIDHgm4OIhY48MnC0jkWoq49+NCtG2KObDVEf0dG46bVx2rmasYFot3y5ac0Nl
	 LGuIGLp+EUtl3rOJ+GNpKF0vadsNphthITF/1Sk9iHkypBGdDJ7izeYJLlVqqT9Uv6
	 jnPUQ5YcTr2uuT1IAvhVYIVeSojpe55vVKR8RBvJyOKf9JB2tXRrGIt3FG3rSHpOlQ
	 kMHRRjRqQo/CA==
Message-ID: <sashiko-outbox-174743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/17] perf maps: Fix lock inversion in
 maps__load_first() and bounds check in __maps__remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-17-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:44:13 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing <string.h> inclusion for string operations
--

commit ea7ae95649777ad210584a0f4110f0b3b715c591
Author: Ian Rogers <irogers@google.com>

perf maps: Fix lock inversion in maps__load_first() and bounds check in __m=
aps__remove()

This commit addresses a read-to-write self-deadlock in maps__load_first()
and adds bounds checking in __maps__remove() to handle concurrent map
removals.

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index f808df2fe77b4..c0fccb776bede 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c

[ ... ]

> @@ -556,10 +558,14 @@ static void __maps__remove(struct maps *maps, struc=
t map *map)
>  	if (maps_by_name) {
>  		unsigned int name_idx =3D maps__by_name_index(maps, map);
> =20
> -		map__put(maps_by_name[name_idx]);
> -		memmove(&maps_by_name[name_idx],
> -			&maps_by_name[name_idx + 1],
> -			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
> +		if (name_idx < nr_maps) {
> +			map__put(maps_by_name[name_idx]);
> +			memmove(&maps_by_name[name_idx],
> +				&maps_by_name[name_idx + 1],
> +				(nr_maps - name_idx - 1) * sizeof(*maps_by_name));

[Severity: Low]
Does this file need an explicit #include <string.h>?

The perf subsystem guidelines require developers to explicitly include the
POSIX-specified headers for any libc functions used (specifically citing
<string.h>) to ensure musl compatibility.

This file invokes memmove() but lacks an explicit #include <string.h>. Since
the patch directly modifies a block invoking memmove() without adding the
requisite header, could this cause build failures on musl libc where standa=
rd
headers are not implicitly included?

> +		} else {
> +			__maps__free_maps_by_name(maps);
> +		}
>  	}
> =20
>  	--RC_CHK_ACCESS(maps)->nr_maps;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D16
