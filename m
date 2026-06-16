Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45647AF67
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629402; cv=pass; b=f91ZNfcUdKFxHClkYcVgdaWKsKYA1B+JW3RFOUgsuPUviT+d4T6lwv7IALF5EQBmy4XHF7WbCgW+gim2J9qoOjuwR8ERuLpvTgYX8xsf19+JIiCr2Dhy0zYx//deQ0mgzhFVI3wUOCpUrlG76McO2Gc5p1zR20a3oVJIvg20Id8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629402; c=relaxed/simple;
	bh=UKHtzCX9zrsrbBj3viJPtVo0ZvDB5f7CP+lqyu1VAEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuR1bVYcJm4HZtsjXvAfpeA1QcfIPwDn6QHgP11Iquwx0VvZkT/liQ263fixu5P19RKazyEjNXevz1wh2QjfGcoBGj4LakP+uQl1oTNqzFOdx5t/QdrZ75nkZPsjkd0lJcrVe6bVYQ7UeMpK4Zm8u3rGN4TLrpYIvnD5dZgC8ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1fgSdMw; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1fgSdMw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2d865383so2115ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 10:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781629400; cv=none;
        d=google.com; s=arc-20240605;
        b=bPB5nC2fqXO2K9P7xH/Kx063IPTel4VoBL0wJUDMHcTRZpqAEVZq8fq9Z+Cd2JqJto
         GlmYXbtJNP3lRJymm/L4BG8IBXMjtIlfQAL2PA3ndQCIN5MGTTHji8D16E/rLQPpKJeV
         oe/ZH4JSAlpt0tbfvQ1ncXFiFARRPQBXrkNyDzMldRN0a280MaBQDtYI1p8wQhbgUtM/
         6h23Ew/kq3aW1CsNd/YEdpRcvcY9dndUMXj+JBrJd+7Ny5khBxsqpC/BU7dkWqu6g13Z
         eu1EKunYLlGOzlNUHGKzzZIVWRrv8UGd29Js1DoF+hxfiLw2O1kQ3w6Qd/uYScrbw74F
         M0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z9Vx4QTw3Fz4ksQLoNqFI9G//LGznFBcPtouXygFC5g=;
        fh=Nha5MUkuOzXsPL9n8D3fNy97xKt9AEfFKRDy5CPfbgk=;
        b=JSjzncIhVmYsStoKwaqudVx74J8MHxCTqKM3agSHHa7gIsLSujANPJlKQceuLd5JQR
         mp13NdZdM0epvCw49MeTQGmUNMLmI8STzKq0coWl8Pma3iC/c4f1Fq2SnWyolxijwU7P
         cBmb9+D+qHYKKxdifT/qxLi8ivex9VqpCFffgtosc8tgC6RvGG2EYk0lQ9qbMMVeqQkM
         +U3uYdL0vfRmnAR83AjGzrph+3IaUk3RGvXLgqw/i0IX487n8YCSyFgJ7EjsDOkdM/tJ
         vWy/MA/UZ3mQsBoZt2ZLXved8WI+UKxaXdEAeLwXPEHaXSLB727LPvjRgHIR4TjO7HhJ
         k45A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781629400; x=1782234200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9Vx4QTw3Fz4ksQLoNqFI9G//LGznFBcPtouXygFC5g=;
        b=i1fgSdMweHm1XZyoRNgdpEAcvrNFS8uJ602vYoDEVtGPxq48x0FS9KIknZXLy3eA60
         sOpUiA6BXCZ6YOutKoj03x05FDh5x/IWdywjps6ssaEJQ+m4uzt24g6PRKyRa3vyHjK5
         CxcnFZEu0DL/arflfyv+0WrqtdFkzxekCWKGtC3+iaZCRWiMK0VTexgn9/8m2SaG3m4A
         np+PMmPswHdP09ZfKBC1X739G5l6+T5lvWkGOyIk/o3cIR9CuK8mex/3CvTV4fag9HDH
         DID7oguaZfw7ddrJ7flnPveT4CyHMqWdDBtmN/4TaQXGeD1aaaIuwICu3klc42g9eCwo
         BXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629400; x=1782234200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9Vx4QTw3Fz4ksQLoNqFI9G//LGznFBcPtouXygFC5g=;
        b=RvdRK6YfsdwdCGizf74NWUKz9qjUI6SUSpc222GD82Vk0NhnVN7Ais7LZ68SaXMH9e
         loFV5/QziVNDN5o8UgF9048SweAoyrNVxzH6mFO7OawFIJmX1RDtjEF8ry/b9fiuBleJ
         Nawt0Bm54Luc8zTubmzMrIksBKhLDy1MHtvLrGh9POq7aRk1GRHu6e775X0e2xnCfutF
         N3XdHE0+Ebn0iwpgo0Sh24kCJRkXKRwv8r/3VAGq/nNLt1nMbVACJynPmW9i+57WrxcE
         QZZSSAfnX5Ef3zDpEwNnyeWNvrTLsWl7zU0a8FpTy9GmtuuqRecD7P3sGGb0mq39ERUF
         2hbw==
X-Forwarded-Encrypted: i=1; AFNElJ+sgy/nzBu1zMj6zaMAW13tR9NFnf/tbFfnZU4B+Am/CNj0AGk65aUYstgb/JLCkGbMDfTunGVNcgsXmocIRrDO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxsg3+SDn3an0177sI65alTvyoROX7qlRiEzqVxS0eZT6k//Sm
	CpNSN5MRBhyfXCiAY2uCBwTfpyyxS2NGPEwe9p2jktEy0J2i6C90o2WX4aUsc4fFO3hmXqZGg9n
	rmYVZTuy+hYSimtFLyzHviony79i0D5KQSivYxowf6bbOFr72kE5+DrcMoaw=
X-Gm-Gg: Acq92OHTuIoMz2iy9S43QisP1iHMn2UszU/ohtk9azkfcfz43KRAiUGcP5+gkKf+aYJ
	0y1nFuWU6ZxOkcxHjm5pWMf57R6CucQ+I4GJ2ps0uJ7HQ5lzYx0bggYyno5gBv1KHC1ddoXuNUD
	au0y5oQukYgLgAqDTU7Cv10kly6vtawrvQMMpQmCg+IYH+/d2CbbXo9DGbfT4US80UjFXU1cnTq
	13666UdGJ4GfkKR29MsxajBOALS6BXCqgBFalA9uea3w/jPGp6rn1u5qUwUJEFcQXq+H1KFUN8H
	JpJnI1UPlD4PPDiR/qMZSMetGXgqKOJ5tnJG
X-Received: by 2002:a17:903:38d0:b0:2b9:a39a:e5db with SMTP id
 d9443c01a7336-2c69c1f531emr2538605ad.7.1781629399919; Tue, 16 Jun 2026
 10:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616011543.4037138-9-irogers@google.com> <20260616015219.0BCC51F000E9@smtp.kernel.org>
 <ajFztSaBdZgJ6sJF@x1>
In-Reply-To: <ajFztSaBdZgJ6sJF@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jun 2026 10:03:08 -0700
X-Gm-Features: AVVi8CcrKgqyKYTSLRL-Qf7WH4CDDNdX69rDzD0zkJQiDDkb1y_THfHoH47RqgE
Message-ID: <CAP-5=fXYGpO1T2zj0Gyr-FaOObiAA8G4Oraj44xPsmX0+Wj6QA@mail.gmail.com>
Subject: Re: [PATCH v21 08/21] perf python: Use evsel in sample in pyrf_event
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:03=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jun 16, 2026 at 01:52:16AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> > - [High] Missing NULL check before calling evsel__get() on the result o=
f evlist__id2evsel() leads to a potential crash.
> > - [Medium] Missing perf_sample__exit() on the error path of guest_sessi=
on__fetch() leaks the evsel reference.
> > - [Medium] Missing perf_sample__exit() on the error path out of perf_mm=
ap__read_event() loop in test__perf_time_to_tsc leaks the evsel reference.
> > --
> >
> > commit c23db56d8fc8d40b59596916ce6b0537514263aa
> > Author: Ian Rogers <irogers@google.com>
> >
> > perf python: Use evsel in sample in pyrf_event
> >
> > Avoid a duplicated evsel by using the one in sample. Add
> > evsel__get/put to the evsel in perf_sample.
> >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index ec759a11f7588..d79112cebb716 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -3365,7 +3365,7 @@ int __evsel__parse_sample(struct evsel *evsel, =
union perf_event *event,
> > >     union u64_swap u;
> > >
> > >     perf_sample__init(data, /*all=3D*/true);
> > > -   data->evsel =3D evsel;
> > > +   data->evsel =3D evsel__get(evsel);
> >
> > [Severity: Medium]
> > Does this new reference acquisition cause memory leaks in existing call=
ers
> > that do not expect sample.evsel to hold a reference on early errors?
>
> So this was something I wasn't expecting: patches for tools/perf/util/
> inside a python binding series :-\

So this was the point of sending the RFC early:
https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irogers@go=
ogle.com/
When working with the session API, copying evsels and evlists becomes
painful; it's easier to hand references to the parts of the system
that need them instead of copying and ensuring the copying is correct.

> > For example, in tools/perf/builtin-inject.c:guest_session__inject_event=
s(),
> > if guest_session__fetch() fails, it returns an error but the cleanup bl=
ock
> > checking if (ret && gs->fetched) prevents perf_sample__exit() from runn=
ing,
> > leaking the evsel reference.
>
> this looks valid, no?
>
> And while looking at it, there is another bug in that function, but now
> I'm looking like sashiko ;-)
>
> Namely:
>
>  tools/perf/builtin-inject.c
> =E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=
=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=
=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C
>  1970        if (sample->cpu >=3D gs->vcpu_cnt) {
>  1971          pr_err("Guest event with unknown VCPU %u\n",
>  1972                 sample->cpu);
>  1973 -        return -EINVAL;
>  1973 +        ret =3D -EINVAL;
>  1974 +        break;
>  1975        }
>  1976        /* Change to host CPU instead of guest VCPU */
>  1977        sample->cpu =3D gs->vcpu[sample->cpu].cpu;
>
> But the comment for your patch seems actionable, i.e. it is an issue
> introduced by your series, by calling that evsel__get(), no?

Hmm.. I checked that the tests were clean using leak sanitizer and
reference count checking. There's no reference count checking on
evsels as the scope of the fix is so large for that. I'll try to find
other issues, and make a v22, but much of the Sashiko feedback has
proven to cover things that are either pre-existing, or addressed
later in this series. In this case the missing perf_sample__exit was
pre-existing and we could have been leaking other values like sampled
registers.

Thanks,
Ian

> > Similarly, in tools/perf/tests/perf-time-to-tsc.c:test__perf_time_to_ts=
c(),
> > the CHECK__(evsel__parse_sample(...)) macro jumps to out_err on failure=
,
> > bypassing perf_sample__exit(&sample) and permanently leaking the newly
> > acquired evsel.
> >
> > >     data->cpu =3D data->pid =3D data->tid =3D -1;
> > >     data->stream_id =3D data->id =3D data->time =3D -1ULL;
> > >     data->period =3D evsel->core.attr.sample_period;
> >
> > [ ... ]
> >
> > > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > > index 89d0f4cec6c7f..18af70488e07a 100644
> > > --- a/tools/perf/util/session.c
> > > +++ b/tools/perf/util/session.c
> > > @@ -1874,7 +1875,11 @@ static int evlist__deliver_deferred_callchain(=
struct evlist *evlist,
> > >             else
> > >                     orig_sample.deferred_callchain =3D false;
> > >
> > > -           orig_sample.evsel =3D evlist__id2evsel(evlist, orig_sampl=
e.id);
> > > +           new_evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> > > +           if (new_evsel !=3D orig_sample.evsel) {
> > > +                   evsel__put(orig_sample.evsel);
> > > +                   orig_sample.evsel =3D evsel__get(new_evsel);
> > > +           }
> >
> > [Severity: High]
> > Can this cause a segmentation fault if the sample ID is unknown or corr=
upted?
> >
> > The evlist__id2evsel() function can return NULL for malformed perf.data=
 files.
> > If new_evsel is NULL, passing it directly to evsel__get(new_evsel) will
> > dereference the NULL pointer when trying to increment its reference cou=
nt.
> >
> > Could we add a NULL check here before calling evsel__get()?
> >
> > >             ret =3D evlist__deliver_sample(evlist, tool, de->event,
> > >                                          &orig_sample, machine);
> > >
> > > @@ -1913,7 +1919,11 @@ static int session__flush_deferred_samples(str=
uct perf_session *session,
> > >             }
> > >             sample.file_offset =3D de->file_offset;
> > >
> > > -           sample.evsel =3D evlist__id2evsel(evlist, sample.id);
> > > +           new_evsel =3D evlist__id2evsel(evlist, sample.id);
> > > +           if (new_evsel !=3D sample.evsel) {
> > > +                   evsel__put(sample.evsel);
> > > +                   sample.evsel =3D evsel__get(new_evsel);
> > > +           }
> >
> > [Severity: High]
> > Similarly, could evlist__id2evsel() return NULL here and cause a crash =
when
> > passed to evsel__get()?
> >
> > >             ret =3D evlist__deliver_sample(evlist, tool, de->event,
> > >                                          &sample, machine);
> > >
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.=
4037138-1-irogers@google.com?part=3D8
