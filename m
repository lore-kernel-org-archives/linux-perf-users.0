Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B114E2CB;
	Tue,  4 Jun 2024 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539461; cv=none; b=gXGPZpSNsqURc2/3p0laQ9clZL9XsfT6+HHN/pE5p6ITF2dg27sCeG1+o8ngLaujM58Yb7piPfxcLu6a0Se3fOeGuzHZT3Pdj91FF4mzqzkO9L7fHL2aJ+XYLC4u0f3Pr0wo6WW1TdjtIL0POqldUuemsC0XqNo95qS0ChS2aFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539461; c=relaxed/simple;
	bh=x/EPc1071ZMLypXuG2I4l+JIj9vQRudO7rwHkhsyVb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuwjBJVeImCEtoB83YRNZuulONVX3aNJzJ1Ll65qCS3PVvNcL/yF5PebkQGJLKT4pm0aK1iMRCDoMw0qp9f7MmAGqF1w9VIdhZks9dyCDUwXca+Wkaw5FQYjz9A7eZvoVgK+dp1tQXij3XCecG2kM8mGpuB2hijweog0rqx5VVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-702621d8725so3464649b3a.0;
        Tue, 04 Jun 2024 15:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717539459; x=1718144259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=We0+yqK0dafq6iaaR0xGOotuOP5a9th3+PZjS7QbEAc=;
        b=WjSTz4gczr/25AOfN2WpfZ+AA2zpv+ek3kT/JRng6gQpj+eTwMwBg7ieQI28Ic8xpg
         +ZMGgYoDWuzcsxNJYsMYQlKBmUDkR4Blq1LuxWIwQo75BPekM1NtA88sQ2o41IQrKQi0
         JVxkyW40v2fs1ZW48uwpQhtiVTc4VJwFHd8sYrM3KSL5jZZJTNKTPSa3xiN/dkqm2Skq
         R3A4ewxF7aJPDX8DI5v6On0q6IJwPpIgFErFTzevtEsR6GR0pfVfnTJrEI1CT/4IS3vo
         qq1PosapAIpMAzLSBTDY7vGBXZqrASIkiGPY+W4cODuCc5dtYNQ3gcpIUsB0afl1F5D2
         Pp7A==
X-Forwarded-Encrypted: i=1; AJvYcCXZHXZiKGCyHtOnzBYELgTHtWHhrW45r7nqKi4QUxuKWNl6ZVYEXD4QpRDPNpVGmMnxFt71K/Vk9ZyjCSO6JSBdfkGkjdCZrLe4M3BUt1CAQg==
X-Gm-Message-State: AOJu0Yyn2L+VOzaXeWROR8+JRHXAaoZjyqT3OSYefQFes1pgdL+nGS3r
	iUgwawmkdIfKt2vJUGGGtKScsbaReegwrzjAgvggfS+lpkuaIPR++FtXQQ81Gvu26I4WbgOnr0a
	GFJXWqMVR6TNbcQwbfxqvywcUFyo=
X-Google-Smtp-Source: AGHT+IGnw53Jh6+2Bw7hebEUz6+jcHb6FcdmD4FMpElK7QDx9CMNLda3raDdi2dACalBJJBA6vymSLyiubJLwPFuzBs=
X-Received: by 2002:a05:6a20:9693:b0:1b2:b5af:ce67 with SMTP id
 adf61e73a8af0-1b2b71c20edmr869900637.59.1717539458861; Tue, 04 Jun 2024
 15:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513091413.738537-1-nick.forrington@arm.com>
 <20240513091413.738537-2-nick.forrington@arm.com> <cf08f5ee-ccd5-4c37-90a6-c88fb3ab2a49@arm.com>
In-Reply-To: <cf08f5ee-ccd5-4c37-90a6-c88fb3ab2a49@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 4 Jun 2024 15:17:27 -0700
Message-ID: <CAM9d7cirU1K34=DOYSW4wfGRqXraV9WnQw3cf9pxnpf+tXYJhA@mail.gmail.com>
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

On Mon, Jun 3, 2024 at 2:38=E2=80=AFAM Nick Forrington <nick.forrington@arm=
.com> wrote:
>
> Is this ok to be applied now?

Sorry for the delay.  Yep, it's now applied to perf-tools-next.

Thanks,
Namhyung

>
> On 13/05/2024 10:14, Nick Forrington wrote:
> > Change "perf lock info" argument handling to:
> >
> > Display both map and thread info (rather than an error) when neither ar=
e
> > specified.
> >
> > Display both map and thread info (rather than just thread info) when
> > both are requested.
> >
> > Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> > ---
> >   tools/perf/Documentation/perf-lock.txt |  4 ++--
> >   tools/perf/builtin-lock.c              | 27 ++++++++++++++-----------=
-
> >   2 files changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Docume=
ntation/perf-lock.txt
> > index f5938d616d75..57a940399de0 100644
> > --- a/tools/perf/Documentation/perf-lock.txt
> > +++ b/tools/perf/Documentation/perf-lock.txt
> > @@ -111,11 +111,11 @@ INFO OPTIONS
> >
> >   -t::
> >   --threads::
> > -     dump thread list in perf.data
> > +     dump only the thread list in perf.data
> >
> >   -m::
> >   --map::
> > -     dump map of lock instances (address:name table)
> > +     dump only the map of lock instances (address:name table)
> >
> >
> >   CONTENTION OPTIONS
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 230461280e45..7eb115aeb927 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -1477,20 +1477,16 @@ static void dump_map(void)
> >               fprintf(lock_output, " %#llx: %s\n", (unsigned long long)=
st->addr, st->name);
> >   }
> >
> > -static int dump_info(void)
> > +static void dump_info(void)
> >   {
> > -     int rc =3D 0;
> > -
> >       if (info_threads)
> >               dump_threads();
> > -     else if (info_map)
> > +
> > +     if (info_map) {
> > +             if (info_threads)
> > +                     fputc('\n', lock_output);
> >               dump_map();
> > -     else {
> > -             rc =3D -1;
> > -             pr_err("Unknown type of information\n");
> >       }
> > -
> > -     return rc;
> >   }
> >
> >   static const struct evsel_str_handler lock_tracepoints[] =3D {
> > @@ -1992,7 +1988,7 @@ static int __cmd_report(bool display_info)
> >
> >       setup_pager();
> >       if (display_info) /* used for info subcommand */
> > -             err =3D dump_info();
> > +             dump_info();
> >       else {
> >               combine_result();
> >               sort_result();
> > @@ -2578,9 +2574,9 @@ int cmd_lock(int argc, const char **argv)
> >
> >       const struct option info_options[] =3D {
> >       OPT_BOOLEAN('t', "threads", &info_threads,
> > -                 "dump thread list in perf.data"),
> > +                 "dump the thread list in perf.data"),
> >       OPT_BOOLEAN('m', "map", &info_map,
> > -                 "map of lock instances (address:name table)"),
> > +                 "dump the map of lock instances (address:name table)"=
),
> >       OPT_PARENT(lock_options)
> >       };
> >
> > @@ -2694,6 +2690,13 @@ int cmd_lock(int argc, const char **argv)
> >                       if (argc)
> >                               usage_with_options(info_usage, info_optio=
ns);
> >               }
> > +
> > +             /* If neither threads nor map requested, display both */
> > +             if (!info_threads && !info_map) {
> > +                     info_threads =3D true;
> > +                     info_map =3D true;
> > +             }
> > +
> >               /* recycling report_lock_ops */
> >               trace_handler =3D &report_lock_ops;
> >               rc =3D __cmd_report(true);
