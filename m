Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865748BE0
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443008; cv=none; b=SDJNyD8iKtgjDWt9NZH0pTDStM7WBzktum96wGO1BBCMomIdSkwJGSwtu9Ervfao1gNx06UECwFIbziVFNBnORVmfewjq+97J25rzo8CSu/3gK/TnmhdJYdg1pKva3F1yKHiQqMLVs7fbkO0WdaF+kkF95FikX6D/wCyJT/SYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443008; c=relaxed/simple;
	bh=T2GiyAIYVxyvxo/l72UT9pmsLbki5Zd42Ig819Ygi2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GluErD8UKB39cI606w5E0EXWhf3X8LNwWlk3aUIMmzSJrhXlWtFm2w6MXsFR6vtfciS6YE6WSeG/rPSRQKPqfPChGlkBi2oHr91FSSZroHzk6g1EAfxETmDJI5C79KeWi8I3f4yVaRKZqXFQEETRGH4DKw1E49CgS2BJD+Q8ZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4RQnYyj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4RQnYyj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eb1cb1a8f1so51875ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 19:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714443007; x=1715047807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCP17/haR0L7iG9nZZgQ33wSIOc8yXlNcZy4lZ7Ob5s=;
        b=p4RQnYyjE6tslv2Qc2rdylyt5WFDf3E6JwhWlul0LVikYVsZ9wvLsEvZ5DLEYaEWVa
         Lp5yyG7AzDNC9pstmo1RoEfqXJssUNhcDLjFB/fm4otRpJXjlWiLuz1qSdSutmXhMsOJ
         l4QYD5LWcCSHKtPYVz55ocIfJLr5gYCvplLizeNIKL0tdtirSNEwuaW5xM6SUj+i2hyB
         g48rITgcgv5WYRCF5VSqyrwobzsILjx0I1VCJ3KKVzBQI9JGy+g5adyyvwUI2pVoHTiD
         wZwKnsmHKBUnMo/mehBvt/s9WouqJgVXBDcRmckXZCYfn2L70Gt8ssQVQ73nvNTb7B2T
         Wrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714443007; x=1715047807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCP17/haR0L7iG9nZZgQ33wSIOc8yXlNcZy4lZ7Ob5s=;
        b=CkAVwmykLbTzgSqMaEw9LjPrmbugJdRdDXc+P7JUUo4XcopRiLnfn3rej7zuXxVkeT
         qZElUt8nzgm5Ll5XIfOvWPNH1kB7XwwKy48sP0fRg+rtnpd9tmQC+l1Wu3QUphU6+oqu
         W7sjDDLj5nIpM5+rPQpmVTgpZLUIJVpgxDZQd1aMiZxXb6tvvW7B0YnwRs1Xh/hHtl17
         B1NXpQIPPYIIuVOtDjohlDSvNin7qohvYiK9i7Mno2xiLDSDCJK1LEnVTJedb3JxNWy4
         T1cnr1j0HlvqTLIWhnwOf6hR1xcHIv+c+L4PVTurXBbUb6JW3vWU85pTFHZ1Mc/LqRKl
         SkRg==
X-Forwarded-Encrypted: i=1; AJvYcCUq/iyuD2r7llBLqWIbXAYPXUWzuhxlXRtIf+2KVxV7ZjkG8YcQDqtvUaueSC6lb5IrfKmzxedHICmPjLG2KP1ME7FOLFMDGGc2JxmI3xgkAA==
X-Gm-Message-State: AOJu0YyYcvaGbiAsBvKTFfUadzMJlae5XypmAudBIVVWvlMy8WCb6poK
	QGMdLgHUyCtcWPM2JNAKOWvEzSGXvreh6yEfaDNX0VhoERekmKGjPYu5LFOZctW13R3KSijJ9j5
	I3HZWDQ0Yq23NQBxczASFFcr6cZiEdRtX41BY
X-Google-Smtp-Source: AGHT+IG/2d5wn5uEu9Iu1VjgVFowAP2+uQ62d9LK474lixlQzZIupw98Hp4b/h1uWUf8YJsPCfBVn1Hi8ka3gr/R/qg=
X-Received: by 2002:a17:902:ecd0:b0:1e5:869a:9449 with SMTP id
 a16-20020a170902ecd000b001e5869a9449mr77725plh.5.1714443006224; Mon, 29 Apr
 2024 19:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429225738.1491791-1-namhyung@kernel.org>
In-Reply-To: <20240429225738.1491791-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Apr 2024 19:09:54 -0700
Message-ID: <CAP-5=fWeFyihQNMEJ2BQpm6hmNBmPuwFk3rGgVh+jV0mKd7myg@mail.gmail.com>
Subject: Re: [PATCH] perf maps: Remove check_invariants() from maps__lock()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 3:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I found that the debug build was a lot slowed down by the maps lock code
> since it checks the invariants whenever it gets the pointer to the lock.
> This means it checks twice the invariants before and after the access.
>
> Instead, let's move the checking code within the lock area but after any
> modification and remove it from the read paths.  This would remove (more
> than) the half of the maps lock overhead.
>
> The time for perf report with a huge data file (200k+ of MMAP2 events).
>
>   Non-debug     Before      After
>   ---------   --------   --------
>      2m 43s     6m 45s     4m 21s

Thanks Namhyung, I think the change makes sense. There is an issue
that a user of a map may mutate it in a way that breaks the maps
sorting, symbol code would be a likely culprit of such a thing. A fix
for such a breakage would be to just set the unsorted flag on maps.
We'd be less likely to spot such an issue after this change, but it is
simple enough to add the function call when needed. Another option
would be to add another make flag like PARSER_DEBUG for these kind of,
"be paranoid," type things. Anyway, let's try to fix those problems
when they exist.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/maps.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 725300896f38..61eb742d91e3 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -211,11 +211,6 @@ void maps__set_unwind_libunwind_ops(struct maps *map=
s, const struct unwind_libun
>
>  static struct rw_semaphore *maps__lock(struct maps *maps)
>  {
> -       /*
> -        * When the lock is acquired or released the maps invariants shou=
ld
> -        * hold.
> -        */
> -       check_invariants(maps);
>         return &RC_CHK_ACCESS(maps)->lock;
>  }
>
> @@ -358,6 +353,7 @@ static int map__strcmp(const void *a, const void *b)
>  static int maps__sort_by_name(struct maps *maps)
>  {
>         int err =3D 0;
> +
>         down_write(maps__lock(maps));
>         if (!maps__maps_by_name_sorted(maps)) {
>                 struct map **maps_by_name =3D maps__maps_by_name(maps);
> @@ -384,6 +380,7 @@ static int maps__sort_by_name(struct maps *maps)
>                         maps__set_maps_by_name_sorted(maps, true);
>                 }
>         }
> +       check_invariants(maps);
>         up_write(maps__lock(maps));
>         return err;
>  }
> @@ -502,6 +499,7 @@ int maps__insert(struct maps *maps, struct map *map)
>
>         down_write(maps__lock(maps));
>         ret =3D __maps__insert(maps, map);
> +       check_invariants(maps);
>         up_write(maps__lock(maps));
>         return ret;
>  }
> @@ -536,6 +534,7 @@ void maps__remove(struct maps *maps, struct map *map)
>  {
>         down_write(maps__lock(maps));
>         __maps__remove(maps, map);
> +       check_invariants(maps);
>         up_write(maps__lock(maps));
>  }
>
> @@ -602,6 +601,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(=
struct map *map, void *data
>                 else
>                         i++;
>         }
> +       check_invariants(maps);
>         up_write(maps__lock(maps));
>  }
>
> @@ -942,6 +942,8 @@ int maps__copy_from(struct maps *dest, struct maps *p=
arent)
>                         map__put(new);
>                 }
>         }
> +       check_invariants(dest);
> +
>         up_read(maps__lock(parent));
>         up_write(maps__lock(dest));
>         return err;
> @@ -1097,6 +1099,7 @@ void maps__fixup_end(struct maps *maps)
>                 map__set_end(maps_by_address[n - 1], ~0ULL);
>
>         RC_CHK_ACCESS(maps)->ends_broken =3D false;
> +       check_invariants(maps);
>
>         up_write(maps__lock(maps));
>  }
> @@ -1147,6 +1150,8 @@ int maps__merge_in(struct maps *kmaps, struct map *=
new_map)
>             map__start(kmaps_maps_by_address[first_after_]) >=3D map__end=
(new_map)) {
>                 /* No overlap so regular insert suffices. */
>                 int ret =3D __maps__insert(kmaps, new_map);
> +
> +               check_invariants(kmaps);
>                 up_write(maps__lock(kmaps));
>                 return ret;
>         }
> @@ -1184,6 +1189,7 @@ int maps__merge_in(struct maps *kmaps, struct map *=
new_map)
>                 map__zput(kmaps_maps_by_address[i]);
>
>         free(kmaps_maps_by_address);
> +       check_invariants(kmaps);
>         up_write(maps__lock(kmaps));
>         return 0;
>  }
> --
> 2.44.0.769.g3c40516874-goog
>
