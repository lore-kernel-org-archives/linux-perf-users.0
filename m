Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDA56B65
	for <linux-perf-users@vger.kernel.org>; Sat, 11 May 2024 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388646; cv=none; b=qsAobOpxKqo3G9bA7bhysm5rfGomc8LhdSyvIHSYWZYYnSbIJ3+slnHxsMIW3i7VBtdGgENvRIz19kUdwWi/ACBe1jIMcwen3QM54KKbC8RlYr70rriJF8ESrbpX+TruRUrX/LM5XsnjxhjrwDzHCGqI1WKMHxECvsQJKbV8NAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388646; c=relaxed/simple;
	bh=29H2ZkSMqUh1NQ71nR4QuJZPnSHhxyUdN/R3ZAzv+1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFjRvCHic65amSyujMuQzB1T/nwnoQfTSEJY0c+aQZU0lzztP4IDwgDPsGDollDOfjPN5fftAW84ROZWH/whl2BZtnZUp4InL7Vx2P0Z2flvFV69PR2H6xRtdpXIUpzfVkvYUOMkNDClqnO2lNkyfVnNyBYktgfO6520aVG4x5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORbM1vOT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORbM1vOT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec76185c0fso37125ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 17:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715388643; x=1715993443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpkRXiISMgxYRyuOPXk0L2m29umqlNK9saYU4NgbZio=;
        b=ORbM1vOTcuBEwUq19USCMObHIovAN0Q1ZSiXVGHEHcmMgllH3vczMCgVCRS2AT1S1r
         wKg5n4zADa9Sr6PAzTdWU7rrxUKKjQ7qEeqdqhQyJPDjwO+zs+A8mWO1B0D2+d9SNWf1
         U3pbN+gfBBu9YQBLlDJ112V0Hv74dTWwaTjYJ45chEQgi+hRb+rhrdcNAzwqjAYIFIhZ
         Xq1qzFGer4tRG4IJKLVVJ7JTSKbjgJ9lllEaIRVRyxOnv4D4boSkj7An4YO2tVWyzCtG
         guKjoQbFlLBr/Y1zbvnwAT/I5RvminqsZah7hNSddTz4hsSBpDIULSrAPb5azrYad8/G
         AHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388643; x=1715993443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpkRXiISMgxYRyuOPXk0L2m29umqlNK9saYU4NgbZio=;
        b=dFGl8DNZalXPxs4JVWMTotmAi56Wmtnxnd8NxMDYV2pZwmbxVJS3SAGM5vw3j4iOIp
         7V8JKs18JQI4Jzo/1DXRO6b/CIzIzRyVc+M1gR7X3A7Y5N5pjooCjYD46nW06TwdH4eO
         WB3hgAMiYBmSru24gRujCLDtgpHGS1pNE+oZaYESB3WvIX852EFdDETe7oKTlS3FWCci
         Yarp0l0SUDFAysKMP3jGPHdzoaWHFFy4uD4OK9ABkHbmW+BYWqZl+AJF4i78zSb2b41D
         me2UOO8omQJmRvqz/D3XaYw2yZGk+gX0ydL6UeKYN+OG5koJaGA2o4fOm2P0HuIguQf7
         HMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkn5PzeZ4IYM7IykoQb7ojohS9Ncv12FY4lzHfg/4dRoCOlWBJENMZ26Uw1MrmZLTjuHaZ2gNWa7Qa0Hehj0lgZLA8Zp95bzLTsuNHLzx//g==
X-Gm-Message-State: AOJu0Yxu/lpnjYY4LhVZttXIOxnbcC/8FGtftpy3OMfyfOKOqicXG3iO
	9QGezfWVHvtNBX1TdTWKy5reHm+A2SDb9yf7HDchNf6O9ElLLQrza3Iz16MFwRaOHDdLpSOuNzW
	mZvvcpcdREGIvImB+YkENpej5UlhhwgadLOnx
X-Google-Smtp-Source: AGHT+IGcOv4CX/F79iCXQC7gbanIkG/guRxkNZwIoCLpaLG+RFa9IbRJ1e/Fc1r3KeEPT54+/eCX4VqJgF3btD61+AA=
X-Received: by 2002:a17:903:124b:b0:1e8:6551:e83c with SMTP id
 d9443c01a7336-1f060bba9c6mr501885ad.25.1715388642768; Fri, 10 May 2024
 17:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510024729.1075732-1-justin.he@arm.com> <20240510024729.1075732-3-justin.he@arm.com>
 <CAP-5=fVGD-pK1igABj0wiq6-KVM+Z4i7rnRhM=Vy7bFHW4pLQA@mail.gmail.com>
 <DBBPR08MB4538A157B81F2BBD2DD9E40DF7E72@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAP-5=fWgGOWi_YedpQgdK2DnBvtRk-79GEhKMsTehcfOVtxLNA@mail.gmail.com>
In-Reply-To: <CAP-5=fWgGOWi_YedpQgdK2DnBvtRk-79GEhKMsTehcfOVtxLNA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 17:50:29 -0700
Message-ID: <CAP-5=fULL0KNWA_O0B3r4Q0DA2_FMk=rARhb=z8ySKzFyVwFyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf pmu: Fix num_events calculation
To: Justin He <Justin.He@arm.com>, John Garry <john.g.garry@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <Mark.Rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <James.Clark@arm.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, May 9, 2024 at 11:52=E2=80=AFPM Justin He <Justin.He@arm.com> wro=
te:
> >
> > Hi, Ian
> >
> > > -----Original Message-----
> > > From: Ian Rogers <irogers@google.com>
> > > Sent: Friday, May 10, 2024 2:17 PM
> > > To: Justin He <Justin.He@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.=
com>;
> > > Arnaldo Carvalho de Melo <acme@kernel.org>; Namhyung Kim
> > > <namhyung@kernel.org>; Mark Rutland <Mark.Rutland@arm.com>; Alexander
> > > Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kerne=
l.org>;
> > > Adrian Hunter <adrian.hunter@intel.com>; Kan Liang
> > > <kan.liang@linux.intel.com>; James Clark <James.Clark@arm.com>;
> > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 2/2] perf pmu: Fix num_events calculation
> > >
> > > On Thu, May 9, 2024 at 7:47=E2=80=AFPM Jia He <justin.he@arm.com> wro=
te:
> > > >
> > > > When pe is NULL in the function perf_pmu__new_alias(), the total
> > > > number of events is added to loaded_json_aliases. However, if
> > > > pmu->events_table is NULL and cpu_aliases_added is false, the
> > > > calculation for the events number in perf_pmu__num_events() is inco=
rrect.
> > > >
> > > > Then cause the error report after "perf list":
> > > > Unexpected event
> > > smmuv3_pmcg_3f062/smmuv3_pmcg_3f062/transaction//
> > > >
> > > > Fix it by adding loaded_json_aliases in the calculation under the
> > > > mentioned conditions.
> > > >
> > > > Test it also with "perf bench internals pmu-scan" and there is no
> > > > regression.
> > > >
> > > > Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > ---
> > > >  tools/perf/util/pmu.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c index
> > > > a1eef7b2e389..a53224e2ce7e 100644
> > > > --- a/tools/perf/util/pmu.c
> > > > +++ b/tools/perf/util/pmu.c
> > > > @@ -1639,6 +1639,8 @@ size_t perf_pmu__num_events(struct perf_pmu
> > > *pmu)
> > > >                  nr +=3D pmu->loaded_json_aliases;
> > > >         else if (pmu->events_table)
> > > >                 nr +=3D
> > > pmu_events_table__num_events(pmu->events_table,
> > > > pmu) - pmu->loaded_json_aliases;
> > > > +       else
> > > > +               nr +=3D pmu->loaded_json_aliases;
> > >
> > > Thanks for working on this! The "struct pmu_event *pe" in new_alias i=
s an entry
> > > from the json data, and "pmu->events_table" should NULL if there is n=
o json
> > > data. I believe the code is assuming that these lines aren't necessar=
y as it
> > > shouldn't be possible to load json data if the json events table does=
n't exist for
> > > the PMU - if there is no json data then loaded_json_aliases should be=
 0 and no
> > > addition is necessary. I'm wondering why this case isn't true for you=
.
> > On my Armv8a N2 server, "pmu->events_table" is NULL because perf_pmu__f=
ind_events_table()
> > return NULL.
> >
> > I also noticed that pmu->loaded_json_aliases is *not* 0. The missing ad=
ding calculation will cause
> > perf_pmu__num_events() less than normal case and will trigger latter ch=
eck failure in
> > perf_pmus__print_pmu_events__callback().
> > At last, perf list will report many lines similar as:
> > Unexpected event smmuv3_pmcg_3f062/smmuv3_pmcg_3f062/transaction//
>
> The issue is the sys events which currently are ARM only. Here is an
> lldb stack trace:
> ```
>     frame #6: 0x0000aaaaabc9b49c
> perf`__assert_fail(assertion=3D"pmu->events_table",
> file=3D"tools/perf/util/pmu.c", line=3D522, function=3D"int
> perf_pmu__new_alias(struct perf_pmu *, const char *, const char *,
> const char *, FILE *, const struct pmu_event *)")
>     frame #7: 0x0000aaaaab41e018
> perf`perf_pmu__new_alias(pmu=3D0x00007377e7e09b40,
> name=3D"hnf_brd_snoops_sent", desc=3D"Counts number of multicast snoops
> sent (not including SF back invalidation)", val=3D"eventid=3D9,type=3D5",
> val_fd=3D0x0000000000000000, pe=3D0x0000ffffffffde88) at pmu.c:522:3
>     frame #8: 0x0000aaaaab4175cc
> perf`pmu_add_sys_aliases_iter_fn(pe=3D0x0000ffffffffde88,
> table=3D0x0000aaaaac299bb0, vdata=3D0x00007377e7e09b40) at pmu.c:939:3
>     frame #9: 0x0000aaaaaaf6d000
> perf`pmu_events_table__for_each_event_pmu(table=3D0x0000aaaaac299bb0,
> pmu=3D0x0000aaaaac299238, fn=3D(perf`pmu_add_sys_aliases_iter_fn at
> pmu.c:931), data=3D0x00007377e7e09b40) at pmu-events.c:5994:23
>     frame #10: 0x0000aaaaaaf6cd78
> perf`pmu_events_table__for_each_event(table=3D0x0000aaaaac299bb0,
> pmu=3D0x0000000000000000, fn=3D(perf`pmu_add_sys_aliases_iter_fn at
> pmu.c:931), data=3D0x00007377e7e09b40) at pmu-events.c:6057:23
>     frame #11: 0x0000aaaaaaf6ec44
> perf`pmu_for_each_sys_event(fn=3D(perf`pmu_add_sys_aliases_iter_fn at
> pmu.c:931), data=3D0x00007377e7e09b40) at pmu-events.c:6295:27
>     frame #12: 0x0000aaaaab41738c
> perf`pmu_add_sys_aliases(pmu=3D0x00007377e7e09b40) at pmu.c:955:2
>     frame #13: 0x0000aaaaab4179fc
> perf`perf_pmu__lookup(pmus=3D0x0000aaaaac500970, dirfd=3D34,
> name=3D"arm_cmn_0") at pmu.c:1037:2
>     frame #14: 0x0000aaaaab4242d0 perf`perf_pmu__find2(dirfd=3D34,
> name=3D"arm_cmn_0") at pmus.c:161:9
>     frame #15: 0x0000aaaaab421614 perf`pmu_read_sysfs(core_only=3Dfalse)
> at pmus.c:209:3
>     frame #16: 0x0000aaaaab42278c
> perf`perf_pmus__scan_skip_duplicates(pmu=3D0x0000000000000000) at
> pmus.c:297:3
>     frame #17: 0x0000aaaaab422078
> perf`perf_pmus__print_pmu_events(print_cb=3D0x0000ffffffffec68,
> print_state=3D0x0000ffffffffecd0) at pmus.c:462:16
>     frame #18: 0x0000aaaaab425d9c
> perf`print_events(print_cb=3D0x0000ffffffffec68,
> print_state=3D0x0000ffffffffecd0) at print-events.c:409:2
>     frame #19: 0x0000aaaaab093ef0 perf`cmd_list(argc=3D0,
> argv=3D0x0000fffffffff340) at builtin-list.c:592:3
>     frame #20: 0x0000aaaaaaf5b490
> perf`run_builtin(p=3D0x0000aaaaac4e8220, argc=3D1,
> argv=3D0x0000fffffffff340) at perf.c:349:11
>     frame #21: 0x0000aaaaaaf5a3e0 perf`handle_internal_command(argc=3D1,
> argv=3D0x0000fffffffff340) at perf.c:402:8
>     frame #22: 0x0000aaaaaaf5b1a0
> perf`run_argv(argcp=3D0x0000fffffffff1c8, argv=3D0x0000fffffffff1c0) at
> perf.c:446:2
>     frame #23: 0x0000aaaaaaf59f44 perf`main(argc=3D1,
> argv=3D0x0000fffffffff340) at perf.c:562:3
> ```
>
> As such the fix here is incomplete. There may be both sys json events
> (detected by PMU/id name) and CPU json events (detected by CPUID). I'm
> looking into a fix.

Patch sent:
https://lore.kernel.org/lkml/20240511003601.2666907-1-irogers@google.com/

Thanks,
Ian

> Thanks,
> Ian
>
> > --
> > Cheers,
> > Justin (Jia He)
