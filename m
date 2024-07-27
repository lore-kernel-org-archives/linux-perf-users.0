Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4812E75
	for <linux-perf-users@vger.kernel.org>; Sat, 27 Jul 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722041405; cv=none; b=etwEAC23O6J8tfEdfH+uNJ66O+pdc/Fu9UVvJ6abhxNwbzNoDwkeiCFnBG6KeRcLZAo7VSJNjS5cEQyE9UtvsO0nlsk/ZSvOM6ub9oC86/0PBc2qVWPf1D9epzz5Gf656FRmVvdyhwNcXhaQT5vq+3BK4UoUDl1UOLwJHU5gHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722041405; c=relaxed/simple;
	bh=h1NRkAAYfILwo5tqX38iItQplHY3FtRZ5SeLPHiOZqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpKn9NvYpt9M1ubHnkui9RjQ7WTFc3RlAsaN+08Ad8uHCKjKUB6hlZlNw1R/++EjeqZSAPcBPa/wJ1sP+6pk3U9ncliBRK+eyeUL7ZA3Ztlp1yxdYq4eztqMp2PJerTzh8qyStM4VsJDcXN6nNSoEI+3OJXrfSRZrJRSeVgBJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIie/lfR; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIie/lfR"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39a16fab332so3205ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 17:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722041403; x=1722646203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mCs8ZCIo4TugB0JMvlvTNn16u+EsAhu40JJJyChvTs=;
        b=IIie/lfRdbXudtGjwy44gu90QA4urpQ/k8Fvx9sQF6BWHBuxEejN3kH9sHw7Q90EAp
         Rob7W9cgOyW/lK2G50qmk6HNZ1FRht3i4CquttjGRBSB5VrxwU00ilZQENlRxQlPrHOj
         40dy2dg73QxNT7PywK5EQ4catn8ii3/pBWb3tZbHQWXHrTUdn1+Nvki079NnW/JR7ZlX
         7Be+Vaw9PS7JWLppoJsqy+uB+gfd6lv9Uiz2McaUyHpdf812oYA8IOyFXY5bsQrrz/Hw
         DX6I+UnnBFQhEbEo6coetpS/hvOIBaSnNBDyEL+4LC05AIFCI4DNTcwHiltfBZYWzi3A
         sS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722041403; x=1722646203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mCs8ZCIo4TugB0JMvlvTNn16u+EsAhu40JJJyChvTs=;
        b=lMHRxDoANhkKMOY4d1u9KmAITcs/2JGConnMy4KfxwZOtc17VSsLydAg8o3/bcvrU9
         A0E2KzJv82uNPxi8CrG6XOCQyUUgvzTiS2lCHGyuTLT0mF3oPGzvhn8caciUJuDC+o28
         7SncX7f0q6FwlW5o1W1WQHDBoFy6HPuLbhZ2xdBXVozmPWbx5M60Bu6/4lIh88TR/8Qg
         HNJ1A0izaHyp2Gbqq/qRM8O3BZ33Ifb3oXvibYHkn0K0xqyrxAWhH7FpB8yZjn6zfU4m
         niN31G57Mrd6r8c3/yVCu9Xg09CCqvAVudklUl+AfKWrgiwwrJ/cUpvMcOhydLfuNFwZ
         Gj7w==
X-Forwarded-Encrypted: i=1; AJvYcCX63cwGBoYKkXiFPDmuVEBePD98W46f7TRiiK9drdomQe+30QhFvmafaM0yTvZeLPw8RNzA2s7fAdnnH2lRi0OEanMkjWk7wO47bhnTsgHRdQ==
X-Gm-Message-State: AOJu0YxuJYoR5aj2RR7/eGydUHYjcAZhtc5+3gdyn8c5gJoGZ0PrPzmC
	HxfB1TO3CzaQe0A9Fgj4aQWH3N7HgnNgl1Ef16n5chKcOSetVrWVPKhI3rnVSzoYMH4DifpmEfy
	Zj91QJkn0yeXDBe/zL1NX7rBFRSc8KvyAmKcM
X-Google-Smtp-Source: AGHT+IErx0Vpwx8B+OMjl56rDDcYnu0gjoEWpyLOUI3ZKhjtdqTeHIcKd27oHM+SYahNI8K6Yl8R2oi6ymDT4Qoe9Po=
X-Received: by 2002:a05:6e02:1569:b0:376:3998:9629 with SMTP id
 e9e14a558f8ab-39aecae5685mr1120855ab.13.1722041402709; Fri, 26 Jul 2024
 17:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102826.787004-1-howardchu95@gmail.com> <20240726102826.787004-5-howardchu95@gmail.com>
In-Reply-To: <20240726102826.787004-5-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jul 2024 17:49:49 -0700
Message-ID: <CAP-5=fW0AATSiUxm4wckT3Y3BvAUczNrzRHd13uvEtmgSw90fw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] perf record off-cpu: save embedded sample type
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:28=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> We have to save the embedded sample type for it to be consumed correctly
> by perf script or perf report.
>
> This is a bad approach because it most definitely will break some
> perf.data convertor. Another approach is to add this sample_type_embed
> to perf_event_attr, but changing perf api is above my pay grade, so
> please give me your suggestions!
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/header.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 55e9553861d0..ccb5493dc515 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -80,6 +80,7 @@ const char perf_version_string[] =3D PERF_VERSION;
>
>  struct perf_file_attr {
>         struct perf_event_attr  attr;
> +       __u64 embed;
>         struct perf_file_section        ids;
>  };
>
> @@ -3713,6 +3714,7 @@ static int perf_session__do_write_header(struct per=
f_session *session,
>                 }
>                 f_attr =3D (struct perf_file_attr){
>                         .attr =3D evsel->core.attr,
> +                       .embed =3D evsel->sample_type_embed,
>                         .ids  =3D {
>                                 .offset =3D evsel->id_offset,
>                                 .size   =3D evsel->core.ids * sizeof(u64)=
,
> @@ -4147,6 +4149,14 @@ static int read_attr(int fd, struct perf_header *p=
h,
>
>                 ret =3D readn(fd, ptr, left);
>         }
> +
> +       ret =3D readn(fd, &f_attr->embed, sizeof(f_attr->embed));
> +       if (ret <=3D 0) {
> +               pr_debug("cannot read %d bytes of embedded sample type\n"=
,
> +                        PERF_ATTR_SIZE_VER0);

nit: sizeof will likely be larger than this, so prefer to this
constant? Maybe errno will be more useful.

Thanks,
Ian

> +               return -1;
> +       }
> +
>         /* read perf_file_section, ids are read in caller */
>         ret =3D readn(fd, &f_attr->ids, sizeof(f_attr->ids));
>
> @@ -4272,6 +4282,8 @@ int perf_session__read_header(struct perf_session *=
session, int repipe_fd)
>                 tmp =3D lseek(fd, 0, SEEK_CUR);
>                 evsel =3D evsel__new(&f_attr.attr);
>
> +               evsel->sample_type_embed =3D f_attr.embed;
> +
>                 if (evsel =3D=3D NULL)
>                         goto out_delete_evlist;
>
> --
> 2.45.2
>
