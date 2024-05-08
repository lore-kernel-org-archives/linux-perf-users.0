Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7815E90;
	Wed,  8 May 2024 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141212; cv=none; b=rcMvfMlwCuYC2P3w9UMJ43Zt0TQlyOrdytC+9L0PLv8qs5XXgHxEKZa7aqzOl6vuzh/wtVV6DdJELAhkTtCaB+2ETAvTUaJfm4m5/otk7OjdsXAOzRF7LJtcm5V89oITASVCouog/268jVZ8/Yben0TVGN1MxyDEuRGYIQY9564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141212; c=relaxed/simple;
	bh=RTNKU5+C3q+Jp44rQUj/Ff7ohngi4/kpN6W5TcZ9IOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjMdH9pMltkEDhAUz5hwnABVgeX5wxwdK7fAS0IyG2nye3aruFg8AaRVA1GHw06d5tyR0Ii/useRoNK8+T6d3tUFdIEuTgA1qadxjXCH9Tiu+dTkLlPdG2xLhOwlYvGJCgoAWKUtZ+ndz3hasS2xuGBzGOiU803B8PnDFh0WchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b37731c118so3008879a91.1;
        Tue, 07 May 2024 21:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715141210; x=1715746010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Emc4wu3YUsALWaVS0eAlLI0vj962psg5queQJkj6iE=;
        b=dMKUQrvGOji1e/SQlKZKOYrX/z051KajEMFQX5T55Pn7WhH62fuJw1StJjBPNbvYlV
         AADK5EC13oc9aDitJXlnW7nMqJvlLKOqbRK4Se8TctkcTy+dzBhW5t0oZeWeJhShInku
         jAx8vvKQcqH9DwENN4cTvl1k307MfOzpfkahRlsyFc8OdQB4W1UgCnWe5l9NNlYx4Ceu
         b2aHvczDGuClthgjvzaHg8L3Fz3u90qW74axSNk1myglBjVh4t21Z4FYCOMajs2k7Jde
         VFvcegjx4or8yt5mzplqb+5fVF0Fk9lqwgM+wASiNzQJdk4QSCbbHdhvmUdLn2MSAF7Z
         he0g==
X-Forwarded-Encrypted: i=1; AJvYcCXEf4KD6fD3Hwyj8KucEM90DDWalIYFbjgFTXtd6fUtOanaP0YFqKVMfh0tgOP+f5QbvpZu/8DVAzes27IkWh7LDh7Hf6V29UzhND3+
X-Gm-Message-State: AOJu0YzV89mL78I0pOJpDKUeP8YD2+IJXhwEL06+Xk9Qf/y/TLxD7x0i
	LkOTpYEWD3CSiJIFemQo1pCavUg1sWJsuldlTc7rceiX/vLeWjhlh4TBCSr/OrI2Th32DRB9EMV
	tK0153vMWdIy2PvomPVWx6zaZu38=
X-Google-Smtp-Source: AGHT+IHGPxKBtnWZ33V6t0Miv2oFpFB8qaOV3MNZKgyc0Txofnktwyfh1zsukSQkZbkd8wK1nbIM0lpgbZbXK6Wr39A=
X-Received: by 2002:a17:90b:3789:b0:2b2:d086:6f84 with SMTP id
 98e67ed59e1d1-2b61639c987mr1385199a91.7.1715141210216; Tue, 07 May 2024
 21:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507141210.195939-1-james.clark@arm.com> <20240507141210.195939-3-james.clark@arm.com>
In-Reply-To: <20240507141210.195939-3-james.clark@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 7 May 2024 21:06:39 -0700
Message-ID: <CAM9d7chQ9UW3+axnCSCYeOi3mRSwJbSmUS0YzTRa8tuXr1TbBA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf maps: Re-use __maps__free_maps_by_name()
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
> maps__merge_in() hard codes the steps to free the maps_by_name list. It
> seems to not map__put() each element before freeing, and it sets
> maps_by_name_sorted to true after freeing, which may be harmless but
> is inconsistent with maps__init() and other functions.
>
> maps__maps_by_name_addr() is also quite hard to read because we already
> have maps__maps_by_name() and maps__maps_by_address(), but the function
> is only used in that place so delete it.

Agreed, I feel like we need some more cleanup here.

Thanks,
Namhyung


>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/maps.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 61eb742d91e3..16b39db594f4 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -124,11 +124,6 @@ static void maps__set_maps_by_address(struct maps *m=
aps, struct map **new)
>
>  }
>
> -static struct map ***maps__maps_by_name_addr(struct maps *maps)
> -{
> -       return &RC_CHK_ACCESS(maps)->maps_by_name;
> -}
> -
>  static void maps__set_nr_maps_allocated(struct maps *maps, unsigned int =
nr_maps_allocated)
>  {
>         RC_CHK_ACCESS(maps)->nr_maps_allocated =3D nr_maps_allocated;
> @@ -284,6 +279,9 @@ void maps__put(struct maps *maps)
>
>  static void __maps__free_maps_by_name(struct maps *maps)
>  {
> +       if (!maps__maps_by_name(maps))
> +               return;
> +
>         /*
>          * Free everything to try to do it from the rbtree in the next se=
arch
>          */
> @@ -291,6 +289,9 @@ static void __maps__free_maps_by_name(struct maps *ma=
ps)
>                 map__put(maps__maps_by_name(maps)[i]);
>
>         zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
> +
> +       /* Consistent with maps__init(). When maps_by_name =3D=3D NULL, m=
aps_by_name_sorted =3D=3D false */
> +       maps__set_maps_by_name_sorted(maps, false);
>  }
>
>  static int map__start_cmp(const void *a, const void *b)
> @@ -1167,8 +1168,7 @@ int maps__merge_in(struct maps *kmaps, struct map *=
new_map)
>         }
>         maps__set_maps_by_address(kmaps, merged_maps_by_address);
>         maps__set_maps_by_address_sorted(kmaps, true);
> -       zfree(maps__maps_by_name_addr(kmaps));
> -       maps__set_maps_by_name_sorted(kmaps, true);
> +       __maps__free_maps_by_name(kmaps);
>         maps__set_nr_maps_allocated(kmaps, merged_nr_maps_allocated);
>
>         /* Copy entries before the new_map that can't overlap. */
> --
> 2.34.1
>
