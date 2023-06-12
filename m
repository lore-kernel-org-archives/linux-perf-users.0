Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B2C7EE2F
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 16:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjFLQcq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbjFLQco (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 12:32:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755511B
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:32:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f98276f89cso387201cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686587562; x=1689179562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPnmFMFnuOl/+BJYAWO3ZIJ9+gOdrJg+ZObFLjXbGV4=;
        b=U5O+/GjXhoO8xW8lLDMVYZ/Qr5eD8/sXL0oRzcMjpqi4Vug2/Mr/R+sx3LOSPXQE7c
         Y5Mn2pzTi09i2IC3zff02IB80QAc2wqTHFaoUiaRurYNdQlJJCGVw8zdqfRjQbXCkbRz
         1/2FBZ3MJmjxIL67HTXV9CAxj5s+xfQq7GD7mmBKG6e8ewdPk7C3DmkCsddE64vgPaxP
         GEDP7iLA6cOjErvcaDGYqKniqcF97I/folaEBVA99QQjtmtGBrLzbpIe7ePAO77Ougtq
         1b6QLOG0l7Snqy08zomYHqBPqoptAgEPspKtK9dyugI3Y1+BXJixvo5307fLUKz01DsU
         sZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587562; x=1689179562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPnmFMFnuOl/+BJYAWO3ZIJ9+gOdrJg+ZObFLjXbGV4=;
        b=WLbgJr/V9ubbiU3QZJMMqHZl2xlq8P/yEhEoykvwXbRrx8swmcjbwxpykQw99brjEy
         ng+sghZ5/qQj8SifK3nOdMS0YkBI93DL8PQWZNdtslrdLJTiTFrAJmFekQjWsgkC8yin
         /bdfU8Vz+VjldnV68Yk+GuGAvBqyCO1L4NJ1vbG1NtlC8WJj47PxjmLh0xbL8g7klzZp
         ESdHvthDFv1eDbLgVB4ug+cUmccdcyj34Da0GNxBZXglbmWkta0cNUWV0NHcrZphw0Rf
         oUsNBW3S2et5qj8h7zjnP6j7nVG8QhMkHcgwWqZAvVidVOZHMpoBEl2w2U6VHkM6rfzY
         Pufg==
X-Gm-Message-State: AC+VfDzMjpgQtpQuSwwbMGNtn5DoXDWBGCz0xgPpsvHQFTKy0dQb61uh
        BfhrLSy2bjRAgA73DyIoE0ji1fOdOLE9t+UEfWbTpQ==
X-Google-Smtp-Source: ACHHUZ46FOITq6RvpLNObfQl3PyLjBziM/Tc7wPAcrSxrHybd6NduppjKQkWwpWEO/shOsSsMra/siM4rGYYNLEFYi0=
X-Received: by 2002:ac8:7f10:0:b0:3f8:3065:7fc5 with SMTP id
 f16-20020ac87f10000000b003f830657fc5mr386846qtk.1.1686587562300; Mon, 12 Jun
 2023 09:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230612150424.198914-1-james.clark@arm.com>
In-Reply-To: <20230612150424.198914-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 09:32:30 -0700
Message-ID: <CAP-5=fWu0yCSCB__prps2g=JRDScbhWuimPJHUsU0S_c0ywDhg@mail.gmail.com>
Subject: Re: [PATCH] perf map: Fix refcount errors on Arm with -DREFCNT_CHECKING=1
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 12, 2023 at 8:05=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> When quitting after running a perf report, the refcount checker finds
> some double frees. The issue is that map__put() is called on a function
> argument so it removes the refcount wrapper that someone else was using.
>
> Fix it by only calling map__put() on a reference that is owned by this
> function.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/symbol-elf.c | 9 +++++----
>  tools/perf/util/symbol.c     | 9 +++++----
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 63882a4db5c7..ec0d7810bbb0 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1365,6 +1365,7 @@ static int dso__process_kernel_symbol(struct dso *d=
so, struct map *map,
>         struct dso *curr_dso =3D *curr_dsop;
>         struct map *curr_map;
>         char dso_name[PATH_MAX];
> +       struct map *map_ref;

nit: can we narrow the scope of this by moving it to the scope where it is =
used.

>
>         /* Adjust symbol to map to file offset */
>         if (adjust_kernel_syms)
> @@ -1390,10 +1391,10 @@ static int dso__process_kernel_symbol(struct dso =
*dso, struct map *map,
>                         if (kmaps) {
>                                 int err;
>
> -                               map__get(map);
> -                               maps__remove(kmaps, map);
> -                               err =3D maps__insert(kmaps, map);
> -                               map__put(map);
> +                               map_ref =3D map__get(map);
> +                               maps__remove(kmaps, map_ref);
> +                               err =3D maps__insert(kmaps, map_ref);
> +                               map__put(map_ref);
>                                 if (err)
>                                         return err;
>                         }
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 6b9c55784b56..b3034fd5c0af 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1368,6 +1368,7 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>         int err, fd;
>         char kcore_filename[PATH_MAX];
>         u64 stext;
> +       struct map *map_ref;

nit: can we narrow the scope of this by moving it to the scope where it is =
used.

Thanks,
Ian

>
>         if (!kmaps)
>                 return -EINVAL;
> @@ -1464,10 +1465,10 @@ static int dso__load_kcore(struct dso *dso, struc=
t map *map,
>                         map__set_map_ip(map, map__map_ip_ptr(new_map));
>                         map__set_unmap_ip(map, map__unmap_ip_ptr(new_map)=
);
>                         /* Ensure maps are correctly ordered */
> -                       map__get(map);
> -                       maps__remove(kmaps, map);
> -                       err =3D maps__insert(kmaps, map);
> -                       map__put(map);
> +                       map_ref =3D map__get(map);
> +                       maps__remove(kmaps, map_ref);
> +                       err =3D maps__insert(kmaps, map_ref);
> +                       map__put(map_ref);
>                         map__put(new_map);
>                         if (err)
>                                 goto out_err;
> --
> 2.34.1
>
