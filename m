Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55208F5D;
	Wed,  8 May 2024 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141468; cv=none; b=Zx01pFUxcPgloCf3MeE+XmVgW5OZeDOsDqWLdpzjltvi//9jcuwCmIf/kAvsOau744i0jApImKz7xuc/Ba6Ax8MnSmeUYo4UvZ6bZvIDekCsilnBTXUQ68HvLZH9Ma2TsKFSV2jz/ti3hh99wz5KNztGav8QwidHhDKgAHC056E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141468; c=relaxed/simple;
	bh=JhAVlxDI8/QA3/FC66i0btB5Emz0CXwud/+uVLzEY6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7uBkCx0QAU236v+HuWlzSu5JP28acRxOC8WMK7/FwVCa5ipJlXYC7IXHSO0dGL1k41A0NdfdzKFMG+VqYCQoItTWRc6dVIZlpOcoQIRQniuOgSYrPk7BY5Jb+M91wQfsM93rX9VaM3IOXBALcp/Tm5MBoTh99eu6OBJwTXwV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b273cbbdfdso2804096a91.1;
        Tue, 07 May 2024 21:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715141466; x=1715746266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6Tgq5sUgs5xCTDmSUyawjsdeW0mmRIbMV6Rvd2uVAY=;
        b=Lz4Ux7a0Sk7IHnRf9HEYttxaiEu9lIMHmkRw09XA2cjwYEb6x/JxWIJfcmlrOBfYaS
         xH4a9CjIxnl//TSuOS3WpfTOc2ROw21CQoc78D1Xm64xYzP0D/0JE5yQoPY1wOWTDbYo
         rfq+AIAePrVni9FURI2bu60wXVrV1aimUyvAZErg6ENYxEnmc6lm/lCTbm4OxJ/RG3aA
         Mg9miLrMzbmocuaoxceLGCj4FAXH5irlsBU8nE/hmlhCaCRlXkIDRFOJw2Gy29uMys0e
         Vh/HswzIhL1/L4v3vhyXKR6gtPup516Et6UKLuMsJ+PlK9YRKuSYTfjTQ0oaROU+B1Qp
         gv4w==
X-Forwarded-Encrypted: i=1; AJvYcCXQJexxRrPZzfdqHPYDCi/TKq/Ao/K90pxJdWd/RauFfs4wCQBa5aTL1TKvXQaUpde2rpxDSS3X+O4I8E7uWmu9IvXmH24gmvygg0IZ
X-Gm-Message-State: AOJu0Yz9SGLX9mURQN5xt+Bb8ZYMuVbRSgNO8XVowkOUDq8rEBE7qxwf
	SpFt1//LqrnVaL+w7KFMPij+LY4NxRgUyM2ZJ2azLzD2HqFs7XhV+02xaz690c9UrMUSvaX5D7Z
	kHvdPDAqlbP1uZzvfoJzIG1RfySw=
X-Google-Smtp-Source: AGHT+IHCd6OcteIJsChWiXIBx1JLXL+xF9/BwVlbCkX4+c5RBJo0XEdUViFNVrd8QJmt5bEkiceF2+d6ah74GcAkojk=
X-Received: by 2002:a17:90a:c901:b0:2b6:29d3:30b with SMTP id
 98e67ed59e1d1-2b629d30502mr552653a91.7.1715141465782; Tue, 07 May 2024
 21:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507141210.195939-1-james.clark@arm.com> <20240507141210.195939-4-james.clark@arm.com>
In-Reply-To: <20240507141210.195939-4-james.clark@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 7 May 2024 21:10:54 -0700
Message-ID: <CAM9d7cjYvMndUmSuwnE1ETwnu_6WrxQ4UzsNHHvo4SVR250L7A@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf symbols: Update kcore map before merging in
 remaining symbols
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com, 
	irogers@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 7:13=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> When loading kcore, the main vmlinux map is updated in the same loop
> that merges the remaining maps. If a map that overlaps is merged in
> before kcore, the list can become unsortable when the main map addresses
> are updated. This will later trigger the check_invariants() assert:
>
>   $ perf record
>   $ perf report
>
>   util/maps.c:96: check_invariants: Assertion `map__end(prev) <=3D
>     map__start(map) || map__start(prev) =3D=3D map__start(map)' failed.
>   Aborted
>
> Fix it by moving the main map update prior to the loop so that
> maps__merge_in() can split it if necessary.

Looks like you and Leo are working on the same problem.

https://lore.kernel.org/r/20240505202805.583253-1-leo.yan@arm.com/

>
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted arra=
y for addresses")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/symbol.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 2d95f22d713d..e98dfe766da3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1289,7 +1289,7 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>  {
>         struct maps *kmaps =3D map__kmaps(map);
>         struct kcore_mapfn_data md;
> -       struct map *replacement_map =3D NULL;
> +       struct map *map_ref, *replacement_map =3D NULL;
>         struct machine *machine;
>         bool is_64_bit;
>         int err, fd;
> @@ -1367,6 +1367,24 @@ static int dso__load_kcore(struct dso *dso, struct=
 map *map,
>         if (!replacement_map)
>                 replacement_map =3D list_entry(md.maps.next, struct map_l=
ist_node, node)->map;
>
> +       /*
> +        * Update addresses of vmlinux map. Re-insert it to ensure maps a=
re
> +        * correctly ordered. Do this before using maps__merge_in() for t=
he
> +        * remaining maps so vmlinux gets split if necessary.
> +        */
> +       map_ref =3D map__get(map);
> +       maps__remove(kmaps, map_ref);

A nitpick.  It'd be natural to use 'map' instead of 'map_ref'
(even if they are the same) since IIUC we want to remove
the old 'map' and update 'map_ref' then add it back.

> +
> +       map__set_start(map_ref, map__start(replacement_map));
> +       map__set_end(map_ref, map__end(replacement_map));
> +       map__set_pgoff(map_ref, map__pgoff(replacement_map));
> +       map__set_mapping_type(map_ref, map__mapping_type(replacement_map)=
);

So here, replacement_map should not be NULL right?

Thanks,
Namhyung

> +
> +       err =3D maps__insert(kmaps, map_ref);
> +       map__put(map_ref);
> +       if (err)
> +               goto out_err;
> +
>         /* Add new maps */
>         while (!list_empty(&md.maps)) {
>                 struct map_list_node *new_node =3D list_entry(md.maps.nex=
t, struct map_list_node, node);
> @@ -1374,24 +1392,8 @@ static int dso__load_kcore(struct dso *dso, struct=
 map *map,
>
>                 list_del_init(&new_node->node);
>
> -               if (RC_CHK_EQUAL(new_map, replacement_map)) {
> -                       struct map *map_ref;
> -
> -                       /* Ensure maps are correctly ordered */
> -                       map_ref =3D map__get(map);
> -                       maps__remove(kmaps, map_ref);
> -
> -                       map__set_start(map_ref, map__start(new_map));
> -                       map__set_end(map_ref, map__end(new_map));
> -                       map__set_pgoff(map_ref, map__pgoff(new_map));
> -                       map__set_mapping_type(map_ref, map__mapping_type(=
new_map));
> -
> -                       err =3D maps__insert(kmaps, map_ref);
> -                       map__put(map_ref);
> -                       map__put(new_map);
> -                       if (err)
> -                               goto out_err;
> -               } else {
> +               /* skip if replacement_map, already inserted above */
> +               if (!RC_CHK_EQUAL(new_map, replacement_map)) {
>                         /*
>                          * Merge kcore map into existing maps,
>                          * and ensure that current maps (eBPF)
> --
> 2.34.1
>
