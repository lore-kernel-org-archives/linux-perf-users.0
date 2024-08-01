Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501914BF8D
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476154; cv=none; b=a2So5LZ/gd3dyITKzq/Mcb6a+k1dPeYar70khoWgGVybYzi44BinrYN1StvONQHOIVka82cb0mhfPpu63X6nNhPd1SS5o6VLr9QUa8Cx1rEhiATA73HiV2Jjea3LrYlGfX/sJSTVYMNua53iUKKf5B7XQpYPZAXbU29pdxzBNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476154; c=relaxed/simple;
	bh=D4jQ3hDsPrOEZnB+4u9pnJvTxR87PrXn94gydb83TLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcdmynFIZk4HVnrRAeKmzvvSjFc3/UZLZporg8vgAb9mAn86KFewYqKXoWqWZdi6QWbpy/8oaF41aKe+bgEDi4ogmp+cKIFxRNPPwHLuvI+KpoHSnjEKSFfzlUl5q8eNfit75lbzguuMpr74HHQJE62nzFpmMJaHQCP/r4RsN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spx3Gpr9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spx3Gpr9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc4aff530dso351555ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 18:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722476152; x=1723080952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plqL2dIvuw7F4PehvmHEAIZYJJhHz3IF52CvuaEwxgA=;
        b=spx3Gpr91VZiTuwwVVPor1WJSlV7l/1L0AxoRT3K4CAmwLjJq4VQR9EbkWWlAAsbxY
         JhfZMqubOGzCypKJbwJHcxPn7ooGvVyJPH11ce0R1Re549vWAKrX8qypyvxc6S8T2NzI
         Z7yltU4jVPECMj/K7P3qMnHSo6ffITEZEklXr5dX+Y9R4V+r3nBj+hTanNvJwKrRWVtV
         +y65y7piZzWBIt9QElNDZldUHezJoKzYID3E9VMnCXNVeYVLXslQE46B7hEb+VZ7n56X
         wcRaREuKy6XOQ3GNn+yrG2hWgXhFn2cwF5rNLGwFviuBmVBYFTkoqI8sbiuj3ZhefIng
         ECIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722476152; x=1723080952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plqL2dIvuw7F4PehvmHEAIZYJJhHz3IF52CvuaEwxgA=;
        b=OcBedjeqC+rcb0L7zeq9goRtV4Y2Vxdw8Vpyk2GmZnkuyw+J9P7uMt4u/JvcJVY2p4
         yB/hiV06wchdir5me8mdQqGR0KpxJ36dBWndsBexvDGsHHLR4Z/fqmZoj5bCnB1Njx4Y
         mIsrmLqSL5J2NSi5stgY9qXPKwE9hKaKzo1l7iDaonEyq8Zi9CHfzA7OeUvnm2BXC2HH
         WRkuGU1pqLAdGEuqKlWh7Feyw/z6zUwhidQ+egi4R67E8pjYzaeKiW89QDy83gJfZJTl
         gjxaqEbkuCiy1JTODg+bb9iRDqY2Mn6Bz4xT56UVX3eSNhmFi8YgkCHOk51zzkiVJZ+j
         /OaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFR2AkMwrafNZOEUEBl4YV5FB/19c/jHDfq+U2qa/5FMUMJuZOcUae0Oj3afL7fV1fYMk2x6bQdlI5nmj4Vcg3EphVNZdTupuvDXs6AOm4wg==
X-Gm-Message-State: AOJu0YziEiYLnq5VCnOEfj2prZkqiEIMOX1PFqATwj10cCX6Uvavp3uH
	SEavn7mi7JZaa2nQsqN05HeQGlYoZB00vkSTmDU9g4Z/onSML+jzmpKdrrIX9nQ38eD7V9AOdKU
	g6YAH/eNfWZ6YGtMzCYP9gQqsm8yG2qbxt+W+
X-Google-Smtp-Source: AGHT+IEecAbhodWaECwF1tFkoM0qqJAxepCeosOn1jrWDomaRpij7jppTG47HHjOvrCgW7/w6XugtAT/loHkkZQloJk=
X-Received: by 2002:a17:903:2283:b0:1fd:67c2:f967 with SMTP id
 d9443c01a7336-1ff4ec9341bmr804255ad.14.1722476151226; Wed, 31 Jul 2024
 18:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com> <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1> <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
 <ZqpZWywTe2j3U9Pl@x1> <ZqpcRIzzBb5KC6Zb@x1> <CAP-5=fVm5FkLDOLk4cbD9K6VPZ088f3Yk3bG8LT79E_OLLN4Lw@mail.gmail.com>
 <ZqqIEckIXQEAd9xr@x1> <CAP-5=fV8S0z=Fn+aoq4SxatBeeJ5MEUL02km_6+enqWaaW2qQA@mail.gmail.com>
 <ZqqhhsJtBJgfXWV4@x1>
In-Reply-To: <ZqqhhsJtBJgfXWV4@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 18:35:38 -0700
Message-ID: <CAP-5=fXvgicd9FjHobQWNmouYHv87FUbtAQqaQfCE_i4bjzFVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 01:20:06PM -0700, Ian Rogers wrote:
> > On Wed, Jul 31, 2024 at 11:53=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 08:58:43AM -0700, Ian Rogers wrote:
> > > > On Wed, Jul 31, 2024 at 8:46=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jul 31, 2024 at 12:33:50PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Wed, Jul 31, 2024 at 07:08:18AM -0700, Ian Rogers wrote:
> > > > > > > On Wed, Jul 31, 2024 at 6:18=E2=80=AFAM Arnaldo Carvalho de M=
elo
> > > > > > > <acme@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > > > > > > > > empty-pmu-events.c exists so that builds may occur withou=
t python
> > > > > > > > > being installed on a system. Manually updating empty-pmu-=
events.c to
> > > > > > > > > be in sync with jevents.py is a pain, let's use jevents.p=
y to generate
> > > > > > > > > empty-pmu-events.c.
> > > > > > > >
> > > > > > > > What am I missing here?
> > > > > > > >
> > > > > > > > If it exists so that we can build on a system without pytho=
n how can we
> > > > > > > > use python to generate it?
> > > > > > > >
> > > > > > > > Now having python in the system is a requirement and thus w=
e don't need
> > > > > > > > empty-pmu-events.c anymore?
> > > > > > > >
> > > > > > > > Can you guys please clarify that?
> > > > > > >
> > > > > > > The requirement for python hasn't changed.
> > > > > > >
> > > > > > > Case 1: no python or NO_JEVENTS=3D1
> > > > > > > Build happens using empty-pmu-events.c that is checked in, no=
 python
> > > > > > > is required.
> > > > > > >
> > > > > > > Case 2: python
> > > > > > > pmu-events.c is created by jevents.py (requiring python) and =
then built.
> > > > > > > This change adds a step where the empty-pmu-events.c is creat=
ed using
> > > > > > > jevents.py and that file is diffed against the checked in ver=
sion.
> > > > > > > This stops the checked in empty-pmu-events.c diverging if cha=
nges are
> > > > > > > made to jevents.py. If the diff causes the build to fail then=
 you just
> > > > > > > copy the diff empty-pmu-events.c over the checked in one.
> > > > > >
> > > > > > I'll try and add your explanation to the log message, thanks fo=
r
> > > > > > clarifying it!
> > > > >
> > > > > So, with it in place I'm now noticing:
> > > > >
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(base=
name $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m=3D'rm -rf ~/libe=
xec/perf-core/ ; make -k CORESIGHT=3D1 O=3D/tmp/build/$(basename $PWD)/ -C =
tools/perf install-bin && perf test python'
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> > > > > <SNIP>
> > > > >   GEN     /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-ev=
ents.c
> > > > >   MKDIR   /tmp/build/perf-tools-next/arch/x86/util/
> > > > >   CC      /tmp/build/perf-tools-next/util/annotate.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
> > > > >   CC      /tmp/build/perf-tools-next/util/block-info.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test=
.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
> > > > >   MKDIR   /tmp/build/perf-tools-next/ui/browsers/
> > > > >   CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
> > > > >   CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
> > > > >   CC      /tmp/build/perf-tools-next/util/block-range.o
> > > > >   TEST    /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.=
log
> > > > > --- pmu-events/empty-pmu-events.c       2024-07-31 12:44:14.35504=
2296 -0300
> > > > > +++ /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c=
       2024-07-31 12:45:35.048682785 -0300
> > > > > @@ -380,7 +380,7 @@
> > > > >                          continue;
> > > > >
> > > > >                  ret =3D pmu_events_table__for_each_event_pmu(tab=
le, table_pmu, fn, data);
> > > > > -                if (pmu || ret)
> > > > > +                if (ret)
> > > >
> > > > Right, you need to copy:
> > > >  /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
> > > > to
> > > > tools/perf/pmu-events/empty-pmu-events.c
> > > > to fix this.
> > > >
> > > > This change has happened as you are testing with:
> > > > https://lore.kernel.org/lkml/20240716132951.1748662-1-kan.liang@lin=
ux.intel.com/
> > > > which isn't in the git repo yet (therefore, I can't make a patch se=
t
> > > > on it). The change is WAI as it is telling you empty-pmu-events.c h=
as
> > > > become stale and needs Kan's fix applying to it.
> > >
> > > ok, I'll remove Kan's patch, publish perf-tools-next and wait for the
> > > now normal flow of patches.
> >
> > I can resend Kan's patch with the empty-pmu-events.c fix applied. I
> > don't see the changes in tmp.perf-tools-next so I can do it with
> > cherry picks.
>
> Just force pushed one more time. After a while should be there, there
> are still some issues here and there, notably:
>
>
> root@x1:~# perf test 105 106 118
> 105: perf all metricgroups test                                      : FA=
ILED!
> 106: perf all metrics test                                           : FA=
ILED!

These tests can be sensitive to the NMI watchdog being enabled.
> 118: Miscellaneous Intel PT testing                                  : FA=
ILED!

I bisected this failure to:

```
Author: Leo Yan <leo.yan@arm.com>
Date:   Thu Jul 25 07:46:17 2024 +0100

   perf auxtrace: Iterate all AUX events when finish reading

   When finished to read AUX trace data from mmaped buffer, based on the
   AUX buffer index the core layer needs to search the corresponding PMU
   event and re-enable it to continue tracing.

   However, current code only searches the first AUX event. It misses to
   search other enabled AUX events, thus, it returns failure if the buffer
   index does not belong to the first AUX event.

   This patch extends the auxtrace_record__read_finish() function to
   search for every enabled AUX events, so all the mmaped buffer indexes
   can be covered.

   Signed-off-by: Leo Yan <leo.yan@arm.com>
   Cc: Mark Rutland <mark.rutland@arm.com>
   Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
   Cc: Ian Rogers <irogers@google.com>
   Cc: Adrian Hunter <adrian.hunter@intel.com>
   Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
   Cc: Jiri Olsa <jolsa@kernel.org>
   Cc: Namhyung Kim <namhyung@kernel.org>
   Cc: James Clark <james.clark@linaro.org>
   Cc: Mike Leach <mike.leach@linaro.org>
   Cc:  <coresight@lists.linaro.org>
   Cc: John Garry <john.g.garry@oracle.com>
   Cc:  <linux-perf-users@vger.kernel.org>
   Link: https://lore.kernel.org/lkml/
   Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

tools/perf/util/auxtrace.c | 25 ++++++++++++++++++++-----
1 file changed, 20 insertions(+), 5 deletions(-)
```

> root@x1:~# perf test 110
> 110: perf stat --bpf-counters --for-each-cgroup test                 : FA=
ILED!

This one flakes if the test machine has load on it.

> root@x1:~#
>
> I'm running out of time today, so I'll probably just push what I have to
> perf-tools-next so that we can start getting testing from linux-next and
> we can then go on fixing up stuff from there.

Thanks,
Ian
