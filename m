Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007FD266
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ME+9t+ht"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453FF3
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 13:02:22 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-671357f0209so14288436d6.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698696142; x=1699300942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfU1Vfre9ZPJUwx/epHI06bmjrSaEYsIgo8tdkDUzfc=;
        b=ME+9t+htyQBWKQJdo32UkF+s3byQWFRMJXPb9sWf6SqDEbfhk8DI3Vbn6yRTtnKrBm
         bJCLLXqPS1/4yC6bivHhAUWDYNLyuvdliaq2TKTortlM1m0fjUBz4bN9Y8RnLCMOAwtq
         8OJ+6Rm4wAtr8rEYyVxrdk8UrdLVhFV2osHLZr39PXj6HrB9WARpkBJ4VsfThFNsDtDj
         5lP4475YJx/EhmOoO7FxylWkf+OH1MgS7Mw3dnImEyrthzCxvkWF7awxrrLViLzGayQu
         W2yOMjm59+3coJMD93BgpDnlI5PzpjFYoN9BFDbHNJNVOELZ9F4zTNiME1vnAVZ6PhlO
         rmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696142; x=1699300942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfU1Vfre9ZPJUwx/epHI06bmjrSaEYsIgo8tdkDUzfc=;
        b=U8/GcS3PEBPDNhjJu0RyeoPI4GfDQ3NbZU3SJLBsuCmF/glfkHjCQRjKARJ71rfqbi
         cyB2+akWIdHnuTfsUW1fS/jVLW1ZZeogL/EgYJjgKmXWOlqT0Ydfb0I+s//H9ERCxGVy
         xGxQ77N0NbyShPjQrduqKEKpin/DCJh3Y4PQXLoFUioD5k14Ev+R1O6x8p1eQTLOFMn2
         4lWxkbU361/99nUCum5RIlZQFleLZL3GOOVnY+rK0PuvcfZZ14nq0bjis90av4QMVOLp
         G2YNmm1uQR54B6lO33azSdn9UHOa9HJ6fMjjYdEorhRJXDXfiTWdAeBFZ/lmpe47gwct
         VTkg==
X-Gm-Message-State: AOJu0YxB+lHtvMx05A8D4XPU/yMSCBSIlv+qvne7pasPM3vpX6EH1pzX
	0hmHqf5dL0ie8uxCpt2T5Me9Ra7fsgMLry8tAUlPxw==
X-Google-Smtp-Source: AGHT+IEpqgeWYuK4AEA+W9HhAJXA/nN3xDb3dPmYj/gB7sD7cdA2fS9iCZIx/ybdKPGcmfhMI9nozE03NMueRkWzTGI=
X-Received: by 2002:a05:6214:d09:b0:672:3f54:b94f with SMTP id
 9-20020a0562140d0900b006723f54b94fmr4383869qvh.7.1698696141585; Mon, 30 Oct
 2023 13:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WLq+wMGC26ESviAwSFGCpCYbf8knRFo=6Lbwgk8qwB8xA@mail.gmail.com>
In-Reply-To: <CAL715WLq+wMGC26ESviAwSFGCpCYbf8knRFo=6Lbwgk8qwB8xA@mail.gmail.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Mon, 30 Oct 2023 13:01:45 -0700
Message-ID: <CAL715W+gnsi8NiRfwBHAGLhGo5hpS1c=+v8EGbz8iX_ygUxm1w@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yang Jihong <yangjihong1@huawei.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:04=E2=80=AFPM Mingwei Zhang <mizhang@google.com>=
 wrote:
>
> On Fri, Sep 15, 2023 at 9:10=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Dummy events are created with an attribute where the period and freq
> > are zero. evsel__config will then see the uninitialized values and
> > initialize them in evsel__default_freq_period. As fequency mode is
> > used by default the dummy event would be set to use frequency
> > mode. However, this has no effect on the dummy event but does cause
> > unnecessary timers/interrupts. Avoid this overhead by setting the
> > period to 1 for dummy events.
> >
> > evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 and
> > period=3D1. This isn't necessary after this change and so the setting i=
s
> > removed.
> >
> > From Stephane:
> >
> > The dummy event is not counting anything. It is used to collect mmap
> > records and avoid a race condition during the synthesize mmap phase of
> > perf record. As such, it should not cause any overhead during active
> > profiling. Yet, it did. Because of a bug the dummy event was
> > programmed as a sampling event in frequency mode. Events in that mode
> > incur more kernel overheads because on timer tick, the kernel has to
> > look at the number of samples for each event and potentially adjust
> > the sampling period to achieve the desired frequency. The dummy event
> > was therefore adding a frequency event to task and ctx contexts we may
> > otherwise not have any, e.g., perf record -a -e
> > cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> > perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> > non-zero, then the kernel will loop over ALL the events of the context
> > looking for frequency mode ones. In doing, so it locks the context,
> > and enable/disable the PMU of each hw event. If all the events of the
> > context are in period mode, the kernel will have to traverse the list f=
or
> > nothing incurring overhead. The overhead is multiplied by a very large
> > factor when this happens in a guest kernel. There is no need for the
> > dummy event to be in frequency mode, it does not count anything and
> > therefore should not cause extra overhead for no reason.
> >
> > Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy con=
structor")
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evlist.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 25c3ebe2c2f5..e36da58522ef 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evl=
ist *evlist)
> >                 .type   =3D PERF_TYPE_SOFTWARE,
> >                 .config =3D PERF_COUNT_SW_DUMMY,
> >                 .size   =3D sizeof(attr), /* to capture ABI version */
> > +               /* Avoid frequency mode for dummy events to avoid assoc=
iated timers. */
> > +               .freq =3D 0,
> > +               .sample_period =3D 1,
> >         };
> >
> >         return evsel__new_idx(&attr, evlist->core.nr_entries);
> > @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *=
evlist, bool system_wide)
> >         evsel->core.attr.exclude_kernel =3D 1;
> >         evsel->core.attr.exclude_guest =3D 1;
> >         evsel->core.attr.exclude_hv =3D 1;
> > -       evsel->core.attr.freq =3D 0;
> > -       evsel->core.attr.sample_period =3D 1;
> >         evsel->core.system_wide =3D system_wide;
> >         evsel->no_aux_samples =3D true;
> >         evsel->name =3D strdup("dummy:u");
> > --
> > 2.42.0.459.ge4e396fd5e-goog
> >
>
> Hi Greg,
>
> This patch is a critical performance fix for perf and vPMU. Can you
> help us dispatch the commit to all stable kernel versions?
>
> Appreciate your help. Thanks.
> -Mingwei

Oops... Update target email to: stable@vger.kernel.org
