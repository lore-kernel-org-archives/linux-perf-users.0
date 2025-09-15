Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A721D3CC
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948469; cv=none; b=Bw25bydTkF+e1OrjgtOTWAGmQN9bcIyrVuFY9HGsOwiBvAP3w5RLDTjduDLesuBOiztajJCyeOPcgNwEU1hXKtXUW7ZucDxoRcAXvrkhJ6W9HKJy6MqtIDig/pmFUqmj0G2LoAJCYbV6APLX1kBC1Xw1vm4/EUC9E3jCWqYU7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948469; c=relaxed/simple;
	bh=XNzym3SlW68WTjuaImeS6uxut+Hkf13t1gya8khOoMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cH7YJ07wtrrNHXlqOWoj3730+H1JeiPtdcBo1Lx9bzkKLLPSAht+vE1eidCrziEW4EgL+yj5f7r7dmgSysnpjENxFgnlKOF19H1rwfbvQJsvuDIC08aDa7W0nbFadNXlywg0BpdBOUI2ZUHTcEwQ6b/suUWHT3KgXyxSgHVcT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+EMtRhX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+EMtRhX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-265abad93bfso197315ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757948467; x=1758553267; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9K2ZNoVdFEQAo4l5PTBMo8u7yy6tT4YYzBB/JfpAiU=;
        b=b+EMtRhXmbQPKQDIdxgKr5lFiiyJE7z0nBf5NKKAb9YWK9bhs5hcUJfEcUbnf4Gb0E
         BaFd9u88VuW6tFvRhgxE1by2Ld0rGHTbZCAOoYtKRI1qrn9nmP1rA5yy8a2LZW10Mkqz
         2XzVnJR7b+hP18EU8x4gKY5tawXRU2KEDBEZFvTA+BqfuVRLd3aFkbAb/jMS7b8H/ONS
         feVikVt54/dBwuJuhaCZregXA/pBuapVUEhuGjAc2O5vWt6MyhL/dIJXR0eQUHMno9gI
         RAu1hr+QFvajGSBbvv2dBZ0000e83hgkPw8jADdYXT2yDck43aymcBtgqnVvbwLu8IVQ
         9lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948467; x=1758553267;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9K2ZNoVdFEQAo4l5PTBMo8u7yy6tT4YYzBB/JfpAiU=;
        b=KTbJbdOh5LJ+mWbpFacEhW4Cpli2QAxZ5f+mocuM2EygmLlk2NDybWB7yn0oWPYzai
         Z7qj9m8fMP1gZv4ltPPnQZuzpbp1NLhqVlBh6J3vHjlxSF5JOBD1MlTkQP7jPom+icA6
         X5FIjmrDoQ1NLLHlFYgwQ9mj149CjUbN5rmeAPikSOvByczsfNv86+Sdql5HF6k4Okgp
         IAcGsOKb2kRq90/Bvu5IhPhCHVlFUREnmZjy+qpSJnhrjKJhaYYalCo5uR/QRVnWxBUY
         wiKrvYnn3ce39sVimoUYhI5NQSbu8Q4kHmc1hxSJTTd5WsGITw++uG6t6Dodv6xwRj4d
         4SyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3svkNFTV1vCb24Z9wvyk6lto5O6kyXx2eVEgoAMUCa9BUMSngo7qiVgXHk+p2LcQyR1GPP+gsMDbXBPWMV0xm@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8jVil545r/hZ06/mmuyreOEeFAF+Bgv/1oZNkmmvJ93zR+cr
	zs6KtMwyl1S9ewyhSGvfGHXhLbPldK7QCp7Elg8y/uK9fblMCeKHDrzAk4pJWnAOYAFTH6C3A0N
	jefqbcUa6IQZVtjZMWY3tVQHdAU0hpg9GE1aJAftO
X-Gm-Gg: ASbGncvLgRathNUsHxxqsYevM5a3wRhPhWuMYE6HJnUeLnXH+n6ANnLh2rMo2sXGPRb
	omAkJ/WTwNbHpbP9ZgRbmxMkuh3uSl7Bbh82YTlbC1Fswx9YbUxL7QhlNXhiB0dojvotb3JxPwT
	YJLttJXkhFS4PZEZh3l/TXw/HHJ2oQdBkaKi+Ja8lea3jH01vFyuFhqRIF7pSldZY6S3IGu7ABl
	UcoCTPuN9K3viPd47Jvw9CXjhV4ZVYdPSXHPJwKuO0DcJD7C+XLbDs=
X-Google-Smtp-Source: AGHT+IGySltNDMqtEE6Huhdc1tR9G0RC/iwxIoxdqKUeG2fq3SitVMFnig3n05ncji36jZGgJEZr47n8UCv81x6Enc4=
X-Received: by 2002:a17:902:ea08:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-266b8a2f830mr2974895ad.3.1757948466100; Mon, 15 Sep 2025
 08:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914181808.1957729-1-irogers@google.com>
In-Reply-To: <20250914181808.1957729-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Sep 2025 08:00:53 -0700
X-Gm-Features: Ac12FXy_iXabN6eCwLi19NLkk4n6ATbOkH6fj37zAuckwN_qB8gDAsBy5dmJucI
Message-ID: <CAP-5=fWz9Put0QznfXSf1ATXjcfQj1T2toZmXrXp502qU4fRSw@mail.gmail.com>
Subject: Re: [PATCH v1] perf maps: Ensure kmap is set up for all inserts
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 11:18=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> __maps__fixup_overlap_and_insert may split or directly insert a map,
> when doing this the map may need to have a kmap set up for the sake of
> the kmaps. The missing kmap set up fails the check_invariants test in
> maps, later "Internal error" reports from map__kmap and ultimately
> causes segfaults.
>
> Similar fixes were added in commit e0e4e0b8b7fa ("perf maps: Add
> missing map__set_kmap_maps() when replacing a kernel map") and commit
> 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel
> maps") but they missed cases. To try to reduce the risk of this,
> update the kmap directly following any manual insert. This identified
> another problem in maps__copy_from.
>
> Fixes: e0e4e0b8b7fa ("perf maps: Add missing map__set_kmap_maps() when re=
placing a kernel map")
> Fixes: 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added ke=
rnel maps")
> Signed-off-by: Ian Rogers <irogers@google.com>

This may be worth picking up for v6.17. It was a fairly regular source
of crashes on basic commands like `perf record` for me on certain
kernels. `perf record` by default is processing the whole perf.data
file and if there were overlapping maps, from BPF symbol events
typically, the broken kmap would trigger assertion failures and seg
faults.

Thanks,
Ian

> ---
>  tools/perf/util/maps.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 85b2a93a59ac..779f6230130a 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -477,6 +477,7 @@ static int __maps__insert(struct maps *maps, struct m=
ap *new)
>         }
>         /* Insert the value at the end. */
>         maps_by_address[nr_maps] =3D map__get(new);
> +       map__set_kmap_maps(new, maps);
>         if (maps_by_name)
>                 maps_by_name[nr_maps] =3D map__get(new);
>
> @@ -502,8 +503,6 @@ static int __maps__insert(struct maps *maps, struct m=
ap *new)
>         if (map__end(new) < map__start(new))
>                 RC_CHK_ACCESS(maps)->ends_broken =3D true;
>
> -       map__set_kmap_maps(new, maps);
> -
>         return 0;
>  }
>
> @@ -891,6 +890,7 @@ static int __maps__fixup_overlap_and_insert(struct ma=
ps *maps, struct map *new)
>                 if (before) {
>                         map__put(maps_by_address[i]);
>                         maps_by_address[i] =3D before;
> +                       map__set_kmap_maps(before, maps);
>
>                         if (maps_by_name) {
>                                 map__put(maps_by_name[ni]);
> @@ -918,6 +918,7 @@ static int __maps__fixup_overlap_and_insert(struct ma=
ps *maps, struct map *new)
>                          */
>                         map__put(maps_by_address[i]);
>                         maps_by_address[i] =3D map__get(new);
> +                       map__set_kmap_maps(new, maps);
>
>                         if (maps_by_name) {
>                                 map__put(maps_by_name[ni]);
> @@ -942,14 +943,13 @@ static int __maps__fixup_overlap_and_insert(struct =
maps *maps, struct map *new)
>                                  */
>                                 map__put(maps_by_address[i]);
>                                 maps_by_address[i] =3D map__get(new);
> +                               map__set_kmap_maps(new, maps);
>
>                                 if (maps_by_name) {
>                                         map__put(maps_by_name[ni]);
>                                         maps_by_name[ni] =3D map__get(new=
);
>                                 }
>
> -                               map__set_kmap_maps(new, maps);
> -
>                                 check_invariants(maps);
>                                 return err;
>                         }
> @@ -1019,6 +1019,7 @@ int maps__copy_from(struct maps *dest, struct maps =
*parent)
>                                 err =3D unwind__prepare_access(dest, new,=
 NULL);
>                                 if (!err) {
>                                         dest_maps_by_address[i] =3D new;
> +                                       map__set_kmap_maps(new, dest);
>                                         if (dest_maps_by_name)
>                                                 dest_maps_by_name[i] =3D =
map__get(new);
>                                         RC_CHK_ACCESS(dest)->nr_maps =3D =
i + 1;
> --
> 2.51.0.384.g4c02a37b29-goog
>
