Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BD10F1
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609513; cv=none; b=uhD3UMc+xPlow8z/R8bkA4Xbzeh9FMETvhg4czZbJs5f68Lp3uIZitehrHEUN3pB4DkeTS3CNyf7wK0GHR/yMceN4gfoCaFWKWScx+U/oPgVUFdlemZOw/q6sGXWixxDC3IIy4m8LCjAJJF0FAdDXAmzFhT04cPVVOhVLTz6mvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609513; c=relaxed/simple;
	bh=CmVoCufqHg7VuWNSQ0tw9C77QX0Bga2biB/OnnjJ5eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LdDmcUzTH4CvJWk86pSMo4gIK8g17BcYAuHFwjcd1gHmk3vNZhIGV38K3G6R0mF0NEbhxEV8+2fvBlOFTUQvTZYoHYZdzzX/rCgSkBv9Q81Ta0Zqb4I2AXdmPWTmeB2h9R3soE5CeoUBFVcLi9+96jB/WVoFb2d/svLu8cA+4Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEOjIZx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEOjIZx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C599FC116C6;
	Wed,  8 Apr 2026 00:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775609512;
	bh=CmVoCufqHg7VuWNSQ0tw9C77QX0Bga2biB/OnnjJ5eU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gEOjIZx+1unhdSQ+cyKtleqn6eT0g3dx+45AMBdRISjP4/7yoEkxQRILdCzlcyanK
	 CykuKMySDV2BduupQKNK6CNflHAIG+28kDMk7kJgNsm+j3ITJ5SvztODxDCxA92q8h
	 3HYiGWIJjoBe69+qjeTlNOM7PJCg3CG8OccbtE1Kv3E5oPN0Di5QNGte6KxmABZ3t6
	 oeryfh1bVCySbxwyjtBEkDGZHVndKPdgc0KdogvMRtrSAT86p9DE3LzSChGapHEWSr
	 55zm0eK7PTeBVl+32tCpk55mbpXX4qegiAxO3ilLu0L3fNxjn6ZUIvLsACjIBFVmrh
	 KpqZpYZ9z2y4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf maps: Fix fixup_overlap_and_insert that can
 break sorted by name order
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408001521.102140-2-irogers@google.com>
References: <20260408001521.102140-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 00:51:52 +0000
Message-Id: <20260408005152.C599FC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The maps__copy_from function corrupts the maps_by_name array by po=
pulating it in address order but flagging it as sorted by name.

--

commit bd0adc21836e1932db4199fc14353b8a08f98a0a
Author: Ian Rogers <irogers@google.com>

perf maps: Fix fixup_overlap_and_insert that can break sorted by name order

When an entry in the address array is replaced, the corresponding name
entry is replaced. The entries names may sort differently and so it is
important that the sorted by name property be cleared on the maps.

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 7dd6da9d1e4f0..b44bc41f51f3b 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
[ ... ]
> @@ -955,6 +955,7 @@ static int __maps__fixup_overlap_and_insert(struct ma=
ps *maps, struct map *new)
>  			if (maps_by_name) {
>  				map__put(maps_by_name[ni]);
>  				maps_by_name[ni] =3D map__get(new);
> +				maps__set_maps_by_name_sorted(maps, false);
>  			}
[ ... ]

This isn't a bug in the newly added lines, but while reviewing the maps
sorting logic, I noticed a regression in maps__copy_from().

In maps__copy_from(), when copying maps from a parent to a destination
(e.g., during thread fork), the dest_maps_by_name array is populated
sequentially inside a loop iterating over parent_maps_by_address:

tools/perf/util/maps.c:maps__copy_from() {
[ ... ]
		for (unsigned int i =3D 0; !err && i < n; i++) {
			struct map *pos =3D parent_maps_by_address[i];
			struct map *new =3D map__clone(pos);
[ ... ]
				if (!err) {
					dest_maps_by_address[i] =3D new;
					map__set_kmap_maps(new, dest);
					if (dest_maps_by_name)
						dest_maps_by_name[i] =3D map__get(new);
[ ... ]
}

Because it clones and copies the elements in address order,
dest_maps_by_name is strictly populated in address order.

However, at the end of the fast-path copy block, the code executes:

tools/perf/util/maps.c:maps__copy_from() {
[ ... ]
		if (!err) {
			RC_CHK_ACCESS(dest)->last_search_by_name_idx =3D
				RC_CHK_ACCESS(parent)->last_search_by_name_idx;
			maps__set_maps_by_name_sorted(dest,
						dest_maps_by_name &&
						maps__maps_by_name_sorted(parent));
		}
[ ... ]
}

If the parent's name array was sorted, does this explicitly flag the new
destination map's name array as sorted by name, even though it is physically
sorted by address?

Could this cause any subsequent lookup by name in the copied map
(such as maps__find_by_name during child thread symbol resolution)
to execute a binary search on an address-sorted array?

Would this cause the binary search to take incorrect paths and fail to find
legitimate mappings, leading to missing symbols or missing maps for
child threads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408001521.1021=
40-1-irogers@google.com?part=3D2
