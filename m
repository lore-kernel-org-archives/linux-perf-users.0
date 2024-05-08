Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232F12C497;
	Wed,  8 May 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203148; cv=none; b=fyVUyKs/J6nTIFuWnbNcPZ99OvrP07kF+fmmVouyWbdcFJ/KQwb2UTAksF//1vs38eR9k6QF7sFtIC+tTRBFmZ7Kgy04njOP9jY6wgcX3EM/d30oUrd64TtbSJlHysDSIIfoY2degE1ZqMmYeR20skEpDIQnyKCrlfb7cNAdHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203148; c=relaxed/simple;
	bh=LZaTxpcC6rDlaczxIBkXQsVl/n555uhdZA29kcRqL1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAUuKL6tHMr7aPSxp3+YB5GLp01w05Ohi2ptsWiPPlqD2XdoOLUhG56HB/ngqMd/H1+siXBlEYIm9nrLeuiIF1TakaJo/KQeBsGADhzJmqwAUc0oKnrIYl3srwaugr0JVEgUJAIeCK66SGS/fknymmTPjoCYGv6R8NUQIo22loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b4348fa971so195600a91.1;
        Wed, 08 May 2024 14:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715203147; x=1715807947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH/sB0aLG2WmibnGzHehJ6oJYqkz2Fm71FR2/jk70jg=;
        b=V8yVYeuGKmPnll8KVt5B9y3lMF3Aq1aFdoEFI2adltzpi9+s5iccPoAyIDMILrv408
         vJTdxKvF7o0w080djTFdYdQq9X32j0Xz1yZJ1H2D+tRoULOf0PhYIQYnOVeX9Rs149Yp
         Feim4IcmAlThBgAkb0vz8E+y0OOHbP8i/enwkeuCioSGnC6Ay2RIn1vfapvvtBKddVMa
         tD9N2d1piVGQSDl2oKZhhcSaq1yL0w4RqBwFy/uXVP6G3Jl0+WM78swng9HquoleapoG
         tF1XAqG9jgZp5Mkjax4mxlQpPR3+vdosewVO+E0YNHd1ve0DwyUKU8Hp1f6HmMF3OnCq
         R24w==
X-Forwarded-Encrypted: i=1; AJvYcCW/OHNKjg9M1gl6iJ4HYBMUAkOkkyouqcPo0fgzjxGUqL+mAq2RoB38YdMaLBhK7pmkGB3soEJkAE9kQduIi9lGq/4iYGOk2HvncIKFeyt/5A==
X-Gm-Message-State: AOJu0YxGo7N0iy3JcSa0uO2QcK9n1xOCUcN03kK7vFXsbMBXPOGw0mLi
	tz2W0V6mXbhENAbBRV5/BzfuK3SIudeQMANO8FXskXyeErzZpEzS1ysduZ1nteCydvU1+gSoKwx
	WC4YUI93xjqqwsREj+iLtFRklmUw=
X-Google-Smtp-Source: AGHT+IH+t++T544tPgXHpsm0a1tOuiLQCQxEAsmohdvIVYxfAQt0ye/thNzXQuR0DBvAYffz/QdOdsHhrcWb0fzJRx8=
X-Received: by 2002:a17:90b:358c:b0:2b4:39cd:250c with SMTP id
 98e67ed59e1d1-2b6163a26d2mr3978862a91.8.1715203146579; Wed, 08 May 2024
 14:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508134259.24413-1-nick.forrington@arm.com> <20240508134259.24413-2-nick.forrington@arm.com>
In-Reply-To: <20240508134259.24413-2-nick.forrington@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 8 May 2024 14:18:54 -0700
Message-ID: <CAM9d7ciQ5idMLWO51JrpNEbFtdtrgz3o0qashX5dL2y1d1MRyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf lock info: Display both map and thread by default
To: Nick Forrington <nick.forrington@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 8, 2024 at 6:46=E2=80=AFAM Nick Forrington <nick.forrington@arm=
.com> wrote:
>
> Change "perf lock info" argument handling to:
>
> Display both map and thread info (rather than an error) when neither are
> specified.
>
> Display both map and thread info (rather than just thread info) when
> both are requested.
>
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
>  tools/perf/Documentation/perf-lock.txt |  4 ++--
>  tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index f5938d616d75..57a940399de0 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -111,11 +111,11 @@ INFO OPTIONS
>
>  -t::
>  --threads::
> -       dump thread list in perf.data
> +       dump only the thread list in perf.data
>
>  -m::
>  --map::
> -       dump map of lock instances (address:name table)
> +       dump only the map of lock instances (address:name table)
>
>
>  CONTENTION OPTIONS
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 230461280e45..d0b8645487ad 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1483,11 +1483,16 @@ static int dump_info(void)
>
>         if (info_threads)
>                 dump_threads();
> -       else if (info_map)
> +
> +       if (info_map) {
> +               if (info_threads)
> +                       fputc('\n', lock_output);

it seems you need pr_info("\n").  Where does lock_output come from?


>                 dump_map();
> -       else {
> +       }
> +
> +       if (!info_threads && !info_map) {
>                 rc =3D -1;
> -               pr_err("Unknown type of information\n");
> +               pr_err("No lock info specified\n");
>         }

I think we can remove this block now.

Thanks,
Namhyung


>
>         return rc;
> @@ -2578,9 +2583,9 @@ int cmd_lock(int argc, const char **argv)
>
>         const struct option info_options[] =3D {
>         OPT_BOOLEAN('t', "threads", &info_threads,
> -                   "dump thread list in perf.data"),
> +                   "dump the thread list in perf.data"),
>         OPT_BOOLEAN('m', "map", &info_map,
> -                   "map of lock instances (address:name table)"),
> +                   "dump the map of lock instances (address:name table)"=
),
>         OPT_PARENT(lock_options)
>         };
>
> @@ -2694,6 +2699,13 @@ int cmd_lock(int argc, const char **argv)
>                         if (argc)
>                                 usage_with_options(info_usage, info_optio=
ns);
>                 }
> +
> +               /* If neither threads nor map requested, display both */
> +               if (!info_threads && !info_map) {
> +                       info_threads =3D true;
> +                       info_map =3D true;
> +               }
> +
>                 /* recycling report_lock_ops */
>                 trace_handler =3D &report_lock_ops;
>                 rc =3D __cmd_report(true);
> --
> 2.44.0
>
>
