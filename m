Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284B1FFC7E
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356515; cv=none; b=PBiS6lHf7m1AQUoG0g8VYxuXLaXi0zSJMzGGc3yHPpsNo8pQIZ4EHQtdUNc1P1/fUX9+GPw1f6AZi3rHFtK+iiv9ny2WG1+S/GoxR54TTBxay72IU4wvM5wM69qirBMSAYmqXHy8tysyFPOQ4owV3XtZ7K1toCfM4wDQmdOXq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356515; c=relaxed/simple;
	bh=9EHM2jtclQ/eLUxrmYgkSSffS2ptr4WGI+1b2yCdv4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qayjh2ekSR+MOOKraB5idLqX6xw6EAXU7J6Qq0KYz8EYxx6u96wuCN7I5mAhQUxF3C8Tb+eiPn9/eGiAwO2O3rT3hlO/lYzZYskqpvpM/Q3bVKdbyUk8VUKLlTLXwy70MDVYHoUSou0F8XwJ+M0eQ2KFzgdFeKsnLD8fH/+E9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFRcO5cW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFRcO5cW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163affd184so141375ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736356513; x=1736961313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzeQL7SWoLSVUIhwFJy6hAJPLk/Pb4CjeJOLnjQXvvU=;
        b=RFRcO5cWPxdaQUD2xy1yPEqfd4YJlMYLvlcwszTHa9DQn6tjCE6opOuvqr8mFUKvmP
         K4uV1/IOG2O94qQVCC/LPIazAJCF7BrX3gLOD0okdiK71/RnxxPzh0u/3JCYel4Z4EEU
         AicGY4cCMy369hzmJOGbQzZzlYc1ALIHL889V+vLxQbzg9VH75vNwGLJwucEwJgcQkX2
         74XYJBD0EcPZGnXhRCNFD5Rrse1RHfWzVcydFhuXPmSODcXNOIERB5FGObd6mWveY7ml
         tGaTVmjxc2Xkqqd18gz2AbljuHNHUMfPLvozDJRlQXGb60Zex1XJX04/Y9HKHOV4sEo/
         NDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736356513; x=1736961313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzeQL7SWoLSVUIhwFJy6hAJPLk/Pb4CjeJOLnjQXvvU=;
        b=F+2ZBVP5y3sbM1GZoLTtpCKWdU/9TmvRK9icgon1NGW5gg+b3dftQlf4rL14hBa9bu
         Wh7mlRF42kk0BH/hdWcEknDLhBDjGVvFdOfX2n8kw+GfVkQm2zuVU09L/d0twuAOHpWO
         k4q/UX92f7ESsvX1c23nkMTzBcNuxMQGGzfzegOXeIiLQ/qi6yK00gwtPXQyo4tqc8XU
         +W6tLCEeq5PI+ltcuWgiVQJdzh1X5X7bv+hdWLZR+d9y7IOjkMttoM91oaTc0oDCKSKe
         umjLaDMxqR/nI4zjynXqjc1mgIP/fQgKjtLXiGDcieIPK4XeySSSTDzz1J3auaRCRzuv
         ramw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6VZr03bOslIbgAGio+wIjU6X6c/5TJo0xf0lMd/nPaOxBqH/Dd5zap1E2xUkNIdx2OkFc7JOoXSSERr7mLlt@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZLv68S/MDq6IulZqp1Dxbc9l0u5RfvKNJCIo3oQ6Yscp10nU
	C+u+JpxJp4Y2JEN/FF0qububDOqBVeHIVbZQrXS9+i9+nVmI0TCElixJyOUQnGoDcsAWM2WEOy9
	FZ3NESX5FF6Opz982+u6s/Rwry5rnbkpl5ysA
X-Gm-Gg: ASbGncuDuDfphhATOteyZRSHBnVmPgv5pROtIV5jJDGcyeAllqC6NaGUa4xNyVNvA0j
	KAwJIyXKp/IMU5jc1PHAKMhrj63yic5uKa5ysJLkP77Nc7O6Z70H5eD87g/IQGQEjv55zrg==
X-Google-Smtp-Source: AGHT+IHV2vEIiKkJXNgvzoiZpd1XCj/Pi+js5cCr0y1wseawq73Fx5cJ7suh74eghtNIkWTrTA8T/QAGrw/1Nt4vuQI=
X-Received: by 2002:a17:902:f54a:b0:216:405e:8e2 with SMTP id
 d9443c01a7336-21a85463148mr2168665ad.27.1736356512676; Wed, 08 Jan 2025
 09:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ea4501209d5363bac71a6757fe91c0747558a42.1736329923.git.christophe.leroy@csgroup.eu>
In-Reply-To: <2ea4501209d5363bac71a6757fe91c0747558a42.1736329923.git.christophe.leroy@csgroup.eu>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Jan 2025 09:15:00 -0800
X-Gm-Features: AbW1kvbRRMuz4ZomzPJSO4OQ8dFOiTuQmMSN2W1Z3i_Udy0Uz506YYihKwYBq5Q
Message-ID: <CAP-5=fWSRJ=PNTRkHVVpWGSM5R0rLH5Sqgwv_St7+Q3TJaLRWw@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Fix display of kernel symbols
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 1:54=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Since commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily
> sorted array for addresses"), perf doesn't display anymore kernel
> symbols on powerpc, allthough it still detects them as kernel addresses.
>
>         # Overhead  Command     Shared Object  Symbol
>         # ........  ..........  ............. ...........................=
...........
>         #
>             80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
>              3.91%  Coeur main  gau            [.] engine_loop.constprop.=
0.isra.0
>              1.72%  Coeur main  [unknown]      [k] 0xc005f11c
>              1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
>              0.44%  Coeur main  libc.so.6      [.] epoll_wait
>              0.38%  Coeur main  [unknown]      [k] 0xc0011718
>              0.36%  Coeur main  [unknown]      [k] 0xc01f45c0
>
> This is because function maps__find_next_entry() now returns current
> entry instead of next entry, leading to kernel map end address
> getting mis-configured with its own start address instead of the
> start address of the following map.
>
> Fix it by really taking the next entry, also make sure that entry
> follows current one by making sure entries are sorted.
>
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted arra=
y for addresses")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> v2: Make sure the entries are sorted, if not sort them.
> ---
>  tools/perf/util/maps.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 432399cbe5dd..09c9cc326c08 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1136,8 +1136,13 @@ struct map *maps__find_next_entry(struct maps *map=
s, struct map *map)
>         struct map *result =3D NULL;
>
>         down_read(maps__lock(maps));
> +       while (!maps__maps_by_address_sorted(maps)) {
> +               up_read(maps__lock(maps));
> +               maps__sort_by_address(maps);
> +               down_read(maps__lock(maps));
> +       }
>         i =3D maps__by_address_index(maps, map);
> -       if (i < maps__nr_maps(maps))
> +       if (++i < maps__nr_maps(maps))
>                 result =3D map__get(maps__maps_by_address(maps)[i]);
>
>         up_read(maps__lock(maps));
> --
> 2.47.0
>
