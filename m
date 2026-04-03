Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF944292B44
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231802; cv=pass; b=UukWjhNfaGAbUoiNE81DJdgGrFL0GPJyBDppYEcH65jJU7SbS4C5QBGHxJq1f1Ii/1etSem8l6Ma9ja5HUjSPiAPnan5PD19VzRIxg0Oj+IL28tklXNrM9xl8iIgPtsU15dopO0qNLR0af1P321Lu6NiWIyXB7h9rsrzfYmdHtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231802; c=relaxed/simple;
	bh=2GkUenXpaZJS+oOybHZPczQn6TaGbv/FHcdmbbsL8iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1GoweOZJQDEQhhhmwJJoJF66HPkwb/Xmt1vlgq7xxWLAcO7o4zftt5vGt9t30/APslOC9kcOAlROIVptIAq9oxyxRxg1TimFIA4QebRR9EZG8BJkGgMfgl2iFl/7zrxniLBRb9128OJ1kTHNxI/KxrV2c0JnyWQ0WEh/zJzdC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMqNOAoY; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMqNOAoY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0b260d309so63845ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 08:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775231800; cv=none;
        d=google.com; s=arc-20240605;
        b=Hfewg7P0Dvne8KLvHSrWdpiy5wqa/QGIjt2yygmC4dsmMllBP+nFlC8U09XtNzbI/3
         ahNoCazrE5yiSdT67rB8KIo0y/4DfLeIUBqBw0dEg2q2Y7Q+WlSIjXyNHCP3rzqQlahK
         AMCylzIC1lQ1d0gSRySk15fxMLdd2dGSN5Po2gVxXHjkxkdXyJuMw+ssDgVBIieev4Cp
         N5Z+jSKHnhToNmmU9KKtNmFDv0l+UztLZu0g/k99a4NaHbcgaNIFYq5wUJPrLgfTZSEK
         01NjLzO9eREyfS3DxikDorfHuVBbHV44cz7T0C4GLulZjQ279NeF5TvALQeg2CX3cU4j
         GsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=09ipRDVqsPJz9GfnSKeIwhOJq1wUwoe1hykzJ/BvAnI=;
        fh=U/l21W0lYe3PRkiq9UdjdiGEetNmj/w1gcZK5fhMXbI=;
        b=V+ufrJBYGn4VTMDlR0j/cNh/0G6s6FqNVhUOrmNBnimpYrZ0pJG1Afa2jwZnZGYW0+
         dVVZ81e1Q/Z2i7v5AO0zIsbEPhVWhS4KRu5OSr09f49E3r2uRNLf1rWea0Gwscg0Xvk2
         0pV1/DRa26g1PPoOaIyf/NqSxXsW+4F3ic6AFqmBZQUpQIQJS/J9BVxB0iuo69WkOXGh
         HtrqoEv9kWxmJc/ZQRFtWViHeYJj7dVnv1SzoCTecEMXtWY3DA6JcgjHdYXbHnTJVDaf
         O9IY9Tkw2H2KUrPRLRe7zEYBtLgLlh/UXyPab+2QPNkrXIL5DG1yDxnrSVGwIYq19kTG
         WLTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775231800; x=1775836600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09ipRDVqsPJz9GfnSKeIwhOJq1wUwoe1hykzJ/BvAnI=;
        b=OMqNOAoYcaL3l0PIcVofzxIKMS2Qz7Ow+XQ7C2fvXdA+ffgo6FgVHvV1CkKUx6RRF8
         CSUGOmfJ26OUKEcUYTCtYpt+Wzduma1uOiHn375j0IiC/nROGa5Hoz5vTMoRlgTKmdEb
         zuleIF51i3/LJH+I+MvSor/c3+m4ONZuE1fMkOyKyYCUugL3y7Bf/SJRq8he1nO8YUoC
         D6RYqoHKT3jYZrU6PgXhJ+JTI2crlJLBGmQU6Nfv6IzDOXmsHTCTAqh58/ptSNUX1lv6
         WVqbNOwLCYLYdm4doa2kQGrgs7N9Y2kGXL0aEDMWVTEYKKtZJjWggVzYHX5QMFJsekQu
         rO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775231800; x=1775836600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=09ipRDVqsPJz9GfnSKeIwhOJq1wUwoe1hykzJ/BvAnI=;
        b=EKaSVbAmE06XYZmBFKcYKW0kKr7tUAok5qzuSxEvFQtqUUr5r1SL7lJKDi6UTB67wx
         7JDivXN/v0ii3JXH8CqpPXZXkenNyXOG7SAb8ZtQFJJPuPDIvXQpPQccgBW9837HnVxz
         +RdJht4Yr6Fo9lCPcqJproSi6TBediHxF630/Jj7veflcA3SxPWoqZj0wfvk/D5ex4sj
         wqirDON0Dm1mG6xYCIr2p8vljA9X/cx0UhA1BuBtAQ7JZV3VmL94vcvTtglK7+a5gZAw
         qA6zFs3TxaBBRqbwAUEInPqk881bA9hpx8u8KMNDdiuaRfeqyWGXxSm447Xnd5MnRfvp
         dcVA==
X-Forwarded-Encrypted: i=1; AJvYcCU+PqrADJv+c366tAEshyfhzFO0RpO9VYPxRdkV2v2HqiRdjLHSU3cjPSNbbBSrpFMK6C/Ks7dgPAEtC7Mg1aWL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyudgf1w8zf3Ap3aoAXKlMWGLJmjoiyUXqJfR4fjnDWZE9fxY68
	+Qu6CBvaGVYdWhvRoFX2JSofCGKmxECRuUVEE0r9IWkxEpRs8cxXBd2DLC5efzwERkmUSdOJREv
	LkQ+nczsC2RRUBLahXQ9AaeuNSWx1XlJFEu+VvpFD
X-Gm-Gg: AeBDieuqbrK0yvbvdB28ySUhuWasoSumv5K5X4HmnCN51ar5enrvGf86ENkb/9mIHRI
	Yv6tLMqbGWR6hdhxo1Srj65URsGg7Kmc7tPvnI/VGVqEYOME6MaNrFjJtHAo1v8RdxanC174jEU
	0sPFzT9QVBNgPqR1/76DcbkhDckDeF09hciSaGA+exIkXTzu+j0nYRcVdhX0LIoFwCtrpSUj+XR
	Mw2wcLzXL9K63PD77fZ1NQjWgyBx3szQnASrzNHr4f1qL3BFJmrHM/qkGSslOXulWHxgEvTs+Wx
	5siMh81d
X-Received: by 2002:a17:902:cf10:b0:2b0:9a61:9d9 with SMTP id
 d9443c01a7336-2b283fbe02fmr1812415ad.9.1775231799482; Fri, 03 Apr 2026
 08:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
 <20260320192627.368357-3-irogers@google.com> <ac8vuNEJNsVa-Trk@google.com>
In-Reply-To: <ac8vuNEJNsVa-Trk@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Apr 2026 08:56:26 -0700
X-Gm-Features: AQROBzC5twTke0CowRpMv64mAYocCs9BRSUajjSf3IvutltYTaNgwd-0wgsCFQs
Message-ID: <CAP-5=fX95e5+ibSKq8mxhintVSYOSumsuzbEakE02N41ARxRcA@mail.gmail.com>
Subject: Re: [PATCH v4 02/25] perf sample: Make sure perf_sample__init/exit
 are used
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 8:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Mar 20, 2026 at 12:26:04PM -0700, Ian Rogers wrote:
> > The deferred stack trace code wasn't using perf_sample__init/exit. Add
> > the deferred stack trace clean up to perf_sample__exit which requires
> > proper NULL initialization in perf_sample__init. Make the
> > perf_sample__exit robust to being called more than once by using
> > zfree. Make the error paths in evsel__parse_sample exit the
> > sample. Add a merged_callchain boolean to capture that callchain is
> > allocated, deferred_callchain doen't suffice for this. Pack the struct
> > variables to avoid padding bytes for this.
> >
> > Similiarly powerpc_vpadtl_sample wasn't using perf_sample__init/exit,
> > use it for consistency and potential issues with uninitialized
> > variables.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-inject.c        |  6 +++++-
> >  tools/perf/tests/perf-record.c     |  1 +
> >  tools/perf/tests/switch-tracking.c |  2 ++
> >  tools/perf/util/callchain.c        | 10 ++++++---
> >  tools/perf/util/evlist.c           |  5 ++++-
> >  tools/perf/util/evsel.c            | 34 ++++++++++++++++++------------
> >  tools/perf/util/powerpc-vpadtl.c   | 10 +++++----
> >  tools/perf/util/sample.c           | 10 +++++++--
> >  tools/perf/util/sample.h           | 17 +++++++++------
> >  tools/perf/util/session.c          | 13 ++++++++----
> >  10 files changed, 74 insertions(+), 34 deletions(-)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 5b29f4296861..8b9a0a4097af 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -1087,6 +1087,7 @@ static int perf_inject__sched_stat(const struct p=
erf_tool *tool,
> >       struct perf_sample sample_sw;
> >       struct perf_inject *inject =3D container_of(tool, struct perf_inj=
ect, tool);
> >       u32 pid =3D evsel__intval(evsel, sample, "pid");
> > +     int ret;
> >
> >       list_for_each_entry(ent, &inject->samples, node) {
> >               if (pid =3D=3D ent->tid)
> > @@ -1103,7 +1104,9 @@ static int perf_inject__sched_stat(const struct p=
erf_tool *tool,
> >       perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_t=
ype,
> >                                     evsel->core.attr.read_format, &samp=
le_sw);
> >       build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine=
);
> > -     return perf_event__repipe(tool, event_sw, &sample_sw, machine);
> > +     ret =3D perf_event__repipe(tool, event_sw, &sample_sw, machine);
> > +     perf_sample__exit(&sample_sw);
> > +     return ret;
> >  }
> >  #endif
> >
> > @@ -1826,6 +1829,7 @@ static int guest_session__inject_events(struct gu=
est_session *gs, u64 timestamp)
> >                       return -EINVAL;
> >               }
> >
> > +             perf_sample__exit(sample);
> >               gs->fetched =3D false;
>
> I don't see matching perf_sample__init() in guest_session__fetch().  And
> as sashiko reported, there are paths missing perf_sample__exit().
>
> In general, I prefer not having perf_sample__init() in
> evsel__parse_sample() since it's already called from the callers and
> it'd be easier to match with corresponding __exit() there.

I think the guest session holding onto samples is error prone as the
samples will refer to events and the events will be overwritten in the
ring buffer, etc. having a global sample is just wrong. Fixing guest
session's usage of sample is out-of-scope here. Similarly with
initiliazing the sample before parsing, I want to fix the obvious bugs
in using perf_sample but not go into a large scale refactor in a patch
series that is already 25 patches long. I think long term
perf_sample__init should go away and the only way to get a perf_sample
should be from constructing one out of an event. I am working on a
series to do this as part of reorganizing samples to not always
contain virtual addresses. In this case there is no error as the
sample is initilalized by evlist__parse_sample. I can address the
Sashiko feedback regarding the missing sample exit on an error path.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> >               ret =3D output_bytes(inject, ev, ev->header.size);
> > diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-rec=
ord.c
> > index efbd9cd60c63..7b881f08906d 100644
> > --- a/tools/perf/tests/perf-record.c
> > +++ b/tools/perf/tests/perf-record.c
> > @@ -297,6 +297,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >                               }
> >
> >                               perf_mmap__consume(&md->core);
> > +                             perf_sample__exit(&sample);
> >                       }
> >                       perf_mmap__read_done(&md->core);
> >               }
> > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/swit=
ch-tracking.c
> > index 15791fcb76b2..72a8289e846d 100644
> > --- a/tools/perf/tests/switch-tracking.c
> > +++ b/tools/perf/tests/switch-tracking.c
> > @@ -239,11 +239,13 @@ static int add_event(struct evlist *evlist, struc=
t list_head *events,
> >
> >       if (!sample.time) {
> >               pr_debug("event with no time\n");
> > +             perf_sample__exit(&sample);
> >               return -1;
> >       }
> >
> >       node->event_time =3D sample.time;
> >
> > +     perf_sample__exit(&sample);
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 8ff0898799ee..19c97137103c 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -1854,16 +1854,19 @@ int sample__merge_deferred_callchain(struct per=
f_sample *sample_orig,
> >       u64 nr_deferred =3D sample_callchain->callchain->nr;
> >       struct ip_callchain *callchain;
> >
> > +     if (sample_orig->merged_callchain) {
> > +             /* Already merged. */
> > +             return -EINVAL;
> > +     }
> > +
> >       if (sample_orig->callchain->nr < 2) {
> >               sample_orig->deferred_callchain =3D false;
> >               return -EINVAL;
> >       }
> >
> >       callchain =3D calloc(1 + nr_orig + nr_deferred, sizeof(u64));
> > -     if (callchain =3D=3D NULL) {
> > -             sample_orig->deferred_callchain =3D false;
> > +     if (callchain =3D=3D NULL)
> >               return -ENOMEM;
> > -     }
> >
> >       callchain->nr =3D nr_orig + nr_deferred;
> >       /* copy original including PERF_CONTEXT_USER_DEFERRED (but the co=
okie) */
> > @@ -1872,6 +1875,7 @@ int sample__merge_deferred_callchain(struct perf_=
sample *sample_orig,
> >       memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips=
,
> >              nr_deferred * sizeof(u64));
> >
> > +     sample_orig->merged_callchain =3D true;
> >       sample_orig->callchain =3D callchain;
> >       return 0;
> >  }
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 591bdf0b3e2a..bdb196425071 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -1622,8 +1622,11 @@ int evlist__parse_sample(struct evlist *evlist, =
union perf_event *event, struct
> >       struct evsel *evsel =3D evlist__event2evsel(evlist, event);
> >       int ret;
> >
> > -     if (!evsel)
> > +     if (!evsel) {
> > +             /* Ensure the sample is okay for perf_sample__exit. */
> > +             perf_sample__init(sample, /*all=3D*/false);
> >               return -EFAULT;
> > +     }
> >       ret =3D evsel__parse_sample(evsel, event, sample);
> >       if (ret)
> >               return ret;
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index f59228c1a39e..59efe460d9bc 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3067,7 +3067,7 @@ static inline bool overflow(const void *endp, u16=
 max_size, const void *offset,
> >  #define OVERFLOW_CHECK(offset, size, max_size)                        =
       \
> >       do {                                                            \
> >               if (overflow(endp, (max_size), (offset), (size)))       \
> > -                     return -EFAULT;                                 \
> > +                     goto out_efault;                                \
> >       } while (0)
> >
> >  #define OVERFLOW_CHECK_u64(offset) \
> > @@ -3199,6 +3199,8 @@ static int __set_offcpu_sample(struct perf_sample=
 *data)
> >       data->cgroup =3D *array;
> >
> >       return 0;
> > +out_efault:
> > +     return -EFAULT;
> >  }
> >
> >  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > @@ -3217,7 +3219,7 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
> >        */
> >       union u64_swap u;
> >
> > -     memset(data, 0, sizeof(*data));
> > +     perf_sample__init(data, /*all=3D*/true);
> >       data->cpu =3D data->pid =3D data->tid =3D -1;
> >       data->stream_id =3D data->id =3D data->time =3D -1ULL;
> >       data->period =3D evsel->core.attr.sample_period;
> > @@ -3231,25 +3233,26 @@ int evsel__parse_sample(struct evsel *evsel, un=
ion perf_event *event,
> >
> >               data->callchain =3D (struct ip_callchain *)&event->callch=
ain_deferred.nr;
> >               if (data->callchain->nr > max_callchain_nr)
> > -                     return -EFAULT;
> > +                     goto out_efault;
> >
> >               data->deferred_cookie =3D event->callchain_deferred.cooki=
e;
> >
> >               if (evsel->core.attr.sample_id_all)
> >                       perf_evsel__parse_id_sample(evsel, event, data);
> > +
> >               return 0;
> >       }
> >
> >       if (event->header.type !=3D PERF_RECORD_SAMPLE) {
> > -             if (!evsel->core.attr.sample_id_all)
> > -                     return 0;
> > -             return perf_evsel__parse_id_sample(evsel, event, data);
> > +             if (evsel->core.attr.sample_id_all)
> > +                     perf_evsel__parse_id_sample(evsel, event, data);
> > +             return 0;
> >       }
> >
> >       array =3D event->sample.array;
> >
> >       if (perf_event__check_size(event, evsel->sample_size))
> > -             return -EFAULT;
> > +             goto out_efault;
> >
> >       if (type & PERF_SAMPLE_IDENTIFIER) {
> >               data->id =3D *array;
> > @@ -3342,7 +3345,7 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
> >                                       sizeof(struct sample_read_value);
> >
> >                       if (data->read.group.nr > max_group_nr)
> > -                             return -EFAULT;
> > +                             goto out_efault;
> >
> >                       sz =3D data->read.group.nr * sample_read_value_si=
ze(read_format);
> >                       OVERFLOW_CHECK(array, sz, max_size);
> > @@ -3370,7 +3373,7 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
> >               data->callchain =3D (struct ip_callchain *)array++;
> >               callchain_nr =3D data->callchain->nr;
> >               if (callchain_nr > max_callchain_nr)
> > -                     return -EFAULT;
> > +                     goto out_efault;
> >               sz =3D callchain_nr * sizeof(u64);
> >               /*
> >                * Save the cookie for the deferred user callchain.  The =
last 2
> > @@ -3428,7 +3431,7 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
> >               data->branch_stack =3D (struct branch_stack *)array++;
> >
> >               if (data->branch_stack->nr > max_branch_nr)
> > -                     return -EFAULT;
> > +                     goto out_efault;
> >
> >               sz =3D data->branch_stack->nr * sizeof(struct branch_entr=
y);
> >               if (evsel__has_branch_hw_idx(evsel)) {
> > @@ -3505,7 +3508,7 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
> >                       data->user_stack.size =3D *array++;
> >                       if (WARN_ONCE(data->user_stack.size > sz,
> >                                     "user stack dump failure\n"))
> > -                             return -EFAULT;
> > +                             goto out_efault;
> >               }
> >       }
> >
> > @@ -3582,10 +3585,15 @@ int evsel__parse_sample(struct evsel *evsel, un=
ion perf_event *event,
> >               array =3D (void *)array + sz;
> >       }
> >
> > -     if (evsel__is_offcpu_event(evsel))
> > -             return __set_offcpu_sample(data);
> > +     if (evsel__is_offcpu_event(evsel)) {
> > +             if (__set_offcpu_sample(data))
> > +                     goto out_efault;
> > +     }
> >
> >       return 0;
> > +out_efault:
> > +     perf_sample__exit(data);
> > +     return -EFAULT;
> >  }
> >
> >  int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_even=
t *event,
> > diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc=
-vpadtl.c
> > index d1c3396f182f..993ab16614c7 100644
> > --- a/tools/perf/util/powerpc-vpadtl.c
> > +++ b/tools/perf/util/powerpc-vpadtl.c
> > @@ -182,7 +182,9 @@ static int powerpc_vpadtl_sample(struct powerpc_vpa=
dtl_entry *record,
> >  {
> >       struct perf_sample sample;
> >       union perf_event event;
> > +     int ret;
> >
> > +     perf_sample__init(&sample, /*all=3D*/true);
> >       sample.ip =3D be64_to_cpu(record->srr0);
> >       sample.period =3D 1;
> >       sample.cpu =3D cpu;
> > @@ -198,12 +200,12 @@ static int powerpc_vpadtl_sample(struct powerpc_v=
padtl_entry *record,
> >       event.sample.header.misc =3D sample.cpumode;
> >       event.sample.header.size =3D sizeof(struct perf_event_header);
> >
> > -     if (perf_session__deliver_synth_event(vpa->session, &event, &samp=
le)) {
> > +     ret =3D perf_session__deliver_synth_event(vpa->session, &event, &=
sample);
> > +     if (ret)
> >               pr_debug("Failed to create sample for dtl entry\n");
> > -             return -1;
> > -     }
> >
> > -     return 0;
> > +     perf_sample__exit(&sample);
> > +     return ret;
> >  }
> >
> >  static int powerpc_vpadtl_get_buffer(struct powerpc_vpadtl_queue *vpaq=
)
> > diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
> > index 8f82aaf1aab6..2a30de4573f6 100644
> > --- a/tools/perf/util/sample.c
> > +++ b/tools/perf/util/sample.c
> > @@ -21,13 +21,19 @@ void perf_sample__init(struct perf_sample *sample, =
bool all)
> >       } else {
> >               sample->user_regs =3D NULL;
> >               sample->intr_regs =3D NULL;
> > +             sample->merged_callchain =3D false;
> > +             sample->callchain =3D NULL;
> >       }
> >  }
> >
> >  void perf_sample__exit(struct perf_sample *sample)
> >  {
> > -     free(sample->user_regs);
> > -     free(sample->intr_regs);
> > +     zfree(&sample->user_regs);
> > +     zfree(&sample->intr_regs);
> > +     if (sample->merged_callchain) {
> > +             zfree(&sample->callchain);
> > +             sample->merged_callchain =3D false;
> > +     }
> >  }
> >
> >  struct regs_dump *perf_sample__user_regs(struct perf_sample *sample)
> > diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> > index 8d4ace0e6594..5809c42631e5 100644
> > --- a/tools/perf/util/sample.h
> > +++ b/tools/perf/util/sample.h
> > @@ -155,12 +155,6 @@ struct perf_sample {
> >        *            intel-pt. The instruction itself is held in insn.
> >        */
> >       u16 insn_len;
> > -     /**
> > -      * @cpumode: The cpumode from struct perf_event_header misc varia=
ble
> > -      *           masked with CPUMODE_MASK. Gives user, kernel and hyp=
ervisor
> > -      *           information.
> > -      */
> > -     u8  cpumode;
> >       /** @misc: The entire struct perf_event_header misc variable. */
> >       u16 misc;
> >       /**
> > @@ -174,6 +168,12 @@ struct perf_sample {
> >        *           powerpc holds p_stage_cyc.
> >        */
> >       u16 weight3;
> > +     /**
> > +      * @cpumode: The cpumode from struct perf_event_header misc varia=
ble
> > +      *           masked with CPUMODE_MASK. Gives user, kernel and hyp=
ervisor
> > +      *           information.
> > +      */
> > +     u8  cpumode;
> >       /**
> >        * @no_hw_idx: For PERF_SAMPLE_BRANCH_STACK, true when
> >        *             PERF_SAMPLE_BRANCH_HW_INDEX isn't set.
> > @@ -184,6 +184,11 @@ struct perf_sample {
> >        *                      user callchain marker was encountered.
> >        */
> >       bool deferred_callchain;
> > +     /**
> > +      * @merged_callchain: A synthesized merged callchain that is allo=
cated
> > +      *                    and needs freeing.
> > +      */
> > +     bool merged_callchain;
> >       /**
> >        * @deferred_cookie: Identifier of the deferred callchain in the =
later
> >        *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 4b465abfa36c..c48e840da7d4 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1367,14 +1367,18 @@ static int evlist__deliver_deferred_callchain(s=
truct evlist *evlist,
> >       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> >               struct perf_sample orig_sample;
> >
> > +             perf_sample__init(&orig_sample, /*all=3D*/false);
> >               ret =3D evlist__parse_sample(evlist, de->event, &orig_sam=
ple);
> >               if (ret < 0) {
> >                       pr_err("failed to parse original sample\n");
> > +                     perf_sample__exit(&orig_sample);
> >                       break;
> >               }
> >
> > -             if (sample->tid !=3D orig_sample.tid)
> > +             if (sample->tid !=3D orig_sample.tid) {
> > +                     perf_sample__exit(&orig_sample);
> >                       continue;
> > +             }
> >
> >               if (event->callchain_deferred.cookie =3D=3D orig_sample.d=
eferred_cookie)
> >                       sample__merge_deferred_callchain(&orig_sample, sa=
mple);
> > @@ -1385,9 +1389,7 @@ static int evlist__deliver_deferred_callchain(str=
uct evlist *evlist,
> >               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> >                                            &orig_sample, evsel, machine=
);
> >
> > -             if (orig_sample.deferred_callchain)
> > -                     free(orig_sample.callchain);
> > -
> > +             perf_sample__exit(&orig_sample);
> >               list_del(&de->list);
> >               free(de->event);
> >               free(de);
> > @@ -1414,9 +1416,11 @@ static int session__flush_deferred_samples(struc=
t perf_session *session,
> >       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> >               struct perf_sample sample;
> >
> > +             perf_sample__init(&sample, /*all=3D*/false);
> >               ret =3D evlist__parse_sample(evlist, de->event, &sample);
> >               if (ret < 0) {
> >                       pr_err("failed to parse original sample\n");
> > +                     perf_sample__exit(&sample);
> >                       break;
> >               }
> >
> > @@ -1424,6 +1428,7 @@ static int session__flush_deferred_samples(struct=
 perf_session *session,
> >               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> >                                            &sample, evsel, machine);
> >
> > +             perf_sample__exit(&sample);
> >               list_del(&de->list);
> >               free(de->event);
> >               free(de);
> > --
> > 2.53.0.959.g497ff81fa9-goog
> >
