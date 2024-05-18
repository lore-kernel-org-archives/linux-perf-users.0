Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AE4A2D
	for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716003020; cv=none; b=E6DCMGpzQGPmFI1mKwAHNYdG+JWFX+Cc+2lccJKnu0yn125tZI9aH8HrMCG/Sa1ygGt5M0fICVxgLEocELhWG9A8G087w0mC7mDvfgyyJvJplV07ZgpgisAHzt9J6YoXVWRUJt4TYgz65nvSIo1gcBxxsKGkSZF0xRd0+LwH9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716003020; c=relaxed/simple;
	bh=i2aLlf3CCtikkEtAK0ntXxBrsOx2ayXvknDbt5qFetw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZbKOGTcYOACDERXyDjViUMZXf10mbREPoLrf/FNjDTd/mPnGNshA2F5Or9O+TbVbEljyBkERqjyJGAkQSt5BkCfXS7MZsDSLw26/0ACx4TqGIvcBNGBehRSxwixjEiCLkD/Wvft1qqvTwVlI64oUChM3WTrMBdYTZpY5wijTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnfKwSv3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnfKwSv3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eed90a926fso28655ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 20:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716003018; x=1716607818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nWYYKjaR/jDGFeRF8uaCxl0MPSOP0KopiQrG5iiGtI=;
        b=MnfKwSv3agOSvJqwuxCwLKPkUOuTka2RxjV5dJZAzjDKNni2b2U4X2WkAay/0Hwg9c
         aMbBHeTDY9dYj8JePiYNYiZkv7gn2OO1uCA29eT9cIvo+VCRiJrfMg9WRMBrz/iIt+lB
         AMgXpzrbZIysQMZqEl+gS6u3xYRNx+1y1Z3IEwN7J+ufQvHUGz7ucI6NFkIG/M4DeYDN
         NHnuRTgRZr4jNoInD3rWI/AeHUo85AW1/h+g66Ie33D9O7QxvMkQZAtlhKdMpG17j5Ao
         z4zFCDPzRToVpFLj2r9asZmxIUwy9p+hyor8HGakspvY74oTB6UZnWU8gwEJItD6fTcl
         hbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716003018; x=1716607818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nWYYKjaR/jDGFeRF8uaCxl0MPSOP0KopiQrG5iiGtI=;
        b=OO9VH+5YCGqMi69xcfKcXHYj4szf4Jg+haKnqpClcZSzzXCRgwR2Or7VZKVTI/sJtI
         nmBq4mgtpLkKU+21O3M0NUwNxRZPgzVWxH/8JLu9V7ukMUD+maKDLO4VDcWazvromJh2
         09JeQyj6qvQmYUkB37L4Q78DKaFb+eWiSzvSoeAgRMYYCUFDWpUGyyDjhBlmLW/bXGSn
         ySKPc3Bkxe/XpGysnMU2zaErJNEpw5P/SAdhH91QIzyBSVRE7ifZPpUAc9wu6LkqEY7G
         5gYu5ngqss3c+8SCvLFuRUtPmqHzkKmLHbHsWj7mg+IRjKktEoh0ysVb1nMcXXtntN2l
         5dbA==
X-Forwarded-Encrypted: i=1; AJvYcCV+tAMzu8xC87z5IRJticVYxGlbAhVkmax2JDoIUzTHzzxeJXRU+sFEx7qxln5oAY8GzzPWynDrnPIvZrPpV+zdwvQ0KMOZ4D1FeMJe1UJ3JA==
X-Gm-Message-State: AOJu0YzQp0HSkyyfbocfiFTki9CxzSuesguAb58yL+E6Zu5X237EFqOc
	fN5OraBoqcoAZ4aN746ucAczdYSn8mcaA7YP3dtFNyL7fjR1MhSWEyUfrU383ZHdlERwjUOALaN
	nnNLMsfMq456SmOpoK6Uk3uGQ6W6urOzrWN/b
X-Google-Smtp-Source: AGHT+IFbyZwc0QMJvH/mRE3Qe4iX1MKPVAPecQCzhgLJIWXVM52u3qQbDZRuGEmLd6AR4KRYL8Rm3IcTwTGe7DwBkg4=
X-Received: by 2002:a17:902:6549:b0:1e5:62:7a89 with SMTP id
 d9443c01a7336-1f2ecbc4160mr1086035ad.18.1716003018134; Fri, 17 May 2024
 20:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com> <20240516041948.3546553-2-irogers@google.com>
 <CAM9d7ch51JK8Xu+kOYUdxgM10_gS2=vjfW5sqFwrRS2eC8cYXA@mail.gmail.com>
In-Reply-To: <CAM9d7ch51JK8Xu+kOYUdxgM10_gS2=vjfW5sqFwrRS2eC8cYXA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 May 2024 20:29:59 -0700
Message-ID: <CAP-5=fXNQ0=8mKKkBrmA9JpNLZEoQxb=AEYjBT-_brFt3Qom-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf bpf filter: Give terms their own enum
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 6:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Give the term types their own enum so that additional terms can be
> > added that don't correspond to a PERF_SAMPLE_xx flag. The term values
> > are numerically ascending rather than bit field positions, this means
> > they need translating to a PERF_SAMPLE_xx bit field in certain places
> > and they are more densely encoded.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util=
/bpf_skel/sample-filter.h
> > index 2e96e1ab084a..161d5ff49cb6 100644
> > --- a/tools/perf/util/bpf_skel/sample-filter.h
> > +++ b/tools/perf/util/bpf_skel/sample-filter.h
> > @@ -16,12 +16,32 @@ enum perf_bpf_filter_op {
> >         PBF_OP_GROUP_END,
> >  };
> >
> > +enum perf_bpf_filter_term {
> > +       /* No term is in use. */
> > +       PBF_TERM_NONE,
> > +       /* Terms that correspond to PERF_SAMPLE_xx values. */
> > +       PBF_TERM_IP,
> > +       PBF_TERM_ID,
> > +       PBF_TERM_TID,
> > +       PBF_TERM_CPU,
> > +       PBF_TERM_TIME,
> > +       PBF_TERM_ADDR,
> > +       PBF_TERM_PERIOD,
> > +       PBF_TERM_TRANSACTION,
> > +       PBF_TERM_WEIGHT,
> > +       PBF_TERM_PHYS_ADDR,
> > +       PBF_TERM_CODE_PAGE_SIZE,
> > +       PBF_TERM_DATA_PAGE_SIZE,
> > +       PBF_TERM_WEIGHT_STRUCT,
> > +       PBF_TERM_DATA_SRC,
> > +};
> > +
> >  /* BPF map entry for filtering */
> >  struct perf_bpf_filter_entry {
> >         enum perf_bpf_filter_op op;
> >         __u32 part; /* sub-sample type info when it has multiple values=
 */
> > -       __u64 flags; /* perf sample type flags */
> > +       enum perf_bpf_filter_term term;
> >         __u64 value;
> >  };
> >
> > -#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> > \ No newline at end of file
> > +#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/=
util/bpf_skel/sample_filter.bpf.c
> > index fb94f5280626..8666c85e9333 100644
> > --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > @@ -48,31 +48,50 @@ static inline __u64 perf_get_sample(struct bpf_perf=
_event_data_kern *kctx,
> >  {
> >         struct perf_sample_data___new *data =3D (void *)kctx->data;
> >
> > -       if (!bpf_core_field_exists(data->sample_flags) ||
> > -           (data->sample_flags & entry->flags) =3D=3D 0)
> > +       if (!bpf_core_field_exists(data->sample_flags))
> >                 return 0;
> >
> > -       switch (entry->flags) {
> > -       case PERF_SAMPLE_IP:
> > +       switch (entry->term) {
> > +       case PBF_TERM_NONE:
> > +               return 0;
> > +       case PBF_TERM_IP:
> > +               if ((data->sample_flags & PERF_SAMPLE_IP) =3D=3D 0)
> > +                       return 0;
>
> Can we check this in a single place like in the original code
> instead of doing it in every case?  I think we can keep the
> entry->flags and check it only if it's non zero.  Then uid and
> gid will have 0 to skip.

I found the old way confusing. As the flags are a bitmap it looks like
more than one can be set, if that were the case then the switch
statement would be broken as the case wouldn't exist. Using an enum
like this allows warnings to occur when a term is missing in the
switch statement - which is good when you are adding new terms. I
think it more obviously matches the man page. We could arrange for the
enum values to encode the shift position of the flag. Something like:

if ((entry->term > PBF_TERM_NONE && entry->term <=3D PBF_TERM_DATA_SRC) &&
    (data->sample_flags & (1 << entry->term)) =3D=3D 0)
   return 0;

But the problem there is that not every sample type has an enum value,
and I'm not sure it makes sense for things like STREAM_ID. We could do
some macro magic to reduce the verbosity like:

#define SAMPLE_CASE(x) \
    case PBF_TERM_##x: \
        if ((data->sample_flags & PERF_SAMPLE_x) =3D=3D 0) \
            return 0

But I thought that made the code harder to read given the relatively
small number of sample cases.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >                 return kctx->data->ip;
> > -       case PERF_SAMPLE_ID:
> > +       case PBF_TERM_ID:
> > +               if ((data->sample_flags & PERF_SAMPLE_ID) =3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->id;
> > -       case PERF_SAMPLE_TID:
> > +       case PBF_TERM_TID:
> > +               if ((data->sample_flags & PERF_SAMPLE_TID) =3D=3D 0)
> > +                       return 0;
> >                 if (entry->part)
> >                         return kctx->data->tid_entry.pid;
> >                 else
> >                         return kctx->data->tid_entry.tid;
> > -       case PERF_SAMPLE_CPU:
> > +       case PBF_TERM_CPU:
> > +               if ((data->sample_flags & PERF_SAMPLE_CPU) =3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->cpu_entry.cpu;
> > -       case PERF_SAMPLE_TIME:
> > +       case PBF_TERM_TIME:
> > +               if ((data->sample_flags & PERF_SAMPLE_TIME) =3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->time;
> > -       case PERF_SAMPLE_ADDR:
> > +       case PBF_TERM_ADDR:
> > +               if ((data->sample_flags & PERF_SAMPLE_ADDR) =3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->addr;
> > -       case PERF_SAMPLE_PERIOD:
> > +       case PBF_TERM_PERIOD:
> > +               if ((data->sample_flags & PERF_SAMPLE_PERIOD) =3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->period;
> > -       case PERF_SAMPLE_TRANSACTION:
> > +       case PBF_TERM_TRANSACTION:
> > +               if ((data->sample_flags & PERF_SAMPLE_TRANSACTION) =3D=
=3D 0)
> > +                       return 0;
> >                 return kctx->data->txn;
> > -       case PERF_SAMPLE_WEIGHT_STRUCT:
> > +       case PBF_TERM_WEIGHT_STRUCT:
> > +               if ((data->sample_flags & PERF_SAMPLE_WEIGHT_STRUCT) =
=3D=3D 0)
> > +                       return 0;
> >                 if (entry->part =3D=3D 1)
> >                         return kctx->data->weight.var1_dw;
> >                 if (entry->part =3D=3D 2)
> > @@ -80,15 +99,25 @@ static inline __u64 perf_get_sample(struct bpf_perf=
_event_data_kern *kctx,
> >                 if (entry->part =3D=3D 3)
> >                         return kctx->data->weight.var3_w;
> >                 /* fall through */
> > -       case PERF_SAMPLE_WEIGHT:
> > +       case PBF_TERM_WEIGHT:
> > +               if ((data->sample_flags & PERF_SAMPLE_WEIGHT) =3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->weight.full;
> > -       case PERF_SAMPLE_PHYS_ADDR:
> > +       case PBF_TERM_PHYS_ADDR:
> > +               if ((data->sample_flags & PERF_SAMPLE_PHYS_ADDR) =3D=3D=
 0)
> > +                       return 0;
> >                 return kctx->data->phys_addr;
> > -       case PERF_SAMPLE_CODE_PAGE_SIZE:
> > +       case PBF_TERM_CODE_PAGE_SIZE:
> > +               if ((data->sample_flags & PERF_SAMPLE_CODE_PAGE_SIZE) =
=3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->code_page_size;
> > -       case PERF_SAMPLE_DATA_PAGE_SIZE:
> > +       case PBF_TERM_DATA_PAGE_SIZE:
> > +               if ((data->sample_flags & PERF_SAMPLE_DATA_PAGE_SIZE) =
=3D=3D 0)
> > +                       return 0;
> >                 return kctx->data->data_page_size;
> > -       case PERF_SAMPLE_DATA_SRC:
> > +       case PBF_TERM_DATA_SRC:
> > +               if ((data->sample_flags & PERF_SAMPLE_DATA_SRC) =3D=3D =
0)
> > +                       return 0;
> >                 if (entry->part =3D=3D 1)
> >                         return kctx->data->data_src.mem_op;
> >                 if (entry->part =3D=3D 2)
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
