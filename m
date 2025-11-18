Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951A31D723
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432927; cv=none; b=aLgSSlHJ+gxPAAT1feo2cIqQJMeRTjdrBAZm+lwveq5x3i+Iyf0RCLZRWYqsRXyzrsr8CwxtdAl++V3fs/FEvl1zIZjay5Udhp1c7tt6N2nuEsq90TtoVpyC9+He9T2PCv+oDg0+YSCV+sogvwz/XX9b1ydRo7hiq3SMoTvG9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432927; c=relaxed/simple;
	bh=RNpMIQGQKW4j4zmSuqZIzWc7QOdNb5tEEcWv5ZpI2wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJkSjB5JCjQJ3iQvYfH+K+W3NKwf90WAmCtWGmRfvmtt3APTu5sZ3r6VBseJnkvKCD6J+ZtpFfNnapEAJg5jfVcEOl9zbnC7RYmDCpWAdH0aecXb75xs2on+mcJIxNOJtO/wrt377LL6nwMjdlq6DeIMLsANX4h0PNvspdGcBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOz/NF+u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOz/NF+u"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295c64cb951so108235ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 18:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763432924; x=1764037724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a693yz+QrmjGZhuJSAQVH9/iAFLd7SqnheJkZhn6O4c=;
        b=tOz/NF+uNq93VC5s5TfP+gVXc+a7zaO8UVnaI2hUQzZ9L/K1n80PfpHS7uWyB3lMfY
         cDr31/hIhpA17CpGvjui+/6Dfco+gnsMIgKOashUOlLoYISiXqprkolXt4ULapQoijDb
         CTit7F6W5t99UAN7HkAlwUe0PLnljnWQReRozz2A7f3EQ5yPrZZJluhKZeahybBFJNei
         BLu9070G7VYJn3fKVPa3bnIuDXLq30MGAKncY9kkD0XxE41sKVT8tEuBoHuPk3vN56E2
         1ZpG3cwV8AlDeyQaU12oR5DU0HIRAAxu8InOnD+IruzbZXaGIBVhOEFp23l+HMimDzBE
         HGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432924; x=1764037724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a693yz+QrmjGZhuJSAQVH9/iAFLd7SqnheJkZhn6O4c=;
        b=QE487hgb381dmONoctLVORPfdTkaSuB3aWDp+vRgeTgTzeD/5xfnoc7hu+bTuzYp3I
         BCWPTWYTGx+ErcyiBCOVgZwIWyuDoiNv8ISX2kRPTbZRUUO5wUuHnu9CCf8KgcSEy4Oi
         8lz5db2iFfKvFv+UD7YfyjbvyC7zBOnZl22WBy0g4rA5hfuEBc9cuTXtpgV4TXQATkwV
         EQIRYpsYBIDdQwd/TVKFEZAlNx7z0gljne9o48sn4+3tJeUnOszqK4y6sGcIe29r0X21
         G6DZU9r37rE8CPMQQBF9v2UIdqfdvQjAt5fYb/cgx9Apjho0qNao1UQkuhHk7LTgWCi1
         1FTg==
X-Forwarded-Encrypted: i=1; AJvYcCVmVBFZfTaCTL4wFWqvPfy4Y3xzF9puxKfaPX4nxJhn1cNQ9dBl4rdIEfzzQyIllag9NQVfLlRIfTMtoFM7kEAu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfu5SlLPQvLKzw8Dx2gG95NtPaj5z/tvY7hhsR954le1uOqYn9
	uojjf7iJ44nYKYtxU4OBDln+wCOXpCO+1j4dNpfNhGgTBse3YQpFNa+GyrDdkrOHWqQtkhWa97D
	xWQfbO7sC6jTmQsQdbpz2HeeKmenOZfguBf3bp4H2
X-Gm-Gg: ASbGncuBz2ufXsNSTMNB2rAKI+4OZx9FmmEVhiJmjQRm85CA2TfmOzUbUF0Fs9x71q4
	Tw4GfgsCwtMekCrgzxDDNuvBG58ENWHi/amoymX2AkfIHC+IeGIVEbW6gHwxxIa3aZ/egRC/RiP
	QTSbVe38VtBeCM5NxN7sG7EIzpNHmg7ANOzVQZkUlMjt0f9UfHQTQPNE227yQIDuFASCQSwGXyy
	+cvw/WMK9J9Glgvg1LXd24k6lRWaEBmJUSVSJSSmgwd7cFxi0X1aRl46vPt8UiccNZDpAoDqRTW
	zy0wmmI=
X-Google-Smtp-Source: AGHT+IHOJwOj/c+oSefzQ5RXC4DanS0yCQKOyiqZUiRZTrbguyb/Vl55IABfIA7X4QSd/OHDQf2pcm2tqlLdHOsmOA4=
X-Received: by 2002:a17:902:ea08:b0:294:e585:1f39 with SMTP id
 d9443c01a7336-299f69fbeb6mr1761645ad.14.1763432924230; Mon, 17 Nov 2025
 18:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com> <20251111212206.631711-4-irogers@google.com>
 <ca0f0cd3-7335-48f9-8737-2f70a75b019a@linaro.org> <CAP-5=fWNr9oaxWy3PyqbeH-sjsPpSt9g=8vP0drbb_e+ijpWkw@mail.gmail.com>
 <aRi9xnwdLh3Dir9f@google.com> <CAP-5=fVKwQbOFcm5kNkuZ62rTu77A+N=aa2Of+hN1-68Qe7rFA@mail.gmail.com>
 <aRvNux4vlacfrgin@google.com>
In-Reply-To: <aRvNux4vlacfrgin@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Nov 2025 18:28:31 -0800
X-Gm-Features: AWmQ_bl4Yf2Ian0T96NlggMCLepMuz6NloWM_fFTEkaI8xD3bdwaAUw_B5_JguM
Message-ID: <CAP-5=fUpkUifLiBSO473Ws5HyDH0dGNMVCqomggE2P2=VNhAZg@mail.gmail.com>
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

On Mon, Nov 17, 2025 at 5:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Nov 15, 2025 at 07:29:29PM -0800, Ian Rogers wrote:
> > On Sat, Nov 15, 2025 at 9:52=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 08:57:39AM -0800, Ian Rogers wrote:
> > > > On Fri, Nov 14, 2025 at 8:28=E2=80=AFAM James Clark <james.clark@li=
naro.org> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 11/11/2025 9:21 pm, Ian Rogers wrote:
> > > > > > Add support to getting a common set of metrics from a default
> > > > > > table. It simplifies the generation to add json metrics at the =
same
> > > > > > time. The metrics added are CPUs_utilized, cs_per_second,
> > > > > > migrations_per_second, page_faults_per_second, insn_per_cycle,
> > > > > > stalled_cycles_per_instruction, frontend_cycles_idle,
> > > > > > backend_cycles_idle, cycles_frequency, branch_frequency and
> > > > > > branch_miss_rate based on the shadow metric definitions.
> > > > > >
> > > > > > Following this change the default perf stat output on an alderl=
ake
> > > > > > looks like:
> > > > > > ```
> > > > > > $ perf stat -a -- sleep 2
> > > > > >
> > > > > >   Performance counter stats for 'system wide':
> > > > > >
> > > > > >                0.00 msec cpu-clock                        #    =
0.000 CPUs utilized
> > > > > >              77,739      context-switches
> > > > > >              15,033      cpu-migrations
> > > > > >             321,313      page-faults
> > > > > >      14,355,634,225      cpu_atom/instructions/           #    =
1.40  insn per cycle              (35.37%)
> > > > > >     134,561,560,583      cpu_core/instructions/           #    =
3.44  insn per cycle              (57.85%)
> > > > > >      10,263,836,145      cpu_atom/cycles/                      =
                                  (35.42%)
> > > > > >      39,138,632,894      cpu_core/cycles/                      =
                                  (57.60%)
> > > > > >       2,989,658,777      cpu_atom/branches/                    =
                                  (42.60%)
> > > > > >      32,170,570,388      cpu_core/branches/                    =
                                  (57.39%)
> > > > > >          29,789,870      cpu_atom/branch-misses/          #    =
1.00% of all branches             (42.69%)
> > > > > >         165,991,152      cpu_core/branch-misses/          #    =
0.52% of all branches             (57.19%)
> > > > > >                         (software)                 #      nan c=
s/sec  cs_per_second
> > > > > >               TopdownL1 (cpu_core)                 #     11.9 %=
  tma_bad_speculation
> > > > > >                                                    #     19.6 %=
  tma_frontend_bound       (63.97%)
> > > > > >               TopdownL1 (cpu_core)                 #     18.8 %=
  tma_backend_bound
> > > > > >                                                    #     49.7 %=
  tma_retiring             (63.97%)
> > > > > >                         (software)                 #      nan f=
aults/sec  page_faults_per_second
> > > > > >                                                    #      nan G=
Hz  cycles_frequency       (42.88%)
> > > > > >                                                    #      nan G=
Hz  cycles_frequency       (69.88%)
> > > > > >               TopdownL1 (cpu_atom)                 #     11.7 %=
  tma_bad_speculation
> > > > > >                                                    #     29.9 %=
  tma_retiring             (50.07%)
> > > > > >               TopdownL1 (cpu_atom)                 #     31.3 %=
  tma_frontend_bound       (43.09%)
> > > > > >                         (cpu_atom)                 #      nan M=
/sec  branch_frequency     (43.09%)
> > > > > >                                                    #      nan M=
/sec  branch_frequency     (70.07%)
> > > > > >                                                    #      nan m=
igrations/sec  migrations_per_second
> > > > > >               TopdownL1 (cpu_atom)                 #     27.1 %=
  tma_backend_bound        (43.08%)
> > > > > >                         (software)                 #      0.0 C=
PUs  CPUs_utilized
> > > > > >                                                    #      1.4 i=
nstructions  insn_per_cycle  (43.04%)
> > > > > >                                                    #      3.5 i=
nstructions  insn_per_cycle  (69.99%)
> > > > > >                                                    #      1.0 %=
  branch_miss_rate         (35.46%)
> > > > > >                                                    #      0.5 %=
  branch_miss_rate         (65.02%)
> > > > > >
> > > > > >         2.005626564 seconds time elapsed
> > > > > > ```
> > > > > >
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > ---
> > > > > >   .../arch/common/common/metrics.json           |  86 +++++++++=
++++
> > > > > >   tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++=
++++-----
> > > > > >   tools/perf/pmu-events/jevents.py              |  21 +++-
> > > > > >   tools/perf/pmu-events/pmu-events.h            |   1 +
> > > > > >   tools/perf/util/metricgroup.c                 |  31 +++--
> > > > > >   5 files changed, 212 insertions(+), 42 deletions(-)
> > > > > >   create mode 100644 tools/perf/pmu-events/arch/common/common/m=
etrics.json
> > > > > >
> > > > > > diff --git a/tools/perf/pmu-events/arch/common/common/metrics.j=
son b/tools/perf/pmu-events/arch/common/common/metrics.json
> > > > > > new file mode 100644
> > > > > > index 000000000000..d915be51e300
> > > > > > --- /dev/null
> > > > > > +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> > > > > > @@ -0,0 +1,86 @@
> > > > > > +[
> > > > > > +    {
> > > > > > +        "BriefDescription": "Average CPU utilization",
> > > > > > +        "MetricExpr": "(software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) =
/ (duration_time * 1e9)",
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > I noticed that this metric is making "perf stat tests" fail.
> > > > > "duration_time" is a tool event and they don't work with "perf st=
at
> > > > > record" anymore. The test tests the record command with the defau=
lt args
> > > > > which results in this event being used and a failure.
> > > > >
> > > > > I suppose there are three issues. First two are unrelated to this=
 change:
> > > > >
> > > > >   - Perf stat record continues to write out a bad perf.data file =
even
> > > > >     though it knows that tool events won't work.
> > > > >
> > > > >     For example 'status' ends up being -1 in cmd_stat() but it's =
ignored
> > > > >     for some of the writing parts. It does decide to not print an=
y stdout
> > > > >     though:
> > > > >
> > > > >     $ perf stat record -e "duration_time"
> > > > >     <blank>
> > > > >
> > > > >   - The other issue is obviously that tool events don't work with=
 perf
> > > > >     stat record which seems to be a regression from 6828d6929b76 =
("perf
> > > > >     evsel: Refactor tool events")
> > > > >
> > > > >   - The third issue is that this change adds a broken tool event =
to the
> > > > >     default output of perf stat
> > > > >
> > > > > I'm not actually sure what "perf stat record" is for? It's possib=
le that
> > > > > it's not used anymore, expecially if nobody noticed that tool eve=
nts
> > > > > haven't been working in it for a while.
> > > > >
> > > > > I think we're also supposed to have json output for perf stat (al=
though
> > > > > this is also broken in some obscure scenarios), so maybe perf sta=
t
> > > > > record isn't needed anymore?
> > > >
> > > > Hi James,
> > > >
> > > > Thanks for the report. I think this is also an overlap with perf st=
at
> > > > metrics don't work with perf stat record, and because these changes
> > > > made that the default. Let me do some follow up work as the perf
> > > > script work shows we can do useful things with metrics while not be=
ing
> > > > on a live perf stat - there's the obstacle that the CPUID of the ho=
st
> > > > will be used :-/
> > > >
> > > > Anyway, I'll take a look and we should add a test on this. There is
> > > > one that the perf stat json output is okay, to some definition. One
> > > > problem is that the stat-display code is complete spaghetti. Now th=
at
> > > > stat-shadow only handles json metrics, and perf script isn't trying=
 to
> > > > maintain a set of shadow counters, that is a little bit improved.
> > >
> > > I have another test failure on this.  On my AMD machine, perf all
> > > metrics test fails due to missing "LLC-loads" events.
> > >
> > >   $ sudo perf stat -M llc_miss_rate true
> > >   Error:
> > >   No supported events found.
> > >   The LLC-loads event is not supported.
> > >
> > > Maybe we need to make some cache metrics conditional as some events a=
re
> > > missing.
> >
> > Maybe we can `perf list Default`, etc. for this is a problem. We have
> > similar unsupported events in metrics on Intel like:
> >
> > ```
> > $ perf stat -M itlb_miss_rate -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >    <not supported>      iTLB-loads
> >            168,926      iTLB-load-misses
> >
> >        1.002287122 seconds time elapsed
> > ```
> >
> > but I've not seen failures:
> >
> > ```
> > $ perf test -v "all metrics"
> > 103: perf all metrics test                                           : =
Skip
> > ```
>
>   $ sudo perf test -v "all metrics"
>   --- start ---
>   test child forked, pid 1347112
>   Testing CPUs_utilized
>   Testing backend_cycles_idle
>   Not supported events
>   Performance counter stats for 'system wide': <not counted> cpu-cycles <=
not supported> stalled-cycles-backend 0.013162328 seconds time elapsed
>   Testing branch_frequency
>   Testing branch_miss_rate
>   Testing cs_per_second
>   Testing cycles_frequency
>   Testing frontend_cycles_idle
>   Testing insn_per_cycle
>   Testing migrations_per_second
>   Testing page_faults_per_second
>   Testing stalled_cycles_per_instruction
>   Testing l1d_miss_rate
>   Testing llc_miss_rate
>   Metric contains missing events
>   Error: No supported events found. The LLC-loads event is not supported.

Right, but this should match the Intel case as iTLB-loads is an
unsupported event so I'm not sure why we don't see a failure on Intel
but do on AMD given both events are legacy cache ones. I'll need to
trace through the code (or uftrace it :-) ).

Thanks,
Ian

>   Testing dtlb_miss_rate
>   Testing itlb_miss_rate
>   Testing l1i_miss_rate
>   Testing l1_prefetch_miss_rate
>   Not supported events
>   Performance counter stats for 'system wide': <not counted> L1-dcache-pr=
efetches <not supported> L1-dcache-prefetch-misses 0.012983559 seconds time=
 elapsed
>   Testing branch_misprediction_ratio
>   Testing all_remote_links_outbound
>   Testing nps1_die_to_dram
>   Testing all_l2_cache_accesses
>   Testing all_l2_cache_hits
>   Testing all_l2_cache_misses
>   Testing ic_fetch_miss_ratio
>   Testing l2_cache_accesses_from_l2_hwpf
>   Testing l2_cache_misses_from_l2_hwpf
>   Testing l3_read_miss_latency
>   Testing l1_itlb_misses
>   ---- end(-1) ----
>   103: perf all metrics test                                           : =
FAILED!
>
> Thanks,
> Namhyung
>
