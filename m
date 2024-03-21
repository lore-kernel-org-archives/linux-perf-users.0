Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFC79FD
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Mar 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985864; cv=none; b=A5nylg3DMRxUpR8e8wQp/NJ3/K7b0ef4vFfD9cOWN8qZX85kEYBXbYSGjhR806rrWhu/tGuhrDbYZdPpTr3DA0I3+VnEX3w6AdFkFc9XAE5ntYPIA6qjrNzFsjG4YgvsrFCltoh+CQeNgjyEocxT/agHwq2aTrZEqK0ep2KWKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985864; c=relaxed/simple;
	bh=5OH1HhBNQ4E7KZG0KnYehzuDvsgYQmJCQoB0QMizlpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxQkuZuAIFdrY0Fp7jwHpi73OM+NJeD0iIhgBJJYDjr58VLjwliV4dgk8+sSu4poG/XZ3kcV6HCe+PVOJqQUHjB7avFR/6dfOfriEVCeBnz2vcazK4WsqrI7lNXsjQOhX8zldUIxgs1/W7svMBauR81w2xR5g1hFk9OQLITpsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grOJyBM0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grOJyBM0"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36849db2578so42325ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710985862; x=1711590662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYU9J7zFBTCo8/TGqyh4wiUR0hjUIzHAyC/ggld+LKI=;
        b=grOJyBM0KiIt4uguVTA0aw/sb195Xlg6RRWn4eQg1KNx0anlMYM9vmai1GkBGSc2IZ
         3lObZ1LeYDDvtkjoSEXC3Mvj0HrsoA6p6wVOP8W+zcorSE1ciiD0os4ArK4QfOmIlIU8
         z1vsUrVJQYerQDSPuQDvw75+y58N0nvgu5Nh4OkcJC0cYqEG4bajjXzrudcPWMGGMDuF
         4cIEGDP9Nahs2bjwPJ2QzwPENSRndq0cHJK30pyOy5yS5Qy8Y2xFF3GcR76Ftuj+joLk
         YUzYOfy562njtbZBunR282Q0CgDSqnYfkl03OgsBk+JAS5/if3ZRMRD6MY4QpPU8+3Eg
         Ke9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985862; x=1711590662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYU9J7zFBTCo8/TGqyh4wiUR0hjUIzHAyC/ggld+LKI=;
        b=vtDC0+Y9AAKvp9L82C20vNFzIhCqGzZmDG4eiAr//QsNvpQW/VsrakzH9DMWeJ5ELd
         9DPoqz0dcpFIQNDncxFoYR3uaxW330ZMylhl3DB5GckRP7cfl63aGCGpv6JURzk6S+n/
         cdxDQGjXlFqfPhqmcOhLjct2BZjcDwOUIuSEeQJaI4D2om+syphDLE7CSXvlvGl9vPiL
         4Rx2za2p7Y3KYxeS5+sE88t0AfjkV3rOysX4VWUlUwQth2iuNZJ5ElMsBLOIU6jR8ShJ
         gS49v5r/iEmJ4vLEsx876isDR46/jTpNEjUPLGcjkKKriHm+OMGHKKLJ8EQApfzM/+nf
         7qeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK0Ugv7p3dnmc1QLSEjArdXv7NSEMZc3r5w9g9Na4KjhWs4vT4B2bQ8DJ8v4koie5mTx4UnaHQlY7IkRUreXuQnz0OeAmMFkXLFAvNpuu6sA==
X-Gm-Message-State: AOJu0YyU6lRqdyYgA6Cs+uFcwJSAQKD5yXa/dQB23qNljusAcAFLgjsq
	4+DokQC2u4rpJlPwOwR7IGFeuzyJ1Qsxt80lDsMfSFKSFT69w/jpeWQsiXy2ZYEQAWcLWGugu3Y
	oS3uT5qByFzuAPtxcWa/zv4dcFN2UIAAyPqjm
X-Google-Smtp-Source: AGHT+IG97IT+pKG4kVZObTgVLGGuIN+Q4dsZ89nyfiz3iy42xhap1df934wbnlGR1HGpgQoYRuryoyYsvKyiT4ht6k0=
X-Received: by 2002:a05:6e02:164e:b0:366:a817:61e5 with SMTP id
 v14-20020a056e02164e00b00366a81761e5mr126039ilu.26.1710985862059; Wed, 20 Mar
 2024 18:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320193115.811899-1-acme@kernel.org> <20240320193115.811899-6-acme@kernel.org>
In-Reply-To: <20240320193115.811899-6-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 18:50:50 -0700
Message-ID: <CAP-5=fWw9n=b02KOvh=OuWrSx0KgUikPdnhs70DHNqNsG6mWPA@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf trace: Fix 'newfstatat'/'fstatat' argument
 pretty printing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> There were needless two entries, one for 'newfstatat' and another for
> 'fstatat', keep just one and pretty print its 'flags' argument using the
> fs_at_flags scnprintf that is also used by other FS syscalls such as
> 'stat', now:
>
>   root@number:~# perf trace -e newfstatat --max-events=3D5
>        0.000 ( 0.010 ms): abrt-dump-jour/1400 newfstatat(dfd: 7, filename=
: "", statbuf: 0x7fff0d127000, flag: EMPTY_PATH) =3D 0
>        0.020 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 9, filename=
: "", statbuf: 0x55752507b0e8, flag: EMPTY_PATH) =3D 0
>        0.039 ( 0.004 ms): abrt-dump-jour/1400 newfstatat(dfd: 19, filenam=
e: "", statbuf: 0x557525061378, flag: EMPTY_PATH) =3D 0
>        0.047 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 20, filenam=
e: "", statbuf: 0x5575250b8cc8, flag: EMPTY_PATH) =3D 0
>        0.053 ( 0.003 ms): abrt-dump-jour/1400 newfstatat(dfd: 22, filenam=
e: "", statbuf: 0x5575250535d8, flag: EMPTY_PATH) =3D 0
>   root@number:~#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ef0dfffd99fdf3cc..d3ec244e692a415e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -978,7 +978,6 @@ static const struct syscall_fmt syscall_fmts[] =3D {
>                    [1] =3D { .scnprintf =3D SCA_FILENAME,     /* path */ =
},
>                    [2] =3D { .scnprintf =3D SCA_FSPICK_FLAGS, /* flags */=
 }, }, },
>         { .name     =3D "fstat", .alias =3D "newfstat", },
> -       { .name     =3D "fstatat", .alias =3D "newfstatat", },
>         { .name     =3D "futex",
>           .arg =3D { [1] =3D { .scnprintf =3D SCA_FUTEX_OP, /* op */ },
>                    [5] =3D { .scnprintf =3D SCA_FUTEX_VAL3, /* val3 */ },=
 }, },
> @@ -1060,8 +1059,10 @@ static const struct syscall_fmt syscall_fmts[] =3D=
 {
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
>         { .name     =3D "nanosleep",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_TIMESPEC,  /* req */ },=
 }, },
> -       { .name     =3D "newfstatat",
> -         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
> +       { .name     =3D "newfstatat", .alias =3D "fstatat",
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,         /* dirfd =
*/ },
> +                  [1] =3D { .scnprintf =3D SCA_FILENAME,     /* pathname=
 */ },
> +                  [3] =3D { .scnprintf =3D SCA_FS_AT_FLAGS, /* flags */ =
}, }, },
>         { .name     =3D "open",
>           .arg =3D { [1] =3D { .scnprintf =3D SCA_OPEN_FLAGS, /* flags */=
 }, }, },
>         { .name     =3D "open_by_handle_at",
> --
> 2.44.0
>
