Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C881DB125
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Nov 2025 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263784; cv=none; b=KZQCveQslfzwJF0ulyRb8O08o+pKkFLPhfCbulgXcoaXCOndI4MHv3RpcxuCeEKag45xlxWIEv0chRoHr93MMywdie6Eo4Bpp5qg9S+QNJgxdCWNHEpze8HzFZ5PeAh7S+WEnYyFs6l08u3B0YMAo34gWRQRuKrxlNe6M7kCpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263784; c=relaxed/simple;
	bh=5WY03GlOFrpYW/e8i9oen4Cc3MyY1mbwOu4bfKJd/eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC68ZFZO+0jQL8kvvsYOw3ayFI87lYiz9oZ6axyc/N2ltGSIgLHolCoAw9MSnuSN3y8aro01+eZBhIAIRwCKG/oS2UraCN9/rxNIG9JG7/6WbNFLkKQpHdc1hLwIai7QB+Z91pCEBu5rvwtS6lS4+9CgN32WLz5ycs3rA1CMzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSuZq4Eb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSuZq4Eb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29852dafa7dso153565ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Nov 2025 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763263782; x=1763868582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YenHTZ1IsVuOfRhsKvPFDqOaMwLMVWJWTeC/KEdwWHY=;
        b=RSuZq4EbeDWqUQE8eF/Ato0bIPwQTBWy2RKR5RAFYhu9F7jvxyLFBaXI50l+EFRnv9
         MVPAZZ29TEOkvJlr2cH2NlpoOcLfRctScglPAF9SNWc7bSATpEKGqAHbkgWq6ZNA3MPC
         igGTV/Wh9903dSgGgyahmEr5omXGBhcI1Q7Gl6CWSGztlw6uV/7uscXZ3CWFAaiSs038
         ffvH4vCHoKX/e2vbPUWQyoE8IYh7WUOjFREoQhhdUPE8x6Bq8bnkdI28SJVogVf4/dY7
         PhDsvufdav1DXiPBXDZXcQYJUAUO8oDbA7FFrgsuOTcH1Lkm8ggjLN4QbBRwqNRcaCB3
         DzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763263782; x=1763868582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YenHTZ1IsVuOfRhsKvPFDqOaMwLMVWJWTeC/KEdwWHY=;
        b=NEA2e3zGx07gmJ+SpMQqCwgosfJW0SxrwQpO6MhmEHLs6vaTBOGy6riVAsSz7J5OND
         S+AHp26HYGwuXu/+1NoPP2SD10N28TDzm7BjeEX9fkqPMx95xBP72AAbTEHUmrhd+cZw
         +XuLsdssuIko3t/O9ovJ0DnVyho8G8uSBkRTkaIrXJxP5GkHjT+7baP9I9wdsGGSJIqt
         Bx2nimlefi90S9bTyW4I7G8wUupOE4AzsG3Z/QmE+3Tx99DzVCAh8oAhMINcDqTImFlR
         EaOVlQuv40OdJzSQ9EK1HbSNdtiIMhr2MmyOUizeHHf4SCPbYo2op5HQhvYk4ENTVqtv
         wYgw==
X-Forwarded-Encrypted: i=1; AJvYcCXbbjq1Mtbi+FY/UgUEzfugkfC8OYPaeqQk5q2BHWLkramSnhsQldGMnU3NA/NFtbdDVqojusqEkJ0rQSyXhH1h@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMHtQwFjWmnsH7VVpnYhdbtN56F+rl6Ib6ptp8HkfrF+hZ2nX
	lu56vq2bgoGEhi+9WJ382qqvaRTSw2Lj8YNAg+TgjPOqikYdYJyS4vSiG0K7KP3WtDJnwG+zlbk
	8Bw+uPni9mCVPR383/NaIxVZioBCVPLATF+veg3lm
X-Gm-Gg: ASbGncvl9kKMsjYDE2TaPzcSpBFfd4H3hBRMTmrhXJ7We9QLTt6WWc8hctZ4C6moCI0
	MfBnYnqn98YNG1PQ9VHhkfozQ/EH7gtS7ygqRjWbPSI3TEoJ/mPlfUR0Mp/wb9j3GH8CJf8xfgP
	Vsr5iH3gx4caNZShmkpsPgX03lXiOkWGhrU7dtF8ZzVYbzJKE3ZuG9fEtE1rv5LYlJPhbp4myXY
	0aICqn8idjENK6Iyl0sn+P63kWm6Z0/Yd11QhaMe04abLIuUF7IpTbM9DRdLu2y7P/rztDI
X-Google-Smtp-Source: AGHT+IGTwV5AI6pAr7IsbiIFQxi3zjHr4l4PPaj4Btj8iJyGRXOdHFfOEhoLQpIbdSuUEJRovrmEwAd3tAqCZscjtLA=
X-Received: by 2002:a17:903:120a:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-299c6a962e8mr3359575ad.6.1763263781730; Sat, 15 Nov 2025
 19:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com> <20251111212206.631711-4-irogers@google.com>
 <ca0f0cd3-7335-48f9-8737-2f70a75b019a@linaro.org> <CAP-5=fWNr9oaxWy3PyqbeH-sjsPpSt9g=8vP0drbb_e+ijpWkw@mail.gmail.com>
 <aRi9xnwdLh3Dir9f@google.com>
In-Reply-To: <aRi9xnwdLh3Dir9f@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 15 Nov 2025 19:29:29 -0800
X-Gm-Features: AWmQ_bnhMe6zSP20I8x9QNg6zfV5mkXy_spw4zRprMmyWnsbiXAVrumTPf9eMPQ
Message-ID: <CAP-5=fVKwQbOFcm5kNkuZ62rTu77A+N=aa2Of+hN1-68Qe7rFA@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] perf jevents: Add set of common metrics based on
 default ones
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 9:52=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 14, 2025 at 08:57:39AM -0800, Ian Rogers wrote:
> > On Fri, Nov 14, 2025 at 8:28=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> > >
> > >
> > >
> > > On 11/11/2025 9:21 pm, Ian Rogers wrote:
> > > > Add support to getting a common set of metrics from a default
> > > > table. It simplifies the generation to add json metrics at the same
> > > > time. The metrics added are CPUs_utilized, cs_per_second,
> > > > migrations_per_second, page_faults_per_second, insn_per_cycle,
> > > > stalled_cycles_per_instruction, frontend_cycles_idle,
> > > > backend_cycles_idle, cycles_frequency, branch_frequency and
> > > > branch_miss_rate based on the shadow metric definitions.
> > > >
> > > > Following this change the default perf stat output on an alderlake
> > > > looks like:
> > > > ```
> > > > $ perf stat -a -- sleep 2
> > > >
> > > >   Performance counter stats for 'system wide':
> > > >
> > > >                0.00 msec cpu-clock                        #    0.00=
0 CPUs utilized
> > > >              77,739      context-switches
> > > >              15,033      cpu-migrations
> > > >             321,313      page-faults
> > > >      14,355,634,225      cpu_atom/instructions/           #    1.40=
  insn per cycle              (35.37%)
> > > >     134,561,560,583      cpu_core/instructions/           #    3.44=
  insn per cycle              (57.85%)
> > > >      10,263,836,145      cpu_atom/cycles/                          =
                              (35.42%)
> > > >      39,138,632,894      cpu_core/cycles/                          =
                              (57.60%)
> > > >       2,989,658,777      cpu_atom/branches/                        =
                              (42.60%)
> > > >      32,170,570,388      cpu_core/branches/                        =
                              (57.39%)
> > > >          29,789,870      cpu_atom/branch-misses/          #    1.00=
% of all branches             (42.69%)
> > > >         165,991,152      cpu_core/branch-misses/          #    0.52=
% of all branches             (57.19%)
> > > >                         (software)                 #      nan cs/se=
c  cs_per_second
> > > >               TopdownL1 (cpu_core)                 #     11.9 %  tm=
a_bad_speculation
> > > >                                                    #     19.6 %  tm=
a_frontend_bound       (63.97%)
> > > >               TopdownL1 (cpu_core)                 #     18.8 %  tm=
a_backend_bound
> > > >                                                    #     49.7 %  tm=
a_retiring             (63.97%)
> > > >                         (software)                 #      nan fault=
s/sec  page_faults_per_second
> > > >                                                    #      nan GHz  =
cycles_frequency       (42.88%)
> > > >                                                    #      nan GHz  =
cycles_frequency       (69.88%)
> > > >               TopdownL1 (cpu_atom)                 #     11.7 %  tm=
a_bad_speculation
> > > >                                                    #     29.9 %  tm=
a_retiring             (50.07%)
> > > >               TopdownL1 (cpu_atom)                 #     31.3 %  tm=
a_frontend_bound       (43.09%)
> > > >                         (cpu_atom)                 #      nan M/sec=
  branch_frequency     (43.09%)
> > > >                                                    #      nan M/sec=
  branch_frequency     (70.07%)
> > > >                                                    #      nan migra=
tions/sec  migrations_per_second
> > > >               TopdownL1 (cpu_atom)                 #     27.1 %  tm=
a_backend_bound        (43.08%)
> > > >                         (software)                 #      0.0 CPUs =
 CPUs_utilized
> > > >                                                    #      1.4 instr=
uctions  insn_per_cycle  (43.04%)
> > > >                                                    #      3.5 instr=
uctions  insn_per_cycle  (69.99%)
> > > >                                                    #      1.0 %  br=
anch_miss_rate         (35.46%)
> > > >                                                    #      0.5 %  br=
anch_miss_rate         (65.02%)
> > > >
> > > >         2.005626564 seconds time elapsed
> > > > ```
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >   .../arch/common/common/metrics.json           |  86 +++++++++++++
> > > >   tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++=
-----
> > > >   tools/perf/pmu-events/jevents.py              |  21 +++-
> > > >   tools/perf/pmu-events/pmu-events.h            |   1 +
> > > >   tools/perf/util/metricgroup.c                 |  31 +++--
> > > >   5 files changed, 212 insertions(+), 42 deletions(-)
> > > >   create mode 100644 tools/perf/pmu-events/arch/common/common/metri=
cs.json
> > > >
> > > > diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json =
b/tools/perf/pmu-events/arch/common/common/metrics.json
> > > > new file mode 100644
> > > > index 000000000000..d915be51e300
> > > > --- /dev/null
> > > > +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> > > > @@ -0,0 +1,86 @@
> > > > +[
> > > > +    {
> > > > +        "BriefDescription": "Average CPU utilization",
> > > > +        "MetricExpr": "(software@cpu\\-clock\\,name\\=3Dcpu\\-cloc=
k@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (d=
uration_time * 1e9)",
> > >
> > > Hi Ian,
> > >
> > > I noticed that this metric is making "perf stat tests" fail.
> > > "duration_time" is a tool event and they don't work with "perf stat
> > > record" anymore. The test tests the record command with the default a=
rgs
> > > which results in this event being used and a failure.
> > >
> > > I suppose there are three issues. First two are unrelated to this cha=
nge:
> > >
> > >   - Perf stat record continues to write out a bad perf.data file even
> > >     though it knows that tool events won't work.
> > >
> > >     For example 'status' ends up being -1 in cmd_stat() but it's igno=
red
> > >     for some of the writing parts. It does decide to not print any st=
dout
> > >     though:
> > >
> > >     $ perf stat record -e "duration_time"
> > >     <blank>
> > >
> > >   - The other issue is obviously that tool events don't work with per=
f
> > >     stat record which seems to be a regression from 6828d6929b76 ("pe=
rf
> > >     evsel: Refactor tool events")
> > >
> > >   - The third issue is that this change adds a broken tool event to t=
he
> > >     default output of perf stat
> > >
> > > I'm not actually sure what "perf stat record" is for? It's possible t=
hat
> > > it's not used anymore, expecially if nobody noticed that tool events
> > > haven't been working in it for a while.
> > >
> > > I think we're also supposed to have json output for perf stat (althou=
gh
> > > this is also broken in some obscure scenarios), so maybe perf stat
> > > record isn't needed anymore?
> >
> > Hi James,
> >
> > Thanks for the report. I think this is also an overlap with perf stat
> > metrics don't work with perf stat record, and because these changes
> > made that the default. Let me do some follow up work as the perf
> > script work shows we can do useful things with metrics while not being
> > on a live perf stat - there's the obstacle that the CPUID of the host
> > will be used :-/
> >
> > Anyway, I'll take a look and we should add a test on this. There is
> > one that the perf stat json output is okay, to some definition. One
> > problem is that the stat-display code is complete spaghetti. Now that
> > stat-shadow only handles json metrics, and perf script isn't trying to
> > maintain a set of shadow counters, that is a little bit improved.
>
> I have another test failure on this.  On my AMD machine, perf all
> metrics test fails due to missing "LLC-loads" events.
>
>   $ sudo perf stat -M llc_miss_rate true
>   Error:
>   No supported events found.
>   The LLC-loads event is not supported.
>
> Maybe we need to make some cache metrics conditional as some events are
> missing.

Maybe we can `perf list Default`, etc. for this is a problem. We have
similar unsupported events in metrics on Intel like:

```
$ perf stat -M itlb_miss_rate -a sleep 1

 Performance counter stats for 'system wide':

   <not supported>      iTLB-loads
           168,926      iTLB-load-misses

       1.002287122 seconds time elapsed
```

but I've not seen failures:

```
$ perf test -v "all metrics"
103: perf all metrics test                                           : Skip
```

Thanks,
Ian

> Thanks,
> Namhyung
>
