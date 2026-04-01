Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA630FC2E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074119; cv=pass; b=hE4ZantIILnzDqkJ5EVN8FYjkKyAi/8BuchgcLFoB1H7bSP7mTGh0UulXir0SEuQM8ujgHZXRwelSD0xPl9eFH9w8SreDC64tMp6Mhaoe1KJG3TeoXIiy9SU9Q/0bpHs+2VV58wg1Iw4Aa8h3fT0Jk+SYVXnUI8FFwlwlcL0s8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074119; c=relaxed/simple;
	bh=nCCp+z4IFtSGwb8CYZRFG7U7g2FsvQ0I9SgmBXS3DsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlkJ5aQqbwYlzQWMWpgEpVBJDgTHDxFRFxJx8ebpV5BcvU8pyb5HqRoLyYThJ+eKuaQM0X8l+FjMiXrTgQcJfA5DG46ZhDBUMQJH5Jc0tapoVMh17DRcIDv9IvuRC7xVFl93+2lgVJuvxgBVQMsN/wWYZYVqeGZxky/AeiQkNJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMOtS6MJ; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMOtS6MJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0b260d309so4535ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775074118; cv=none;
        d=google.com; s=arc-20240605;
        b=ExgPAqfdidhCjsVp+Dej2+4Stio6Rthln5wQLVZxxDXgZC6CFHInsEKu1jGaEiAoNH
         CbMl8YvkKbNCzm08OJNAjn9ZVBhf0Ank64XrefSsW5IvsNAXvSQJxiHbN/ZGRvyCsDHe
         9GIkqdl/jN9g02dINfjnzQr0pRyxBQZj9qul606VBBFEvaTeoFx1hM4UOzn7QI8LsRnv
         wWrKMnRulOpzna/M79/oypwTg3RWP/D01REHGqQ7HSz0e6LDoWWCz3ISpHUHxicWu/EG
         LjJzEQ0z+wmT0tNZdCYCCwIwaTFigkvzjkhfxq3CPiojaFefqIiYZAekW4P8Mz0Lraf2
         T34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5nqHoAJ3c1NxKg4itndaa3GpwxxY0aKMnxcW6PJB9s=;
        fh=8hHLB3tfobL7H0S/ja26fBYmUYR4huuU/Zaj210kZ/I=;
        b=SbVLysp4brs7mJBP+/TNwfCJ7zq2bS2eSNWkT3tPz4pk/rtkgu/DnvThBnAiC/+jaK
         4LMP2jRl9qTrJz4+3RpCDkI0XACiVUsmOTyBEPcLypw9IbSEdd8F6EbGBgo56jUUrBq6
         s6r48wd4sMxY3rj0f0HzXJLge3Cf8ovG3+SAKs8N1tR7RpQ2NWwAgg7WZyL117e2y6V/
         fAzWYo6rTZK/bgZ5yocas0tUK/UCmrrpXHvrRxEAJIsfrIARr4+RYczB+XlSp1d3wmvV
         0cGDteS2YjT6++poNwdBK4Q9brjDYfjtstuXyB33w9MB9c5VnGSE91UK38YDMamEEy8G
         lfjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775074118; x=1775678918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5nqHoAJ3c1NxKg4itndaa3GpwxxY0aKMnxcW6PJB9s=;
        b=DMOtS6MJ8XmgbszFCfUWGL5lsZdWqb2D5V4cg/cGoev9JUGA+23oTolc5XCpfsZ1cV
         1+3o04XZ2edfdLeYkvYt7mUmfgH997tzvomrRvsfZ+aNxlZQ6aGJNyAnnptAXon1hgkh
         BBF9b63XIe1hTLCumN/BAjqP8HKqlol3611/3TQKEPA8+EZAQqIbo1HhhtTacYpNFL2/
         WRNwenP7pXZg/Cnzlcl8YTgKbA0BiSLY0ZgZ3Vt8nnUJoYywkc2QIpxOU1YNlUfTjSNl
         BkGWTaweusTmp0sXgtkgKvoxOpfaicdhPuZVE5b5ZV10pp9UL7Mtzry/DWBhlVulhLbJ
         E4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074118; x=1775678918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5nqHoAJ3c1NxKg4itndaa3GpwxxY0aKMnxcW6PJB9s=;
        b=Yv0NBywlwgCfYar8xvw/MwSRO0/552R+jeitFQwIWrkPTEkjUtQQ+9R0Z3eFk00vKh
         9JX0gr+6mYDhHUUjuuXT8caQb/xu+y4UYw1t/bbpsqgA0znVnN+uQ+p/pcL5HFCn+yBD
         nvw6pFa4ElXm/RbqYaWcyomLoK7knyX31wsf7cXpCOA1m+lEMF1el3HCMbvCIUqzq9Nb
         BzA+4IVGaTUQvA15rXBBBFPBiMMnjsqtOftsydv+MsuyfgFrGPOqfkcA7cuALdeYv6xU
         e0VVsgrHcQKwQCj6O9zn4UiOJ+P5TCsSibVmEdbTynXfRD8lFerv1DSS3PiMmC1Td6Fh
         PlLQ==
X-Gm-Message-State: AOJu0YyohPmtyV/svOwf3bBZApK4oNTRTVSEmoGc8GLd0kmHCyU5E1IU
	syFrDbhr6UqzUwb7tEd1oRvjePS/HQZdKmqMgRZzDqvhuIoKkDaywjYaZBIxf5aQCsm9JuQZ+bW
	3VjDjCC0p0VgO51hldhPY1uckb/t/XgaCo2Egq5AN
X-Gm-Gg: ATEYQzyqv2tNHEWNY4ODtGKhnrY/6Z4fxG7sXZP0MbaWP64CGmeMd988w37dicJ8H4h
	7ijg3y1N3IrQjhEaOguwLCFKEiaLhA42oNOFvhnxVINLXK70iJsBE3gVNhHoRzxiWiUXiV27RNx
	oE1y9Bc1We5qPl2+uSVog2RwwVoa6CoYzvaQvHrOw4+2vrdOJ5zt1yq3EFsV08WgzNJE9i/YrIo
	dqGgLSozhyTQqqRIy7IoBTZomSi6w3SnJkBfFRy58KKN3Qu2ivd3rK3q1MjFBXiiHno93RzZevE
	aE5hRCNS/zoRWF5/X6Wv3UT89b+StwN+XRDJ
X-Received: by 2002:a17:903:2c0d:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2b276ab69ccmr362085ad.16.1775074117156; Wed, 01 Apr 2026
 13:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
 <20260327015927.223999-1-thomas.falcon@intel.com> <CAP-5=fXCUB3Hqwi1M7gpEZLrGw_H2DgH5Us=ez6PE2Nmb_3efA@mail.gmail.com>
In-Reply-To: <CAP-5=fXCUB3Hqwi1M7gpEZLrGw_H2DgH5Us=ez6PE2Nmb_3efA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:08:25 -0700
X-Gm-Features: AQROBzA-We5P0AafzsfmHufpObLMZGyBJlrl67KUyn2X0dkdTgLWim98Wi8TiQY
Message-ID: <CAP-5=fWLjEE832GG-9nex8+W61nMS4tQw17z0_LfOk9Z0z30hw@mail.gmail.com>
Subject: Re: [PATCH v3] tools/perf: Fix ratio_to_prev event parsing test
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Mar 26, 2026 at 7:01=E2=80=AFPM Thomas Falcon <thomas.falcon@inte=
l.com> wrote:
> >
> > test__ratio_to_prev() assumed the first event in a group is the leader,
> > which is not the case when the event is expanded into two event groups
> > on hybrid PMU's with auto counter reload support. Instead, iterate over=
 the
> > event group generated for each core PMU. Also update "wrong leader" tes=
t to
> > check that the subordinate event has the correct leader instead of chec=
king
> > that it is not the group leader. Finally, do not exit immediately if a =
PMU
> > without auto counter reload support is found.
> >
> > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and re=
gression tests")
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Ping. Thanks,
Ian

> Thanks!
> Ian
>
> > ---
> > v3: Fixed early loop termination if PMU without auto counter reload sup=
port is
> >     encountered first, suggested by Ian Rogers
> > https://lore.kernel.org/all/CAP-5=3DfUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5=
_Yv_VfxP+A@mail.gmail.com/
> >
> > v2: made changes suggested by Dapeng Mi
> > https://lore.kernel.org/all/997b6291-7429-4eaa-8467-1fd88e100616@linux.=
intel.com/
> > ---
> >
> >  tools/perf/tests/parse-events.c | 49 +++++++++++++++++++--------------
> >  1 file changed, 28 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index 1d3cc224f..05c3e899b 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -1796,31 +1796,38 @@ static bool test__acr_valid(void)
> >
> >  static int test__ratio_to_prev(struct evlist *evlist)
> >  {
> > -       struct evsel *evsel;
> > +       struct evsel *evsel, *leader;
> >
> >         TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_c=
ore_pmus() =3D=3D evlist->core.nr_entries);
> >
> > -        evlist__for_each_entry(evlist, evsel) {
> > -               if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
> > -                       return TEST_OK;
> > -
> > -               if (evsel =3D=3D evlist__first(evlist)) {
> > -                       TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel=
->core.attr.config2);
> > -                       TEST_ASSERT_VAL("wrong leader", evsel__is_group=
_leader(evsel));
> > -                       TEST_ASSERT_VAL("wrong core.nr_members", evsel-=
>core.nr_members =3D=3D 2);
> > -                       TEST_ASSERT_VAL("wrong group_idx", evsel__group=
_idx(evsel) =3D=3D 0);
> > -                       TEST_ASSERT_EVSEL("unexpected event",
> > -                                       evsel__match(evsel, HARDWARE, H=
W_CPU_CYCLES),
> > -                                       evsel);
> > -               } else {
> > -                       TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel=
->core.attr.config2);
> > -                       TEST_ASSERT_VAL("wrong leader", !evsel__is_grou=
p_leader(evsel));
> > -                       TEST_ASSERT_VAL("wrong core.nr_members", evsel-=
>core.nr_members =3D=3D 0);
> > -                       TEST_ASSERT_VAL("wrong group_idx", evsel__group=
_idx(evsel) =3D=3D 1);
> > -                       TEST_ASSERT_EVSEL("unexpected event",
> > -                                       evsel__match(evsel, HARDWARE, H=
W_INSTRUCTIONS),
> > -                                       evsel);
> > +       evlist__for_each_entry(evlist, evsel) {
> > +               if (evsel !=3D evsel__leader(evsel) ||
> > +                   !perf_pmu__has_format(evsel->pmu, "acr_mask")) {
> > +                       continue;
> >                 }
> > +               leader =3D evsel;
> > +               /* cycles */
> > +               TEST_ASSERT_VAL("wrong config2", 0 =3D=3D leader->core.=
attr.config2);
> > +               TEST_ASSERT_VAL("wrong core.nr_members", leader->core.n=
r_members =3D=3D 2);
> > +               TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(lea=
der) =3D=3D 0);
> > +               TEST_ASSERT_EVSEL("unexpected event",
> > +                                 evsel__match(leader, HARDWARE, HW_CPU=
_CYCLES),
> > +                                 leader);
> > +               /*
> > +                * The period value gets configured within evlist__conf=
ig,
> > +                * while this test executes only parse events method.
> > +                */
> > +               TEST_ASSERT_VAL("wrong period", 0 =3D=3D leader->core.a=
ttr.sample_period);
> > +
> > +                /* instructions/period=3D200000,ratio-to-prev=3D2.0/ *=
/
> > +               evsel =3D evsel__next(evsel);
> > +               TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel->core.a=
ttr.config2);
> > +               TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel=
, leader));
> > +               TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr=
_members =3D=3D 0);
> > +               TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evs=
el) =3D=3D 1);
> > +               TEST_ASSERT_EVSEL("unexpected event",
> > +                                 evsel__match(evsel, HARDWARE, HW_INST=
RUCTIONS),
> > +                                 evsel);
> >                 /*
> >                  * The period value gets configured within evlist__conf=
ig,
> >                  * while this test executes only parse events method.
> > --
> > 2.51.0
> >
