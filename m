Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638421D12E0;
	Thu, 22 Aug 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287139; cv=none; b=b5AlJp7WM79dWLgW8+uZhTnUZj3vUHdp1guCK52sUkkVa9w+sr5fvE//GBRnAZ0I/NycOqE157x2Z6FClgL1vFd0kiG/1wU0o3cdOWTcQM6Rlw7teBJh1kuOsAU3R4QWGNnJemI5yrjbmdNoSAgjFE7JDfl/bGlSdNZliN5CpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287139; c=relaxed/simple;
	bh=uODybORlW1Kn4hk/0jntMAIqd+PQSZLqURGiujbvz78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsA9NpBD9oN3eSmWkjYFob5Ot+SWyPZMQ4oaVnaEMAejiupJio9aT/yrN4bifK2swFhT9PlUXZ5io5K9LV8Lyffb7u77q5vuyGVDsFqK8TujDBbSb9m6rKEaXJFVWVSd4czlO2CX3QImCGI+rREXfOrrJWrL4E+Yrr/bC4F3F34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo188870a12.1;
        Wed, 21 Aug 2024 17:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287138; x=1724891938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFpmgSqC6zlZh7xPVeXEKWlc28TttUJByYddICCMgAU=;
        b=hpA83QMls7HxoW5oN8sAvWZCep/eGeR15fqkidgQaezi+afHttjX72y/uAn+8tPB/x
         uW/VpO9vwovdSHpsYlXoKWVar/2O/R2KIuU229o9vGuDjWhHEcmCT50d3Hm0LIAZBPDg
         NG1XN4xSlW0swmKAEm2zoKcN8v7NHyPh1Jg7x13up0bbmeUoTjAKDIGnneP8KtUYuE72
         LaYyPSMLiSdwew6fikXLePxVlqlpdZnRK1Miueg4G/dmvD7lUHeMFkx3jwNbVCxbYFbq
         2d+jgh+H35cFceK1n0mgb7IIVXoavAX5XuCAM0qR2OfKO+cS3amKPpp25qOOXRlDsMh3
         oU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7SMSqKRqG0wQ/+b0Cp0ccJWHJuFOr6Nzc4Y+dgRpHxqxQbILCyBJrITiwuHE857nFmgRlc88roJsS4khaRu4EnA==@vger.kernel.org, AJvYcCWdQQUrfEDJL6semyJZCvsusiQFLOI8hX/jAasRPUar7UDX7Uh4lyVKBx/dUi19IzKT8j14TkKrqzhaLF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kkb94xSInsy6kSIct3VLscyvQdfLlyN0etHwljh0TAKrK10e
	ZiEqDpvAsG+/DhygC3vIgrqjUHP7jiLSIDnl1UUoTwPhfwxpwho3JGWr86TFJJTJPm9i5j1Agmy
	rpDfX45dGrQYoJu1dkY1TKqN9XcI=
X-Google-Smtp-Source: AGHT+IEZAhCN3obd4iWx6i1hVZ/nzpajIeDbS5jp84c4JIOQUC6gRflxdHKz2kY2uuYUd2uktuewTTzAN167Luvz0ac=
X-Received: by 2002:a05:6a21:1786:b0:1c3:fc87:374e with SMTP id
 adf61e73a8af0-1cada15f583mr4694795637.41.1724287137418; Wed, 21 Aug 2024
 17:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820183202.3174323-1-kan.liang@linux.intel.com>
In-Reply-To: <20240820183202.3174323-1-kan.liang@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 21 Aug 2024 17:38:45 -0700
Message-ID: <CAM9d7ch1tmkmrpcxdW4Txz20Xzt6NFx_-0m6HQzTwXAV7Opg2Q@mail.gmail.com>
Subject: Re: [PATCH] perf hist: Don't set hpp_fmt_value for members in --no-group
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kan,

On Tue, Aug 20, 2024 at 11:31=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Perf crashes as below when applying --no-group
>
> perf record -e "{cache-misses,branches"} -b sleep 1
> perf report --stdio --no-group
> free(): invalid next size (fast)
> Aborted (core dumped)
>
> In the __hpp__fmt(), only 1 hpp_fmt_value is allocated for the current
> event when --no-group is applied. However, the current implementation
> tries to assign the hists from all members to the hpp_fmt_value, which
> exceeds the allocated memory.
>
> Fixes: 8f6071a3dce4 ("perf hist: Simplify __hpp_fmt() using hpp_fmt_data"=
)
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/ui/hist.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index 5d1f04f66a5a..e5491995adf0 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -62,7 +62,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist=
_entry *he,
>         struct evsel *pos;
>         char *buf =3D hpp->buf;
>         size_t size =3D hpp->size;
> -       int i, nr_members =3D 1;
> +       int i =3D 0, nr_members =3D 1;
>         struct hpp_fmt_value *values;
>
>         if (evsel__is_group_event(evsel))
> @@ -72,16 +72,16 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hi=
st_entry *he,
>         if (values =3D=3D NULL)
>                 return 0;
>
> -       i =3D 0;
> -       for_each_group_evsel(pos, evsel)
> -               values[i++].hists =3D evsel__hists(pos);
> -
> +       values[0].hists =3D evsel__hists(evsel);
>         values[0].val =3D get_field(he);
>         values[0].samples =3D he->stat.nr_events;
>
>         if (evsel__is_group_event(evsel)) {
>                 struct hist_entry *pair;
>
> +               for_each_group_member(pos, evsel)
> +                       values[++i].hists =3D evsel__hists(pos);
> +
>                 list_for_each_entry(pair, &he->pairs.head, pairs.node) {
>                         for (i =3D 0; i < nr_members; i++) {
>                                 if (values[i].hists !=3D pair->hists)
> --
> 2.38.1
>
