Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83AAC3DA66
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 04:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjHYEnC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 00:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjHYEmw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 00:42:52 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA01FEA
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:42:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34bae839382so84555ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692938569; x=1693543369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91RfB25O6yu8T731N1AvJL3cZqwpe5F1Rt24OzyGGDY=;
        b=dtWKJQ2EdY6nVTdspcnlz9mApTEg7PvaeMrda8JA+n5JUcP65wKDHQ6tjjK6IkwSX9
         EVlIUoTSmTLKwNJXc+zAduJNbjpFOOwhwsa1oYKnGfB9Q4E10mSqDFApgFLSoiG0p5+Z
         fLsfGrY28BSHqgrr79oWonFoexDX9NuOVDowDDnAX6FScBVPsVaA/3PqcLbrwbKF1ugK
         vFgOJWanW1mKvbapSZgs90JF9E6kEG7E+72pFsO5QhwcLutPeFc86t4a1IZkv6QaX25b
         rQyOCaGyFqxZLPduZpczLbIHFNXv7kZ665psSZaDe/M6By4oGx0nHWL5+a/kUUrTcb3m
         yl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692938569; x=1693543369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91RfB25O6yu8T731N1AvJL3cZqwpe5F1Rt24OzyGGDY=;
        b=dWBvE3VaaVl/+Z0rleSbsYLcb1nODSmuyb8JS2szm50SoYXAp6m3jIA/NoTESuPoSn
         5IsWiCKivWbr+OGJYIUmQWIF/ck+2xyauTE1b5iycCe3ZNg5z+LgFKKFxvd5DQTW/nXZ
         zrDfbHiKeaiDwrxYYC0qB55JBKEMbs2ZehaiXoCxj6tmaHQjoVqUnIFhFJyssmXpJ7Gc
         5Fri6t7yUVYzb/fdOHSd4w+bCmxF9W2kiL8KYIaejmTPhJDCVZBan15u/DC8Rmqc9zY+
         dlKM9cHXi9X1HmKzyY5l5tgPA00fAKApqgaGbl276j2pi1cNnZMEEXJohWgr/6kSZ4n7
         3OFA==
X-Gm-Message-State: AOJu0Yx4sw26+Jp4UXs7Gse9Zkchvt2qlFXRFxOAZ25CjwzgeOtXkSy0
        sKKO81ntt+W7Llo9eM2Ez1h2pyYumJEskp9eVKLprw==
X-Google-Smtp-Source: AGHT+IEns/qxw2Loxo4H07LkQrGGZS/78O4lTqrDGeKterfzvUAkLGrRVDPQK3QgBLcfdyl9wyaGkhkG9N8X8IEt1+U=
X-Received: by 2002:a05:6e02:1605:b0:348:d80c:ca16 with SMTP id
 t5-20020a056e02160500b00348d80cca16mr91934ilu.5.1692938569440; Thu, 24 Aug
 2023 21:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1692606977-92009-5-git-send-email-renyu.zj@linux.alibaba.com> <166d2a93-0d86-b106-e996-d74fb4521aa2@arm.com>
In-Reply-To: <166d2a93-0d86-b106-e996-d74fb4521aa2@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:42:37 -0700
Message-ID: <CAP-5=fW28aaXsKH4hUyZoBBHSJZqQ1HnNWY2miv+VSzeBt87vQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] perf jevents: Support more event fields
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 23, 2023 at 2:12=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-21 09:36, Jing Zhang wrote:
> > The previous code assumes an event has either an "event=3D" or "config"
> > field at the beginning. For CMN neither of these may be present, as an
> > event is typically "type=3Dxx,eventid=3Dxxx".
> >
> > If EventCode and ConfigCode is not added in the alias JSON file, the
> > event description will add "event=3D0" by default. So, even if the even=
t
> > field is added "eventid=3Dxxx" and "type=3Dxxx", the CMN events final
> > parsing result will be "event=3D0, eventid=3Dxxx, type=3Dxxx".
> >
> > Therefore, when EventCode and ConfigCode are missing in JSON, "event=3D=
0"
> > is no longer added by default. And add EventIdCode and Type to the even=
t
> > field.
> >
> > I compared pmu_event.c before and after compiling with JEVENT_ARCH=3Dal=
l,
> > they are consistent.
> >
> > Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> > ---
> >   tools/perf/pmu-events/jevents.py | 20 ++++++++++++++++----
> >   1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index f57a8f2..369c8bf 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -275,11 +275,14 @@ class JsonEvent:
> >         }
> >         return table[unit] if unit in table else f'uncore_{unit.lower()=
}'
> >
> > -    eventcode =3D 0
> > +    eventcode =3D None
> >       if 'EventCode' in jd:
> >         eventcode =3D int(jd['EventCode'].split(',', 1)[0], 0)
> >       if 'ExtSel' in jd:
> > -      eventcode |=3D int(jd['ExtSel']) << 8
> > +      if eventcode is None:
> > +        eventcode =3D int(jd['ExtSel']) << 8
> > +      else:
> > +        eventcode |=3D int(jd['ExtSel']) << 8
> >       configcode =3D int(jd['ConfigCode'], 0) if 'ConfigCode' in jd els=
e None
> >       self.name =3D jd['EventName'].lower() if 'EventName' in jd else N=
one
> >       self.topic =3D ''
> > @@ -317,7 +320,11 @@ class JsonEvent:
> >       if precise and self.desc and '(Precise Event)' not in self.desc:
> >         extra_desc +=3D ' (Must be precise)' if precise =3D=3D '2' else=
 (' (Precise '
> >                                                                    'eve=
nt)')
> > -    event =3D f'config=3D{llx(configcode)}' if configcode is not None =
else f'event=3D{llx(eventcode)}'
> > +    event =3D None
> > +    if eventcode is not None:
> > +      event =3D f'event=3D{llx(eventcode)}'
> > +    elif configcode is not None:
> > +      event =3D f'config=3D{llx(configcode)}'
> >       event_fields =3D [
> >           ('AnyThread', 'any=3D'),
> >           ('PortMask', 'ch_mask=3D'),
> > @@ -327,10 +334,15 @@ class JsonEvent:
> >           ('Invert', 'inv=3D'),
> >           ('SampleAfterValue', 'period=3D'),
> >           ('UMask', 'umask=3D'),
> > +        ('NodeType', 'type=3D'),
> > +        ('EventIdCode', 'eventid=3D'),
>
> FWIW, this smells like another brewing scalability problem, given that
> these are entirely driver-specific. Not sure off-hand how feasible it
> might be, but my instinct says that a neat solution would be to encode
> them right in the JSON, e.g.:
>
>         "FormatAttr": { "type": 0x5 }
>
> such that jevents should then only really need to consider whether an
> event is defined in terms of a raw "ConfigCode", one or more
> "FormatAttr"s which it can then parse dynamically, or reasonable special
> cases like "EventCode" (given how "event" is one of the most commonly
> used formats).

Hi Robin,

I'm not sure about scalability but I think it is a problem that we
encode names into the event that should correspond with formats, but
we don't test that the PMU driver in question supports the format. If
we tar up sysfs directories I think we can check/test this and it
makes sense for the perf tool to be able to parse a sysfs type
directory structure.

I think the hard coded names and matching to dictionary entries is
suboptimal, we should really be able to know the formats, abstract
this, etc. The code is deliberately done this way so that we could
migrate away from a legacy C version of this code and generate an
identical pmu-events.c. As much as is possible the python code matches
the C code, but now the transition has happened there is no reason to
maintain this behavior.

Thanks,
Ian

> Thanks,
> Robin.
>
> >       ]
> >       for key, value in event_fields:
> >         if key in jd and jd[key] !=3D '0':
> > -        event +=3D ',' + value + jd[key]
> > +        if event:
> > +          event +=3D ',' + value + jd[key]
> > +        else:
> > +          event =3D value + jd[key]
> >       if filter:
> >         event +=3D f',{filter}'
> >       if msr:
