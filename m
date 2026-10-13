Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4455C1CE
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931122; cv=none; b=AjaE/+jRg331TJ1U2ui1L0GbTNAgPA8DyRV3sz2kJWkhuN6JxyNibBWWSgej9QlQKbfJ8b7+8dpjQYvViB8t/d/R3fz+7hZ68+4imVcTAPSQTTVicR1z49O+rXIjINFvrpxZOhGce342eleTb4rhHMecy9RRZaIFMId3Rsx1pPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931122; c=relaxed/simple;
	bh=epRDJFlBzeysg6IxcCWCLcgMbDXw/BEOACvHFQe2qYw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QN/PDBJKtu19QgaYxablYbHLBgnC2fcTPjEk8hvIWtJH1tFQ2IKdkMW7I1K5qs1k9/bhi0Jix0mH0zW3izEVnkiJXpZzvgk8U5BvKrwnxerecwCIjrbskDTHB5H4tF3dyh0PKIfiWG7CMruJd3tOK58vcCwEVJxqfcn+7jr2Tm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw2bp4Zv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw2bp4Zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706BA1F000FF;
	Tue, 13 Oct 2026 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931120;
	bh=Kq5qvCBOYph8TsptspQQ/zvOse0L6ushur0hIMxxrHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tw2bp4Zvr7CQ5T7bMktzIVgvpj6Gy93OflvtKVF4oTUhXC8eNb3PczbWHPZEXsDCl
	 nx58bIPfc0ukMhKFRWNsPzQgBrQF3RvwHa6iEpvvsFfbndyrP345fmvdgtAL1iR+ZY
	 namBW3tUSzDgjLr99D9phemsjdoLJ7dW/MWN+oQcmQlduT6vSX5XTFhHbxSE/VmHly
	 LDVm/RnZ6VqMo3iAevGutKnsph0EAI1bs1JJ80GzhkHY7707eENVJV7E5aPpAlOLcP
	 ZbI6IYUdrZpeCrcp7CItM+vATGpbixetOTupWi7+KKX3MRo3u2SdSQhgOgjRKzv2V2
	 nhAuQyFRg5x+g==
Message-ID: <sashiko-outbox-170586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-11-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:38:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf maps: Missing -1 return check in __maps__remove() causes OOB =
access
--

commit cfd924d431a48e1a59506fcafdc9a6ec06b58bad
Author: Ian Rogers <irogers@google.com>

perf maps: Add context analysis annotations

This commit adds lock annotations for static analysis of the maps locking
context. It also modifies maps__load_first() to take a map reference to
prevent read-to-write deadlocks during map loading.

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c

[ ... ]

> @@ -540,10 +570,11 @@ int maps__insert(struct maps *maps, struct map *map)
>  }
> =20
>  static void __maps__remove(struct maps *maps, struct map *map)
> +	__must_hold(maps__lock(maps))
>  {
>  	struct map **maps_by_address =3D maps__maps_by_address(maps);
>  	struct map **maps_by_name =3D maps__maps_by_name(maps);
> -	unsigned int nr_maps =3D maps__nr_maps(maps);
> +	unsigned int nr_maps =3D __maps__nr_maps(maps);
>  	unsigned int address_idx;
> =20
>  	/* Slide later mappings over the one to remove */

[Severity: High]
Could the lack of a return value check on maps__by_address_index() lead to
an out-of-bounds array access here?

In concurrent environments, a TOCTOU race can occur. For instance,
machine__process_ksymbol_unregister() retrieves a map via maps__find()
(which drops the read lock) and then calls maps__remove() (which acquires
the write lock):

tools/perf/util/machine.c:machine__process_ksymbol_unregister() {
    ...
    map =3D maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
    if (!map)
        return 0;

    if (!RC_CHK_EQUAL(map, machine->vmlinux_map))
        maps__remove(machine__kernel_maps(machine), map);
    ...
}

If another thread removes the map in the interim, maps__by_address_index()
will print an error and return -1:

tools/perf/util/maps.c:maps__by_address_index() {
    ...
    pr_err("Map missing from maps");
    return -1;
}

Since address_idx is unsigned, the -1 casts to UINT_MAX. When __maps__remov=
e()
continues, it directly uses this value, resulting in out-of-bounds accesses:

tools/perf/util/maps.c:__maps__remove() {
    ...
    address_idx =3D maps__by_address_index(maps, map);
    map__put(maps_by_address[address_idx]);
    memmove(&maps_by_address[address_idx],
            &maps_by_address[address_idx + 1],
            (nr_maps - address_idx - 1) * sizeof(*maps_by_address));
    ...
}

Would it be safer to check if address_idx is valid (e.g., !=3D -1) before
performing the map__put() and memmove() operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D10
